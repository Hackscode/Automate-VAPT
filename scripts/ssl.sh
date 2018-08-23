mkdir -p `pwd`/ssl/ssl_enum/
mkdir -p `pwd`/ssl/testssl/
echo $1
IFS=':' read var3 var4 <<< "$1"
bash ../scripts/testssl/testssl.sh $1 > `pwd`/ssl/testssl/$1
nmap -Pn -n --script=ssl-enum-ciphers $var3 -p $var4 -oN `pwd`/ssl/ssl_enum/$1
