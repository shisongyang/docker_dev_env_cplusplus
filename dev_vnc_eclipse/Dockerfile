# this docker file is used to build a base dev env for chinese

FROM frankshi/base_env_chinese
MAINTAINER frank "songyangshi@gmail.com"


ENV JAVA_VERSION 8u92
ENV DISPLAY :1
ENV NO_VNC_HOME /root/noVNC
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW ssy123456
ENV SAKULI_DOWNLOAD_URL https://labs.consol.de/sakuli/install
ENV DIR_DEV /root/eclipse
ENV URL_ECLIPSE http://mirror.rise.ph/eclipse/technology/epp/downloads/release/neon/2/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz
ENV URL_NO_VNC https://raw.githubusercontent.com/shisongyang/novnc_res/master/noVNC-0.6.1.tar.gz
ENV URL_WEB_SOKIFY https://raw.githubusercontent.com/shisongyang/novnc_res/master/websockify-0.8.0.tar.gz

# vnc xfce
RUN yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce" && yum clean all -y
RUN yum -y install tigervnc-server && yum -y install gedit && yum clean all -y

# novnc
RUN mkdir -p $NO_VNC_HOME/utils/websockify \
    && wget -qO- $URL_NO_VNC | tar xz --strip 1 -C $NO_VNC_HOME \
    && wget -qO- $URL_WEB_SOKIFY | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v /root/noVNC/utils/*.sh

# java
RUN yum -y install $SAKULI_DOWNLOAD_URL/3rd-party/java/jre-$JAVA_VERSION-linux-x64.rpm && yum clean all

# xvnc server porst, if $DISPLAY=:1 port will be 5901
EXPOSE 5901
# novnc web port
EXPOSE 6901

ADD .vnc /root/.vnc
ADD .config /root/.config
ADD scripts /root/scripts
RUN chmod +x  /root/scripts/*.sh /root/.vnc/xstartup /etc/xdg/xfce4/xinitrc
RUN /bin/dbus-uuidgen > /etc/machine-id
# Disable xfce-polkit
RUN rm /etc/xdg/autostart/xfce-polkit.desktop

# eclipse
RUN mkdir -p $DIR_DEV \
 	&& wget -qO- $URL_ECLIPSE | tar xz --strip 1 -C $DIR_DEV
 	
# chinese input 
RUN  yum -y install ibus ibus-libpinyin ibus-qt ibus-table-chinese-array im-chooser && yum clean all -y



ENTRYPOINT ["/root/scripts/vnc_startup.sh"]
CMD ["--tail-log"]

