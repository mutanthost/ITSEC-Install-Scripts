#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

GITREPO=https://github.com/oddcod3/Phantom-Evasion
BRANCH=master
GITREPOROOT=/opt/ITSEC/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor/phantom-evasion/oddcod3/Phantom-Evasion
GITCONFDIR=/opt/ITSEC/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor/phantom-evasion/oddcod3/Phantom-Evasion/.git
GITCLONEDIR=/opt/ITSEC/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor/phantom-evasion/oddcod3
EXECUTEABLE1=phantom-evasion.sh
EXECUTEABLE2=phantom-evasion
EXECUTEABLE3=phantom-evasion.py
BINDIR=/usr/local/bin
DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor
DSKTPFLSDEST=/home/$USER/.local/share/applications/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor
DSKTPFL=phantom-evasion.desktop
GITRESET () {
	git clean -f
	git fetch origin
	git reset --hard origin/$BRANCH
	git pull
}
GITSBMDLINIT () {
	git submodule init
	git submodule update --recursive
	sudo updatedb && sudo ldconfig
}

echo "${bold}
 ____  _   _    _    _   _ _____ ___  __  __ 
|  _ \| | | |  / \  | \ | |_   _/ _ \|  \/  |
| |_) | |_| | / _ \ |  \| | | || | | | |\/| |
|  __/|  _  |/ ___ \| |\  | | || |_| | |  | |
|_|   |_| |_/_/   \_\_| \_| |_| \___/|_|  |_|
                                             
 _____ 
|_____|
       
 _______     ___    ____ ___ ___  _   _ 
| ____\ \   / / \  / ___|_ _/ _ \| \ | |
|  _|  \ \ / / _ \ \___ \| | | | |  \| |
| |___  \ V / ___ \ ___) | | |_| | |\  |
|_____|  \_/_/   \_\____/___\___/|_| \_|
                                        

UPDATE oddcod3/Phantom-Evasion
${normal}"

if [ ! -d $GITCONFDIR ]

then

mkdir -p $GITCLONEDIR
cd $GITCLONEDIR
git clone -b $BRANCH $GITREPO

else

echo "${bold}REPO EXISTS, skip clone...${normal}"

fi

cd $GITREPOROOT

if git checkout $BRANCH &&
    git fetch origin $BRANCH &&
    [ `git rev-list HEAD...origin/$BRANCH --count` != 0 ] &&
    git merge origin/$BRANCH
then
    
cd $GITREPOROOT

### DEPS:
# sudo apt-get install gcc mingw-w64 apktool openssl metasploit zipalign
# metasploit already installed, apktool installed with fatrat

cd $GITREPOROOT 
git clone https://github.com/pyinstaller/pyinstaller
cd pyinstaller
GITSBMDLINIT
cd bootloader
python ./waf distclean all
cd ..
sudo python setup.py install

### DEPS END

#sudo -H pip 3 install PyInstaller
GITSBMDLINIT
####### SERVER

cd $GITREPOROOT 
GITRESET
GITSBMDLINIT

####### SERVER

cd $GITREPOROOT 
git clone https://github.com/pyinstaller/pyinstaller
cd pyinstaller
GITRESET
GITSBMDLINIT
cd bootloader
python ./waf distclean all
cd ..
sudo python setup.py install
cd ..

cd $GITREPOROOT 

cd $GITREPOROOT 

echo '#!/bin/bash

cd /opt/ITSEC/9.Maintain-Access/1.OS-Backdoors/0.MultiOS-Backdoor/phantom-evasion/oddcod3/Phantom-Evasion

python3 phantom-evasion.py ' > $GITREPOROOT/$EXECUTEABLE1

chmod +x $GITREPOROOT/$EXECUTEABLE1
chmod +x $GITREPOROOT/$EXECUTEABLE3
sudo rm -f $BINDIR/$EXECUTEABLE2
sudo ln -s $GITREPOROOT/$EXECUTEABLE1 $BINDIR/$EXECUTEABLE2
mkdir -p $DSKTPFLSDEST && cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL

echo "${bold}
UPDATED
${normal}"

else

echo "${bold}
UP TO DATE
${normal}"
	
fi

