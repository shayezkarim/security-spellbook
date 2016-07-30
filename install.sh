#!/usr/bin/bash

#########################################################
# Bunny developed by Heitor Gouvêa                      #
# This work is licensed under MIT License               #
# Copyright (c) 2016 Heitor Gouvea                      #
#                                                       #
# [+] AUTOR:        Heitor Gouvêa                       #
# [+] EMAIL:        hi@heitorgouvea.me                  #
# [+] GITHUB:       https://github.com/GouveaHeitor     #
# [+] TWITTER:      https://twitter.com/GouveaHeitor    #
# [+] FACEBOOK:     https://fb.com/GouveaHeitor         #
#########################################################

export RED='\033[1;91m'
export ENDC='\033[1;00m'


if [ $(id -u) -ne 0 ]; then
    echo -e "\n$RED[!] This script must be run as root$ENDC\n" >&2
    exit 1
fi

if [ -e /etc/pacman.conf ]
then
	sudo pacman -S perl --needed
elif [ -e /etc/apt ]
then
	sudo apt-get install perl
elif [ -e /etc/yum.conf ]
then
	sudo yum install perl perl-CPAN
else
	echo "$RED[!] Your system is unsupported by this script"
	echo "Please install the dependencies manually"
	echo "open the terminal and type: sudo cpan install Switch$ENDC"
fi
sudo cpan install Switch

if [ -e /usr/share/bunny ]
then
	sudo rm -rf /usr/share/bunny
fi

if [ -e /usr/bin/bunny ]
then
	sudo rm /usr/bin/bunny
fi

cd .. && sudo mv bunny /usr/share/

sudo sh -c 'echo "#!/bin/bash" > /usr/bin/bunny'
sudo sh -c 'echo "cd /usr/share/bunny" >> /usr/bin/bunny'
sudo sh -c 'echo "exec perl bunny $@" >> /usr/bin/bunny'
sudo chmod +x /usr/bin/bunny
clear
bunny
