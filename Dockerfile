FROM dacr/jenkins-slave
MAINTAINER crosson.david@gmail.com

USER root

ENV TERM xterm

RUN yum -y install gcc gcc-c++ make flex bison gperf ruby \
  openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel \
  libpng-devel libjpeg-devel

RUN git clone git://github.com/ariya/phantomjs.git \
    && cd phantomjs \
    && git checkout 1.9.7

RUN cd /phantomjs \
    && ./build.sh --confirm

RUN yum -y erase gcc gcc-c++ make flex bison gperf ruby \
    openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel \
    libpng-devel libjpeg-devel
RUN yum clean all

RUN cp /phantomjs/bin/phantomjs /usr/bin && rm -fr /phantomjs

# TAKE CARE This release of yslow doesn't not work with phantomjs >= 2.0
ADD http://yslow.org/yslow-phantomjs-3.1.8.zip /tmp/
RUN unzip /tmp/yslow*.zip

USER jenkins

