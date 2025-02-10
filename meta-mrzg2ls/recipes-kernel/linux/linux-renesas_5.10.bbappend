KBUILD_DEFCONFIG = "mrzg2ls_defconfig"
COMPATIBLE_MACHINE_mrzg2ls = "(mrzg2ls)"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	${@bb.utils.contains('MSRZG2UL_SECURE_DRAM_2MB', '1', 'file://0001-MRZG2LS-2MB-secure-DRAM-for-Trust-Zone-and-OP-TEE.patch', '',d)} \
"
