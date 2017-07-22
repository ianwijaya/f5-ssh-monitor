#!/bin/bash
IP=`echo $1 | sed 's/::ffff://'`
user="testf5" # change to test user
cert="/home/admin/my-openssh-key" #change to ssh public key location
dir_to_check="~"
command="ls -l $dir_to_check | wc -l"

# Check if there is a prior instance of the monitor running
bn=`basename $0`
pidfile="/var/run/${bn%_*}.$IP.pid"
if [ -f $pidfile ]
then
   kill -9 `cat $pidfile` > /dev/null 2>&1
fi
echo "$$" > $pidfile

#start the test
#disable GSSAPIauthentication for minimal check duration, change bash
test1=`ssh -4 -o "GSSAPIAuthentication=no" -i $cert -l $user $IP $command 2> /dev/null`
if [[ ${test1} =~ ^[0-9]+$ ]]; then
  if [[ ${test1} -gt 0 ]]; then
    echo "UP"
  fi
fi

rm -f "${pidfile}"
#test
