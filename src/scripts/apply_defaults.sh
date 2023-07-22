#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
tput setaf 1
echo "###############################################################################"
echo "#                         !!! XeroLinux Reset Tool !!!                        #"
echo "#                                                                             #"
echo "#              Having Issues With Messed Up Layout or Settings ?              #"
echo "#                                                                             #"
echo "#            This Will Restore Stock Defaults. Layout WILL BE RESET           #"
echo "###############################################################################"
tput sgr0
echo
echo "Hello $USER, which Edition are you using ?"
echo
echo "1.  XeroLinux KDE Plasma."
echo "2.  XeroLinux GNOME Spin."
echo "3.  XeroLinux XFCE  Spin."
echo
#echo "4.  Exit"
echo
echo "Please Select an Option..."
echo

read CHOICE

case $CHOICE in

    1 )
      echo
      echo "Option currently unavailable. Please check back soon..."
#      tput setaf 4
#      read -p "Final Warning, This Will Undo Your Customizations, Proceed ? (y/n): " proceed_response
#      tput sgr0
#      echo
#      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
#      echo
#        echo "###################################"
#        echo "  Restoring/Applying KDE defaults  "
#        echo "###################################"
#      sleep 2
#      echo
#      echo "Git Cloning Default Settings Repo"
#      cd ~ && git clone https://github.com/xerolinux/xero-layan-git && cd xero-layan-git/
#      sleep 2
#      echo
#      echo "Running Install Script..."
#      sh install.sh
#      echo
#      rm -Rf ~/xero-layan-git/
#      sleep 2
#        # Prompt the user to reboot
#        tput setaf 4
#        read -p "Customization Restored. Reboot recommended. Reboot now? (y/n): " reboot_response
#        tput setaf 0
#      echo
#        # Check the user's response
#        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
#          sudo reboot
#        else
#          echo
#          echo "Please manually reboot your system to apply changes."
#        fi
#      else
#        echo "Restoration cancelled."
#        exit 0
#      fi

      ;;

    2 )
      echo
      tput setaf 4
      read -p "Final Warning, This Will Undo Your Customizations, Proceed ? (y/n): " proceed_response
      tput sgr0
      echo
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
      echo
        echo "###################################"
        echo " Restoring/Applying Gnome defaults "
        echo "###################################"
      sleep 2
      # Check if any of the specified packages are installed
      if pacman -Qi gnome-software gnome-software-packagekit-plugin &>/dev/null; then
      echo
      echo "Removing Gnome Software..."
      sudo pacman -Rns --noconfirm gnome-software gnome-software-packagekit-plugin &>/dev/null
      fi
      echo
      # Check if any of the specified packages are installed and install them if not present
      packages="libpamac pamac-gtk pamac-cli libpamac-flatpak-plugin"
      echo
      echo "Installing required packages..."
      for package in $packages; do
          pacman -Qi "$package" &>/dev/null || sudo pacman -Syy --noconfirm --needed "$package" &>/dev/null
      done
      echo
      echo "Creating backup & Applying custom Settings"
      echo "##########################################"
      cp ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -Rf /etc/skel/. ~ && sudo cp -Rf /etc/skel/. /root/
      rm ~/.config/autostart/dconf-load.desktop
      sh /usr/local/bin/xdconf
      sleep 2
      echo
        # Prompt the user to reboot
        tput setaf 4
        read -p "Customization Restored. Reboot recommended. Reboot now? (y/n): " reboot_response
        tput setaf 0
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Restoration cancelled."
        exit 0
      fi

      ;;

    3 )
      echo
      tput setaf 4
      read -p "Final Warning, This Will Undo Your Customizations, Proceed ? (y/n): " proceed_response
      tput sgr0
      echo
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
      echo
        echo "###################################"
        echo " Restoring/Applying Gnome defaults "
        echo "###################################"
      sleep 2
      echo
      echo "Creating Backups of ~/.config folder"
      echo "#####################################"
      cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
      sleep 2
      echo "###################################"
      echo "      Restoring XFCE defaults      "
      echo "###################################"
      sleep 2
      cp -rf /etc/skel/. ~
      sudo cp -Rf /etc/skel/. /root/
      sleep 2
        # Prompt the user to reboot
        tput setaf 4
        read -p "Customization Restored. Reboot recommended. Reboot now? (y/n): " reboot_response
        tput setaf 0
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Restoration cancelled."
        exit 0
      fi

      ;;

    * )
      echo "#################################"
      echo "Choose the correct number"
      echo "#################################"
      ;;
esac
