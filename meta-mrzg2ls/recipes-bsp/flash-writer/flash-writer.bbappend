FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BOARD_mrzg2ls = "RZG2L_SMARC_PMIC"
SRC_URI += "file://0001-RM6824-add-support-for-W25Q512NW-SPI-flash.patch"
