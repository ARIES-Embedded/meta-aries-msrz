FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://0001-drm-panel-Add-support-for-Ampire-AM-800480R2-800x480.patch \
	file://0002-drm-panel-increase-clock-freq-of-Ampire-AM-800480R2-.patch \
	file://0003-MSRZG3EEVK-add-support-for-the-RZ-G3E-OSM-from-ARIES.patch \
	file://msrzg3eevk.cfg \
"
