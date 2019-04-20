#!/usr/bin/env bash
set -e

if [ "$ARCH" = "arm" ] ; then
	echo "Download armhf version"
	curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_armhf.deb"
fi
if [ "$ARCH" = "aarch64" ] ; then
    echo "Download arm64 version"
    curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_arm64.deb"
fi
if [ "$ARCH" = "amd64" ] ; then
	echo "Download AMD64 version"
	curl --output /tmp/opensky-feeder.deb "https://opensky-network.org/files/firmware/opensky-feeder_latest_amd64.deb"
fi

echo 'opensky-feeder openskyd/latitude string 2' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/longitude string 2' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/altitude string 1' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/username string' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/serial string' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/port string' >> /tmp/preseed.txt; \
echo 'opensky-feeder openskyd/host string' >> /tmp/preseed.txt; \