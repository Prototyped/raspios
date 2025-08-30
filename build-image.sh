#!/bin/bash

set -euo pipefail

PODMAN=/usr/bin/podman

if ! [[ -x $PODMAN ]]
then
    PODMAN=/usr/bin/docker
fi

if ! [[ -x $PODMAN ]]
then
    echo Cannot find podman or docker.
    exit 1
fi

location="$(dirname "$0")"

cd "$location"
$PODMAN build --platform=linux/arm/v6 -t ghcr.io/prototyped/raspios:bookworm-armhf-lite .
