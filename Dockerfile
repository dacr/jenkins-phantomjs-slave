FROM dacr/jenkins-slave
MAINTAINER crosson.david@gmail.com

RUN apt-get update \
 && apt-get install -y \
      gcc g++ make flex bison gperf ruby \
      libssl-dev libfreetype6-dev libfontconfig-dev \
      libicu-dev libsqlite-dev \
      libpng-dev libjpeg-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone git://github.com/ariya/phantomjs.git \
    && cd phantomjs \
    && git checkout 1.9.7

RUN cd /phantomjs \
    && ./build.sh --confirm

RUN apt-get remove -y gcc g++ make flex bison gperf ruby \
    libssl-dev libfreetype6-dev libfontconfig-dev libicu-dev libsqlite-dev \
    libpng-dev libjpeg-dev

RUN cp /phantomjs/bin/phantomjs /usr/bin && rm -fr /phantomjs

# TAKE CARE This release of yslow doesn't not work with phantomjs >= 2.0
ADD http://yslow.org/yslow-phantomjs-3.1.8.zip /tmp/
RUN unzip /tmp/yslow*.zip

