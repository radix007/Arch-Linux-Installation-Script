#!/bin/env bash
# File : Applications.sh




lspci -k | grep -A 2 -E "(VGA|3D)"

sleep 2

echo -e "\n\n\n"

sudo reflector --verbose --protocol https --latest 10 --sort rate --save /etc/pacman.d/mirrorlist


sudo pacman -S git firewalld base-devel bash-completion nvidia nvidia-utils nvidia-settings nvidia-prime git mesa acpi acpi_call vlc firefox konsole tmux thunderbird qbittorrent firewalld tmux rsync signal-desktop wireguard-tools libreoffice-fresh calibre clamav restic ksysguard p7zip dolphin tor spectacle okular hexedit gdb gthumb kalendar eog torbrowser-launcher discord neofetch ghidra pulseaudio-bluetooth pulseaudio-jack pulseaudio pulseaudio-alsa pulseaudio-equalizer
sudo cp blacklistnouveau.conf /etc/modprobe.d/
sudo mkinitcpio -P


bash yay_packages.sh

sudo reboot
echo ""
echo ""
echo ""
echo "------------------------------------------_#############################################################_---------------------------------------------"
echo ""
echo "                                                          Done With Installation Enjoy Arch                                                             "
echo ""
echo "------------------------------------------------------------------------------------------------------------------------------------------------------"


