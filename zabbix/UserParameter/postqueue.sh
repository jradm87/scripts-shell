#!/bin/bash
#Get queue size on postfix to create zabbix trigger

value=`postqueue -p | grep Requests | awk -F" "  '{print $5}'`

if [ -z "$value" ]; then
        echo "0"
else
        echo $value
fi

