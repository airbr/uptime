#!/bin/env bash
set -uo pipefail;
# set -e is aspired to for this script, currently relies on capturing failed Curl calls

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# A very crude way to check connectivity is to curl google.com
case "$(curl -s --max-time 2 -I https://www.google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
  [23]) echo "HTTP connectivity is up";;
  5) echo "The web proxy won't let us through";;
  *) err "The network is down or very slow"; exit 1 ;;
esac

printf "URL STATUS UP";
printf "\n";

while IFS= read -r line; do

    curl=$(curl -Is --max-time 15 "$line");
    res=$?
  
    if test "$res" != "0"; then
      printf "$line $res No";
      printf "\n";

        # printf "the curl command failed for %s with: %s \n" "$line" "$res";
    else
      printf "$line $res Yes";
      printf "\n";

        # printf "The curl command was successful for %s. It exited with a status code of:" "$line";
        # printf "%s" "$curl" | head -n 1;
        # printf "\n";
    fi
done < urls.txt


