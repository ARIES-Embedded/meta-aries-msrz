FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
	file://fw_env.config \
	${@bb.utils.contains('MSRZ_SECURE_DRAM_2MB', '1', 'file://0001-MRZG2LS-2MB-secure-DRAM-for-Trust-Zone-and-OP-TEE.patch', '',d)} \
"
BRANCH = "dev/v2021.10/msrz"
SRCREV = "${AUTOREV}"
