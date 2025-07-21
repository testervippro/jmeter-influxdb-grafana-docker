#!/bin/bash

# Get current timestamp
export timestamp=$(date +%Y%m%d_%H%M%S)

# Define paths
export volume_path=$(pwd)/jmeter-scripts
export jmeter_path=/mnt/jmeter

# Detect OS and set INFLUXDB_HOST accordingly
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     influx_host="host.docker.internal";; # Try host-gateway below
    Darwin*)    influx_host="host.docker.internal";; # macOS supports it
    *)          influx_host="localhost"
esac

# For Linux, ensure host-gateway works
if [[ "$unameOut" == "Linux" ]]; then
  docker run \
    --add-host=host.docker.internal:host-gateway \
    --volume "${volume_path}":${jmeter_path} \
    jmeter \
    -n \
    -t ${jmeter_path}/$1 \
    -JINFLUXDB_HOST="${influx_host}" \
    -l ${jmeter_path}/results/result_${timestamp}.jtl \
    -j ${jmeter_path}/results/jmeter_${timestamp}.log
else
  docker run \
    --volume "${volume_path}":${jmeter_path} \
    jmeter \
    -n \
    -t ${jmeter_path}/$1 \
    -JINFLUXDB_HOST="${influx_host}" \
    -l ${jmeter_path}/results/result_${timestamp}.jtl \
    -j ${jmeter_path}/results/jmeter_${timestamp}.log
fi
