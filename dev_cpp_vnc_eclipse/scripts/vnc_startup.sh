#!/bin/bash

#resolve_vnc_connection
VNC_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
VNC_PORT="590"${DISPLAY:1}
NO_VNC_PORT="690"${DISPLAY:1}

# change vnc password
echo "change vnc password!"
echo $VNC_PW
echo $VNC_IP
echo $VNC_PORT
echo $NO_VNC_PORT
(echo $VNC_PW && echo $VNC_PW) | vncpasswd

# start vncserver and noVNC webclient
$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill :1 && rm -rfv /tmp/.X* ; echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
startxfce4 &
sleep 1
# copy remote
vncconfig -nowin&

ibus-daemon&
mkdir -p /root/Desktop
ln -s /root/eclipse/eclipse /root/Desktop/eclipse
ln -s /usr/bin/google-chrome /root/Desktop/google_chrome
ln -s /usr/bin/evince /root/Desktop/evince
ln -s /usr/bin/goldendict /root/Desktop/goldendict
ln -s /usr/bin/filezilla /root/Desktop/filezilla
mkdir -P /root/work_dir/
if [ ! -d "/root/work_dir/eclipse_workspace/" ] ; then
       tar -zxf /root/eclipse_workspace.tar.gz -C /root/work_dir/ && rm -f /root/eclipse_workspace.tar.gz
fi


# log connect options
echo -e "\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/vnc_auto.html?password=..."

for i in "$@"
do
case $i in
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    -t|--tail-log)
    echo -e "\n------------------ /root/.vnc/*$DISPLAY.log ------------------"
    tail -f /root/.vnc/*$DISPLAY.log
    ;;
    *)
    # unknown option ==> call command
    exec $i
    ;;
esac
done