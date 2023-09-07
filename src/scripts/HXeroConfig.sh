



## Install the dotfiles

############################################
## CREDITS:   AmadeusWM			   #
## NAME:      XEROAMADEUS		   #
############################################
git clone https://github.com/AmadeusWM/dotfiles-hyprland.git
cd dotfiles-hyprland
cp -r ./* ~/.config/hypr
# Rename config file
mv ~/.config/hypr/_hyprland.conf ~/.config/hypr/hyprland.conf 
