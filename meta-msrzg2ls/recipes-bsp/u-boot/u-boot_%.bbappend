FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://fw_env.config"
BRANCH = "dev/v2021.10/msrz"
SRCREV = "${AUTOREV}"
