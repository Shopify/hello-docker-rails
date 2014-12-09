hello-docker-rails
==================

This is a Hello Rails project by Docker.  

## Requirement
### Installed these
* __boot2docker__
    * How to install
        * Mac
            * ```brew cask install boot2docker```
        * Windows
            * See http://boot2docker.io/

## Demo
```bash
## Clone this Project.
git clone git@github.com:xtity/hello-docker-rails.git

## CD
cd hello-docker-rails

## Init boot2docker
boot2docker init

## Run boot2docker
boot2docker up

## Run MySQL Server
docker run -p 3306:3306 -d --name db -e MYSQL_ROOT_PASSWORD=hoge mysql 

## Build App Server Image
docker build -t local/project .

## Run App Server
docker run -i -p 80:3000 --link db:db --name app -t local/project

## Get Virtual Machine's IP & Access!!
boot2docker ip
```

## Usage
See the Demo. But if you already know the [DockerHub](https://registry.hub.docker.com/u/xtity/hello-docker-rails/), the usage is Super Easy. Take a look below.

```bash
## Run MySQL Server
docker run -p 3306:3306 -d --name db -e MYSQL_ROOT_PASSWORD=hoge mysql 

## Run App Server
docker run -i -p 80:3000 --link db:db --name app -t xtity/hello-docker-rails
```
__Just 2 steps__ to make a VM with Rails and MySQL :)

## TIPS
### boot2docker setting
The boot2docker requires these environmental variables.

* DOCKER_CERT_PATH
* DOCKER_TLS_VERIFY
* DOCKER_HOST

We could ```export``` these vars in every time we use boot2docker.
But This way isn't handy.  
For example, you could execute the below command to set these in ```.bash_profile```.
```bash
echo -e '\n# boot2docker config\nif [ "`boot2docker status`" = "running" ]; then\n    $(boot2docker shellinit 2>/dev/null)\nfi\n' >> ~/.bash_profile.
```
Try it :)

## Licence

[Apache License](https://github.com/xtity/hello-docker-rails/blob/master/LICENSE)

## Author

[xtity](https://github.com/xtity)
