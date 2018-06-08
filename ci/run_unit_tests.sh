#!/usr/bin/env sh

set -x

apt-get update
yes | sudo apt-get install libsqlite3-dev
yes | sudo apt-get install nodejs
bundle install
rake db:migrate
rake test:unit
