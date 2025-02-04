# meta-aries-msrz

This is a Yocto build layer (version:dunfell) that provides support for the
MSRZ modules and carrier boards from [ARIES Embedded][1], which are based on
the RZ/G2 and RZ/G3 Group of 64 bit Arm-based MPUs from Renesas Electronics.
Currently the following modules, boards and MPUs are supported:

  | Module        | Board/EVK              | Renesas MPU          |
  | ------------- | ---------------------- | -------------------- |
  | SMARC MRZG2LS | MRZG2LSEVK             | R9A07G044L (RZ|G2L)  |
  | SMARC MRZV2LS | MRZV2LSEVK             | R9A07G054L (RZ|V2L)  |
  | MSRZG2UL      | MSRZG2ULEVK, G2ULberry | R9A07G043U (RZ|G2UL) |
  | MSRZG3S       | MSRZG3SEVK, G3Sberry   | R9A08G045 (RZ/G3S)   |

## Patches

To contribute to this layer you should email patches to info@aries-embedded.de.
Please send patch files as email attachments, not embedded in the email body.

## Dependencies

This layer depends on:

    URI: git://git.yoctoproject.org/poky
    layers: meta, meta-poky, meta-yocto-bsp
    branch: dunfell
    revision: a9e3cc3b9eab7a83c715bb8440454e8fea852c2a
    tag: dunfell-23.0.31
    cherry-pick commit eb0915c699fbe86488de172d529f073a30d05b6a

    URI: https://git.openembedded.org/meta-openembedded
    layers: meta-oe, meta-python, meta-multimedia
    branch: dunfell
    revision: daa4619fe3fbf8c28f342c4a7163a84a330f7653

    URI: https://git.yoctoproject.org/meta-gplv2
    layers: meta-gplv2
    branch: dunfell
    revision: 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac

    URI: https://github.com/renesas-rz/meta-renesas
    layers: meta-rz-common, meta-rzg2l, meta-rzv2l, meta-rzg3s, meta-rzfive
    tag: refs/tags/BSP-3.0.6-update4

    core-image-qt: Optional (unsupported for RZ/V2M, RZ/V2MA and RZ/G3S)
    URI: https://github.com/meta-qt5/meta-qt5.git
    layers: meta-qt5
    revision: c1b0c9f546289b1592d7a895640de103723a0305
    cherry-pick commit 77b6060cef9337b184100083746c2e35f531be74

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

In the case where the build machine's distribution is not in the list, a
deployment of an isolated build environment using docker or podman containers is
required.

For more information on building with docker see README.docker.

## Build Instructions

Assume that `$WORK` is the current working directory.
The following instructions require a Poky installation (or equivalent).

Below git configuration is required:
```bash
    $ git config --global user.email "you@example.com"
    $ git config --global user.name "Your Name"
```

You can download all Yocto related public source to prepare the build
environment as below:
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
    $ git checkout BSP-3.0.6-update4
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
    $ git cherry-pick 77b6060cef9337b184100083746c2e35f531be74
    $ cd ..
```
If you want to use OpenSource graphics support for the GPU, please download the
`meta-rz-panfrost` layer from Renesas:

```bash
    $ git clone https://github.com/renesas-rz/meta-rz-panfrost.git
```

For proprietary graphics and multimedia drivers from Renesas please follow the
instructions at:

         https://github.com/renesas-rz/meta-renesas?tab=readme-ov-file#build-instructions

### Build procedure (Recommended):

- Initialize a build using the `setup-environment` script in the `$WORK` directory
  and specify `MACHINE` and `DISTRO` variants  e.g.:

   ```bash
   $ mkdir -p build
   $ MACHINE=msrzg2ul-baa DISTRO=poky . setup-environment build
   ```

  `MACHINE` can be selected in below table:

  | Renesas MPU |    Module     |      Board/EVK         |          MACHINE           |
  | ----------- | ------------- | ---------------------- | -------------------------- |
  |   RZ/G2L    | SMARC MRZG2LS | MRZG2LSEVK             | mrzg2ls                    |
  |   RZ/V2L    | SMARC MRZV2LS | MRZV2LSEVK             | mrzv2ls                    |
  |   RZ/G2UL   | MSRZG2UL      | MSRZG2ULEVK, G2ULberry | msrzg2ul-a0a, msrzg2ul-baa |
  |   RZ/G3S    | MSRZG3S       | MSRZG3SEVK, G3sberry   | msrzg3s-a0a, msrzg3s-baa   |

  `DISTRO` is fixed as ´poky´.

- Build the target images using bitbake:

  ```bash
  $ bitbake msrz-image-minimal msrz-image-minimal-initramfs
  ```

  The following images and files will be generated as a result of the build:

  * bl2_bp-\<MACHINE\>.bin - ARM Boot Loader stage 2
  * bl2_bp-\<MACHINE\>.srec - ARM Boot Loader stage 2, Motorola S-record format
  * fip-\<MACHINE\>.bin - combined U-Boot image
  * fip-\<MACHINE\>.srec - combined U-Boot image, Motorola S-record format
  * Flash_Writer_SCIF_\<MACHINE\>.mot - Serial Flash Programmer image
  * Image-\<MACHINE\>.bin - uncompressed Linux Kernel binary
  * Image.gz-\<MACHINE\>.bin - compressed Linux Kernel binary
  * \<MACHINE\>.dtb - DTB for target machine
  * msrz-image-minimal-\<MACHINE\>.ext4 - rootfs image in ext4 format
  * msrz-image-minimal-initramfs-\<MACHINE\>.cpio.gz - initramfs image
  * msrz-image-minimal-\<MACHINE\>.wic.gz - image for the micro SD card

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

## Boot mode switches:

The following boot modes are supported for the MSRZ boards:

- MRZG2LSEVK, MRZG2LSEVK (Switch S1):

  | Boot from |     Switch settings     |
  | --------- | ----------------------- |
  | SCIF      | 1=open, 2=closed 3=open |
  | SPI-NOR   | 1=open, 2=open 3=open   |
  | eMMC      | 1=closed, 2=open 3=open |

- MSRZG2ULEVK (Swtch S1/BOOT), G2ULberry (Switch S3/BOOT)

  | Boot from |     Switch settings     |
  | --------- | ----------------------- |
  | SCIF      | 1=ON, 2=OFF             |
  | SPI-NOR   | 1=OFF, 2=ON             |
  | eMMC      | 1=OFF, 2=ON             |

- G3Sberry (Switch S2/CFG1)

  | Boot from |     Switch settings     |
  | --------- | ----------------------- |
  | SCIF      | 1=OFF, 2=ON             |
  | SPI-NOR   | 1=ON, 2=OFF             |
  | eMMC      | 1=ON, 2=ON              |

## Automatic selection of boot source

In SPI-NOR boot mode initial target booting is performed from the QSPI Flash.
Once the U-Boot is started, further loading of Linux OS can be performed from
additional sources, such as an eMMC, SD card or USB flash drive, in addition to
the SPI Flash itself. The priority of boot sources is the following SD -> USB
-> SPI. Thus, by default U-Boot tries to load Linux kernel, DTB and rootfs from
an SD card, and if this procedure fails it switches to the next source. U-Boot
searches for the required files on the first partition of the corresponding
device (mmcblk0p1, mmcblk1p1 for SD, and sda1 for USB).

The automatic boot source selection can be overridden and set to any source
from SD, USB or SPI. This is controlled by the `boot_mode` U-Boot environment
variable, which is set to `auto` by default. The variable can be set to the
following values, which are self describing:
- `auto` - automatic boot surce selection
- `spi` - boot kernel, DTB and initramfs are located on the SPI Flash
- `mmc` - boot kernel, DTB and rootfs are located on the SD card
- `usb` - boot kernel, DTB and rootfs are located on the USB Flash drive

The following command can be used in U-Boot for adjusting the `boot_mode`
variable:
```
=> setenv boot_mode usb
=> saveenv
```

From Linux the `boot_mode` variable can be changed with help of the `fw_setenv`
command, as show below:
```
# fw_setenv boot_mode mmc
```

## Initial Target Programming

### Programming U-Boot and Secondary Program Loader via Serial Interface

Serial Interface (SCIF) can be used for initial programming of all supported
targets. SCIF supports maximum transmission rate of 115200 baud, so this method
is only suitable for programming U-Boot and subsidiary loaders. Programming
other images such as Kernel image or rootfs image via SCIF will take too much
time. Follow the below steps for initial programming of U-Boot and SPL/BL2
loaders into the SPI flash of the target:

1. Set boot switches of the board into the SCIF boot position (see above).
   Then reset the board.
2. Follow the instruction about "Write the Bootloader" from [2] to program
   U-Boot and SPL/BL2 loader into the SPI Flash. For the MSRZG3S, please
   follow [3].
3. The below images should be used along with the Serial Downloader
   instructions:
   - `Flash_Writer_SCIF_<MACHINE>_*.mot`
   - `bl2_bp-<MACHINE>.srec`
   - `fip-<MACHINE>.srec`
4. Set boot switches on the carrier board into the SPI-NOR boot position. Then
   reset the board.
5. Verify that the board boots into the U-Boot command prompt.

### Programming Kernel and Initramfs images into the SPI Flash

U-Boot for MSRZ includes builtin support for network interfaces. Thus when
initial programming of U-Boot is done, additional images such as Linux Kernel
and rootfs can be loaded via network. MSRZ targets have 16 or 32 Mb of SPI-NOR
Flash. This is enough for storing a Linux Kernel and initramfs images. While a
full fledged root filesystem can be created on a SD card, or USB flash drive.

Follow the below steps for setting up a TFTP server and load kernel, DTB and
initramfs images into the SPI Flash:

1. Setup tftpboot server on a host machine: ```sudo apt-get install tftpd-hpa```
2. Copy kernel, DTB and initramfs images generated by Yocto build into the TFTP
   server root directory:
   ```
   # mkdir /var/lib/tftpboot/boot
   # cp Image.gz-<MACHINE>.bin /var/lib/tftpboot/boot/
   # cp <MACHINE>.dtb /var/lib/tftpboot/boot/
   # cp msrz-image-minimal-initramfs-<MACHINE>.cpio.gz /var/lib/tftpboot/boot/msrz-image-minimal-initramfs-<MACHINE>.bin
   ```
3. Copy U-Boot and secondary loader images:
   ```
   # cp bl2_bp-<machine_name>.bin /var/lib/tftpboot/boot/
   # cp fip-<machine_name>.bin /var/lib/tftpboot/boot/
   ```
4. Open serial connection to the target, and configure IP addresses of the board
   and tftp server in the U-Boot prompt:
   ```
   => setenv ipaddr 192.168.22.201
   => setenv serverip 192.168.22.11
   ```
5. Optionally, adjust the MAC address of the target, if there are more than one
   boards present in the network:
   ```
   => setenv ethaddr d6:8f:16:4f:c3:c7
   ```
6. Save adjusted U-Boot environment parameters:
   ```
   => saveenv
   Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash...done
   Valid environment: 2
   OK
   ```
7. Run the following command in the U-Boot prompt for writing Linux kernel Image
   and rootfs image to SPI flash:
   ```
   => run spi_update_all
   ```

### Programming Kernel and rootfs images to SD card/USB Flash

U-Boot searches the first partition of SD/USB drive for Linux boot files and
root filesystem. Perform the below steps for installing rootfs generated as a
result of Yocto build into an SD card or USB flash drive:

1. Insert an SD card or USB Flash drive that will be used for booting Linux into
   a host PC.
2. Run `fdisk` and create a partition table with at least one partition on the
   SD/USB drive. Size of the partition should be enough to store the
   `msrz-image-minimal-<MACHINE>.ext4` file.
3. Install the rootfs filesystem to the first partition of the SD/USB drive:
   ```
   # sudo dd if=msrz-image-minimal-<MACHINE>.ext4 of=/dev/sdX1
   ```
4. Mount the root file system on the host, and copy kernel and DTB images into
   the `/boot` directory on the file system:
   ```
   # sudo mount /dev/sdX1 /mnt/
   # sudo cp Image.gz-<MACHINE>.bin /mnt/boot/
   # sudo cp <MACHINE>.dtb /mnt/boot/
   # sudo sync && sudo umount /mnt
   ```
5. Insert the SD/USB drive into the MSRZ target and reset it.

The build also generates `wic.gz` images, which you can write directly to the
SD card with `dd` after decompression:

  ```bash
  $ ungzip msrz-image-minimal-<MACHINE>.wic.gz
  $ dd if=msrz-image-minimal-<MACHINE>.wic of=<mmc-device> bs=512
  ```

Please replace `<mmc-device>` with your SD card device, e.g. `/dev/mmcblk0`.


[1]: https://www.aries-embedded.com
[2]: https://www.renesas.com/en/document/qsg/rzg2l-evaluation-board-kit-quick-start-guide
[3]: https://www.renesas.com/en/document/qsg/rzg3s-evaluation-board-kit-quick-start-guide
