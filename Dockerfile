ARG DOCKER_IMAGE_VERION=
FROM ghcr.io/linuxserver/baseimage-selkies:alpine322
ARG JDOWNLOADER_URL=https://installer.jdownloader.org/JDownloader.jar
RUN apk --no-cache add \
	curl \
	openjdk8-jre \
	jq \
	font-dejavu \
	ffmpeg \
	rtmpdump \
	moreutils && \
	mkdir -p /defaults && \
	mkdir -p /downloads && \
	curl -# -L -o /defaults/JDownloader.jar ${JDOWNLOADER_URL}

WORKDIR /tmp

RUN \
	sudo chown abc:abc -R /defaults && \
	sudo chmod +755 -R /defaults && \
	sudo chown abc:abc -R /downloads && \
	sudo chmod +755 -R /downloads

COPY /root /

# Set public environment variables.
ENV \
    PUID=1000 \
    PGID=100 \
    MYJDOWNLOADER_EMAIL= \
    MYJDOWNLOADER_PASSWORD= \
    MYJDOWNLOADER_DEVICE_NAME= \
    JDOWNLOADER_HEADLESS=0 \
    JDOWNLOADER_MAX_MEM=

# Expose ports.
#   - 3129: For MyJDownloader in Direct Connection mode.
EXPOSE 3129
EXPOSE 3002 3001
VOLUME /config
VOLUME /downloads
