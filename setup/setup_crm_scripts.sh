#!/usr/bin/env bash

# dev & production run scripts
sudo echo '#!/usr/bin/env bash' >> $SETUP_HOME/up_crm.sh
sudo echo '' >> $SETUP_HOME/up_crm.sh
sudo echo '# usage: up_crm.sh env db' >> $SETUP_HOME/up_crm.sh
sudo echo '' >> $SETUP_HOME/up_crm.sh
sudo echo '# env = production | development' >> $SETUP_HOME/up_crm.sh
sudo echo '# db = mysql | postgres' >> $SETUP_HOME/up_crm.sh
sudo echo '' >> $SETUP_HOME/up_crm.sh
sudo echo 'export RAILS_ENV=$1' >> $SETUP_HOME/up_crm.sh
sudo echo 'cd $SETUP_HOME/app_$2' >> $SETUP_HOME/up_crm.sh
sudo echo 'rails s -b 0.0.0.0' >> $SETUP_HOME/up_crm.sh

sudo chown delphix:delphix $SETUP_HOME/up_crm.sh
sudo chmod +x $SETUP_HOME/up_crm.sh