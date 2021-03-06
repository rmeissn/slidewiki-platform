#!/bin/zsh
#zsh is needed for floating point calculations, e.g. ((idle = 100 - idle))

# to pretty print: ./combine_data.sh combined_converted.csv browser_data.csv| column -s";" -t

if [ "$#" != "2" ]; then
  echo "Too few/much arguments! Use like ./combine_data.sh INPUT_FILE_NAME_SYSTEM_DATA INPUT_FILE_NAME_BROWSER_DATA"
  echo "e.g. './combine_data.sh combined_converted.csv browser_data.csv'"
  exit 1
fi

i=0;
while read p; do
  if [ "$i" -eq "0" ]; then
    echo "$p;%cpu_usage;txkb/s;rxkb/s;kbmemfree;kbmemused"
    i=$((i + 1))
    continue
  fi
  peers=$(echo $p | q-text-as-data --delimiter=";" "select c1 from -")
  start=$(echo $p | q-text-as-data --delimiter=";" "select c2 from -")
  start=$(echo $start | cut -b1-10) #convert to seconds by round.floor
  end=$(echo $p | q-text-as-data --delimiter=";" "select c3 from -")
  end=$(echo $end | cut -b1-10) #convert to seconds by round.floor
  ((end = end + 1)) #add one to become round.ceil
  delay=$(echo $p | q-text-as-data --delimiter=";" "select c4 from -")
  variance=$(echo $p | q-text-as-data --delimiter=";" "select c5 from -")
  deviation=$(echo $p | q-text-as-data --delimiter=";" "select c6 from -")
  idle=$(cat $1 | q-text-as-data --delimiter=";" -H "select avg(\"%idle\") from - where timestamp >= $start and timestamp <= $end")
  ((idle = 100 - idle))
  tx=$(cat $1 | q-text-as-data --delimiter=";" -H "select avg(\"txkb/s\") from - where timestamp >= $start and timestamp <= $end")
  rx=$(cat $1 | q-text-as-data --delimiter=";" -H "select avg(\"rxkb/s\") from - where timestamp >= $start and timestamp <= $end")
  memfree=$(cat $1 | q-text-as-data --delimiter=";" -H "select avg(\"kbmemfree\") from - where timestamp >= $start and timestamp <= $end")
  memused=$(cat $1 | q-text-as-data --delimiter=";" -H "select avg(\"kbmemused\") from - where timestamp >= $start and timestamp <= $end")
  i=$((i + 1))
  echo "$peers;$start;$end;$delay;$variance;$deviation;$idle;$tx;$rx;$memfree;$memused"
done < $2

rm $1 $2
