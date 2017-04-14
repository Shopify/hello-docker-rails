#!/bin/sh
set -e

rake db:exists || rake db:setup
rake db:migrate

rails s -b 0.0.0.0
