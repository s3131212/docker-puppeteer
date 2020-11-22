# Puppeteer in Docker
A simple boilerplate for running [Puppeteer](https://github.com/puppeteer/puppeteer) in Docker.  

## Usage
Modify `Dockerfile` if needed.  

Then, run `build.sh` to create the image. Note that it will create the image according to the current user (i.e. `$(id)`), so don't execute it with root.  

```
./build.sh
```
(If for some reason, the script is not execuatable due to the permission, try `chmod +x build.sh`)  

Next, create a container using `start.sh`. You might want to change the configuration, especially the volume to be mounted.  
```
./start.sh
```

Finally, enter the container and execute the puppeteer script.
```
docker exec -it puppeteer /bin/bash

# to install puppeteer, choose the command according to the scenario.
npm install
npm install puppeteer --save 

node app.js
```

For the sake of testing, a sample script is located in `/test-code`.  

You might want to config the [resource constraints](https://docs.docker.com/config/containers/resource_constraints/) and the [network](https://docs.docker.com/engine/reference/run/#network-settings).  
For example, I run the crawler with the following constraints.
```
docker run -d -it -v /home/s3131212/crawler:/usr/src/app:rw \
	--security-opt="seccomp=./chrome.json" \
	--user=pptruser \
	--network="host" \
	--cpuset-cpus="0-12" --memory=32G --shm-size=1G \
	--name puppeteer \
	puppeteer-image
```

If the Puppeteer fails to start with an error indicating that it can't find the executable Chromium, you might want to check out [this issue](https://github.com/puppeteer/puppeteer/issues/6560). At the time of writing, the issue has yet to be solved.  
The known workarounds are:
1. install puppeteer in the container, or
2. specify the `executablePath`.

Most importantly, even if you're not going to make any change, it's always a good habit to take a look at what you're going to execute. :slightly_smiling_face:  

## License
Released under MIT.  
The Dockerfile is inspired by [Kinlan's awesome article](https://paul.kinlan.me/hosting-puppeteer-in-a-docker-container/).  
The seccomp file (`chrome.json`) is from [jessfraz/dotfiles](https://github.com/jessfraz/dotfiles/blob/master/etc/docker/seccomp/chrome.json), released under MIT.