########## ENV ##########
## RUBY
FROM ruby

## APT-GET
RUN apt-get update && apt-get install -y vim && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

## WORKING DIRECTORY
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

## EXPOSED PORT
EXPOSE 3000
########## ENV ##########


########## RAILS ENV ##########
# SET development or test or production
ENV RAILS_ENV production
ENV RAILS_MYSQL_USERNAME root
########## RAILS ENV ##########

RUN gem install rails rake

RUN rails new . --skip-bundle --force -d mysql

RUN bundle install --path vendor/bundler

RUN export SECRET_KEY_BASE=`bundle exec rake secret`

ADD config/database.yml ./config/database.yml
ADD docker-init.sh ./docker-init.sh

CMD ["sh", "docker-init.sh"]
