# hello-docker-rails
[![Docker Automated build](https://img.shields.io/docker/automated/benjamincaldwell/hello-docker-rails.svg)](https://hub.docker.com/r/benjamincaldwell/hello-docker-rails/)

Hello-docker-rails is a docker container for expirement with a rails docker container. This container requires an instance of mysql to connect to.

## Environment variables
In addition to the default rails environment variables the following variables might be useful:

| Variable        | Meaning                                                 | Default                                                                                                                          |
|-----------------|---------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| MYSQL_USER      | User used to login to mysql                             | root                                                                                                                             |
| MYSQL_PASSWORD  | Password used to login to mysql                         |                                                                                                                                  |
| MYSQL_HOST      | Host where mysql is located                             |                                                                                                                                  |
| MYSQL_PORT      | Port of mysql                                           | 3306                                                                                                                             |
| RAILS_ENV       | Rails environment                                       | development (useful for debugging)                                                                                               |
| SECRET_KEY_BASE | Used by rails to verify the integrity of signed cookies | 3776e39015fb84499097d3288f80eeae4a25c0d527385364dfef52262bb272bf0d95e57730ee4b8b07356f9c9d3339d59609720e1053175b97707b0ce9a18e85 |

## Licence

[The MIT License (MIT)](https://github.com/xtity/hello-docker-rails/blob/master/LICENSE)
