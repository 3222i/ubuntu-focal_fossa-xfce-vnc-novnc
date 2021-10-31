#!/bin/bash
 
# Erstelle Machinen-ID
uuidgen > /etc/machine-id
 
# Setze Tastatur für alle Shell User
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile
 
exec "$@"