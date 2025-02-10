KBUILD_DEFCONFIG = "msrzg2ul_defconfig"
COMPATIBLE_MACHINE_msrzg2ul = "(msrzg2ul-baa|msrzg2ul-a0a)"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	${@bb.utils.contains('MSRZ_SECURE_DRAM_2MB', '1', 'file://0001-MSRZG2UL-2MB-secure-DRAM-for-Trust-Zone-and-OP-TEE.patch', '',d)} \
"
