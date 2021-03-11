# Uptime

A project to create a program to read a list of URL's and check their health and return the information in a variety of formats. This is intended to be a tool to promote network health and awareness with a little customization and eventually the report or returned HTML will be pretty.

I am kind of just hacking at this as I go.

# Usage


1. Put your URL's in `urls.txt`;


2. Generate a temporary report:

`sh uptime.sh`

Write report to a new file:

`sh uptime.sh -a`

Write a crude formatted file by success/failure:

`sh uptime.sh -f`

## Initial progress

In my first commits to this project, I will be committing a simple bash script which returns information read from a list of URLS.

 * Passed initial Shellcheck
 * Tested on several urls

# Goals

* Write results in crude/basic tabular format to a file.
    *   Add command flag `-a` to write the report to a new dated file OR just overwrite a temp file
* Write results to HTML
* Improve reliability and accuracy
