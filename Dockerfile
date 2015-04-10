########## ENV ##########
## RUBY
FROM ruby

## APT-GET
RUN apt-get update && apt-get install -y vim && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

## WORKING DIRECTORY
RUN mkdir -p /var/www/html
ADD . /var/www/html/
WORKDIR /var/www/html

## EXPOSED PORT
EXPOSE 3000
########## ENV ##########


########## RAILS ENV ##########
# SET development or test or production
ENV RAILS_ENV development
ENV RAILS_MYSQL_USERNAME root
########## RAILS ENV ##########


########## ON BOOT ##########
CMD if [ ! -f /var/www/html/Gemfile.lock ]; then \
    # ON INITIALIZE
    echo '######################### INITIALIZE RAILS PROJECT #########################' && \
    ls -lsat /var/www/html && \
    echo 'source '\''https://rubygems.org'\''' > Gemfile && \
    echo 'gem '\''rails'\''' >> Gemfile && \
    bundle install --path vendor/bundler && \
    bundle exec rails new . --skip-bundle --force -d mysql && \
    bundle install --path vendor/bundler && \
    export SECRET_KEY_BASE=`bundle exec rake secret` && \
    sed -i "s/username:.*/username: '<%= ENV['RAILS_MYSQL_USERNAME'] %>'/g" config/database.yml && \
    sed -i "s/password:.*/password: '<%= ENV['DB_ENV_MYSQL_ROOT_PASSWORD'] %>'/g" config/database.yml && \  
    sed -i "s/host:.*/host: <%= ENV['DB_PORT_3306_TCP_ADDR'] %>\n  port: <%= ENV['DB_PORT_3306_TCP_PORT'] %>/g" config/database.yml && \ 
    bundle exec rake db:create && \
    bundle exec rake db:migrate && \
    echo '######################### RUN RAILS SERVER #########################' && \
    bundle exec rails s -b 0.0.0.0; \
  else \
    # ON UPDATE
    echo '######################### UPDATE RAILS PROJECT #########################' && \
    ls -lsat /var/www/html && \
    echo '######################### Gemfile #########################' && \
    cat /var/www/html/Gemfile && \
    echo '######################### Bundle Install #########################' && \
    bundle install --path vendor/bundler && \
    export SECRET_KEY_BASE=`bundle exec rake secret` && \
    echo '######################### RUN RAILS SERVER #########################' && \
    bundle exec rails s -b 0.0.0.0; \
  fi
########## ON BOOT ##########
