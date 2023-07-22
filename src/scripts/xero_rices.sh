#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
tput setaf 3

echo "#################################################"
echo "#          The XeroLinux Rice Installer         #"
echo "#      The Following Rices Are for KDE Only     #"
echo "#################################################"
tput sgr0
echo
echo "Hello $USER, which rice would you like to apply today ?"
echo
echo "################# Rice Selector #################"
echo
echo "1. The Catppuccin Rice (Teddy)."
echo "2. The Dunes Rice (GamerKing)."
echo "3. The Layan Rice (DarkXero)."
echo "4. The Nord Rice (DarkXero)."
echo "5. The Sweet Rice (Teddy)."
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-catppuccin-git && cd ~/xero-catppuccin-git/ && ./install.sh
			sleep 3
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    2 )
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-dunes-git.git && cd ~/xero-dunes-git/ && ./install.sh
			sleep 3
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    3 )
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-layan-git.git && cd ~/xero-layan-git/ && ./install.sh
			sleep 3
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    4 )
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-nord-git.git && cd ~/xero-nord-git/ && ./install.sh
			sleep 3
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    5 )
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-sweet-git.git && cd ~/xero-sweet-git/ && ./install.sh
			sleep 3
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
