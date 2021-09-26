FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y \
#sudo
 sudo \
#ping 
  iputils-ping \
#iptables
  iptables \
#firefox
  firefox \
#python
  python python3 \
  python3-pip scrot python3-tk python3-dev python-xlib \
  python3-pymysql \
  python3-numpy \
  python-numpy \
  libopencv-dev \
  python3-opencv \
# X Server
  xvfb \
# VNC Server
  x11vnc \
# Openbox
  openbox menu \
# NoVNC with dependencies
  git net-tools && \
# Clean up the apt cache
  rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN \
  # must switch to a release tag once the ssl-only arg included
  git clone https://github.com/novnc/noVNC --branch v1.2.0 /root/noVNC && \
  git clone --branch v0.9.0 https://github.com/novnc/websockify /root/noVNC/utils/websockify

RUN touch ~/.Xauthority
RUN python3 -m pip install pyautogui python3-xlib python-xlib #pip install pyautogui
RUN python3 -m pip install mysql-connector-python
RUN python3 -m pip install requests requests-toolbelt tk




CMD \
# X Server
  Xvfb :1 -screen 0 1200x1024x16 & \
# Openbox
  (export DISPLAY=:1 && openbox-session) & \
# VNC Server
  if [ -z $VNC_PASSWD ]; then \
    # no password
    x11vnc -display :1 -xkb -forever & \
  else \
    # set password from VNC_PASSWD env variable
    mkdir ~/.x11vnc && \
    x11vnc -storepasswd $VNC_PASSWD /root/.x11vnc/passwd && \
    x11vnc -display :1 -xkb -forever -rfbauth /root/.x11vnc/passwd & \
  fi && \
# NoVNC
  openssl req -new -x509 -days 36500 -nodes -batch -out /root/noVNC.pem -keyout /root/noVNC.pem && \
  ln -sf /root/noVNC/vnc.html /root/noVNC/index.html && \
  /root/noVNC/utils/launch.sh --vnc localhost:5900 --cert /root/noVNC.pem --ssl-only



