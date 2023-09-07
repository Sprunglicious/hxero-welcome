#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
tput setaf 3

echo "####################################################################"
echo "#        The HXERO Hyprland Configurator                           #"
echo "# Feel free to modify this script and submit more configurations!  #"
echo "####################################################################"
tput sgr0
echo
echo "Hello $USER, which Hyprland Configuration would you like to use?"
echo
echo "################# Rice Selector #################"
echo
echo "1. The XeroAMEDEUS Config."
echo "2. The Dunes Rice (GamerKing)."
echo "3. The Nord Rice (DarkXero)."
echo "4. The Sweet Rice (Teddy)."
echo
echo "################# Ricing Tweaks #################"
echo
echo "5. Reset config back to Pure Vanilla KDE."
echo "6. Activate Flatpak Theming (Required If used)."
echo "7. Update Default System Theme (Layan KDE/GTK)."
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo
      echo "#################################################"
      echo "#     Applying the XeroAMEDEUS DOTFILES         #"
      echo "#################################################"
      echo

     # Install yay for use
     pacman -S --needed git base-devel
     git clone https://aur.archlinux.org/yay.git
     cd yay
     makepkg -si

     # Install Swaylockd
     wget https://github.com/jirutka/swaylockd/archive/v0.1.0/swaylockd-0.1.0.tar.gz
     tar -xzf swaylockd-0.1.0.tar.gz
     cd swaylockd-0.1.0

     make build
     make install DESTDIR=/ prefix=/usr/local

			
     # Install the necessary packages for XeroAMEDEUS
     yay -Sy hyprland-git swww-git ttf-font_name-nerd otf-font_name-nerd  wofi dunst jq eww-wayland swayidle swaylock-effects-git  sway-audio-idle-inhibit-git bc pamixer light-git papirus-icon-theme playerctl cava kitty xdg-desktop-portal-wlr grim slurp wl-clipboard socat swappy cliphist hyprpicker nm-connection-editor dictd wl-clip-persist-git blueberry

			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-catppuccin-git && cd ~/xero-catppuccin-git/ && ./install.sh
			sleep 3
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
          tput setaf 4
          echo "Please manually reboot your system to apply changes."
          tput sgr0
        fi
        exit 0

      ;;

    2 )
      echo
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-dunes-git.git && cd ~/xero-dunes-git/ && ./install.sh
			sleep 3
      echo
      # Prompt the user to reboot
        tput setaf 4
        read -p "Customization Restored. Reboot recommended. Reboot now? (y/n): " reboot_response
        tput sgr0
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo
          echo "Please manually reboot your system to apply changes."
        fi
        exit 0

      ;;

    3 )
      echo
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/xerolinux/xero-nord-git.git && cd ~/xero-nord-git/ && ./install.sh
			sleep 3
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
          tput setaf 4
          echo "Please manually reboot your system to apply changes."
          tput sgr0
        fi
        exit 0

      ;;

    4 )
      echo
      echo "#################################################"
      echo "#             Applying Selected Rice            #"
      echo "#################################################"
      echo
			sleep 2
			cd ~ && git clone https://github.com/AmadeusWM/dotfiles-hyprland.git && cd dotfiles-hyprland && cp -r ./* ~/.config/hypr && mv ~/.config/hypr/_hyprland.conf ~/.config/hypr/hyprland.conf 
			sleep 3
      echo
      # Prompt the user to reboot
        tput setaf 4
        read -p "Customization Restored. Reboot recommended. Reboot now? (y/n): " reboot_response
        tput setaf 0
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo shutdown -r --now
        else
          echo
          tput setaf 4
          echo "Please manually reboot your system to apply changes."
          tput sgr0
        fi
        exit 0

      ;;

    6 )
      echo
      sleep 2
      sh /usr/local/bin/flatfix
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    7 )
      echo
      sleep 2
      sh /usr/local/bin/stup
      sleep 2
      clear && sh /usr/share/xerowelcome/scripts/xero_rices.sh

      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
