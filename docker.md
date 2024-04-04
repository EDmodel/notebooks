# Installing Docker

You will need to install docker first, this can be done by following the instructions at: 

- [Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/)
- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
  - If the docker desktop shows "Docker Desktop stopped....", you might have to install wsl (windows subsystem linux). This is done using: `wsl --install --distribution ubuntu`
- [Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)

Once you have installed docker, please see below to test it to make sure it works as expected.

## Troubleshooting Windows

When installing Docker for Windows, please make sure that you have all updates installed. When running any of the docker commands, I'd recommend using the powershell (no need for administrator). Main reason is that I will use `${PWD}` to get the current working directory, under the MS-DOS command you will need to use `%cd%` instead.

1. install wsl from powershell with Admin rights: `wsl --install` and reboot your system
   - this will install ubuntu as well after the reboot
   - this can be removed using `wsl --unregister ubuntu`
2. update wsl `wsl --update` and restart wsl `wsl --shutdown`
3. check your version `wsl --status` this should show "Default version 2"
4. Download and install docker

## Testing Docker

To test your installation you should be able to use the following from the command line:

```bash
docker run docker/whalesay cowsay Hello World
```

This should generate the following output

```
Unable to find image 'docker/whalesay:latest' locally
latest: Pulling from docker/whalesay
Image docker.io/docker/whalesay:latest uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/
e190868d63f8: Pull complete
909cd34c6fd7: Pull complete
0b9bfabab7c1: Pull complete
a3ed95caeb02: Pull complete
00bf65475aba: Pull complete
c57b6bcc83e3: Pull complete
8978f6879e2f: Pull complete
8eed3712d2cf: Pull complete
Digest: sha256:178598e51a26abbc958b8a2e48825c90bc22e641de3d31e18aaf55f3258ba93b
Status: Downloaded newer image for docker/whalesay:latest
 _____________
< Hello World >
 -------------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/
```

The second time you run it, it will be faster and only show the output. You can change what the whale says:

```bash
docker run docker/whalesay cowsay Welcome to ED2 in containers
```

## Docker Command Line

The docker application takes a second argument that is indicates what to do:

- *run* : creates a container from an image and starts the default application in the container. The run command takes additional flags, some of the ones e use are:

  - *-it*: (really two options) means that we can **i**nteract with the **t**erminal.

  - *-v \<src\>:\<dst\>* : This will mount your \<src\> folder in the container at \<dst\>. If the destination does not exist, the folder will be created in the container. This is used to bring data from your machine into the container.
  - *-d* : run the container in the background. This does not work with *-it*.

- *images* : are what is used to start a container, these are pulled from a server and contain everything needed to run the application (think a zip file of a linux filesystem).

  - *ls* : shows a list of all images you have downloaded.
  - *rm* : will remove an image (you can always download it again).

- *pull* : will download image without running it, this is also used to make sure you have the latest image downloaded.

- *logs* : shows the output from a container, you can do this after the container is finished, or if the container runs in the background allows you to see the output of the container (think of the tail command in unix).

- *rm* : removes a stopped container, this is a cleanup process. You will free up the diskspace that the stopped container takes up.

- *stop* : stops a container that is running.

# ED Container Demo

To follow the demo some demo data will need to be downloaded. You might have most of this already in the EDTS folder if you did any testing of ED. 

## Downloading Demo Data

You can download all the demo data as a [single zip file](https://isda.ncsa.illinois.edu/~kooper/ed-demo.zip). When unzipped you will have a folder called ed-demo, in there is all the data you need for some test runs.

```
wget https://isda.ncsa.illinois.edu/~kooper/ed-demo.zip
unzip ed-demo.zip
cd ed-demo
```



## Running ED in container

You can now start the first run of ED in a container:

```bash
docker run -ti -v ${PWD}:/data --name ed.tonzi --ulimit stack=-1 edmodel/ed2:gnu-PR-357 ed2 -f ED2IN-tonzi
```

This should download the image and start the container. The output of the container should look exactly like the output of a normal ED run. Once the container is finished you can find the outputs in `test-outputs/tonzi`. 

```
docker run -ti -v ${PWD}:/data --name ed.tonzi edmodel/ed2:gnu-PR-357 ed2 -s -f ED2IN-tonzi
Unable to find image 'edmodel/ed2:gnu-PR-357' locally
gnu-PR-357: Pulling from edmodel/ed2
2238450926aa: Pull complete
297bf628a143: Pull complete
fa0ad483f436: Pull complete
81bd29daeb48: Pull complete
Digest: sha256:6ebdf07c8f9d3240d59ac1cfc76f4dba1cc248138e37de34d6176b4eac50f78c
Status: Downloaded newer image for edmodel/ed2:gnu-PR-357
+---------------- MPI parallel info: --------------------+
+  - Machnum  =      0
+  - Machsize =      1
+---------------- OMP parallel info: --------------------+
+  - thread  use:       8
+  - threads max:       8
+  - cpu     use:       8
+  - cpus    max:       8
+  Note: Max vals are for node, not sockets.
+--------------------------------------------------------+
 + Read namelist information.
 + Copy most namelist variables.
 + Check whether to restore the run.
 + Copy initialisation-dependent variables.
+------------------------------------------------------------+
|           Ecosystem Demography Model, version 2.2
+------------------------------------------------------------+
|  Input namelist filename is ED2IN-tonzi
|
|  Single process execution on INITIAL run.

<lots more text>

 - Simulating:   06/21/2002 00:00:00 UTC
 - Simulating:   06/22/2002 00:00:00 UTC
 - Simulating:   06/23/2002 00:00:00 UTC
 - Simulating:   06/24/2002 00:00:00 UTC
 - Simulating:   06/25/2002 00:00:00 UTC
 - Simulating:   06/26/2002 00:00:00 UTC
 - Simulating:   06/27/2002 00:00:00 UTC
 - Simulating:   06/28/2002 00:00:00 UTC
 - Simulating:   06/29/2002 00:00:00 UTC
 - Simulating:   06/30/2002 00:00:00 UTC
 === Time integration ends; Total elapsed time=      460.4  ===
 ------ ED-2.2 execution ends ------
```



To see the outputs agains, you can use `docker logs ed.tonzi` (note that it matches the name parameter). If you want to re-run the code, you first need to remove the stopped container `docker rm ed.tonzi` or use a different name. You can also run the containers with no name parameter, you will need to use `docker ps -a` to find the ID of the container to remove it, or check the log files.

# Docker Cleanup

Once you are done, stored all your results and want to do a big cleanup, you will use the command `docker system prune -a`. This will remove all stopped containers and all images that were downloaded and no longer used.

