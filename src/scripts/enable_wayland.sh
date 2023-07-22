#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	DarkXero
# Website 	: 	http://xerolinux.xyz
##################################################################################################################
tput setaf 4
echo "###############################################################################"
echo "#                         XeroLinux Wayland Enabler                           #"
echo "#                                                                             #"
echo "#                            !!!! ATTENTION !!!                               #"
echo "#                                                                             #"
echo "#             This Will Allow You To Enable Wayland On Your System            #"
echo "# Be careful though, if you are on nVidia GPU, this might end up not working. #"
echo "#                                                                             #"
echo "#  nVidia users, Test AT YOUR OWN RISK ! If you do Please Report on Discord.  #"
echo "###############################################################################"
tput sgr0
echo
echo "Hello $USER, which Edition are you using ?"
echo
echo "########## Edition Selection ##########"
echo
echo "1.  XeroLinux KDE Plasma."
echo "2.  XeroLinux GNOME (XeroG)."
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo
    if lspci -k | grep -i "VGA" | grep -qi "nvidia"; then
      tput setaf 3
      echo "############################################################################################"
      echo "                    !!! Warning: nVidia proprietary Drivers detected !!!                    "
      echo "                      !!! Test AT YOUR OWN RISK & Report if you do !!!                      "
      echo
      echo "            To enable Wayland with Nvidia, additional configuration is required.            "
      echo "  Please refer to the following URL (Ctrl+Click), for instructions or proceed with caution  "
      echo "                   --- https://community.kde.org/Plasma/Wayland/Nvidia ---                  "
      echo "############################################################################################"
      tput sgr0
      echo
      read -p "Do you Still want to proceed At your own Risk ? (y/n): " proceed_response
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
      echo
        echo "Proceeding with enabling Wayland."

      # Install sddm-git package via pacman
      sudo pacman -Rdd sddm --noconfirm 2>/dev/null
      yay -S sddm-git --noconfirm --needed 2>/dev/null
      # Install Wayland packages via pacman
      sudo pacman -S --noconfirm --needed xorg-xwayland  2>/dev/null; sudo pacman -S --noconfirm --needed kwayland-integration  2>/dev/null; sudo pacman -S --noconfirm --needed plasma-wayland-session  2>/dev/null; sudo pacman -S --noconfirm --needed plasma-wayland-protocols  2>/dev/null; sudo pacman -S --noconfirm --needed xlsclients  2>/dev/null; sudo pacman -S --noconfirm --needed qt5-wayland 2>/dev/null
      # Enable Services
      sudo systemctl enable --now sddm && sudo systemctl enable --now NetworkManager
      # Modify Files
      sudo sed -i "s/Current=.*/Current=breeze/" /usr/lib/sddm/sddm.conf.d/default.conf
      echo

      # Specify the file path
      file_path="/etc/mkinitcpio.conf"
      replacement='MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"'
      # Switch to the root user
      echo "Switching to Super Root (SU) User, required, please type your password"
      if ! su -c true >/dev/null 2>&1; then
          echo "Unable to switch to root. Make sure 'su' is installed and try again."
      fi

      sudo sed -i 's/MODULES=""/'"$replacement"'/' "$file_path"
      sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img && sudo mkinitcpio -P
      echo
      # Check if the /etc/default/grub file exists
      grub_file="/etc/default/grub"
      if [ ! -f "$grub_file" ]; then
          echo "File not found: $grub_file"
          exit 1
      fi

      # Backup the original file
      backup_file="/etc/default/grub.backup"
      sudo cp "$grub_file" "$backup_file"
      # Define the entry you want to add
      new_entry="nvidia_drm.modeset=1"
      echo
      # Read the current GRUB_CMDLINE_LINUX_DEFAULT line from /etc/default/grub
      current_line=$(grep -o 'GRUB_CMDLINE_LINUX_DEFAULT="[^"]*"' /etc/default/grub)

      # Extract the value within the quotes
      current_value=$(echo $current_line | cut -d'"' -f2)

      # Check if the new entry already exists in the current value
      if [[ $current_value == *"$new_entry"* ]]; then
        echo "Entry already exists in GRUB_CMDLINE_LINUX_DEFAULT."
        exit 1
      fi

      # Append the new entry to the current value
      updated_value="${current_value} ${new_entry}"

      # Replace the old line with the updated value in /etc/default/grub
      sudo sed -i "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT=\"$updated_value\"|" /etc/default/grub

      # Update GRUB
      sudo update-grub
      echo
      echo "Original file backed up to: $backup_file"
      echo "GRUB configuration updated successfully!"
      echo
      # Define the line to add
      line="options nvidia-drm modeset=1"

      # Define the file path
      file_path="/etc/modprobe.d/nvidia.conf"

      # Check if the file exists
      if [ ! -f "$file_path" ]; then
          echo "File not found: $file_path"
          echo "Creating the file..."
          su -c "touch $file_path"
      fi

      # Check if the line already exists in the file
      if grep -qF "$line" "$file_path"; then
          echo "Line already exists in $file_path"
      else
          # Add the line to the file
          su -c "echo \"$line\" >> $file_path"
          echo "Line added to $file_path"
      fi

      tput setaf 3
      echo "If you are using Autologin, Please Make Sure to Log Out, Select Plasma Wayland from Drop-Down."
      tput sgr0
      echo
        # Prompt the user to reboot
        read -p "Wayland has been Activated. Reboot recommended. Reboot now? (y/n): " reboot_response
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Wayland installation cancelled."
        exit 0
      fi
    else
      echo
      # Prompt the user if they want to proceed enabling Wayland
      read -p "No Nvidia proprietary drivers detected. Shall we proceed enabling Wayland? (y/n): " proceed_response
      echo
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
        echo "Proceeding with enabling Wayland."
       # Install sddm-git package via pacman
      sudo pacman -Rdd sddm --noconfirm 2>/dev/null
      yay -S sddm-git --noconfirm --needed 2>/dev/null
      # Install Wayland packages via pacman
      sudo pacman -S --noconfirm --needed xorg-xwayland  2>/dev/null; sudo pacman -S --noconfirm --needed kwayland-integration  2>/dev/null; sudo pacman -S --noconfirm --needed plasma-wayland-session  2>/dev/null; sudo pacman -S --noconfirm --needed plasma-wayland-protocols  2>/dev/null; sudo pacman -S --noconfirm --needed xlsclients  2>/dev/null; sudo pacman -S --noconfirm --needed qt5-wayland 2>/dev/null
      # Enable Services
      sudo systemctl enable --now sddm && sudo systemctl enable --now NetworkManager
      # Modify Files
      sudo sed -i "s/Current=.*/Current=breeze/" /usr/lib/sddm/sddm.conf.d/default.conf
      echo
      tput setaf 3
      echo "If you are using Autologin, Please Make Sure to Log Out, Select Plasma Wayland from Drop-Down."
      tput sgr0
      echo
        # Prompt the user to reboot
        read -p "Wayland has been Activated. Reboot recommended. Reboot now? (y/n): " reboot_response
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Wayland installation cancelled."
        exit 0
      fi
    fi

      ;;

    2 )
      echo
    if lspci -k | grep -i "VGA" | grep -qi "nvidia"; then
      tput setaf 3
      echo "############################################################################################"
      echo "                              !!! Warning : nVidia GPU detected !!!                         "
      echo
      echo "            To enable Wayland with Nvidia, additional configuration is required.            "
      echo "    Please refer to the following URL (Ctrl+Click) over at the KDE Wiki for instructions    "
      echo "                --- https://wiki.archlinux.org/title/GDM#Troubleshooting ---                "
      echo "############################################################################################"
      tput sgr0
      echo
      read -p "Do you Still want to proceed At your own Risk ? (y/n): " proceed_response
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
      echo
        echo "Proceeding with enabling Wayland."

      # Modify GDM
      sudo sed -i 's|WaylandEnable|#WaylandEnable|g' /etc/gdm/custom.conf
      echo
      # Specify the file path
      file_path="/etc/mkinitcpio.conf"
      replacement='MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"'
      # Switch to the root user
      echo "Switching to Super Root (SU) User, required, please type your password"
      if ! su -c true >/dev/null 2>&1; then
          echo "Unable to switch to root. Make sure 'su' is installed and try again."
      fi

      sudo sed -i 's/MODULES=""/'"$replacement"'/' "$file_path"
      sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img && sudo mkinitcpio -P
      echo
      # Check if the /etc/default/grub file exists
      grub_file="/etc/default/grub"
      if [ ! -f "$grub_file" ]; then
          echo "File not found: $grub_file"
          exit 1
      fi

      # Backup the original file
      backup_file="/etc/default/grub.backup"
      sudo cp "$grub_file" "$backup_file"

      # Define the entry you want to add
      new_entry="nvidia_drm.modeset=1"
      echo
      # Read the current GRUB_CMDLINE_LINUX_DEFAULT line from /etc/default/grub
      current_line=$(grep -o 'GRUB_CMDLINE_LINUX_DEFAULT="[^"]*"' /etc/default/grub)

      # Extract the value within the quotes
      current_value=$(echo $current_line | cut -d'"' -f2)

      # Check if the new entry already exists in the current value
      if [[ $current_value == *"$new_entry"* ]]; then
        echo "Entry already exists in GRUB_CMDLINE_LINUX_DEFAULT."
        exit 1
      fi

      # Append the new entry to the current value
      updated_value="${current_value} ${new_entry}"

      # Replace the old line with the updated value in /etc/default/grub
      sudo sed -i "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|GRUB_CMDLINE_LINUX_DEFAULT=\"$updated_value\"|" /etc/default/grub

      # Update GRUB
      sudo update-grub
      echo
      echo "Original file backed up to: $backup_file"
      echo "GRUB configuration updated successfully!"
      echo
      # Define the line to add
      line="options nvidia-drm modeset=1"

      # Define the file path
      file_path="/etc/modprobe.d/nvidia.conf"

      # Check if the file exists
      if [ ! -f "$file_path" ]; then
          echo "File not found: $file_path"
          echo "Creating the file..."
          su -c "touch $file_path"
      fi

      # Check if the line already exists in the file
      if grep -qF "$line" "$file_path"; then
          echo "Line already exists in $file_path"
      else
          # Add the line to the file
          su -c "echo \"$line\" >> $file_path"
          echo "Line added to $file_path"
      fi
      echo
      tput setaf 3
      echo "If you are using Autologin, GDM should, in theory default to Wayland."
      tput sgr0
      echo
        # Prompt the user to reboot
        read -p "Wayland has been Activated. Reboot recommended. Reboot now? (y/n): " reboot_response
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Wayland installation cancelled."
        exit 0
      fi
    else
      echo
      # Prompt the user if they want to proceed enabling Wayland
      read -p "No Nvidia GPU detected. You are good for Wayland, Proceed? (y/n): " proceed_response
      echo
      if [[ $proceed_response == "y" || $proceed_response == "yes" ]]; then
        echo "Proceeding with enabling Wayland."
      # Modify GDM
      sudo sed -i 's|WaylandEnable|#WaylandEnable|g' /etc/gdm/custom.conf
      echo
      tput setaf 3
      echo "If you are using Autologin, GDM should, in theory default to Wayland."
      tput sgr0
      echo
        # Prompt the user to reboot
        read -p "Wayland has been Activated. Reboot recommended. Reboot now? (y/n): " reboot_response
      echo
        # Check the user's response
        if [[ $reboot_response == "y" || $reboot_response == "yes" ]]; then
          sudo reboot
        else
          echo "Please manually reboot your system to apply changes."
        fi
      else
        echo "Wayland installation cancelled."
        exit 0
      fi
    fi

      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
