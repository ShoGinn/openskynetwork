#!/usr/bin/env bash

set -o errexit # Exit on most errors (see the manual)
#set -o errtrace         # Make sure any error trap is inherited
set -o nounset  # Disallow expansion of unset variables
set -o pipefail # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

[[ -n ${DUMP1090_LAT} ]] && debconf-set-selections <<<"opensky-feeder openskyd/latitude string ${DUMP1090_LAT}" || DUMP1090_LAT="1"
[[ -n ${DUMP1090_LON} ]] && debconf-set-selections <<<"opensky-feeder openskyd/longitude string ${DUMP1090_LON}" || DUMP1090_LON="1"
[[ -n ${DUMP1090_ALT} ]] && debconf-set-selections <<<"opensky-feeder openskyd/altitude string ${DUMP1090_ALT}" || DUMP1090_ALT="1"
[[ -n ${OPENSKY_USER} ]] && debconf-set-selections <<<"opensky-feeder openskyd/username string ${OPENSKY_USER}" || OPENSKY_USER=""
[[ -n ${OPENSKY_SERIAL} ]] && debconf-set-selections <<<"opensky-feeder openskyd/serial string ${OPENSKY_SERIAL}" || OPENSKY_SERIAL=""
[[ -n ${DUMP1090_SERVER} ]] && debconf-set-selections <<<"opensky-feeder openskyd/host string ${DUMP1090_SERVER}" || DUMP1090_SERVER="dump1090"
[[ -n ${DUMP1090_PORT} ]] && debconf-set-selections <<<"opensky-feeder openskyd/port string ${DUMP1090_PORT}" || DUMP1090_PORT="30005"
dpkg-reconfigure opensky-feeder

echo "Waiting for dump1090 to start up"
sleep 5s

echo "Ping test to dump1090"
ping -c 3 "${DUMP1090_SERVER}"

exec /usr/bin/openskyd-dump1090

exit ${?}
