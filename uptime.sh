#!/bin/bash

# Clear the report.txt file
cp /dev/null report.txt;

date=$(date); 

printf "Report generated on: %s \n" "$date" | tee -a report.txt;


while IFS= read -r line; do

    curl=$(curl -Is "$line");
    res=$?
    if test "$res" != "0"; then
        printf "the curl command failed for %s with: %s \n" "$line" "$res" | tee -a report.txt;
    else
        printf "The curl command was successful for %s. It exited with a status code of:" "$line" | tee -a report.txt;
        printf "%s" "$curl" | head -n 1 | tee -a report.txt;
        printf "\n";
    fi
   
done < urls.txt
