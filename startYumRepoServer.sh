#!/bin/bash

# 读取定义的变量
source env.sh
set +u
<<<<<<< HEAD

=======
>>>>>>> 2906f2e6b2397c022d24ed3511889122699c8f19
RPM_PATH=${sysroot}

start(){
cd ${RPM_PATH} && nohup python -m SimpleHTTPServer 80 &>/dev/null &
}
stop(){
ps -ef | egrep "SimpleHTTPServer" | grep -v grep | awk '{print $2}' | xargs kill -9
}
status(){
 P_PID=$(ps -ef | egrep "SimpleHTTPServer" | grep -v grep | awk '{print $2}')
 if [ -n $P_PID ];then
     echo "repo is running"
 else
     echo "repo is down"
 fi
}
action=$1
case $action in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
    *)
        echo "$0 start|stop|restart|status"
<<<<<<< HEAD
       ;;
=======
        ;;
>>>>>>> 2906f2e6b2397c022d24ed3511889122699c8f19
esac
