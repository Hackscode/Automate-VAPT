mkdir -p `pwd`/telnet/encryption/
echo $1
IFS=':' read var3 var4 <<< "$1"
nmap -Pn -n --script=telnet-encryption $var3 -p $var4 -oN `pwd`/telnet/encryption/$1