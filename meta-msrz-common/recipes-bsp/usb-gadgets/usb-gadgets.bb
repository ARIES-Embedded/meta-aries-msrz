# Copyrigh (C) 2022 VoxelBotics
# Copyrigh (C) 2023 ARIES Embedded
# Various USB gadgets

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://usb-gadget-eth@.service \
	file://usb-gadget-eth.sh \
	file://usb-gadget-stop.sh \
	file://usbeth.sh \
"

#DISTRO_FEATURES += "systemd"


inherit systemd update-rc.d

# RZ/G2UL and RZ/FIVE USB-A port
USB_PORT ?= "11c60000.usb"

# USB gadget links directory
GADGET_LINKS_DIR = "${sysconfdir}/systemd/system/usb-gadget.target.wants"

INITSCRIPT_PACKAGES = "${PN}-eth"
INITSCRIPT_NAME:${PN}-eth = "usbeth"

do_install() {
	install -d ${D}

	# USB gadget scripts
	install -d ${D}${sbindir}
	install -m 0755 ${WORKDIR}/usb-gadget-eth.sh ${D}${sbindir}
	install -m 0755 ${WORKDIR}/usb-gadget-stop.sh ${D}${sbindir}

	# USB gadget init script
	install -d ${D}${sysconfdir}/init.d
	install -m 0755 ${WORKDIR}/usbeth.sh ${D}${sysconfdir}/init.d/usbeth

	# USB gadget services
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/usb-gadget-eth@.service ${D}${systemd_system_unitdir}
}

PACKAGES += " \
	${PN}-eth \
"
SYSTEMD_PACKAGES = "${PACKAGES}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES:${PN} = "${sbindir} ${systemd_system_unitdir}/*.service"
FILES:${PN}-eth = "${sbindir} ${sysconfdir}"
SYSTEMD_SERVICE:${PN}-eth = "usb-gadget-eth@${USB_PORT}.service"
RDEPENDS:${PN}-eth = "${PN}"
