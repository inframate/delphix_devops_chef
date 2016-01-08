#!/bin/bash

# create a delphix user 
useradd delphix
echo delphix | passwd delphix --stdin

# Add some 32bit libs because the Delphix engine will need this ...
sudo yum -y install glibc.i686

# extend the sudoer file
echo "Defaults:postgres !requiretty" >> /etc/sudoers.d/delphix
echo "postgres ALL=NOPASSWD:/bin/mount, /bin/umount, /bin/mkdir, /bin/rmdir, /bin/ps, /bin/date, /sbin/shutdown, /sbin/reboot, /usr/sbin/ntpdate, /usr/bin/updatedb, /usr/sbin/ntpdaterestart
" >> /etc/sudoers.d/delphix
echo "Defaults:delphix !requiretty" >> /etc/sudoers.d/delphix
echo "delphix ALL=NOPASSWD:/bin/mount, /bin/umount, /bin/mkdir, /bin/rmdir, /bin/ps, /bin/date, /sbin/shutdown, /sbin/reboot, /usr/sbin/ntpdate, /usr/bin/updatedb, /usr/sbin/ntpdaterestart
" >> /etc/sudoers.d/delphix

# add the toolkit location
mkdir -p /opt/toolkit_1
chown postgres:postgres /opt/toolkit_1
chmod 0770 /opt/toolkitp

mkdir -p /opt/toolkit
chown delphix:delphix /opt/toolkit
chmod 0770 /opt/toolkit

# add the delphix user to various groups
usermod -a -G wheel delphix
usermod -a -G postgres delphix
