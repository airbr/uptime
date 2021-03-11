#!/bin/bash

while IFS= read -r line; do

    curl=$(curl -Is "$line");
    res=$?
    if test "$res" != "0"; then
        printf "the curl command failed for %s with: %s \n" "$line" "$res";
    else
        printf "The curl command was successful for %s. It exited with a status code of:" "$line"
        printf "%s" "$curl" | head -n 1;
        printf "\n";
    fi
   
done < urls.txt
