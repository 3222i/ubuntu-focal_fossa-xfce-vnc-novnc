# ubuntu-focal_fossa-xfce-vnc-novnc

Ubuntu 20.04 (LTS), XFCE-Desktop, VNC, noVNC, LibreOffice, Firefox

-----
Language: Mainly German

-----
User: ubuntu | Password: ubuntu

To change the user password, enter the following in the Docker terminal: sudo passwd ubuntu

-----
How to create/start the container?

docker pull knilix/ubuntu-xfce-vnc-novnc

-----
VNC:

sudo docker run -d --restart always -e VNC_PASSWORD=12345 -p 5900:5900 --name ubuntu_xfce_vnc_novnc knilix/ubuntu-xfce-vnc-novnc

-----
noVNC:

sudo docker run -d --restart always -e VNC_PASSWORD=12345 -p 6900:8080 --name ubuntu_xfce_vnc_novnc knilix/ubuntu-xfce-vnc-novnc

-----
VNC & noVNC:

sudo docker run -d --restart always -e VNC_PASSWORD=12345 -p 5900:5900 -p 6900:8080 --name ubuntu_xfce_vnc_novnc knilix/ubuntu-xfce-vnc-novnc

-----
Start in Browser: IP:6900/vnc.html

-----
Start in VNC-Viewer: IP:5900

-----
Only one instance of VNC and/or noVNC can be active at a time.

-----
This image is for testing purposes. All changes in Docker will be lost if it is deleted/destroyed or an update appears.

-----
This docker is for informational purposes about this guide series: https://knilixdock.wordpress.com/ubuntu-xfce-vnc-novnc/


-----
The original uploader fom the xfce-logo was Waldo the terrible at English Wikipedia., GPL <http://www.gnu.org/licenses/gpl.html>, via Wikimedia Commons
