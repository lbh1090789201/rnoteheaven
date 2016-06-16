#!/usr/bin/env bash
git pull
rm -rf public/assets/
RAILS_ENV=production bundle exec rake assets:precompile
sudo service nginx stop; sudo killall nginx; sudo service nginx start;
