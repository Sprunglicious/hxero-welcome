#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
tput setaf 3
echo "#################################################"
echo "#          Extra XeroLinux Fixes/Tweaks         #"
echo "#################################################"
tput sgr0
echo
echo "Hello $USER, what would you like to do today ?"
echo
echo "################# System Tweaks #################"
echo
echo "1. Activate Flatpak Theming (Required If used)."
echo "2. Update Pacman.conf File To Latest (Optional)."
echo "3. Update Default System Theme (KDE Release Only)."
echo
echo "################ Troubleshooting ################"
echo
echo "4. Apply The Samba Share Fix."
echo "5. Apply KDFontOP.c / Setfont Fix."
echo "6. Restart PipeWire/PipeWire-Pulse."
echo "7. Downgrade Grub & Get New xhbp Repo."
echo "8. Enable The PipeWire Echo-Cancel Module."
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo
      sleep 2
      sh /usr/local/bin/flatfix
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    2 )
      echo
      sleep 2
      sh /usr/local/bin/pacup
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    3 )
      echo
      sleep 2
      sh /usr/local/bin/stup
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    4 )
      echo
      sleep 2
      sh /usr/local/bin/smbfix
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    5 )
      echo
	  sleep 2
      sh /usr/local/bin/kdfix
      sleep 2
	  echo
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;


    6 )
      echo
	  sleep 2
	  sh /usr/local/bin/rpipe
	  sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    7 )
      echo
	  sleep 2
	  sh /usr/local/bin/grubdown
	  sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    8 )
      echo
	  sleep 2
	  sh /usr/local/bin/pipecho
	  sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xerofix.sh

      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
