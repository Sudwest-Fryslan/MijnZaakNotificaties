#!/bin/bash

if [[ -n $1 ]]; then
  echo "writeBuildInfo.sh - writing version $1"
  echo "version=$1" > src/main/configurations/LopendeZaken/BuildInfo.properties
  echo "versionDate_ddmmyyyy=$(date +%d/%m/%Y)" >> src/main/configurations/LopendeZaken/BuildInfo.properties
else
  echo "writeBuildInfo.sh - no version to write, leaving BuildInfo.properties unchanged"
fi