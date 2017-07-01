#!/bin/bash

#http://www.hackingvoip.com/sec_tools.html

#http://www.hackingvoip.com/tools/udpflood.tar.gz

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}
 _   _ ____  ____  _____ _     ___   ___  ____  _____ ____  
| | | |  _ \|  _ \|  ___| |   / _ \ / _ \|  _ \| ____|  _ \ 
| | | | | | | |_) | |_  | |  | | | | | | | | | |  _| | |_) |
| |_| | |_| |  __/|  _| | |__| |_| | |_| | |_| | |___|  _ < 
 \___/|____/|_|   |_|   |_____\___/ \___/|____/|_____|_| \_\
           
${normal}"

mkdir -p /opt/ITSEC/2.Vulnerability-Analysis/10.Stresstest/udp-flooder

DOWNLOADDIR=/opt/ITSEC/2.Vulnerability-Analysis/10.Stresstest/udp-flooder
BINROOT=/opt/ITSEC/2.Vulnerability-Analysis/10.Stresstest/udp-flooder/udpflood
#EXECUTEABLE1=pig.py
#EXECUTEABLE2=pig
EXECUTEABLE1=udpflood
EXECUTEABLE2=udpflood

DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/2.Vulnerability-Analysis/10.Stresstest
DSKTPFLSDEST=/home/$USER/.local/share/applications/2.Vulnerability-Analysis/10.Stresstest
DSKTPFL=udpflood.desktop

cd $DOWNLOADDIR
sudo rm /usr/local/bin/$EXECUTEABLE2
sudo updatedb
sudo ldconfig

wget http://www.hackingexposedvoip.com/tools/udpflood.tar.gz -O udpflood.tar.gz 
tar xvf udpflood.tar.gz
cd udpflood
make
#chmod +x $GITREPOROOT/$EXECUTEABLE1
#sudo ln -s $GITREPOROOT/$EXECUTEABLE1 /usr/local/bin/$EXECUTEABLE2

chmod +x $BINROOT/$EXECUTEABLE1
sudo ln -s $BINROOT/$EXECUTEABLE1 /usr/local/bin/$EXECUTEABLE2

mkdir -p $DSKTPFLSDEST && cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL