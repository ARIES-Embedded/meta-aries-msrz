SUMMARY = "A small image just capable of allowing a device to boot."
LICENSE = "MIT"

IMAGE_LINGUAS = ""
IMAGE_INSTALL = " \
    packagegroup-core-boot \
    packagegroup-fiveberry-base \
    packagegroup-fiveberry-bringup \
    "
IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

inherit image
