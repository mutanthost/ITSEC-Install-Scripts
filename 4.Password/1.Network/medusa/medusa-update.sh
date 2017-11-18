#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

GITREPO=https://github.com/jmk-foofus/medusa.git
GITREPOROOT=/opt/ITSEC/4.Password/1.Network/medusa/jmk-foofus/medusa
GITCONFDIR=/opt/ITSEC/4.Password/1.Network/medusa/jmk-foofus/medusa/.git
GITCLONEDIR=/opt/ITSEC/4.Password/1.Network/medusa/jmk-foofus
DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/4.Password/1.Network
DSKTPFLSDEST=/home/$USER/.local/share/applications/4.Password/1.Network
DSKTPFL=medusa.desktop
GITRESET () {
	git clean -f
	git fetch origin
	git reset --hard origin/master
	git pull
}
GITSBMDLINIT () {
	git submodule init
	git submodule update --recursive
	sudo updatedb && sudo ldconfig
}

echo "${bold}
 __  __ _____ ____  _   _ ____    _    
|  \/  | ____|  _ \| | | / ___|  / \   
| |\/| |  _| | | | | | | \___ \ / _ \  
| |  | | |___| |_| | |_| |___) / ___ \ 
|_|  |_|_____|____/ \___/|____/_/   \_\
              
UPDATE
${normal}"

if [ ! -d $GITCONFDIR ]

then

mkdir -p $GITCLONEDIR
cd $GITCLONEDIR
git clone $GITREPO

else

echo "${bold}REPO EXISTS, skip clone...${normal}"

fi

cd $GITREPOROOT

if git checkout master &&
    git fetch origin master &&
    [ `git rev-list HEAD...origin/master --count` != 0 ] &&
    git merge origin/master
then
    
cd $GITREPOROOT

sudo rm -r $GITREPOROOT/deps
GITRESET
make clean
GITSBMDLINIT

mkdir deps
cd deps

cd afpfs-ng
sudo make uninstall 
make clean
GITRESET
GITSBMDLINIT
./configure
make -j 4 
sudo make install 
cd $GITREPOROOT

./configure 
make -j 4
sudo make install
#

mkdir -p $DSKTPFLSDEST
cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL


echo "${bold}
UPDATED
${normal}"

else

echo "${bold}
UP TO DATE
${normal}"
	
fi

