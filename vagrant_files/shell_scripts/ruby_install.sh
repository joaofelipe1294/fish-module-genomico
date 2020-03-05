if [ ! -d "/home/vagrant/.rbenv" ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
/home/vagrant/.rbenv/bin/rbenv install -s 2.6.3
/home/vagrant/.rbenv/bin/rbenv global 2.6.3
