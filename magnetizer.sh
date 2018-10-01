#!/bin/bash

set -euo pipefail

# Address and port of the transmission web interface
URL="http://192.168.1.100:9091"
# Download path on the target machine
DIRECTORY="/mnt/HD/HD_a2/Public/Transmission"

RPCURL="$URL/transmission/rpc"
SESSION=$(curl -s -I "${RPCURL}" | grep "X-Transmission-Session-Id" | tr -d '\r')

curl -H "X-Requested-With: XMLHttpRequest" -H "${SESSION}" -H "Content-Type: application/json" -X POST -d '{"method": "torrent-add", "arguments": {"paused":"false", "download-dir":"'"${DIRECTORY}"'", "filename":"'"$1"'"}}' "${RPCURL}"
