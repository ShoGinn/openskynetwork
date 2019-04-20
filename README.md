# openskynetwork
Docker container for ADS-B - This is the opensky-network.org component

This is part of a suite of applications that can be used if you have a dump1090 compatible device including:
* Any RTLSDR USB device
* Any network AVR or BEAST device
* Any serial AVR or BEAST device

# Container Requirements

This is a multi architecture build that supports arm (armhf/arm64) and amd64

You must first have a running setup for before using this container as it will not help you on initial setup

# Container Setup

Env variables must be passed to the container containing the opensky-network required items

### Defaults
* DUMP1090_SERVER=dump1090 -- make sure your dump1090 container is named this and on the same network
* DUMP1090_PORT=30005 -- default port

### User Configured
* OPENSKY_USER - Your Opensky User
* OPENSKY_SERIAL - Your Opensky Serial
*These are not optional and must be set*
* DUMP1090_LAT ; The latitude of your ADSB Antenna ( In decimal format ex. 36.000)
* DUMP1090_LON ; The longitude of your ADSB Antenna (In decimal format ex. -115.000)
* DUMP1090_ALT ; The altitude above sea level for your ADSB Antenna (In decimal format ex. 500.00) 

#### Example docker run

```
docker run -d \
--restart unless-stopped \
--name='openskynetwork' \
-e DUMP1090_LAT="36.000" \
-e DUMP1090_LON="-115.000" \
-e DUMP1090_ALT="500.000" \
-e OPENSKY_USER="adsb-feeder55" \
-e OPENSKY_SERIAL="24323dsf2" \
shoginn/openskynetwork:latest-amd64

```
# Status
| branch | Status |
|--------|--------|
| master | [![Build Status](https://travis-ci.org/ShoGinn/openskynetwork.svg?branch=master)](https://travis-ci.org/ShoGinn/openskynetwork) |

| Arch | Size/Layers | Commit |
|------|-------------|--------|
[![](https://images.microbadger.com/badges/version/shoginn/openskynetwork:latest-arm.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm "Get your own version badge on microbadger.com") | [![](https://images.microbadger.com/badges/image/shoginn/openskynetwork:latest-arm.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/commit/shoginn/openskynetwork:latest-arm.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm "Get your own commit badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/shoginn/openskynetwork:latest-arm64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm64 "Get your own version badge on microbadger.com") | [![](https://images.microbadger.com/badges/image/shoginn/openskynetwork:latest-arm64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm64 "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/commit/shoginn/openskynetwork:latest-arm64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-arm64 "Get your own commit badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/shoginn/openskynetwork:latest-amd64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-amd64 "Get your own version badge on microbadger.com") | [![](https://images.microbadger.com/badges/image/shoginn/openskynetwork:latest-amd64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-amd64 "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/commit/shoginn/openskynetwork:latest-amd64.svg)](https://microbadger.com/images/shoginn/openskynetwork:latest-amd64 "Get your own commit badge on microbadger.com")

