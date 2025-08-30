FROM docker.io/library/debian:trixie-slim AS extracting

RUN set -eu; \
    DEBIAN_FRONTEND=noninteractive; \
    export DEBIAN_FRONTEND; \
    apt -y update; \
    apt -y install unzip curl 7zip xz-utils fdisk jq; \
    cd /root; \
    curl -LSso raspios.img.xz https://downloads.raspberrypi.com/raspios_lite_armhf/images/raspios_lite_armhf-2025-05-13/2025-05-13-raspios-bookworm-armhf-lite.img.xz; \
    xz -dc raspios.img.xz | dd conv=sparse of=raspios.img bs=1048576; \
    start_offset=$(sfdisk -d -J raspios.img | jq '.partitiontable.partitions[1].start'); \
    sector_size=$(sfdisk -d -J raspios.img | jq '.partitiontable.sectorsize'); \
    dd conv=sparse if=raspios.img bs=$sector_size skip=$start_offset of=raspios-linux.img; \
    mkdir -p raspios; \
    7z -snld -oraspios x raspios-linux.img; \
    rm -rf extfstools.zip raspios.img.xz raspios.img raspios-linux.img extfstools-master /var/lib/apt/lists/* /var/cache/apt/archives/*

FROM --platform=linux/arm/v6 scratch

COPY --from=extracting /root/raspios/ /

WORKDIR /root
CMD /bin/bash
