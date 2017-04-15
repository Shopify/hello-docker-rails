# hello-docker-rails
[![Docker Automated build](https://img.shields.io/docker/automated/benjamincaldwell/hello-docker-rails.svg)](https://hub.docker.com/r/benjamincaldwell/hello-docker-rails/)

This project was inspired by [xtity/hello-docker-rails](https://github.com/xtity/hello-docker-rails).

Hello-docker-rails is a docker container for expirement with a rails docker container. This container requires an instance of mysql to connect to.

## Environment variables
In addition to the default rails environment variables the following variables might be useful:

| Variable        | Meaning                                                 | Default                                                                                                                          |
|-----------------|---------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| MYSQL_USER      | User used to login to mysql                             | root                                                                                                                             |
| MYSQL_PASSWORD  | Password used to login to mysql                         |                                                                                                                                  |
| MYSQL_HOST      | Host where mysql is located                             |                                                                                                                                  |
| MYSQL_PORT      | Port of mysql                                           | 3306                                                                                                                             |
| RAILS_ENV       | Rails environment (Note: this container 404s in production) | development                                                                                           |
| SECRET_KEY_BASE | Used by rails to verify the integrity of signed cookies (Must be changed in production systems) | 3776e3901... |

## Getting started using docker

To use this container with docker first install docker. See [docker documentation for details](https://docs.docker.com/engine/installation/#platform-support-matrix)

``` bash
#create network
docker network create hello-rails

# Run Mysql Server
docker run -p 3306 -d --network=hello-rails --network-alias=db -e MYSQL_ROOT_PASSWORD=password --name hello-rails-db mysql

# Run app server
docker run -it -p 3000:3000 --network=hello-rails -e MYSQL_USER=root -e MYSQL_PASSWORD=password -e MYSQL_HOST=db --name hello-rails benjamincaldwell/hello-docker-rails:latest
```

Rails application should be available on [`localhost:3000`](http://localhost:3000)

To clean up delete the hello-rails network and the created containers.

``` bash
# stop containers if it is running
docker stop hello-rails-db hello-rails

# delete containers
docker rm hello-rails-db hello-rails

# delete network 
docker network rm hello-rails
```

## Using docker-compose
``` bash
git clone https://github.com/benjamincaldwell/hello-docker-rails.git
docker-compose up
```

To clean up
```bash
docker-compose down
docker-compose rm
```
## Licence

[The MIT License (MIT)](https://github.com/benjamincaldwell/hello-docker-rails/blob/master/LICENSE)
