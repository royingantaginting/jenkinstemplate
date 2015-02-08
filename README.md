# jenkinstemplate
*First written by Tri Ahmad Irfan (triahmadirfan@gmail.com)*

This repository contains a Dockerfile for building Jenkins template on top of Docker, it's preloaded with plugins, PHP QA tools and PHP job templates.

### Building an image
Make sure you are in the same directory as the Dockerfile, then call

```bash
sudo docker build -t yourname/jenkinstemplate .
```

### Running a container
You can list all images available on your instance by calling

```bash
sudo docker images
```

You can run a container from a specific image by calling

```bash
sudo docker run -dp 8080:8080 --name jenkinsserver yourname/jenkinstemplate
```

Note:
- `-d` will make the container to run in a daemon/detached mode
- `-p 8080:8080` will make the container to run at hostPort:containerPort
- `--name jenkinsserver` will name your container `jenkinsserver`, so you can call the container using this name instead of using the hash id

You can map a the $JENKINS_HOME volume into a specific directory on your host machine by adding `-v` option

```bash
sudo docker run -dp 8080:8080 --name jenkinsserver -v /home/yourname/jenkins_home:/var/jenkins_home yourname/jenkinstemplate
```

`-v /home/yourname/jenkins_home:/var/jenkins_home` will map `/var/jenkins_home` on your container into `/home/yourname/jenkins_home` on your host machine

After running the container, Jenkins will be available at `http://yourpublicdns:8080`

You can list all running containers by calling

```bash
sudo docker ps
```

### Stopping a container

You can stop a running container by calling
```bash
sudo docker stop jenkinsserver
```
### Removing a container

You can remove an existing container by calling

```bash
sudo docker rm jenkinsserver
```

### Note
- You have to update some plugins manually after running a new Jenkins server using this template
