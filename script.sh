#!/bin/bash

nsenter -t 1 -m -u -n -i bash -c 'echo -e "FILES\tPID\tPROCESS"; lsof -nP 2>/dev/null | awk '"'"'{ print $2; }'"'"' | sort -rn | uniq -c | sort -rn | head -5 | awk '"'"'{print $1 " " $2}'"'"' | while IFS= read -r LINE; do   PID="$(echo "$LINE" | awk '"'"'{print $2}'"'"')";   echo -e "$(echo "$LINE" | awk '"'"'{print $1}'"'"')\t${PID}\t$(ps -fp "${PID}" -o cmd=)"; done'
