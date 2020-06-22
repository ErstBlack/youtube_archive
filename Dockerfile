FROM alpine:latest

MAINTAINER erstblack

RUN apk add --no-cache bash ffmpeg py-pip parallel imagemagick zip
RUN pip3 install -U youtube-dl

COPY ./archive.sh ./youtube-archive.conf /app/
RUN chmod +x /app/archive.sh

ENTRYPOINT ["/app/archive.sh"]
