FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://fw_env.config"
do_deploy_append() {
    install -m 755 ${B}/u-boot-spl_bp.bin ${DEPLOY_DIR_IMAGE}/spl-${MACHINE}.bin
    install -m 755 ${B}/${config}/u-boot.itb ${DEPLOY_DIR_IMAGE}/fit-${MACHINE}.bin
}
