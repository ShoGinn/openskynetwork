FROM debian:stretch-slim AS base

COPY rootfs /

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	iputils-ping \
	dnsutils \
	perl \
	&& apt-get clean \
	&& rm -rf \
	/tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

FROM --platform=$TARGETPLATFORM debian:stretch-slim as builder

WORKDIR /tmp

RUN \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates \
	curl

# TARGETARCH is used to identify which version of opensky to download
ARG TARGETARCH

RUN if [ "${TARGETARCH}" = "linux/arm/v6" -o "${TARGETARCH}" = "linux/arm/v7" ]; then \
		echo "Downloading arm version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_armhf.deb"; \
	fi; \
    if [ "${TARGETARCH}" = "linux/arm64" ]; then \
	echo "Downloading arm64 version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_arm64.deb"; \
	fi; \
    if [ "${TARGETARCH}" = "linux/amd64" ]; then \
	echo "Downloading amd64 version" ; \
		curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_amd64.deb"; \
	fi; \
    echo 'opensky-feeder openskyd/latitude string 2' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/longitude string 2' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/altitude string 1' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/username string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/serial string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/port string' >> /tmp/preseed.txt; \
	echo 'opensky-feeder openskyd/host string' >> /tmp/preseed.txt;

FROM base

COPY --from=builder /tmp /tmp

RUN debconf-set-selections /tmp/preseed.txt \
	&& dpkg -i /tmp/opensky-feeder.deb \
	&& rm -rf \
	/tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]