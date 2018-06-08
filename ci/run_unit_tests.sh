#!/usr/bin/env sh

set -x

apt-get update
yes | apt-get install vim wget libsqlite3-dev nodejs

yes | apt-get install libnss3
yes | apt-get install apt-transport-https libxss1 libappindicator1 libindicator7
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
yes | sudo apt-get update
yes | sudo apt-get install google-chrome-stable

bundle install
rake db:migrate
rake test:unit
