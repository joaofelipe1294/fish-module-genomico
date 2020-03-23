
sudo apt update
sudo apt upgrade
echo "Ruby dependencies ..."
sudo apt install -f -y autoconf bison build-essential \
                    libyaml-dev libreadline-dev zlib1g-dev \
                    libncurses5-dev libffi-dev libgdbm-dev \
                    build-essential tcl git
sudo apt-get install -y libssl1.0.0/bionic libssl-dev/bionic openssl/bionic
echo "Ruby dependancies [OK]"
echo "Postgres ..."
sudo apt install -y postgresql  postgresql-contrib
echo "Postgres [OK]"
echo "Node ..."
sudo apt update
sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt update
sudo apt -y install gcc g++ make
sudo apt -y install nodejs
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
echo "Node [OK]"
echo "Redis ..."
if [ ! -d "redis" ]; then
  mkdir redis
  cd redis
  wget http://download.redis.io/releases/redis-5.0.5.tar.gz
  tar xzf redis-5.0.5.tar.gz
  cd redis-5.0.5
  make
  sudo make install
fi
echo "Redis [OK]"
echo "Ruby ..."
if [ ! -d "/home/$USER/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
/home/$USER/.rbenv/bin/rbenv install -s 2.6.3
/home/$USER/.rbenv/bin/rbenv global 2.6.3
echo "Ruby [OK]"
echo "Rails 6.0.2 ..."
/home/$USER/.rbenv/shims/gem install bundler -v 2.0.2
/home/$USER/.rbenv/shims/gem install rails -v 6.0.2
/home/$USER/.rbenv/bin/rbenv rehash
echo "Rails 6.0.2 [OK]"
echo "Now set redis to start at reboot"
echo "@reboot /usr/local/bin/redis-server /home/vagrant/install/redis/redis-5.0.5/redis.conf"
echo "Copy redis.conf configured right"
echo "$(which redis-server) $(pwd)/redis/redis-5.0.5/redis.conf"
echo "Setup sidekiq"
echo "Copy sidekiq.service to /lib/systemd/system"
echo "run systemctl enable sidekiq"
echo "systemctl start sidekiq"
echo "setup postgres production user"
echo "sudo -u postgres psql"
echo "ALTER USER postgres PASSWORD 'password';"
