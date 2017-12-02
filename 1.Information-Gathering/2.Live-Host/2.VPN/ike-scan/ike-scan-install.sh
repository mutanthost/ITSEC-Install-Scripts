#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

GITREPO=https://github.com/royhills/ike-scan.git
BRANCH=master
GITREPOROOT=/opt/ITSEC/1.Information-Gathering/2.Live-Host/2.VPN/ike-scan/royhills/ike-scan
GITCLONEDIR=/opt/ITSEC/1.Information-Gathering/2.Live-Host/2.VPN/ike-scan/royhills
DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/1.Information-Gathering/2.Live-Host/2.VPN
DSKTPFLSDEST=/home/$USER/.local/share/applications/1.Information-Gathering/2.Live-Host/2.VPN
DSKTPFL=ike-scan.desktop
GITSBMDLINIT () {
	git submodule init
	git submodule update --recursive
	sudo updatedb && sudo ldconfig
}

echo "${bold}
 ___ _  _______     ____   ____    _    _   _ 
|_ _| |/ / ____|   / ___| / ___|  / \  | \ | |
 | || ' /|  _| ____\___ \| |     / _ \ |  \| |
 | || . \| |__|_____|__) | |___ / ___ \| |\  |
|___|_|\_\_____|   |____/ \____/_/   \_\_| \_|
   
INSTALL
${normal}"

mkdir -p $GITCLONEDIR
cd $GITCLONEDIR
git clone -b $BRANCH $GITREPO
cd $GITREPOROOT

### DEPS:
# no deps noted, feel free to add ...
### DEPS END

make clean
GITSBMDLINIT

autoreconf --install
./configure --with-openssl
make -j 4
sudo make install
mkdir -p $DSKTPFLSDEST
cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL
