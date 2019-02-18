RED='\033[0;31m'
GREEN='\033[0;32m'
echo -e "${RED}Installing Dependencies" 
apt-get update

echo "Installing PPSS"

wget -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/ppss/ppss_2.97_noarch.deb
dpkg -i ppss_2.97_noarch.deb
rm -rf ppss_2.97_noarch.deb
echo -e "${GREEN}PPSS installed"

echo -e "${RED}Installing xmlstarlet"
apt-get install xmlstarlet 
echo -e "${GREEN}Xmslstarlet Installed"

echo -e "${RED}Installing eyewitness"
apt-get install eyewitness
echo -e "${GREEN}eyewitness Installed"

echo -e "${GREEN}All dependenices Installed"
