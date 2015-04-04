FROM ubuntu:14.04
MAINTAINER Flora Tasse <floratasse@gmail.com>

# update and install dependencies

# add ppa repos
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository -y ppa:v-launchpad-jochen-sprickerhof-de/pcl # PCL
RUN apt-get update

# install c++ build tools
RUN apt-get install -y g++ gdb make cmake

# install glfw, glew and anttweakbar
RUN apt-get install -y libxrandr-dev x11proto-xf86vidmode-dev  libxxf86vm-dev
RUN apt-get install -y libglu1-mesa-dev  libglew1.6-dev qt5-default
RUN apt-get install -y libglfw-dev libxinerama-dev libxi-dev libxcursor-dev

# Install pcl
RUN apt-get install -y libpcl-all

# install git & python
RUN apt-get install -y git  python-scipy

# install display
RUN apt-get -y install dbus x11vnc xvfb
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

# build and install cgal 4.5
RUN apt-get install -y curl libgmp-dev libmpfrc++-dev; \
    curl https://gforge.inria.fr/frs/download.php/file/34400/CGAL-4.5.1.tar.gz > CGAL.tar.gz ;\
    tar -xf CGAL.tar.gz ; mkdir CGAL-4.5.1/build ; cd CGAL-4.5.1/build; \
    cmake --quiet ../; make --silent; make --silent install; cd ../../; rm -r CGAL-4.5.1; rm CGAL.tar.gz

RUN curl http://www.libqglviewer.com/src/libQGLViewer-2.6.1.tar.gz > libQGLViewer-2.6.1.tar.gz;\
    tar -xf libQGLViewer-2.6.1.tar.gz; cd libQGLViewer-2.6.1/QGLViewer; qmake; make; make install;\
    cd ../../; rm -r libQGLViewer-2.6.1; rm -r  libQGLViewer-2.6.1.tar.gz;

RUN apt-get install -y meshlab fluxbox
RUN apt-get clean

EXPOSE 5900
