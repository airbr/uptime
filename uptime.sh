#!/bin/bash

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  [23]) echo "HTTP connectivity is up";;
  5) echo "The web proxy won't let us through";;
  *) err "The network is down or very slow"; exit 1 ;;
esac

wflag=''
while getopts 'abf:v' flag; do
  case "${flag}" in
    a) aflag='true' ;;
  esac
done

date=$(date); 
if [[ -n $aflag ]]; then
    filename="reports/$date-report.txt"
else
  # Clear the report.txt file
    filename="reports/temp-report.txt"
    cp /dev/null reports/temp-report.txt;
fi

printf "Report generated on: %s \n" "$date" | tee -a "$filename";

while IFS= read -r line; do

    curl=$(curl -Is "$line");
    res=$?
    if test "$res" != "0"; then
        printf "the curl command failed for %s with: %s \n" "$line" "$res" | tee -a "$filename";
    else
        printf "The curl command was successful for %s. It exited with a status code of:" "$line" | tee -a "$filename";
        printf "%s" "$curl" | head -n 1 | tee -a "$filename";
        printf "\n";
    fi

done < urls.txt
