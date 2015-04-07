# hello-docker-rails
This is a Docker image project with Rails and MySQL.  

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
echo -e '\n# boot2docker config\nif [ "`boot2docker status`" = "running" ]; then\n    $(boot2docker shellinit 2>/dev/null)\nfi\n' >> ~/.bash_profile
```

Try it :)

### Persistent Database
To persist database, you need mount a data volume to database container.  
If not, the data will be gone when you remove database container.  
__Separate DBMS and DB data!__

There is a example below.

```bash
# Get up data volume container
docker run -t -v /var/lib/mysql --name db_data busybox

# Run MySQL Server mounted the volume
docker run -t -d -p 3306:3306 --volumes-from db_data --name db -e MYSQL_ROOT_PASSWORD=hoge mysql
```

Check the MySQL data is persisted when you rerun new database container after the database container removed :)

### Persistent Application Data
Like the 'Persistent Database', you may want application data to persist.  
Yeah, me too. So, how about below.

```bash
# Get up app data volume container
docker run -t -v /var/www/html --name app_data busybox

# Run App Server mounted the volume
docker run -d --volumes-from app_data -p 80:3000 --link db:db --name app -t xtity/hello-docker-rails
```

That's it!  
It's very easy way so that it's similar to the 'Persistent Database' :)


### Sharing Application Data
The next step of the 'Persistent Application Data' is sharing the data to your host OS like Windows, Mac OS X and so on. 
A usual solution is using Samba Server, I think.

```bash
# Run Samba Container 
docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba app_data
```

When you execute this command, you would see some messages to mount the volume.  
They are pretty easy to understand how to use and I think you are not going to lost your way.  
But if your host OS is Mac OS X and you use Eclipse IDE, take a look below.

```bash
# In case that your boot2docker's ip is 192.168.59.103 and your mount point is ~/eclipse/workspace/app_data
mount_smbfs //GUEST@192.168.59.103/var%2Fwww%2Fhtml ~/eclipse/workspace/app_data
```

You can mount the volume where ever you want :)


## Licence

[The MIT License (MIT)](https://github.com/xtity/hello-docker-rails/blob/master/LICENSE)

## Author

[xtity](https://github.com/xtity)
