#!/bin/bash

date=$(date); 
if [[ $* == *-w* ]]; then
    filename="reports/$date-report.txt"
else
  # Clear the report.txt file
    filename="reports/temp-report.txt"
    cp /dev/null temp-report.txt;
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
