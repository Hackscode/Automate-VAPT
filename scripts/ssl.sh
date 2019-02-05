mkdir -p `pwd`/ssl/ssl_enum/
mkdir -p `pwd`/ssl/testssl/
mkdir -p `pwd`/ssl/ssl_cert/
mkdir -p `pwd`/ssl/cert_intaddr/
echo $1
IFS=':' read var3 var4 <<< "$1"
bash ../scripts/testssl/testssl.sh --warnings off $1 > `pwd`/ssl/testssl/$1
nmap -Pn -n --script=ssl-enum-ciphers $var3 -p $var4 -oN `pwd`/ssl/ssl_enum/$1
nmap -Pn -n --script=ssl-cert $var3 -p $var4 -oN `pwd`/ssl/ssl_cert/$1
nmap -Pn -n --script=ssl-cert-intaddr $var3 -p $var4 -oN `pwd`/ssl/ssl_intaddr/$1
