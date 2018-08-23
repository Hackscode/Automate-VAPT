mkdir -p `pwd`/microsoft-ds/enum4linux/
mkdir -p `pwd`/microsoft-ds/smb_security_mode/
echo $1
IFS=':' read var3 var4 <<< "$1"
enum4linux -a $1 > `pwd`/microsoft-ds/enum4linux/$1
nmap -Pn -n --script=smb-security-mode.nse $var3 -p $var4 -oN `pwd`/microsoft-ds/smb_security_mode/$1