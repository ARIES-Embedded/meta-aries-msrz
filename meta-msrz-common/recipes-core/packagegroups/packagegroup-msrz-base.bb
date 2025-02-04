#
# Copyright (C) 2023 ARIES Embedded
#

SUMMARY = "MSRZ debug package groups"
PR = "r0"

inherit packagegroup

RDEPENDS_${PN} = "\
    ssh \
    u-boot-fw-utils \
    u-boot-default-env \
    usb-gadgets \
    "
