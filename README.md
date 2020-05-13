# Projet Durcissement LAMP
Projet réalisé dans le cadre des TER 2020 M1 FSI AMU
## Objectif du TER
Le but de ce TER est de mettre en place une architecture web LAMP (Linux, Apache, Mysql, PHP)
sécurisée avec :
- un reverse proxy qui masque l’architecture interne ;
- le pare-feu applicatif web ModSecurity qui protège le ou les serveurs web derrière le reverse proxy des attaques les plus courantes ;
- le module Apache de protection contre le déni de service ModEvasive ;
- l’application Fail2ban qui détecte les comportements interdits dans les logs et bloque l’IP à la source de ces demandes ;
- des réglages de sécurité dans le fichier de configuration du serveur Apache et de PHP.

# Installation