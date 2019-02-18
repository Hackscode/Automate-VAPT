#if [[ $1 == *":"* ]];
#then var="$1"
mkdir -p `pwd`/http/http_trace/
mkdir -p `pwd`/http/nikto/
mkdir -p `pwd`/http/EyeWitness/
mkdir -p `pwd`/http/http_methods/
mkdir -p `pwd`/http/http_headers/

echo $1
IFS=':' read var1 var2 <<< "$1"
nmap -Pn -n --script=http-trace $var1 -p $var2 -d -oN `pwd`/http/http_trace/$1
nmap -Pn -n --script=http-methods $var1 -p $var2 -d -oN `pwd`/http/http_methods/$1
nmap -Pn -n --script=http-headers $var1 -p $var2 -d -oN `pwd`/http/http_headers/$1
/usr/bin/perl /usr/bin/nikto -h $var1 -p $var2 -F txt -o `pwd`/http/nikto/$1
eyewitness --web --no-prompt --single "$1" -d `pwd`/http/EyeWitness/$1
