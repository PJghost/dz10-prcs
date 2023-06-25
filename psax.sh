#!/bin/bash
header="%-10s %-20s %-30s %15s\n"

printf "$header" PID USER COMM
for proc in `ls  /proc/ | egrep "^[0-9]" | sort -n`
    do
    User=`awk '/Uid/{print $2}' /proc/$proc/status`

    if [[ User -eq 0 ]]
    then
    UserName='root'
    else
    UserName=`grep $User /etc/passwd | awk -F ":" '{print $1}'`
    fi
    command=$(cat /proc/$proc/comm)
    if [[ -n $command ]]; then
       printf "$header" $proc $UserName $command
    fi
done
