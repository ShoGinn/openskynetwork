ARG BASE=debian:stretch-slim

FROM $BASE

ARG arch=none
ENV ARCH=$arch

COPY qemu/qemu-$ARCH-static* /usr/bin/

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

 RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 	ca-certificates \
 	curl \
 	perl \
 	init-system-helpers

RUN set -ex; \
    if [ ${ARCH} = "arm" ]; then \
		echo "Downloading arm version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_armhf.deb"; \
	fi; \
    if [ ${ARCH} = "aarch64" -o ${ARCH} = "arm64" ]; then \
	echo "Downloading arm64 version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_arm64.deb"; \
	fi; \
    if [ ${ARCH} = "amd64" ]; then \
	echo "Downloading amd64 version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_amd64.deb"; \
	fi; \
    echo 'opensky-feeder openskyd/latitude string 2' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/longitude string 2' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/altitude string 1' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/username string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/serial string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/port string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/host string' >> /tmp/preseed.txt; \
	debconf-set-selections /tmp/preseed.txt \
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
