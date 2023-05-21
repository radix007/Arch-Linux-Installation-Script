#!/bin/env bash
# File : yay_packages.sh


sleep 4
echo "----------------------------------------------------------------------------------- "
echo "                                  INSTALLING yay                                    "
echo "-------------------------------------------------------------------------------------"
cd
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S aic94xx-firmware wd719x-firmware notion-app spotify-adblock vmware-workstation simplescreenrecorder visual-studio-code-bin yt-dlp-git mkinitcpio-numlock

yay -Sc
yay -Scc
sudo systemctl start firewalld.service
sudo systemctl enable firewalld.service
sudo systemctl start systemd-resolved.service 
sudo systemctl enable systemd-resolved.service
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service 
sudo systemctl enable sddm.service 
