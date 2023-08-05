#!/bin/bash
#set -e
##################################################################################################################
# Written to be used on 64 bits computers
# Author  :   DarkXero
# Website   :   http://xerolinux.xyz
##################################################################################################################
tput setaf 2
echo "###############################################################################"
echo "#               XeroLinux nVidia (Proprietary) Driver Installer               #"
echo "###############################################################################"
tput sgr0
echo
echo "Hello $USER, Please Select An Option Below.."
echo
echo "1.  Check Which nVidia GPU You Have."
echo
echo "############ Vanilla Drivers (Recommended) ############"
echo
echo "2. Latest Vanilla Drivers (900 Series & up)."
echo "3. Latest Open-dkms Drivers (Experimental/Turing+)."
echo
echo "####### TKG Drivers (Optional/Use At Own Risk) ########"
echo
echo "4. Latest TKG Drivers (900 Series & up)."
echo "5. Legacy TKG Drivers (Some 600/700 Series)."
echo
echo "6. Cleanup TKG &/or Vanilla Drivers. (Start Fresh)"
echo
echo "Type Your Selection. To Exit, just close Window."
echo

while :; do

read CHOICE

case $CHOICE in

    1 )
      echo
      echo "##########################################"
      echo "          Checking Installed GPU          "
      echo "##########################################"
      echo
      echo "Your system has the following GPU(s)"
      echo
      sleep 3
      lspci -x | grep VGA
      sleep 3
      echo
            glxinfo | grep -E "OpenGL vendor|OpenGL renderer*"
            sleep 10
      echo
      echo "##################################################################"
      echo "                  Opening nVidia Drivers page...                  "
      echo " Check What Version Your GPU Needs Before Installing or Building. "
      echo "##################################################################"
      sleep 6
      xdg-open https://www.nvidia.com/download/index.aspx?lang=en-us &>/dev/null;
      sleep 1
      clear && sh /usr/share/xerowelcome/scripts/nVidia_drivers.sh
      echo
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"

      ;;

    2 )
      echo
      echo "####################################################"
      echo "            Clean Vanilla Drivers (NFB)             "
      echo "                                                    "
      echo "          Provides Clean Vanilla Drivers            "
      echo "        Limiting you to only 900 Series & Up        "
      echo "####################################################"
      sleep 6
      echo
      echo "##########################################"
      echo "        Installing Vanilla Drivers        "
      echo "##########################################"
      sleep 3
      sudo pacman -S --needed nvidia-dkms nvidia-settings nvidia-utils opencl-nvidia libvdpau lib32-libvdpau lib32-libvdpau lib32-nvidia-utils egl-wayland dxvk-nvapi-mingw libxnvctrl dxvk-bin lib32-libxnvctrl vulkan-icd-loader lib32-vulkan-icd-loader
      sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    3 )
      echo
      echo "####################################################"
      echo "           Experimental Open-dkms Drivers           "
      echo "                                                    "
      echo "      Provides Experimental Open-dkms Drivers       "
      echo "         Limited to Turing Series GPUs & Up         "
      echo "####################################################"
      sleep 10
      echo
      echo "##########################################"
      echo "       Installing Open-dkms Drivers       "
      echo "##########################################"
      sleep 3
      sudo pacman -S --needed nvidia-open-dkms nvidia-settings nvidia-utils opencl-nvidia libvdpau lib32-libvdpau lib32-libvdpau lib32-nvidia-utils egl-wayland dxvk-nvapi-mingw libxnvctrl dxvk-bin lib32-libxnvctrl vulkan-icd-loader lib32-vulkan-icd-loader
      sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    4 )
      
      echo
      echo "####################################################"
      echo "              New Feature Branch (TKG)              "
      echo "                                                    "
      echo "           Provide latest Driver features           "
      echo "####################################################"
      sleep 6
      echo
      echo "##########################################"
      echo "   Installing nVidia R535.x GPU Drivers   "
      echo "##########################################"
      sleep 3
      sudo pacman -S --needed nvidia-dkms-tkg nvidia-utils-tkg nvidia-settings-tkg nvidia-egl-wayland-tkg opencl-nvidia-tkg libxnvctrl lib32-libxnvctrl lib32-nvidia-utils-tkg lib32-opencl-nvidia-tkg dxvk-nvapi-mingw vulkan-icd-loader lib32-vulkan-icd-loader dxvk-bin
      sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    5 )
      echo
      echo "####################################################"
      echo "                Legacy Branch (TKG)                 "
      echo "                                                    "
      echo "       Provides Support for now Legacy GPUs         "
      echo " Use at Own Risk. Stuck on nouveau ? Use LTS Kernel "
      echo "####################################################"
      sleep 6
      echo
      echo "##########################################"
      echo "   Installing nVidia R470.x GPU Drivers   "
      echo "##########################################"
      sleep 3
      sudo pacman -S --needed nvidia-470xx-dkms-tkg nvidia-470xx-utils-tkg nvidia-470xx-settings-tkg opencl-nvidia-470xx-tkg libxnvctrl-470xx lib32-nvidia-470xx-utils-tkg lib32-opencl-nvidia-470xx-tkg lib32-libxnvctrl-470xx
      sleep 3
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            exit
      ;;

    6 )
      echo
      echo "#########################################"
      echo "     Uninstalling all nVidia Drivers     "
      echo "#########################################"
      sleep 3
      # Array of NVIDIA package names
      packages=(
        "nvidia-dkms-tkg"
        "nvidia-utils-tkg"
        "nvidia-settings-tkg"
        "nvidia-egl-wayland-tkg"
        "opencl-nvidia-tkg"
        "libxnvctrl"
        "lib32-libxnvctrl"
        "lib32-nvidia-utils-tkg"
        "lib32-opencl-nvidia-tkg"
        "dxvk-nvapi-mingw"
        "vulkan-icd-loader"
        "lib32-vulkan-icd-loader"
        "lib32-nvidia-libgl"
        "dxvk-bin"
        "nvidia-470xx-dkms-tkg"
        "nvidia-470xx-utils-tkg"
        "nvidia-470xx-settings-tkg"
        "opencl-nvidia-470xx-tkg"
        "libxnvctrl-470xx"
        "lib32-nvidia-470xx-utils-tkg"
        "lib32-opencl-nvidia-470xx-tkg"
        "lib32-libxnvctrl-470xx"
        "nvidia-dkms"
        "nvidia-open-dkms"
        "opencl-nvidia"
        "lib32-opencl-nvidia"
        "libvdpau"
        "lib32-libvdpau"
        "nvidia-settings"
        "nvidia-utils"
        "lib32-nvidia-utils"
        "egl-wayland"
      )
    # Loop through the packages and remove them
    for package in "${packages[@]}"; do
     sudo pacman -Rdd --noconfirm "$package" > /dev/null 2>&1
    done
      sleep 3
      echo
      echo "#######################################"
      echo "                 Done !                "
      echo "#######################################"
            clear && sh /usr/share/xerowelcome/scripts/nVidia_drivers.sh
      ;;

    * )
      echo "#################################"
      echo "    Choose the correct number    "
      echo "#################################"
      ;;
esac
done
