#!/bin/bash

rm -rf /home/$USER/.config/xfce4
cp -R /opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.config/xfce4 /home/$USER/.config



sudo updatedb
sudo ldconfig
xfce4-panel -r
xfce4-session-logout

#echo "force reboot to adapt changes - else the panel will be blank"
#sudo reboot