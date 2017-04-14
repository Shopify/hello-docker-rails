#!/bin/sh
set -e

rake db:exists && rake db:migrate || rake db:setup

rails s -b 0.0.0.0
