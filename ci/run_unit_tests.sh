#!/user/bin/env sh -x

apt-get update
yes | sudo apt-get install libsqlite3-dev
yes | sudo apt-get install nodejs
bundle install
rake test:unit
