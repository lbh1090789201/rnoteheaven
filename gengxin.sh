#!/usr/bin/env bash
rm -rf public/assets/
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake db:migrate
