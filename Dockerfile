FROM shipimg/ubuntu1204_base:latest
MAINTAINER Avi "avi@shippable.com"

RUN dpkg-divert --local --rename --add /sbin/initctl;
RUN ln -s /bin/true /sbin/initctl;
RUN locale-gen en_US en_US.UTF-8;
RUN dpkg-reconfigure locales;
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe restricted multiverse" > /etc/apt/sources.list ;

RUN apt-get update -y;

RUN apt-get -y install --force-yes wget curl g++ texinfo make vim;
RUN apt-get -y install --force-yes supervisor sudo python-pip;

RUN echo "============ Installing mongodb ===============";\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10;\
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list;\
    apt-get update -y;\
    apt-get -y install --force-yes mongodb-10gen && mkdir -p /data/db/;

ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017
CMD []
ENTRYPOINT ["/usr/bin/mongod", "-f", "/etc/mongodb.conf"]
