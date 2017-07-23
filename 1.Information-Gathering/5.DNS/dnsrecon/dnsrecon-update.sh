#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}
 ____  _   _ ____  ____  _____ ____ ___  _   _ 
|  _ \| \ | / ___||  _ \| ____/ ___/ _ \| \ | |
| | | |  \| \___ \| |_) |  _|| |  | | | |  \| |
| |_| | |\  |___) |  _ <| |__| |__| |_| | |\  |
|____/|_| \_|____/|_| \_\_____\____\___/|_| \_|
           
${normal}"

GITREPOROOT=/opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon
GITREPOGITFILE=$GITREPOROOT/.git
DSKTPFLS=/opt/ITSEC-Install-Scripts/0.Initial/usrlcl/.local/share/applications/1.Information-Gathering/5.DNS
DSKTPFLSDEST=/home/$USER/.local/share/applications/1.Information-Gathering/5.DNS
DSKTPFL=dnsrecon.desktop

if [ ! -d $GITREPOGITFILE ]

then

mkdir -p /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator
cd /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator
git clone https://github.com/darkoperator/dnsrecon.git

else

echo "repo exists"

fi

cd $GITREPOROOT

if git diff-index --quiet HEAD --; then
    echo "UP TO DATE"

else

cd $GITREPOROOT
sudo rm -r /usr/local/bin/dnsrecon
sudo rm -r /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon/dnsrecon
git clean -f
git fetch origin
git reset --hard origin/master
git pull
git submodule init
git submodule update --recursive
sudo -H pip2 install -r requirements.txt 

echo "#!/bin/bash 
cd /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon
python dnsrecon.py" > /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon/dnsrecon
chmod +x /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon/dnsrecon
sudo ln -s /opt/ITSEC/1.Information-Gathering/5.DNS/dnsrecon/darkoperator/dnsrecon/dnsrecon /usr/local/bin/dnsrecon
rm -f $DSKTPFLSDEST/$DSKTPFL
mkdir -p $DSKTPFLSDEST
cp $DSKTPFLS/$DSKTPFL $DSKTPFLSDEST/$DSKTPFL

fi