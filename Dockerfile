FROM alpine:3.19.1

MAINTAINER erstblack

RUN apk add --no-cache bash \
	ffmpeg \
	python3 \
	py-pip \
	zip \
	py3-pycryptodomex \
	mutagen \
	coreutils \
	py3-websockets \
	py3-brotli \
	py3-secretstorage \
	py3-certifi \
	py3-requests \
	py3-urllib3

RUN python3 -m pip install --break-system-packages --no-cache-dir --upgrade yt-dlp

COPY ./archive.sh ./youtube-archive.conf /app/

ENTRYPOINT ["/bin/bash", "/app/archive.sh"]
