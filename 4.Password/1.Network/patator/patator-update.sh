#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}
 ____   _  _____  _  _____ ___  ____  
|  _ \ / \|_   _|/ \|_   _/ _ \|  _ \ 
| |_) / _ \ | | / _ \ | || | | | |_) |
|  __/ ___ \| |/ ___ \| || |_| |  _ < 
|_| /_/   \_\_/_/   \_\_| \___/|_| \_\
          
${normal}"

GITREPOROOT=/opt/ITSEC/4.Password/1.Network/patator/lanjelot/patator
GITREPOGITFILE=$GITREPOROOT/.git
EXECUTEABLE1=patator.py
EXECUTEABLE2=patator
EXECUTEABLE3=patator.sh

DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/4.Password/1.Network
DSKTPFLSDEST=/home/$USER/.local/share/applications/4.Password/1.Network
DSKTPFL=patator.desktop

if [ ! -d $GITREPOGITFILE ]

then

mkdir -p /opt/ITSEC/4.Password/1.Network/patator/lanjelot
cd /opt/ITSEC/4.Password/1.Network/patator/lanjelot
git clone https://github.com/lanjelot/patator.git

else

echo "repo exists"

fi

cd $GITREPOROOT

if git diff-index --quiet HEAD --; then
    echo "UP TO DATE"

else

sudo rm -f /usr/local/bin/$EXECUTEABLE2

cd $GITREPOROOT 
git clean -f
git fetch origin
git reset --hard origin/master
git pull
git submodule init
git submodule update --recursive

sudo -H pip2 install pyOpenSSL impacket IPy dnspython
sudo updatedb
sudo ldconfig

echo '#!/bin/bash

cd /opt/ITSEC/4.Password/1.Network/patator/lanjelot/patator
python patator.py "$@"' > patator.sh
chmod +x $GITREPOROOT/$EXECUTEABLE1
chmod +x $GITREPOROOT/$EXECUTEABLE3
sudo ln -s $GITREPOROOT/$EXECUTEABLE3 /usr/local/bin/$EXECUTEABLE2
rm -f $DSKTPFLSDEST/$DSKTPFL
mkdir -p $DSKTPFLSDEST
cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL

fi

