#
# Copyright (C) 2023 ARIES Embedded
#

SUMMARY = "MSRZ packages groups needed for bringup"
PR = "r0"

inherit packagegroup

RDEPENDS_${PN} = "\
    stress-ng \
    iperf3 \
    libstdc++ \
    curl \
    ncurses-libncurses \
    devmem2 \
    "
