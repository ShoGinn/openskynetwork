ARG BASE=debian:stretch-slim

FROM $BASE

ARG arch=none
ENV ARCH=$arch

COPY qemu/qemu-$ARCH-static* /usr/bin/

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

COPY openskydl.sh /tmp/

RUN \
	DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	ca-certificates \
	perl \
	init-system-helpers

RUN \
	/tmp/openskydl.sh \
	&& debconf-set-selections /tmp/preseed.txt \
	&& dpkg -i /tmp/opensky-feeder.deb \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean \
	&& rm -rf \
	/tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

WORKDIR /root

COPY opensky-runner.sh /usr/bin/opensky-runner.sh		

ENTRYPOINT ["opensky-runner.sh"]

# Metadata
ARG VCS_REF="Unknown"
LABEL maintainer="ginnserv@gmail.com" \
      org.label-schema.name="Docker ADS-B - openskynetwork" \
      org.label-schema.description="Docker container for ADS-B - This is the opensky-network.org component" \
      org.label-schema.url="https://github.com/ShoGinn/docker-ads-b" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/ShoGinn/docker-ads-b" \
      org.label-schema.schema-version="1.0"
