EXTRA_OEMAKE:append:rzg3e-family = " PLAT_SYSTEM_SUSPEND=1"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:rzg3e-family = " \
	file://0001-MSRZG3E-board-configuration.patch \
"

SRC_URI:append:rzv2h-family = " \
	file://0001-MSRZV2H-board-configuration.patch \
"
