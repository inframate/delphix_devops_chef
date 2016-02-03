#!/bin/bash

# add dev dependencies
sudo yum -y install libsqlite3-dev zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline6-dev libncurses5-dev libpq-dev libffi-dev

# libs needed for e.g. RAILS apps etc
sudo yum -y install ImageMagick-devel libxml2 libxml2-devel libxslt libxslt-devel readline-devel zlib-devel libyaml-devel bc openssl-devel iconv-devel curl-devel sqlite-devel

MAJOR=2
MINOR=2
PATCH=4

VERSION=$MAJOR.$MINOR.$PATCH

# build ruby from source
cd /tmp
wget http://ftp.ruby-lang.org/pub/ruby/$MAJOR.$MINOR/ruby-$VERSION.tar.gz
tar -xzvf ruby-$VERSION.tar.gz
cd ruby-$VERSION
./configure --disable-install-rdoc
make
make install
rm -rf /tmp/ruby*

# path to new ruby, for all users (system-wide)
sudo echo "# ruby $VERSION" >> /etc/profile
sudo echo 'export PATH=$PATH:/usr/local/bin:/usr/local/lib/ruby/gems/2.2.0' >> /etc/profile
sudo echo 'export PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin' >> /etc/profile

# WARNING !!! this is really bad but I do not want to deal with access rights right now :-)
#chmod -R 777 /usr/local/lib/ruby/gems
