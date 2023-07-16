# meta-aries-msrz

This is a Yocto build layer(version:dunfell) that provides support for the MSRZ/G2UL MSRZ/FIVE Arm-based OSMs from ARIED Embedded.
Currently the following boards and MPUs are supported:

- Board: FIVEBerry/MSRZG2UL / MPU: R9A07G043U (RZ/G2UL)
- Board: FIVEBerry/MSRZFIVE / MPU: R9A07G043U (RZ/Five)

## Patches

To contribute to this layer you should email patches to <todo>@aries-embedded.de. Please send .patch files as email attachments, not embedded in the email body.

## Dependencies

This layer depends on:

    URI: git://git.yoctoproject.org/poky
    layers: meta, meta-poky, meta-yocto-bsp
    branch: dunfell
    tag: dunfell-23.0.21

    URI: https://git.openembedded.org/meta-openembedded
    layers: meta-oe, meta-python, meta-multimedia
    branch: dunfell
    revision: 7952135f650b4a754e2255f5aa03973a32344123

    URI: https://git.yoctoproject.org/meta-gplv2
    layers: meta-gplv2
    branch: dunfell
    revision: 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac

    URI: https://github.com/renesas-rz/meta-renesas
    layers: meta-rz-common, meta-rzg2l, meta-rzfive
    tag: refs/tags/BSP-3.0.3

## Supported Linux distributions

The dunfell Poky release supports the following Linux distributions:
    ubuntu-16.04
    ubuntu-18.04
    ubuntu-19.04
    ubuntu-20.04
    fedora-30
    fedora-31
    fedora-32
    fedora-33
    fedora-34
    fedora-35
    centos-7
    centos-8
    debian-8
    debian-9
    debian-10
    debian-11
    opensuseleap-15.1
    opensuseleap-15.2
    opensuseleap-15.3
    almalinux-8.5

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
    $ git checkout dunfell-23.0.21
    $ cd ..

    $ git clone https://github.com/openembedded/meta-openembedded
    $ cd meta-openembedded
    $ git checkout 7952135f650b4a754e2255f5aa03973a32344123
    $ cd ..

    $ git clone https://git.yoctoproject.org/git/meta-gplv2
    $ cd meta-gplv2
    $ git checkout 60b251c25ba87e946a0ca4cdc8d17b1cb09292ac
    $ cd ..
    $
    $ git clone https://github.com/renesas-rz/meta-renesas
    $ cd meta-renesas
    $ git checkout BSP-3.0.3
    $ cd ..
    $
    $ git clone git@github.com:ARIES-Embedded/meta-aries-msrz # TODO: replace with HTTPS when the repo has gone public
    $ cd ..

    $ ln -s sources/meta-aries-msrz/scripts/setup-environment
    $ ln -s sources/meta-aries-msrz/scripts/docker-build
```

**1. Build procedure (Recommended):**
- Initialize a build using the 'setup-environment' script in the $WORK directory and specify MACHINE and DISTRO variants  e.g.:
   ```bash
   $ mkdir -p build
   $ MACHINE=msrzg2ul DISTRO=poky . setup-environment build
   ```

- Build the target file system image using bitbake:
   ```bash
   $ bitbake core-image-minimal
   ```
\<MACHINE\> can be selected in below table:

|Renesas MPU| platform |       MACHINE          |
|:---------:|:--------:|:----------------------:|
|RZ/G2UL    |fiveberry |msrzg2ul                |
|RZ/Five    |fiveberry |msrzfive                |

\<DISTRO\> is fixed as poky

Images generated:
* Image (generic Linux Kernel binary image file)
* DTB for target machine
* core-image-minimal-\<machine name\>.tar.bz2 (rootfs tar+bzip2)
* core-image-minimal-\<machine name\>.ext4  (rootfs ext4 format)
