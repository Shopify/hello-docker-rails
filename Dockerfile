##### ENV #####
## RUBY
FROM ruby

## WORKING DIRECTORY
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

## GEM
ADD . Gemfile
ADD . Gemfile.lock
RUN echo "source 'https://rubygems.org'" > Gemfile
RUN echo "gem 'rails'" >> Gemfile
RUN bundle install --system

## APT-GET
ADD . /var/www/html
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
##### ENV #####


##### RAILS SETTINGS #####
RUN bundle exec rails new . --skip-bundle --force -d mysql
ENV RAILS_ENV development
ENV SECRET_KEY_BASE RUN ["bundle", "exec", "rake", "secret"]
##### RAILS SETTINGS #####


##### ON BOOT #####
EXPOSE 3000

CMD bundle update && \
  sed -i "s/password:.*/password: '<%= ENV['DB_ENV_MYSQL_ROOT_PASSWORD'] %>'/g" config/database.yml && \  
  sed -i "s/host:.*/host: <%= ENV['DB_PORT_3306_TCP_ADDR'] %>\n  port: <%= ENV['DB_PORT_3306_TCP_PORT'] %>/g" config/database.yml && \ 
  bundle exec rake db:create && \
  bundle exec rake db:migrate && \
  bundle exec rails s\
##### ON BOOT #####
