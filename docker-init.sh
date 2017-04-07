#!/bin/sh

rake db:create
rake db:migrate
rails s -b 0.0.0.0
