#!/usr/bin/env sh

set -ex

service postgresql start

bundle install

rake db:migrate

rake test:unit
