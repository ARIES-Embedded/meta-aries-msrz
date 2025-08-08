FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://0001-MSRZG3EEVK-add-support-for-the-RZ-G3E-OSM-from-ARIES.patch \
"
