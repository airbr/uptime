# Uptime

A shell program that reads a list of URL's line by line and checks their connectivity/status with curl. The aim of this tool is to promote network health and awareness with a little customization of the output and reports possible at some point. 

# TODO:

1. Make output of shell script tabular and columned so it can be consumed by other programs more effectively
2. Figure out a way to make two instances of the script talk to each other to get connectivity from two points 


# Usage (Development)

1. Put your URL's in `urls.txt`;

2. Get results printed to standard output 

`sh uptime.sh` 

# Usage (Master branch)

1. Put your URL's in `urls.txt`;

2. Generate a temporary report:

`sh uptime.sh`

Write report to a new file:

`sh uptime.sh -a`

Write a crude formatted file by success/failure:

`sh uptime.sh -f`

## Progress

Small batch of commits in March

 * Passed initial Shellcheck
 * Tested on several urls

# Goals

* Write results in crude/basic tabular format to a file.
* Improve reliability and accuracy
