#!/bin/bash 
#Effacer l'ecran
clear

echo -e  '''\t\t\t\t\t###################################### RUNNING ANSIBLE PLAYBOOK ##################################################'''

#Entrer dans le répertoire ./roles-project
cd ./roles-project
#Lancer ansible playbook playbook.yml
ansible-playbook playbook.yml

echo -e '''\t\t\t\t\t################################### RUNNING VIRTUAL ENVIRONNEMENT ################################################'''
#Créer workspace et se déplacer dedans
mkdir ./pyats && cd ./pyats
#Créer un nouvel environnement virtuel Python CSR1kv
python3 -m venv csr1kv
#Entrer dans le répertoire ~/labs/devnet-src/pyats/csr1kv/
cd ./csr1kv
#Lancer l'environnement virtuel
source bin/activate
#Installation de pyats
pip3 install pyats[full]
#Cloner et examiner les exemples de scripts PyATS de GitHub
git clone https://github.com/CiscoTestAutomation/examples
#Lancer le job de basic_example_job.py
pyats run job examples/basic/basic_example_job.py
#Génie pour analyser la sortie non structurée de la commande show ip interface brief en JSON structuré
genie parse "show ip interface brief" --testbed-file yaml/testbed.yml --devices CSR1kv
# Génie pour analyser la sortie non structurée de la commande show version en JSON structuré
genie parse "show version" --testbed-file yaml/testbed.yml --devices CSR1kv
#Génie pour analyser la sortie non structurée de la commande show ipv6 interface brief en JSON structuré
genie parse "show ipv6 interface gig 1" --testbed-file yaml/testbed.yml --devices CSR1kv --output verify-ipv6-1
#Génie pour analyser la sortie non structurée de la commande show ipv6 interface brief en JSON structuré après ajout de lien-local IPV6
genie parse "show ipv6 interface gig 1" --testbed-file yaml/testbed.yml --devices CSR1kv --output verify-ipv6-2
#Voir la difference entre le deux répertoires
genie diff verify-ipv6-1 verify-ipv6-2
#Sortir de l'environnement virutel
deactivate
