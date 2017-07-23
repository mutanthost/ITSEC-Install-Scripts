#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}
 ____   _    ____ ____ _____     _______ ____  _   _ ____  
|  _ \ / \  / ___/ ___|_ _\ \   / / ____|  _ \| \ | / ___| 
| |_) / _ \ \___ \___ \| | \ \ / /|  _| | | | |  \| \___ \ 
|  __/ ___ \ ___) |__) | |  \ V / | |___| |_| | |\  |___) |
|_| /_/   \_\____/____/___|  \_/  |_____|____/|_| \_|____/ 
    
${normal}"

GITREPOROOT=/opt/ITSEC/1.Information-Gathering/5.DNS/passivedns/gamelinux/passivedns
GITREPOGITFILE=$GITREPOROOT/.git
DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/1.Information-Gathering/5.DNS
DSKTPFLSDEST=/home/$USER/.local/share/applications/1.Information-Gathering/5.DNS
DSKTPFL=passivedns.desktop

if [ ! -d $GITREPOGITFILE ]

then

mkdir -p /opt/ITSEC/1.Information-Gathering/5.DNS/passivedns/gamelinux
cd /opt/ITSEC/1.Information-Gathering/5.DNS/passivedns/gamelinux
git clone https://github.com/gamelinux/passivedns.git

else

echo "repo exists"

fi

cd $GITREPOROOT

if git diff-index --quiet HEAD --; then
    echo "UP TO DATE"

else


cd $GITREPOROOT
sudo make uninstall
git clean -f
git fetch origin
git reset --hard origin/master
git pull
git submodule init 
git submodule update --recursive
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure
make -j 4
sudo make install
rm -f $DSKTPFLSDEST/$DSKTPFL
mkdir -p $DSKTPFLSDEST
cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL
fi