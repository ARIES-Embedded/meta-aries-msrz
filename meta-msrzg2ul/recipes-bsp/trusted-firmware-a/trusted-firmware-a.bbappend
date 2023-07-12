COMPATIBLE_MACHINE_msrzg2ul = "(msrzg2ul)"

PLATFORM_msrzg2ul = "g2ul"
EXTRA_FLAGS_msrzg2ul = "BOARD=msrzg2ul SOC_TYPE=1 SPI_FLASH=AT25QL128A"
FLASH_ADDRESS_BL2_BP_msrzg2ul = "00000"
FLASH_ADDRESS_FIP_msrzg2ul = "1D200"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-MSRZG2UL-board-configuration.patch \
            file://0001-Call-spi-init-during-EMMC-boot.patch \
            "

