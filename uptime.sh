#!/bin/bash

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  [23]) echo "HTTP connectivity is up";;
  5) echo "The web proxy won't let us through";;
  *) err "The network is down or very slow"; exit 1 ;;
esac

aflag='';
fflag='';
while getopts 'af' flag; do
  case "${flag}" in
    a) aflag='true' ;;
    f) fflag='true' ;;
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

success=( );
failure=( );

while IFS= read -r line; do

    curl=$(curl -Is "$line");
    res=$?
    if test "$res" != "0"; then
        printf "the curl command failed for %s with: %s \n" "$line" "$res" | tee -a "$filename";
        failure+=("$line");
    else
        printf "The curl command was successful for %s. It exited with a status code of:" "$line" | tee -a "$filename";
        printf "%s" "$curl" | head -n 1 | tee -a "$filename";
        printf "\n";
        success+=("$line");
    fi

done < urls.txt

if [[ -n $fflag ]]; then
cp /dev/null reports/formatted-report.txt;
 printf "SUCCESS:\n"   
 printf '%s\n' "${success[@]}" | tee -a "reports/formatted-report.txt";
 printf "\n" | tee -a "reports/formatted-report.txt";
 printf "FAILURE:\n" | tee -a "reports/formatted-report.txt";
 printf '%s\n' "${failure[@]}" | tee -a "reports/formatted-report.txt";
fi

