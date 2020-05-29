FROM alpine:latest

MAINTAINER erstblack

RUN apk add --no-cache bash ffmpeg py-pip parallel
RUN pip3 install -U youtube-dl

COPY ./archive.sh /archive.sh
COPY ./youtube-archive.conf /etc/youtube-archive.conf
RUN chmod +x /archive.sh

ENTRYPOINT ["/archive.sh"]
