#!/bin/sh
# mod_security
mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
sed -ie 's/^\s*SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf
rm -rf /usr/share/modsecurity-crs
git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/share/modsecurity-crs
mv /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf
sed -ie  '/SecDataDir /d' /etc/apache2/mods-enabled/security2.conf
sed -ie  '/IncludeOptional /d' /etc/apache2/mods-enabled/security2.conf
sed -ie  '/# /d' /etc/apache2/mods-enabled/security2.conf
sed -ie '2i\SecDataDir /var/cache/modsecurity ' /etc/apache2/mods-enabled/security2.conf
sed -ie '3i\IncludeOptional /usr/share/modsecurity-crs/*.conf ' /etc/apache2/mods-enabled/security2.conf
sed -ie '4i\IncludeOptional /etc/modsecurity/*.conf ' /etc/apache2/mods-enabled/security2.conf
sed -ie '5i\IncludeOptional "/usr/share/modsecurity-crs/rules/*.conf ' /etc/apache2/mods-enabled/security2.conf
touch /etc/modsecurity/modsecurity_custom_rules.conf
echo 'SecRule REQUEST_FILENAME "test.php" "id:+400001+,chain,deny,log,msg:+Spam detected+"' >> /etc/modsecurity/modsecurity_custom_rules.conf
echo 'SecRule REQUEST_METHOD "POST" chain' >> /etc/modsecurity/modsecurity_custom_rules.conf
echo 'SecRule REQUEST_BODY "@rx (?i:(Alexandre|Quentin|Boudjema))"' >> /etc/modsecurity/modsecurity_custom_rules.conf
sed -i "s/+/'/g"  /etc/modsecurity/modsecurity_custom_rules.conf
# mod_evasive
sed -ie 's/^\s*#DOS/DOS/' /etc/apache2/mods-enabled/evasive.conf
mkdir /var/log/mod_evasive
chown -R www-data:www-data /var/log/mod_evasive
#service apache2 reload
