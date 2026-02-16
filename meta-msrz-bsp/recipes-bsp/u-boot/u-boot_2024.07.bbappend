FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:msrzg3eevk = " \
	file://0001-MSRZG3EEVK-add-support-for-the-RZ-G3E-OSM-from-ARIES.patch \
"

SRC_URI:append:msrzv2hberry = " \
	file://0001-MSRZV2H-board-configuration.patch \
"
