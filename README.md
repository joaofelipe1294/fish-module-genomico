# README

To set up development machine run the sequence

 - vagrant up
 - give execution privilege to node_install.sh, ruby_install.sh, rails_install.sh and chrome_install.sh
 - run node_install
 - run ruby_install
 - run rails_install
 - run chrome_install
 - ren redis_install

To deploy application you must run the scripts in deploy dir on file name sequence

After install all apps and setup redis and sidekiq application can be started running script start.sh
