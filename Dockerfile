## re-build:
# docker tag bjoernr/voctocore:latest bjoernr/voctocore:old; docker build -t bjoernr/voctocore ./voctocore-docker && docker rmi bjoernr/voctocore:old
## build:
# docker build -t bjoernr/voctocore ./voctocore-docker
## run:
# docker run -it --rm bjoernr/voctocore
# docker run -it --rm -v /some/dir:/video
#	-p 9999:9999 -p 10000:10000 -p 10001:10001 -p 10002:10002 -p 11000:11000 -p 12000:12000 \
#	-p 13000:13000 -p 13001:13001 -p 13002:13002 -p 14000:14000 -p 15000:15000 -p 16000:16000 \
#	-p 17000:17000 -p 17001:17001 -p 17002:17002 -p 18000:18000 --name=voctocore bjoernr/voctocore

FROM ubuntu:wily

MAINTAINER Bjoern Riemer <bjoern.riemer@web.de>

ENV DEBIAN_FRONTEND noninteractive

ENV uid 1000
ENV gid 1000

RUN useradd -m voc

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-ugly gstreamer1.0-tools libgstreamer1.0-0 python3 python3-gi gir1.2-gstreamer-1.0 \
	&& apt-get install -y git wget \
	&& apt-get clean

RUN wget -q https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 -O /bin/gosu && chmod +x /bin/gosu
RUN cd /opt && git clone https://github.com/voc/voctomix.git

EXPOSE 9999 10000 10001 10002 11000 12000 13000 13001 13002 14000 15000 16000 17000 17001 17002 18000 
VOLUME /video

COPY start-voctocore.sh /opt/start-voctocore.sh

CMD /opt/start-voctocore.sh

## apt-get install -y gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0 gir1.2-gtk-3.0

# docker run -it --rm --name=voctocore bjoernr/voctocore