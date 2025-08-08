# meta-aries-msrz

This is a Yocto build layer(version:scarthgap) that provides support for
MSRZ modules and carrier boards from [ARIES Embedded][], which are based
on the RZ/G2 Group of 64bit Arm-based MPUs from Renesas Electronics.
Currently the following modules, boards and MPUs are supported:

  | Module        | Board/EVK              | Renesas MPU          |
  | ------------- | ---------------------- | -------------------- |
  | [MSRZG3E][]   | [MSRZG3EEVK][]         | R9A09G047 (RZ/G3E)   |

## Patches

To contribute to this layer you should email patches to info@aries-embedded.de. Please send patch files as email attachments, not embedded in the email body.

## Dependencies
This layer (for the Scarthgap release) depends on the following specific revisions:

**poky:**
- URL: `https://git.yoctoproject.org/poky`
- Branch: `scarthgap`
- Revision: `dc4827b3660bc1a03a2bc3b0672615b50e9137ff`
- (Tag: `scarthgap-5.0.8`)

**meta-arm:**
- URL: `https://git.yoctoproject.org/meta-arm`
- Branch: `scarthgap`
- Revision: `950a4afce46a359def2958bd9ae33fc08ff9bb0d`
- (Tag: `yocto-5.0.1`)

**meta-openembedded:**
- URL: `https://github.com/openembedded/meta-openembedded.git`
- Branch: `scarthgap`
- Revision: `67ad83dd7c2485dae0c90eac345007af6195b84d`

**meta-renesas:**
- URL: `https://github.com/renesas-rz/meta-renesas.git`
- Branch: `scarthgap/rz`
- Revision: `RZG3E-BSP-1.0.0`

**meta-virtualization (for Docker):**
- URL: `https://git.yoctoproject.org/git/meta-virtualization`
- Branch: `scarthgap`
- Revision: `9287a355b338361e42027ce371444111a791d64f`

## Build Instructions

### Build Yocto BSP

Assume that $WORK is the current working directory.
The following instructions require a Poky installation (or equivalent).

Below git configuration is required:
```bash
    $ git config --global user.email "you@example.com"
    $ git config --global user.name "Your Name"
```

To download proprietary Multimedia and Graphics library and related Linux
drivers, please follow the [meta-renesas build instructions][].
Graphic drivers are required for Wayland. Multimedia drivers are optional.
After downloading the proprietary package, please decompress them then put meta-rz-features folder at $WORK directory,
alongside poky, meta-arm, etc. (e.g., $WORK/meta-rz-features).

You can download the public Yocto Project source layers to prepare the build environment as shown below. Ensure you checkout the specific revisions listed in the "Dependencies" section.
```bash
    $ cd $WORK # Ensure you are in your working directory
    $ git clone https://git.yoctoproject.org/poky
    $ cd poky
    $ git checkout dc4827b3660bc1a03a2bc3b0672615b50e9137ff
    $ cd ..
    $
    $ git clone https://git.yoctoproject.org/meta-arm
    $ cd meta-arm
    $ git checkout 950a4afce46a359def2958bd9ae33fc08ff9bb0d
    $ cd ..
    $
    $ git clone https://github.com/openembedded/meta-openembedded.git
    $ cd meta-openembedded
    $ git checkout 67ad83dd7c2485dae0c90eac345007af6195b84d
    $ cd ..
    $
    $ git clone  https://github.com/renesas-rz/meta-renesas.git
    $ cd meta-renesas
    $ git checkout <tag>
    $ cd ..
    $
    $ git clone  https://git.yoctoproject.org/git/meta-virtualization
    $ cd meta-virtualization
    $ git checkout 9287a355b338361e42027ce371444111a791d64f
    $ cd ..
    $
    $ git clone https://github.com/ARIES-Embedded/meta-aries-msrz.git
    $ cd meta-aries-msrz
    $ git checkout scarthgap/msrz
    $ cd ..
    $
```

Replace the \<tag\> with the latest tag, currently RZG3E-BSP-1.0.0.

The BSP can be built default normally: copy the template files to build folder, manually modifying *bblayer.conf*, *local.conf*
files then using bitbake to build the image. Or you can do the steps below:

- Initialize a build using the 'oe-init-build-env' script in Poky and point TEMPLATECONF to platform conf path. e.g.:
   ```bash
   $ TEMPLATECONF=$PWD/meta-aries-msrz/meta-msrz-bsp/conf/templates/rz-conf/ source poky/oe-init-build-env build
   ```

- To build optional features (Docker, Codec, or Graphics), you can use "bitbake-layers add-layer" from within the build directory:
   ```bash
   # For Docker
   $ bitbake-layers add-layer ../meta-openembedded/meta-networking
   $ bitbake-layers add-layer ../meta-openembedded/meta-filesystems
   $ bitbake-layers add-layer ../meta-virtualization

   # For Codec (requires meta-rz-features, see "Download Proprietary Drivers")
   $ bitbake-layers add-layer ../meta-rz-features/meta-rz-codecs

   # For Graphics (requires meta-rz-features, see "Download Proprietary Drivers")
   $ bitbake-layers add-layer ../meta-rz-features/meta-rz-graphics

   ```

- Build the target file system image using bitbake:
   ```bash
    # Replace <machine> with your target board (e.g., msrzg3evk)
    # Replace <target> with your desired image type (e.g., minimal, weston)
    $ MACHINE=<machine> bitbake core-image-<target> [<build-directory-name>]
   ```
Example: ```MACHINE=msrzg3eevk bitbake core-image-weston```

\<machine\> can be selected from below table:

| Renesas MPU |    Module     |      Board/EVK         |          MACHINE           |
| ----------- | ------------- | ---------------------- | -------------------------- |
|   RZ/G3E    |    MSRZG3E    |      MRZG3EEVK         |         msrzg3eevk         |

After completing the images for the target machine will be available in the output
directory _'tmp/deploy/images/\<machine\>'_.

Images generated:
* Flash_Writer_SCIF_MSRZG3EEVK_LPDDR4.mot (Flash-Writer image)
* bl2_bp_\*.bin, bl2_bp_\*.srec, fip_\*.bin, fip_\*.srec (Bootloader images)
* Image (generic Linux Kernel binary image file)
* DTB for target machine
* core-image-\<target\>-\<machine\>.tar.bz2 (rootfs tar+bzip2)
* core-image-\<target\>-\<machine\>.ext4  (rootfs ext4 format)
* core-image-\<target\>-\<machine\>.wic.gz  (rootfs wic gz format)
* core-image-\<target\>-\<machine\>.wic.bmap  (rootfs wic block map format)

### Build BSP SDK

Use bitbake -c populate_sdk for generating the toolchain SDK. For example, to build an SDK for core-image-weston on a specific <machine>:

```bash
    # For a 64-bit target SDK (aarch64) based on core-image-weston:
    $ bitbake core-image-weston -c populate_sdk
```
The SDK installer script can be found in the output directory _'tmp/deploy/sdk'_

It will be named similarly to: _'rz-vlp-glibc-x86_64-core-image-weston-cortexa55-<machine>-toolchain-<version>.sh'_

**Usage of toolchain SDK:**
Install the SDK to the default location: _/opt/poky/<version>_
For 64-bit target SDK:
```bash
    $ sh rz-vlp-glibc-x86_64-core-image-weston-cortexa55-smarc-rzg2l-toolchain-5.0.8.sh
```

To use the 64-bit application development environment, source the environment script (adjust path if you installed elsewhere or if <version> differs):
```bash
    $ source /opt/poky/<version>/environment-setup-cortexa55-poky-linux
```

### Build configs

It is possible to change some build configs by modifying your _local.conf_ file (usually $WORK/build/conf/local.conf):
* **Realtime Linux:** To build with the PREEMPT_RT Linux kernel, add or modify the following line in _local.conf_:
  ```
  PREFERRED_PROVIDER_virtual/kernel = "linux-renesas-rt"
  ```

* **Docker:** To include Docker support in your image, ensure the following line is present and uncommented in _local.conf_:
  ```
  DISTRO_FEATURES:append = " virtualization docker"
  ```

## Using kas tool to build BSP

Kas provides an easy mechanism to set up and build Yocto BSP projects.
For kas's user guide, how to install kas..., please refer to: https://kas.readthedocs.io/en/latest/userguide.html.
For command-line usage and kas environment variables, please also refer to the user guide.

Assume $KAS_WORK_DIR is the path of the kas working directory (defaults to the current working directory if not set).

### How to buid with kas command

**Step 1: Clone meta-aries-msrz in KAS_WORK_DIR**

KAS_WORK_DIR is the path of the kas work directory, current working directory is the default.
Run the below commands to clone meta-aries-msrz and check out corresponding tag.

```bash
    $ cd ${KAS_WORK_DIR}
    $ git clone https://github.com/ARIES-Embedded/meta-aries-msrz.git
    $ cd meta-aries-msrz
    $ git checkout
    $ cd ..
```

**Step 2: Config and build the BSP**

Run the "kas build" command, pointing to the appropriate YAML configuration files within the meta-aries-msrz directory

```bash
    $ kas build meta-aries-msrz/kas/base.yml:meta-aries-msrz/kas/machines/msrzg3eevk.yml:meta-aries-msrz/kas/images/core-image-weston.yml
```

To specify a download directory, you can use this command instead:
```bash
    $ DL_DIR=<download-directory-path> kas build meta-aries-msrz/kas/base.yml:meta-aries-msrz/kas/machines/msrzg3eevk.yml:meta-aries-msrz/kas/images/core-image-weston.yml
```

### How to buid with kas-container command

This method uses a containerized environment for the build.

**Step 1: Clone meta-aries-msrz in KAS_WORK_DIR**

```bash
    $ cd ${KAS_WORK_DIR}
    $ git clone https://github.com/ARIES-Embedded/meta-aries-msrz.git
    $ cd meta-aries-msrz
    $ git checkout <tag>
    $ cd ..
```

**Step 2: Config and build the BSP**

```bash
    $ kas-container build meta-aries-msrz/kas/base.yml:meta-aries-msrz/kas/machines/msrzg3eevk.yml:meta-aries-msrz/kas/images/core-image-weston.yml
```

### How to buid with kas menu

The kas menu command allows for interactive configuration, typically based on _Kconfig_ files if provided by the kas setup.

**Step 1: Clone meta-aries-msrz in KAS_WORK_DIR**

```bash
    $ cd ${KAS_WORK_DIR}
    $ git clone https://github.com/ARIES-Embedded/meta-aries-msrz.git
    $ cd meta-aries-msrz
    $ git checkout <tag>
    $ cd ..
```

**Step 2: Launch kas menu**

The kas menu command targets a _Kconfig_ file in the folder _meta-aries-msrz_.
```bash
    $ kas menu meta-aries-msrz/Kconfig
```

When the menu appears, continue to select the expected configuration(machine, image, docker option...).
Then push "Save & Build" button to save the current configuration and build the image. The defaut build folder is
*${KAS_WORK_DIR}/build*.

With kas menu, you also can use it to change the configuration when building with kas or kas container.
Just run the menu, re-configuration, push "Save & Exit" button, exit the menu and rebuild.

[ARIES embedded]: https://www.aries-embedded.com
[MSRZG3E]: https://www.aries-embedded.com/system-on-module/cpu/rzg3e-renesas-cortexa55quadcore-msrzg3e-osm-ethernet-pcie-npu
[MSRZG3EEVK]: https://www.aries-embedded.com/evaluation-kit/cpu/rzg3e-renesas-cortexa55quadcore-msrzg3e-osm-ethernet-pcie-npu
[meta-renesas build instructions]: https://github.com/renesas-rz/meta-renesas?tab=readme-ov-file#build-instructions