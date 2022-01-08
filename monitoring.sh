#!/bin/bash

echo $(date +%x_%H:%M:%S)" Monitoring started"
tomcat_pid() {
  TOMCAT_INSTALLATION_DIR=$(cat /etc/init.d/tomcat | grep 'CATALINA_HOME=' | cut -d '=' -f 2)
  echo `ps x | grep $TOMCAT_INSTALLATION_DIR | grep -v grep | cut -d ' ' -f 2`
}
start() {
  pid=$(tomcat_pid)
  if [ -n "$pid" ] 
  then
    echo "Tomcat is already running (pid: $pid)"
  else
    echo "Starting tomcat"
    /etc/init.d/tomcat start
  fi
  return 0
}

pid=$(tomcat_pid)

if [ -n "$pid" ]
  then
    echo "Tomcat is running with pid: $pid"
  else
    echo "Tomcat is not running"
    start
	pid=$(tomcat_pid)
	echo "Tomcat is started with monitoring service with new pid: $pid"	
  fi
echo $(date +%x_%H:%M:%S)" Monitoring Completed"

exit 0
