#!/bin/bash

IP=$(ifconfig | perl -nle'print $& while m{inet ([0-9]+\.){3}(1[0-9]+|[2-9][0-9]*)}g' | grep -Eo '([0-9]+\.){3}[0-9]+' | head -n 1)
PUB_IP=$(curl ifconfig.me)

echo -n "#[fg=colour197]$IP | $PUB_IP"
