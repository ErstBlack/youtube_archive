FROM alpine:latest

MAINTAINER erstblack

RUN apk add --no-cache bash ffmpeg python3
RUN pip3 install -U pip youtube-dl

COPY ./archive.sh /archive.sh
RUN chmod +x /archive.sh

ENTRYPOINT ["/archive.sh"]
