#!/bin/bash

if [ -z $1 ]; then

	echo "Empty param - username";
	exit;

else 

	USERNAME_LOCAL=$1

fi


if id -u "$USERNAME_LOCAL" >/dev/null 2>&1; then
   
echo "user exist";

else
    adduser "$USERNAME_LOCAL"


#clear
echo "Не забудь про visudo"
echo "$USERNAME_LOCAL	ALL=(ALL:ALL) ALL"
sleep 2;
#visudo

#su "$USERNAME_LOCAL"
echo "перейди на нового пользователя и запусти скрипт снова";

mv "$0" /home/"$USERNAME_LOCAL"/
chown "$USERNAME_LOCAL":"$USERNAME_LOCAL" /home/"$USERNAME_LOCAL"/"$0"
exit;
fi

while true; do
    read -p "Нужен SWAP? [y/n] " yn
    case $yn in
        [Yy]* ) sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024;sudo /sbin/mkswap /var/swap.1;sudo /sbin/swapon /var/swap.1; break;;
        [Nn]* ) break;;
        * ) echo "Только y или n";;
    esac
done

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.4 php7.4-dev php7.4-xml php7.4-zip php7.4-gmp php7.4-cli php7.4-mbstring php7.4-json php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl git -y

sudo apt install curl -y
sudo apt install mc -y
sudo apt install vim -y
sudo apt install wget -y
sudo apt install git -y
sudo apt install htop -y
sudo apt install net-tools -y

sudo apt-get install bash-completion -y
#echo '. /etc/bash_completion' >> ~/.bashrc

curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php

sudo apt update 
sudo apt upgrade -y

sudo apt install apache2 


#alias and env config
cd ~
echo "
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -hl'
alias ls='ls --color=auto'

PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
" >> .bashrc



#end alias

#remember 
cd ~
ssh-keygen -t rsa -b 2048

FILE=/home/"$USERNAME_LOCAL"/.ssh
if [ -f "$FILE" ]; then
    echo "$FILE exist"
else 
    mkdir .ssh
fi

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
rm  ~/.ssh/id_rsa.pub

echo '
# Package generated configuration file
# See the sshd_config(5) manpage for details

# What ports, IPs and protocols we listen for
Port 5499
# Use these options to restrict which interfaces/protocols sshd will bind to
#ListenAddress ::
#ListenAddress 0.0.0.0
Protocol 2
# HostKeys for protocol version 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
#Privilege Separation is turned on for security
UsePrivilegeSeparation yes

# Lifetime and size of ephemeral version 1 server key
KeyRegenerationInterval 3600
ServerKeyBits 1024

# Logging
SyslogFacility AUTH
LogLevel INFO

# Authentication:
LoginGraceTime 120
PermitRootLogin no
StrictModes yes

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile	%h/.ssh/authorized_keys %h/.ssh/id_rsa.pub

IgnoreRhosts yes
# For this to work you will also need host keys in /etc/ssh_known_hosts
RhostsRSAAuthentication no
# similar for protocol version 2
HostbasedAuthentication no
#IgnoreUserKnownHosts yes

# To enable empty passwords, change to yes (NOT RECOMMENDED)
PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Change to no to disable tunnelled clear text passwords
PasswordAuthentication no

# Kerberos options
#KerberosAuthentication no
#KerberosGetAFSToken no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes

X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
UseLogin no

#MaxStartups 10:30:60
#Banner /etc/issue.net

# Allow client to pass locale environment variables
AcceptEnv LANG LC_*

Subsystem sftp /usr/lib/openssh/sftp-server

UsePAM yes
' | sudo tee /etc/ssh/sshd_config

chmod 700 ~/.ssh/
chmod 600 ~/.ssh/authorized_keys

sudo service sshd restart

sudo ufw deny 22
sudo ufw allow 80
sudo ufw allow 5499
sudo ufw allow 443
sudo ufw allow 8888
sudo ufw enable

sudo chsh -s /bin/bash "$USERNAME_LOCAL"

sudo update-alternatives --config editor
#end remember

#ssh-keygen


#locale
sudo apt install language-pack-ru 
sudo update-locale LANG=ru_RU.UTF-8
#sudo dpkg-reconfigure locales
#end locale


#mysql only

while true; do
    read -p "Нужен mysql? [y/n] " yn
    case $yn in
        [Yy]* ) sudo apt update;sudo apt install mysql-server;sudo mysql_secure_installation; sudo add-apt-repository ppa:phpmyadmin/ppa;
sudo apt install phpmyadmin php-mbstring php-gettext; break;;
        [Nn]* ) break;;
        * ) echo "Только y или n";;
    esac
done


#####
clear

cat ~/.ssh/id_rsa
rm ~/.ssh/id_rsa
rm "$0"




