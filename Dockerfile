FROM shipimg/appbase:master.17
MAINTAINER Avi "avi@shippable.com"

RUN apt-get update;

RUN echo "============ Installing mongodb ===============";\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10;\
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list;\
    apt-get update -y;\
    apt-get -y install --force-yes mongodb-10gen && mkdir -p /data/db/;

ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017
CMD []
ENTRYPOINT ["/usr/bin/mongod", "-f", "/etc/mongodb.conf"]
