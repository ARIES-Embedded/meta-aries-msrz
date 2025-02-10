COMPATIBLE_MACHINE_mrzg2ls = "(mrzg2ls)"

PLATFORM_mrzg2ls = "g2l"
EXTRA_FLAGS_mrzg2ls = "BOARD=smarc_pmic_2 SOC_TYPE=1 SPI_FLASH=AT25QL128A"
PMIC_EXTRA_FLAGS_mrzg2ls = "BOARD=smarc_pmic_2"
FLASH_ADDRESS_BL2_BP_mrzg2ls = "00000"
FLASH_ADDRESS_FIP_mrzg2ls = "1D200"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	${@bb.utils.contains('MSRZ_SECURE_DRAM_2MB', '1', 'file://0001-MSRZ-2MB-secure-DRAM-for-Trust-Zone-and-OP-TEE.patch', '',d)} \
"
