# Description

Simple docker project to build [QxmlEdit](http://qxmledit.org/) and get `deb`
package to be installed in _Ubuntu 18.04_. (Maybe can work with other
distributions).

# Build with docker

Command to build _deb_ package for Ubuntu 18.04:

```
docker build --tag qxmledit-build .
```

Extract deb package from image. In this case to current path

```
docker run --rm -v $PWD:/output qxmledit-build bash -c 'cp -r /dist/* /output/'
```

Remove docker image

```
docker rmi -f qxmledit-build
```

Now you can install package in your _ubuntu_ host:

```
sudo dpkg -i qxmledit-XXXXXX.deb
```

**NOTE**: Replace `XXXXXX` for appropriate value.
