# this docker file is used to build a base dev env for chinese

FROM centos:7
MAINTAINER frank "songyangshi@gmail.com"

# yum res 
RUN yum -y install epel-release \ 
	&& yum -y update \ 
	&& yum -y install sudo \ 
	&& yum clean all -y 

# developer
RUN	yum -y groups install "Development Tools" \ 
	&& yum -y install cmake htop gtest vim wget which net-tools valgrind perf lsof collectl \ 
	&& yum -y install --setopt=tsflags='' man man-pages \
	&& debuginfo-install -y glibc \
	&& yum clean all -y
	

# chinese
RUN yum -y groups install "Fonts" \
	&& yum clean all -y
	
RUN localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 \ 
	&& localedef -i zh_CN -f GB18030 zh_CN.GB18030 \
	&& localedef -i zh_CN -f GB2312 zh_CN.GB2312 \
	&& localedef -i zh_CN -f GBK zh_CN.GBK 
	
ENV LC_ALL en_US.UTF8
ENV LANG zh_CN.UTF8


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
ENV URL_CPP_REF http://upload.cppreference.com/mwiki/images/f/f2/html_book_20170214.tar.gz
ENV URL_SETUP_IBUS https://raw.githubusercontent.com/shisongyang/novnc_res/master/docker_res/ibus-setup/utmp
ENV DIR_DOWNLOAD /root/download
ENV DIR_CPP_REF /root/cpp_ref

# vnc xfce
RUN yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce" \
	&& yum -y install tigervnc-server && yum -y install gedit && yum clean all -y

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

# config Disable xfce-polkit
RUN chmod +x  /root/scripts/*.sh /root/.vnc/xstartup /etc/xdg/xfce4/xinitrc \
	&& /bin/dbus-uuidgen > /etc/machine-id \
	&& rm /etc/xdg/autostart/xfce-polkit.desktop

# eclipse
RUN mkdir -p $DIR_DEV \
 	&& wget -qO- $URL_ECLIPSE | tar xz --strip 1 -C $DIR_DEV
 	
# chinese input 
RUN  yum -y install ibus ibus-libpinyin ibus-qt ibus-table-chinese-array im-chooser && yum clean all -y

# cpp reference browser and pdf reader ibus setup
RUN mkdir -p $DIR_CPP_REF \
	&& wget -qO- $URL_CPP_REF | tar xz --strip 1 -C $DIR_CPP_REF \
	&& wget -P $DIR_DOWNLOAD $URL_SETUP_IBUS \
	&& yum -y install firefox && yum -y install evince && yum clean all -y
	

ENTRYPOINT ["/root/scripts/vnc_startup.sh"]
CMD ["--tail-log"]

