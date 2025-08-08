EXTRA_OEMAKE:append = " PLAT_SYSTEM_SUSPEND=1"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://0001-MSRZG3E-board-configuration.patch \
"
