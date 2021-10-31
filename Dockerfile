FROM ubuntu:20.04
  
MAINTAINER knilix <https://knilixblog.wordpress.com>
  
RUN sed -i 's#http://archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list;
  
ENV DEBIAN_FRONTEND noninteractive
  
## Tools
RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    ca-certificates
RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y \
    xfce4 \
    xfce4-terminal \
    fonts-croscore \
    elementary-xfce-icon-theme \
    update-manager \
    dbus-x11 \
    libx11-6 \
    libx11-xcb1 \
    libfontconfig1 \
    sudo \
    supervisor \
    xauth \
    xvfb \
    x11vnc \
    novnc \
    xfonts-base \
    locales \
    language-pack-gnome-de \
    language-pack-de-base \
    language-pack-de
RUN apt-get clean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*
RUN rm -rf /etc/xdg/autostart/xscreensaver*
  
## Eigene Programme
RUN apt-get update && apt-get install -y \
    firefox \
    nano \
    autocutsel \
    vlc \
    ffmpeg \
    libreoffice
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*
  
## Setze Variablen inkl. Benutzer-Password für sudo-Befehle (PASSWORT: ubuntu)
RUN echo "set convert-meta off" >> /etc/inputrc && \
    echo "xfce4-session" > /etc/skel/.Xclients && \
    addgroup ubuntu && \
    useradd -m -s /bin/bash -g ubuntu ubuntu && \
    echo "ubuntu:ubuntu" | /usr/sbin/chpasswd && \
    echo "ubuntu    ALL=(ALL) ALL" >> /etc/sudoers
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN  mkdir /var/log/supervisor && \
     mkdir /var/run/dbus
COPY bin /bin
RUN chmod +x /bin/docker-entrypoint.sh && \
    chmod +x /bin/startvnc.sh
  
## Festlegen der Sprache
RUN sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen \
&& locale-gen
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8
 
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
  
# Bildschirmsperre entfernen (damit nach einigen Minuten Inaktivität kein Black-Screen erscheint)
RUN apt-get remove light-locker -y && \
    apt-get autoremove -y
  
ENV DISPLAY :0
EXPOSE 5900
EXPOSE 8080
  
ENTRYPOINT ["/bin/docker-entrypoint.sh","/bin/startvnc.sh"]
CMD ["supervisord"]