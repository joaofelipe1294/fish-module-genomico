sudo echo 'Acquire{
  HTTP::proxy "http://proxy.cdapp.net.br:3128";
  FTP::proxy "http://proxy.cdapp.net.br:3128";
}' > /etc/apt/apt.conf
