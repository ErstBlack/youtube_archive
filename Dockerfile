FROM alpine:latest

MAINTAINER erstblack

RUN apk add --no-cache bash ffmpeg python3 py-pip zip
RUN python3 -m pip install -U youtube-dlc

COPY ./archive.sh ./youtube-archive.conf /app/

ENTRYPOINT ["/bin/bash", "/app/archive.sh"]
