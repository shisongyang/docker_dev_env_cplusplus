# this docker file is used to build a base dev env for chinese

FROM frankshi/base_env_chinese
MAINTAINER frank "songyangshi@gmail.com"


ENV JAVA_VERSION 8u92
ENV DISPLAY :1
ENV NO_VNC_HOME /root/noVNC
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW ssy123
ENV SAKULI_DOWNLOAD_URL https://labs.consol.de/sakuli/install
ENV DEV_DIR /root/eclipse
ENV URL_ECLIPSE http://mirrors.ustc.edu.cn/eclipse/technology/epp/downloads/release/neon/2/eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz
ENV URL_NO_VNC https://raw.githubusercontent.com/shisongyang/novnc_res/master/noVNC-0.6.1.tar.gz
ENV URL_WEB_SOKIFY https://raw.githubusercontent.com/shisongyang/novnc_res/master/websockify-0.8.0.tar.gz

# vnc xfce
RUN yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce" && yum clean all -y
RUN yum -y install tigervnc-server && yum clean all -y

# novnc
RUN mkdir -p $NO_VNC_HOME/utils/websockify \
    && wget -qO- $URL_NO_VNC | tar xz --strip 1 -C $NO_VNC_HOME \
    && wget -qO- $URL_WEB_SOKIFY | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v /root/noVNC/utils/*.sh



# xvnc server porst, if $DISPLAY=:1 port will be 5901
EXPOSE 5901
# novnc web port
EXPOSE 6901

ADD .vnc /root/.vnc
ADD .config /root/.config
ADD scripts /root/scripts

RUN chmod +x  /root/scripts/*.sh /root/.vnc/xstartup /etc/xdg/xfce4/xinitrc /root/Desktop/*.desktop
RUN /bin/dbus-uuidgen > /etc/machine-id

# Disable xfce-polkit
RUN rm /etc/xdg/autostart/xfce-polkit.desktop

# eclipse
ADD eclipse-cpp-neon-2-linux-gtk-x86_64.tar.gz $DEV_DIR
# --java and java plugin
RUN yum -y install $SAKULI_DOWNLOAD_URL/3rd-party/java/jre-$JAVA_VERSION-linux-x64.rpm && yum clean all
RUN wget -qO- $ECLIPSE_URL | tar xz --strip 1 -C $DEV_DIR \
	&& ln -s /root/Desktop/elipse $DEV_DIR/eclipse/eclipse



ENTRYPOINT ["/root/scripts/vnc_startup.sh"]
CMD ["--tail-log"]

# default cmd
CMD ["/bin/bash"]

