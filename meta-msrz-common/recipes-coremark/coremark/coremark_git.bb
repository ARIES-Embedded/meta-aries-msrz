# CoreMark
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=0a18b17ae63deaa8a595035f668aebe1"

SRC_URI = "git://github.com/eembc/coremark.git;protocol=https;branch=main"

PV = "1.0+git${SRCPV}"
SRCREV = "d5fad6bd094899101a4e5fd53af7298160ced6ab"

S = "${WORKDIR}/git"

export XCFLAGS="-DPERFORMANCE_RUN=1"
#export XCFLAGS="-DPERFORMANCE_RUN=1 -DMULTITHREAD=4 -DUSE_PTHREAD -pthread"

EXTRA_OEMAKE += " PORT_DIR=linux OUTNAME=coremark link "
do_compile () {
	oe_runmake
}

INSANE_SKIP_${PN} += "ldflags"

do_install () {
	install -d ${D}/${bindir}
	install -m 0755 ${S}/coremark ${D}/${bindir}
}
