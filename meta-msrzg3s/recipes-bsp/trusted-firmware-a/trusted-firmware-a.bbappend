require trusted-firmware-a.inc

COMPATIBLE_MACHINE_rzg3s = "(msrzg3s-baa|msrzg3s-a0a)"

PLATFORM = "g3s"
EXTRA_FLAGS_msrzg3s-a0a = "BOARD=msrzg3s PLAT_SYSTEM_SUSPEND=awo PLAT_DRAM_SIZE=0x20000000ull"
EXTRA_FLAGS_msrzg3s-baa = "BOARD=msrzg3s PLAT_SYSTEM_SUSPEND=awo PLAT_DRAM_SIZE=0x40000000ull"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-MSRZG3S-board-configuration.patch \
	${@bb.utils.contains('MSRZ_SECURE_DRAM_2MB', '1', 'file://0002-MSRZ-2MB-secure-DRAM-for-Trust-Zone-and-OP-TEE.patch', '',d)} \
"

FILES_${PN} = "/boot "
SYSROOT_DIRS += "/boot"

do_compile() {
        oe_runmake PLAT=${PLATFORM} ${EXTRA_FLAGS} bl2 bl31
}

do_install() {
        install -d ${D}/boot
        install -m 644 ${S}/build/${PLATFORM}/release/bl2.bin ${D}/boot/bl2-${MACHINE}.bin
        install -m 644 ${S}/build/${PLATFORM}/release/bl31.bin ${D}/boot/bl31-${MACHINE}.bin
}

