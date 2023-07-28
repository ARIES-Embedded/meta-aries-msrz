FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-MSRZFIVE-board-support.patch \
            file://0002-remove-redundant-memset.patch \
            "
BOARD = "MSRZFIVE"

