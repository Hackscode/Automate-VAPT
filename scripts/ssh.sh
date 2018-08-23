mkdir -p `pwd`/ssh/
echo $1
IFS=':' read var1 var2 <<< "$1"
nmap -Pn -n --script ssh2-enum-algos $var1 -p $var2 -oN `pwd`/ssh/$1
#else nmap -Pn -n --script ssh2-enum-algos $var1 -p 22 -oN `pwd`/ssh/$1


