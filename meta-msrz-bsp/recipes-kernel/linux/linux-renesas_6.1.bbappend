FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:msrzg3eevk = " \
	file://0001-drm-panel-Add-support-for-Ampire-AM-800480R2-800x480.patch \
	file://0002-drm-panel-increase-clock-freq-of-Ampire-AM-800480R2-.patch \
	file://0003-MSRZG3EEVK-add-support-for-the-RZ-G3E-OSM-from-ARIES.patch \
	file://msrzg3eevk.cfg \
"

SRC_URI:append:msrzv2hberry = " \
	file://0001-MSRZV2HBerry-add-support-for-module-MSRZV2H-on-the-V.patch \
	file://0002-drm-panel-Add-support-for-Ampire-AM-800480R2-800x480.patch \
	file://0003-drm-panel-increase-clock-freq-of-Ampire-AM-800480R2-.patch \
	file://0004-drm-bridge-tc358767-fixes-for-the-ARIES-embedded-MSR.patch \
	file://0005-MSRZV2HBerry-add-graphics-support-to-display-port-or.patch \
	file://msrzv2hberry.cfg \
"
