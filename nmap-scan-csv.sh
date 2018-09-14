mkdir -p `pwd`/scans/
for file in `pwd`/*; do if [[ ${file##*/} == *".xml"* ]];
then var="${file##*/}"
#IFS='.' read var1 var2 var3 var4 var5<<< "$var"
cat "$var" | xmlstarlet sel -T -t -m "//state[@state='open']" -m ../../.. -m hostnames/hostname -i @name -o ' (' -v @name -o ')' -b -b -b -o "" -m .. -v @portid -o ',' -v @protocol -o "," -m service -v @name -i "@tunnel=''" -o 's' -b -o "," -v @product -o ' ' -v @version -v @extrainfo -b -n - | awk -F ',' -v OFS=',' '$2 == "tcp" { $2 = "TCP" }1' > `pwd`/scans/"$var.csv"
fi
done
