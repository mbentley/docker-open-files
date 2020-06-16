#!/bin/bash

# check to see if lsof exists in the host namespace
if [ "$(nsenter -t 1 -u -m -n -i lsof -v 2> /dev/null; echo $?)" = "0" ]
then
  echo "OK: lsof found on the host"
  # lsof exists in the host namespace; use it because of accuracy
  nsenter -t 1 -m -u -n -i bash -c 'echo -e "FILES\tPID\tPROCESS"; lsof -nP 2>/dev/null | awk '"'"'{ print $2; }'"'"' | sort -rn | uniq -c | sort -rn | head -5 | awk '"'"'{print $1 " " $2}'"'"' | while IFS= read -r LINE; do PID="$(echo "$LINE" | awk '"'"'{print $2}'"'"')"; echo -e "$(echo "$LINE" | awk '"'"'{print $1}'"'"')\t${PID}\t$(ps -fp "${PID}" -o cmd=)"; done'
else
  # lsof does not exist in the host namespace; use it from the container
  echo "WARNING: lsof not found on the host; results may not be 100% accurate"
  nsenter -t 1 -u -n -i bash -c 'echo -e "FILES\tPID\tPROCESS"; lsof -nP 2>/dev/null | awk '"'"'{ print $2; }'"'"' | sort -rn | uniq -c | sort -rn | head -5 | awk '"'"'{print $1 " " $2}'"'"' | while IFS= read -r LINE; do PID="$(echo "$LINE" | awk '"'"'{print $2}'"'"')"; echo -e "$(echo "$LINE" | awk '"'"'{print $1}'"'"')\t${PID}\t$(ps -fp "${PID}" -o cmd=)"; done'
fi
