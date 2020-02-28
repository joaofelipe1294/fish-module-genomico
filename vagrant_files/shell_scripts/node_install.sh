curl -sL https://deb.nodesource.com/setup_10.x --proxy http://proxy.cdapp.net.br:3128 | bash - && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg --proxy http://proxy.cdapp.net.br:3128 | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
