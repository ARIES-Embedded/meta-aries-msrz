SUMMARY = "Initramfs script to run shell instead of doing chroot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
SRC_URI = "file://devshell.sh"

PR = "r2"

S = "${WORKDIR}"

do_install() {
        install -d ${D}/init.d
        install -m 0755 ${WORKDIR}/devshell.sh ${D}/init.d/98-devshell
}

inherit allarch

RDEPENDS_${PN} = "initramfs-module-udev"
FILES_${PN} += "/init.d/98-devshell"
