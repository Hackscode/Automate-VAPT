dos2unix file.txt
prime () {
num=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $1 | wc -l | cut -d " " -f1`
i=2
if [ "$num" != "1" ] && [ "$num" != "2" ]
then
while [ $i -lt $num ];
do
  if [ `expr $num % $i` -eq 0 ]
  then
      echo $((num/2))
      exit

  fi
  num=`expr $num + 1`
done
else
        echo "$num"
fi
}

echo "Welcome To Automation"
echo ""
echo ""
read -p "Please Enter New project Name:" DIR
mkdir $DIR
read -p "Please Enter the list containing the ip-address:" FILE

if [ -f $FILE ];
then

l=`grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $FILE | wc -l | cut -d " " -f1`
grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $FILE > main.txt
echo $l ip-address found

cd "$(dirname "${BASH_SOURCE[0]}")"/$DIR
echo "Sarting VAPT Phase 1:"
read -p "Please Enter number of threads min (1) && max ($l): "  THREADS
#read -p "Please Enter nmap arguments: "  ARGUMENTS
mkdir nmap_scan
cd "$(dirname "${BASH_SOURCE[0]}")"/nmap_scan
cp ../../main.txt . 
ppss -f main.txt -c 'nmap -Pn -n -A -oA "$ITEM" "$ITEM"' -p $THREADS
echo "Nmap Scan completed"
mkdir xml_final
cp *.xml xml_final/
python "$(dirname "${BASH_SOURCE[0]}")"/../../merge.py -s=xml_final/ > ../final.xml
sed -E -i "s/[0-9a-fA-F:]{17}//" ../final.xml
rm -rf xml_final/
cd "$(dirname "${BASH_SOURCE[0]}")"/../..
for i in $(cat file.txt); do 
cat $DIR/"final.xml" | xmlstarlet sel -T -t -m "$i" -m ../../.. -v address/@addr -m hostnames/hostname -i @name -o '  (' -v @name -o ')' -b -b -b -o "," -m .. -v @portid -o ',' -v @protocol -o "," -m service -v @name -i "@tunnel=''" -o 's' -b -o "," -v @product -o ' ' -b -n > output.csv
sed -e :a -e '$!N;s/\n,/,/;ta' -e 'P;D' output.csv > output1.csv
mv output1.csv output.csv
cat output.csv | cut -f 1,2 -d "," | tr "," ":" | sed 's/\(.*\)\(..:..:..:..:..:..\)\(.*\)//g' | sed '/^$/d' > $DIR/$(echo $i | sed "s/'//g" | cut -f 2,2 -d "=" | cut -f 1,1 -d "-" | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]').txt ; done
cd "$(dirname "${BASH_SOURCE[0]}")"/$DIR
for file in `pwd`/*; do if [[ ${file##*/} == *".txt"* ]];
then var="${file##*/}"
IFS='.' read var1 var2 <<< "$var"
if [ $(wc -l "$var" | cut -d " " -f1) != 0 ];
then
#bash ../scripts/$var1.sh $var $DIR $var1 $l
if [ $var1 == "http" ]
then
echo http
rm -rf ppss_dir/
pme=$(prime $var)
dos2unix ../scripts/http.sh
ppss -f $var -c 'bash ../scripts/http.sh "$ITEM"' -p $pme
fi
if [ $var1 == "microsoft" ]
then
echo netbios
rm -rf ppss_dir/
pme=$(prime $var)
dos2unix ../scripts/microsoft.sh
ppss -f $var -c 'bash ../scripts/microsoft.sh "$ITEM"' -p $pme
fi
if [ $var1 == "telnet" ]
then
echo telnet
rm -rf ppss_dir/
pme=$(prime $var)
dos2unix ../scripts/telnet.sh
ppss -f $var -c 'bash ../scripts/telnet.sh "$ITEM"' -p $pme
fi
if [ $var1 == "ssh" ]
then
echo ssh
rm -rf ppss_dir/
pme=$(prime $var)
dos2unix ../scripts/ssh.sh
ppss -f $var -c 'bash ../scripts/ssh.sh "$ITEM"' -p $pme
fi
if [ $var1 == "ssl" ]
then
echo ssl
rm -rf ppss_dir/
pme=$(prime $var)
dos2unix ../scripts/ssl.sh
ppss -f $var -c 'bash ../scripts/ssl.sh "$ITEM"' -p $pme
fi
fi
fi
done
else
   echo "File $FILE does not exist."
exit
fi
