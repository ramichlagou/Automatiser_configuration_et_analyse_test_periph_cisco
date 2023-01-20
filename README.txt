vous devez téléchager CSR1000v : https://www.cisco.com/c/en/us/support/routers/cloud-services-router-1000v-series/products-release-notes-list.html
Une machine virtuelle contient python et Ansible installé.
assurer la connectivité entre les deux machines.
4 Tâches:
 - installer CSR1000v.
 - Utiliser Ansible pour sauvegarder et configurer un périphérique.
 - Utiliser Ansible pour automatiser l'installation d'un serveur Web.
 - Tests automatisés utilisant PYATS et Genie.


pour voir le contenu du playbook:
cat playbook.yml
pour voir les roles:
cat roles/cisco_routeur/tasks/main.yml

Créer votre fichier YAML testbed, . 
- Nom d'hôte du périphérique - Ce nom doit correspondre au nom d'hôte du périphérique, qui est CSR1kv pour ce laboratoire .
- Adresse IP - Cette adresse doit correspondre à votre adresse IPv4 CSR1kv que vous avez découverte plus tôt dans ce laboratoire. Le montre ici est 192.168.56.101.
- Nom d'utilisateur - Ceci est le nom d'utilisateur local utilisé pour ssh, qui est cisco.
- Mot de passe par défaut - Ceci est le mot de passe local utilisé pour ssh, qui est cisco123!.
- Activer le mot de passe - Laissez vide. Aucun mot de passe privilégié n'est configuré sur le routeur.
- Protocole - SSH avec le groupe d'échange de clés attendu par le routeur.
- OS - Le système d'exploitation sur le routeur.
(csr1kv) devasc@labvm:~/labs/devnet-src/pyats/csr1kv$ genie create testbed 
interactive --output yaml/testbed.yml --encode-password
Start creating Testbed yaml file ...
Do all of the devices have the same username? [y/n] n
Do all of the devices have the same default password? [y/n] n
Do all of the devices have the same enable password? [y/n] n
Device hostname: CSR1kv
 IP (ip, or ip:port): 192.168.56.101
 Username: cisco
Default Password (leave blank if you want to enter on demand): cisco123!
Enable Password (leave blank if you want to enter on demand): 
 Protocol (ssh, telnet, ...): ssh -o KexAlgorithms=diffie-hellman-group14-
sha1
 OS (iosxr, iosxe, ios, nxos, linux, ...): iosxe
More devices to add ? [y/n] n
Testbed file generated: 
yaml/testbed.yml

Verifier le contenu du fichier testbed.yml
cat yaml/testbed.yml

pour savoir l'adresse IP du machine CSR1kv:
CSR1kv> en
CSR1kv# show ip interface brief


Ajoutez une adresse IPv6 à CSR1k:
CSR1kV (config) # interface gig 1
CSR1kv(config-if)# ipv6 address 2001:db8:acad:56::101/64

Lister le contenu du répertoire verify-ipv6-1:
ls -l verify-ipv6-1

*** Afficher le contenu du fichier CSR1kv_show-ipv6-interface-gig-1_console.txt:
cat verify-ipv6-1/CSR1kv_show-ipv6-interface-gig-1_console.txt

*** Afficher le contenu du fichier CSR1kv_show-ipv6-interface-gig-1_parsed.txt:
cat verify-ipv6-1/CSR1kv_show-ipv6-interface-gig-1_parsed.txt

*** Modifiez l'adresse Lien-Local IPv6 Sur CSR1kv VM, ajoutez l'adresse IPv6 suivante : 
CSR1kv> en
CSR1kv# configure terminal
Enter configuration commands, one per line. End with CNTL/Z.
CSR1kv(config)# interface gig 1
CSR1kv(config-if)# ipv6 address fe80::56:1 link-local



*** Lister le contenu du répertoire verify-ipv6-2
ls -l verify-ipv6-2
*** Afficher le contenu du fichier CSR1kv_show-ipv6-interface-gig-1_console.txt
cat verify-ipv6-2/CSR1kv_show-ipv6-interface-gig-1_console.txt
*** Afficher le contenu du fichier CSR1kv_show-ipv6-interface-gig-1_console.txt
cat verify-ipv6-2/CSR1kv_show-ipv6-interface-gig-1_parsed.txt

*** Afficher le contenu du fichier générer par la commande genie diff
cat ./diff_CSR1kv_show-ipv6-interface-gig-1_parsed.txt

