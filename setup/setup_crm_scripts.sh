#!/usr/bin/env bash

UP_CRM=/home/vagrant/up_crm.sh

# dev & production run scripts
sudo echo '#!/usr/bin/env bash' >> $UP_CRM
sudo echo '' >> $UP_CRM
sudo echo '# Usage: up_crm.sh production | development' >> $UP_CRM
sudo echo '' >> $UP_CRM
sudo echo 'export RAILS_ENV=$1' >> $UP_CRM
sudo echo 'cd $HOME/app_mysql' >> $UP_CRM
#sudo echo 'sudo /usr/local/bin/gem install bundler' >> $UP_CRM
#sudo echo 'bundle install --path $HOME/.gem/ruby/2.2.0' >> $UP_CRM
sudo echo 'bundle exec rails s -b 0.0.0.0' >> $UP_CRM

sudo chown vagrant:vagrant $UP_CRM
sudo chmod +x $UP_CRM
