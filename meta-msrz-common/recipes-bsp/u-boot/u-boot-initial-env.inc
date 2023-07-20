UBOOT_INITIAL_ENV ?= "${PN}-initial-env"

for_each_config_type() {
    local fn=$1
    if [ -n "${UBOOT_CONFIG}" ]
    then
        unset i j k
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    eval $fn $config $type
                fi
            done
            unset  j
        done
        unset  i
    else
        eval $fn
    fi
}

compile_default_env() {
    local config=$1 type=$2
    if [ -n "${config} " ];
    then
        oe_runmake -C ${S} O=${B}/${config} u-boot-initial-env
        cp ${B}/${config}/u-boot-initial-env ${B}/${config}/u-boot-initial-env-${type}
    else
        oe_runmake -C ${S} O=${B} u-boot-initial-env
    fi
}

install_default_env() {
    local config=$1 type=$2
    if [ -n "${config} " ];
    then
        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${type}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
    else
        install -D -m 644 ${B}/u-boot-initial-env ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
    fi
}

deploy_default_env() {
    local config=$1 type=$2
    if [ -n "${config} " ];
    then
        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
        cd ${DEPLOYDIR}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${type}
    else
        install -D -m 644 ${B}/u-boot-initial-env ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
        cd ${DEPLOYDIR}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}
        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}
    fi
}

do_compile_append () {
    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
        for_each_config_type compile_default_env
    fi
}
do_compile[vardeps] += "compile_default_env"

do_install_append () {
    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
        for_each_config_type install_default_env
    fi
}
do_install[vardeps] += "install_default_env"

do_deploy_append () {
    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
        for_each_config_type deploy_default_env
    fi
}
do_deploy[vardeps] += "deploy_default_env"

PACKAGE_BEFORE_PN += "${PN}-env"
RPROVIDES_${PN}-env += "u-boot-default-env"
ALLOW_EMPTY_${PN}-env = "1"
FILES_${PN}-env = " \
    ${@ '${sysconfdir}/${UBOOT_INITIAL_ENV}*' if d.getVar('UBOOT_INITIAL_ENV') else ''} \
    ${sysconfdir}/fw_env.config \
"

FILES_${PN} = "/boot ${datadir}"
RDEPENDS_${PN} += "${PN}-env"
