#!/bin/sh

if [ ! -d ed-demo ]; then
  wget https://isda.ncsa.illinois.edu/~kooper/ed-demo.zip
  unzip ed-demo.zip
  rm ed-demo.zip
  mkdir -p ed-demo/test-outputs/{tonzi,tonzi.harvest,umbs.bg}
fi
docker build --push --load --tag ncsa/jupyter-ed --platform linux/amd64,linux/arm64 .
docker build --push --tag ncsa/jupyter-ed --platform linux/amd64,linux/arm64 .
docker run -ti --rm --ulimit stack=-1 -p 8888:8888 -v ${PWD}:/home/jovyan/work ncsa/jupyter-ed
