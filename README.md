# meta-aries-msrz

This is a Yocto build layer(version:dunfell) that provides support for the MSRZ/G2UL MSRZ/FIVE Arm-based OSMs from ARIED Embedded.
Currently the following boards and MPUs are supported:

- Board: FIVEBerry/MSRZG2UL / MPU: R9A07G043U (RZ/G2UL)
- Board: FIVEBerry/MSRZFIVE / MPU: R9A07G043U (RZ/Five)
- Board: RZ SMARC Carrier Board/MRZG2LS / MPU: R9A07G044L (RZ/G2L)
- Board: RZ SMARC Carrier Board/MRZV2LS / MPU: R9A07G054L (RZ/V2L)
- Board: RZ OSM Carrier Board/MSRZG2UL / MPU: R9A07G043U (RZ/G2UL)

## Patches

To contribute to this layer you should email patches to <todo>@aries-embedded.de. Please send .patch files as email attachments, not embedded in the email body.

## Dependencies

This layer depends on:

    URI: git://git.yoctoproject.org/poky
    layers: meta, meta-poky, meta-yocto-bsp
    branch: dunfell
    tag: dunfell-23.0.31

    URI: https://git.openembedded.org/meta-openembedded
    layers: meta-oe, meta-python, meta-multimedia
    branch: dunfell
    revision: daa4619fe3fbf8c28f342c4a7163a84a330f7653

    URI: https://git.yoctoproject.org/meta-gplv2
    layers: meta-gplv2
    branch: dunfell
    revision: 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac

    URI: https://github.com/renesas-rz/meta-renesas
    layers: meta-rz-common, meta-rzg2l, meta-rzfive
    tag: refs/tags/BSP-3.0.6-update2

## Supported Linux distributions

The dunfell Poky release supports the following Linux distributions:
- Ubuntu-16.04
- Ubuntu-18.04
- Ubuntu-19.04
- Ubuntu-20.04
- Fedora-30
- Fedora-31
- Fedora-32
- Fedora-33
- Fedora-34
- Fedora-35
- Centos-7
- Centos-8
- Debian-8
- Debian-9
- Debian-10
- Debian-11
- Opensuseleap-15.1
- Opensuseleap-15.2
- Opensuseleap-15.3
- Almalinux-8.5

In the case where the build machine's distribution is not in the list, a deployment
of an isolated build environment using docker or podman containers is required.

For more information on building with docker see README.docker.

## Build Instructions

Assume that $WORK is the current working directory.
The following instructions require a Poky installation (or equivalent).

Below git configuration is required:
```bash
    $ git config --global user.email "you@example.com"
    $ git config --global user.name "Your Name"
```

You can download all Yocto related public source to prepare the build environment as below.
```bash
    $ mkdir sources && cd sources
    $ git clone https://git.yoctoproject.org/git/poky
    $ cd poky
    $ git checkout dunfell-23.0.31
    $ git cherry-pick eb0915c699fbe86488de172d529f073a30d05b6a
    $ cd ..

    $ git clone https://github.com/openembedded/meta-openembedded
    $ cd meta-openembedded
    $ git checkout daa4619fe3fbf8c28f342c4a7163a84a330f7653
    $ cd ..

    $ git clone https://git.yoctoproject.org/git/meta-gplv2
    $ cd meta-gplv2
    $ git checkout 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac
    $ cd ..
    $
    $ git clone https://github.com/renesas-rz/meta-renesas
    $ cd meta-renesas
    $ git checkout BSP-3.0.6-update2
    $ cd ..
    $
    $ git clone https://github.com/ARIES-Embedded/meta-aries-msrz.git
    $ cd ..

    $ ln -s sources/meta-aries-msrz/scripts/setup-environment
    $ ln -s sources/meta-aries-msrz/scripts/docker-build
```

In case you want to have Qt5 support, please install the following
layer as well:

```bash
    $ $ git clone  https://github.com/meta-qt5/meta-qt5.git
    $ cd meta-qt5
    $ git checkout -b tmp c1b0c9f546289b1592d7a895640de103723a0305
    $ cd ..
```
If you want to use OpenSource graphics support for the GPU, please download
the `meta-rz-panfrost` layer from Renesas:

```bash
    $ git clone https://github.com/renesas-rz/meta-rz-panfrost.git
```

For proprietary graphics and multimedia drivers from Renesas please follow
the instructions at:

         https://github.com/renesas-rz/meta-renesas?tab=readme-ov-file#build-instructions

**Build procedure (Recommended):**
- Initialize a build using the 'setup-environment' script in the $WORK directory and specify MACHINE and DISTRO variants  e.g.:
   ```bash
   $ mkdir -p build
   $ MACHINE=msrzg2ul DISTRO=poky . setup-environment build
   ```
  \<MACHINE\> can be selected in below table:

  | Renesas MPU |  Platform |  MACHINE |
  |:-----------:|:---------:|:--------:|
  |   RZ/G2UL   | fiveberry | msrzg2ul |
  |   RZ/Five   | fiveberry | msrzfive |
  |   RZ/G2UL   |    OSM    | msrzg2ul |
  |    RZ/G2L   |  RZ SMARC | mrzg2ls  |
  |    RZ/V2L   |  RZ SMARC | mrzv2ls  |

  \<DISTRO\> is fixed as poky

- Build the target images using bitbake:
  ```bash
  $ bitbake fiveberry-image-minimal fiveberry-image-minimal-initramfs
  ```
  The following images and files will be generated as a result of the build:
  * spl-msrzfive.bin - U-Boot secondary program loader (MSRZFive only)
  * spl-msrzfive.srec - U-Boot secondary program loader, Motorola S-record format (MSRZFive only)
  * fit-msrzfive.bin - combined U-Boot image (MSRZFive only)
  * fit-msrzfive.srec - combined U-Boot image, Motorola S-record format (MSRZFive only)
  * bl2_bp-\<machine name\>.bin - ARM Boot Loader stage 2 (MSRZG2UL and MRZG2LS only)
  * bl2_bp-\<machine name\>.srec - ARM Boot Loader stage 2, Motorola S-record format (MSRZG2UL and MRZG2LS only)
  * fip-\<machine name\>.bin - combined U-Boot image (MSRZG2UL and MRZG2LS only)
  * fip-\<machine name\>.srec - combined U-Boot image, Motorola S-record format (MSRZG2UL and MRZG2LS only)
  * Flash_Writer_SCIF_\<machine name\>.mot - Serial Flash Programmer image
  * Image.gz-\<machine name\>.bin - compressed Linux Kernel binary
  * \<machine name\>.dtb - DTB for target machine
  * fiveberry-image-minimal-\<machine name\>.ext4 - rootfs image in ext4 format
  * fiveberry-image-minimal-initramfs-\<machine name\>.cpio.gz - initramfs image
  * fiveberry-image-minimal-\<machine name\>.wic.gz - image for the micro SD card

  The uncompressed `wic.gz` image can be written directly to the micro SD card with `dd`.

- For graphics, you can build a "Weston" or a "Weston+Qt5" image.
  You need the following settings in your `local.conf`:

  ```bash
      $ vi conf/local.conf
      ...
      IMAGE_INSTALL_remove += "\
          lttng-modules \
          lttng-tools \
          lttng-ust \
          kernel-module-uvcvideo \
      "

      PACKAGECONFIG_append_pn-mesa = " egl kmsro panfrost"
      IMAGE_INSTALL_append += " mesa weston kmscube"
  ```

Then you can build the the image with:
  ```bash
      $ bitbake core-image-weston
  ```

or
  ```bash
      $ bitbake core-image-qt
  ```

## Automatic selection of boot source

In SPI boot mode (SW1.1 - closed, SW1.2 - open) initial target booting is performed from the QSPI Flash. Once the U-Boot
is started, further loading of Linux OS can be performed from additional sources, such as an SD card or an USB flash
drive, in addition to the SPI Flash itself. The priority of boot sources is the following SD -> USB -> SPI. Thus, by
default U-Boot tries to load Linux kernel, DTB and rootfs from an SD card, and if this procedure fails it switches to
the next source. U-Boot searches for the required files on the first partition of the corresponding device (mmcblk1p1
for SD, and sda1 for USB).

The automatic boot source selection can be overridden and set to any source from SD, USB or SPI. This is controlled by
the `boot_mode` U-Boot environment variable, which is set to `auto` by default. The variable can be set to the following
values, which are self describing:
- `auto` - automatic boot surce selection
- `spi` - boot kernel, DTB and initramfs are located on the SPI Flash
- `mmc` - boot kernel, DTB and rootfs are located on the SD card
- `usb` - boot kernel, DTB and rootfs are located on the USB Flash drvie

The following command can be used in U-Boot for adjusting the `boot_mode` variable:
```
=> setenv boot_mode usb
=> saveenv
```

From Linux the `boot_mode` variable can be changed with help of the `fw_setenv` command, as show below:
```
# fw_setenv boot_mode mmc
```


## Initial Target Programming

### Programming U-Boot and Secondary Program Loader via Serial Interface

Serial Interface (SCIF) can be used for initial programming of all supported targets (MSRZG2UL, MRZG2LS and MSRZFive). SCIF supports maximum transmission rate of 115200 baud, so this method is only suitable for progreamming U-Boot and subsidiary loaders. Programming othre images such as Kernel image or rootfs image via SCIF will take too much time. Follow the below steps for initial programming of U-Boot and SPL/BL2 loaders into the SPI flash of the target:

1. Set boot switches on the Fiveberry carrier board into the SCIF boot position: SW1.1 - open, SW1.2 - closed. Then reset the board.
1. Follow instruction from the following document to porgram U-Boot and SPL/BL2 loader into the SPI Flash: https://www.renesas.com/eu/en/document/gde/smarc-evk-rzg2l-rzg2lc-rzg2ul-rzv2l-and-rzfive-start-guide-rev103?r=1569466
1. The below images should be used along with the Serial Downloader instructions:
   - MSRZFive: `spl-msrzfive.srec`, `fit-msrzfive.srec`
   - MSRZG2UL: `bl2_bp-msrzg2ul.srec`, `fip-msrzg2ul.srec`
   - MRZG2LS: `bl2_bp-mrzg2ls.srec`, `fip-mrzg2ls.srec`
1. Set boot switches on the Fiveberry carrier board into the QSPI boot position: SW1.1 - closed, SW1.2 - open. Then reset the board.
1. Verify that the board boots into the U-Boot command prompt.

### Programming Kernel and Initramfs images into the SPI Flash

U-Boot for MSRZG2UL/MRZG2LS/MSRZFive includes builin support for network interfaces. Thus when initial programming of U-Boot is done, additional images such as Linux Kernel and rootfs can be loaded via network. MSRZG2UL/MSRZFive targets has 16 Mb of QSPI Flash (64 Mb on MRZG2LS). This is enough for storing a Linux Kernel and initramfs images. While a full fledged root filesystem can be created on a SD card, or USB flash drive.

Follow the below steps for setting up a TFTP server and load kernel, DTB and initramfs images into the SPI Flash.

1. Setup tftpboot server on a host machine: ```sudo apt-get install tftpd-hpa```
1. Copy kernel, DTB and initramfs images generated by Yocto build into the TFTP server root directory:
   ```
   # mkdir /var/lib/tftpboot/boot
   # cp Image.gz-<machine name>.bin /var/lib/tftpboot/boot/
   # cp <machine name>.dtb /var/lib/tftpboot/boot/
   # cp fiveberry-image-minimal-initramfs-<machine name>.cpio.gz /var/lib/tftpboot/boot/fiveberry-image-minimal-initramfs-<machine name>.bin
   ```
1. Copy U-Boot and secondary loader images (MSRZFive):
   ```
   # cp spl-msrzfive.bin /var/lib/tftpboot/boot/
   # cp fit-msrzfive.bin /var/lib/tftpboot/boot/
   ```
1. Copy U-Boot and secondary loader images (MSRZG2UL and MRZG2LS):
   ```
   # cp bl2_bp-<machine_name>.bin /var/lib/tftpboot/boot/
   # cp fip-<machine_name>.bin /var/lib/tftpboot/boot/
   ```
1. Open serial connection to the target, and configure IP addresses of the board and tftp server in the U-Boot prompt:
   ```
   => setenv ipaddr 192.168.22.201
   => setenv serverip 192.168.22.11
   ```
1. Optionally, adjust the MAC address of the target, if there are more than one boards present in the network:
   ```
   => setenv ethaddr d6:8f:16:4f:c3:c7
   ```
1. Save adjusted U-Boot environment parameters:
   ```
   => saveenv
   Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...done
   Valid environment: 2
   OK
   ```
1. Run the following command in the U-Boot prompt for writing Linux kernel Image and rootfs image to SPI flash:
   ```
   => run spi_update_all
   ```

### Programming Kernel and rootfs images to SD card/USB Flash

U-Boot searches the first partition of SD/USB drive for Linux boot files and root filesystem. Perform the below steps
for installing rootfs generated as a result of Yocto build into an SD card or USB flash drive:

1. Insert an SD card or USB Flash drive that will be used for booting Linux into a host PC.
1. Run `fdisk` and create a partition table with at least one partition on the SD/USB drive. Size of the partition should be enought to store the `fiveberry-image-minimal-<machine name>.ext4` file.
1. Install the rootfs filesystem to the first partition of the SD/USB drive:
   ```
   # sudo dd if=fiveberry-image-minimal-<machine name>.ext4 of=/dev/sdX1
   ```
1. Mount the root file system on the host, and copy kernel and DTB images into the `/boot` directory on the file system:
   ```
   # sudo mount /dev/sdX1 /mnt/
   # sudo cp Image.gz-<machine name>.bin /mnt/boot/
   # sudo cp <machine name>.dtb /mnt/boot/
   # sudo sync && sudo umount /mnt
   ```
1. Insert the SD/USB drive into the MSRZG2UL/MRZG2LS/MSRZFive target and reset it.
