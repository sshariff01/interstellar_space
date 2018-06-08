#!/usr/bin/env sh

set -x

apt-get update
yes | apt-get install wget libsqlite3-dev nodejs

yes | apt-get install libnss3
yes | apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
yes | apt-get install -f
sudo dpkg -i google-chrome*.deb

bundle install
rake db:migrate
rake test:unit
rake test:acceptance
