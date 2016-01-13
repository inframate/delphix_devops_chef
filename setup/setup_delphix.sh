#!/bin/bash

# Add some 32bit libs because the Delphix engine will need this ...
sudo yum -y install glibc.i686

# extend the sudoer file
echo "Defaults:postgres !requiretty" >> /etc/sudoers.d/delphix
echo "postgres ALL=NOPASSWD:/bin/mount, /bin/umount, /bin/mkdir, /bin/rmdir, /bin/ps, /bin/date, /sbin/shutdown, /sbin/reboot, /usr/sbin/ntpdate, /usr/bin/updatedb, /usr/sbin/ntpdaterestart
" >> /etc/sudoers.d/delphix
echo "Defaults:delphix !requiretty" >> /etc/sudoers.d/delphix
echo "delphix ALL=NOPASSWD:/bin/mount, /bin/umount, /bin/mkdir, /bin/rmdir, /bin/ps, /bin/date, /sbin/shutdown, /sbin/reboot, /usr/sbin/ntpdate, /usr/bin/updatedb, /usr/sbin/ntpdaterestart
" >> /etc/sudoers.d/delphix

# add the postgres user to groups
sudo usermod -a -G postgres delphix
sudo usermod -a -G delphix postgres
# add the mysql user to groups
sudo usermod -a -G mysql delphix
sudo usermod -a -G delphix mysql
