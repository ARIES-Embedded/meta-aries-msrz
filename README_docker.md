# Using Docker to Build the ARIES BSP

The BSPs are distributed as Yocto builds. However, Yocto versions are limited to what host OS version you can use.

A docker container will allow you to replicate the same build environment (Ubuntu OS version) without having to modify your current running host OS version.
These instructions explain how to install and set up docker so that you can build the BSP inside a docker container of the correct Ubuntu version.

The container only requires 1GB - 2GB of hard drive space. So it is much more efficient than installing a complete virtual machine. Additionally, using the instructions we will explain here, you will get to keep all your build files in your existing file system making them easy to access (as opposed to hidden inside a virtual machine).

## 1. Docker Install

Follow https://github.com/renesas-rz/rzg2_bsp_scripts/tree/master/docker_setup URL to see more indepth description of docker environment and its installation.

## 2. Using docker for building ARIES BSP

The easiest way to create a Ubuntu container with everything you need to build the BSP is to use a "docker-build" script created by ARIES.

The bellow instructions assume that the user has already followed the build instructions from ARIES BSP README.md in part of cloning and creating Yocto build environment.

Also, assuming that $WORK is the directory where the ARIES BSP has been deployed, all the "docker-build" script invocation must be done using it as the current directory.

### 2.1 Build a docker Image

First, we need to build a docker "Image". The creation of the image is automated by the "docker-build" script and can be done as a separate action or be integral to the building commands.

To create a docker image as a separate action, invoke the script in the $WORK directory as shown below.

```bash
    $ ./docker-build -i
```

This is a one-time operation which can take a while.

### 2.2 Configuring build environment

Once the docker image is created, a build environment must be configured.

The "docker-build" script allows setting up several build environments sharing the same Yocto BSP sources.

Each build environment would bind a target MACHINE and DISTRO with specific build directories. Moreover, build environments may share certain directories such as 'downloads' and 'sstate-cache' between each other in order to optimize build times.

To configure default build environment, invoke the script in the $WORK directory as shown below.

```bash
    $ ./docker-build -c -m msrzg2ul
```

In the shown example the "-m msrzg2ul" option chooses MSRZG2UL as the target machine. The remaining environment options are set to defaults. The configured environment is saved intp ".build.env" file.

Look into its contents to see the filled-in configuration.

```bash
    $ cat .build.env
    BUILD_DIR=build
    DISTRO=poky
    MACHINE=msrzg2ul
    DL_DIR=downloads
    SSTATE_DIR=sstate-cache
    OUTPUT_DIR=build/deploy
```

All of the above parameters can be altered via the script invocation, or by directly editing the file.

NOTE: changing of the environment configuration should precede the activation of the build environment (either interactive or by running a command). After the Yocto has been activated, altering the environment may not has effect as several configuration parameters are cached in various configuration files and must be altered in place.

In case where several build environments are required, the build environment file used by the script can be overriden through the "BUILDENV" shell environment.

The example below configures MSRZFIVE target machine with "build_msrzfive" build directory. The sstate cache and downloads directory would be shared with the default build environment.

```bash
    $ BUILDENV=msrzf.env ./docker-build -c -m msrzfive -B build_msrzfive
```

### 2.3 Running build environment interactively

To activate the build environment for interactive use. invoke the script in the #WORK directory as shown below.

```bash
    $ ./docker-build
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.


    Welcome to ARIES MSRZ BSP

    The Yocto Project has extensive documentation about OE including a
    reference manual which can be found at:
        http://yoctoproject.org/documentation

    For more information about OpenEmbedded see their website:
        http://www.openembedded.org/

    You can now run 'bitbake <target>'

    Common targets are:
        core-image-minimal
        core-image-minimal-initramfs

    Your configuration files at /opt/yocto/build have not been touched.
    dir: /opt/yocto/build
    user@(docker)$
```

The script will run a docker container, mount the build directories according to the configuration and prompt for build commands.

One can use it for running "bitbake", "devtool", or other commands.

To deactivate the build environment, enter "exit" command or press "Ctr-D" key sequence.

### 2.4 Running non-interactive commands in the build environment

Alternatively to the interactive use, the "docker-build" script allows non-interactive command execution in the build environment.

The build commands are typically "bitbake", "devtool", and other Yocto BSP related commands. However, it may be any shell command which needs to be run in the active Yocto environment.

The example below shows how to run "bitbake" command to build a "core-image-minimal" recipe.

```bash
    $ ./docker-build -- bitbake core-image-minimal
```

Notice the '--' argument which must precede the whatever command line and argument to invoke in the build environment.

### 2.5 Getting build artifacts

The configured build environment has "OUTPUT_DIR" configuration parameter which specifies directory where the Yocto build system would put (deploy) its build artifacts.

The example blow shows build results from the "bitbake core-image-minimal" invocation for the MSRZG2UL machine.

```bash
    $ ls -l build/deploy/
    total 110204
    -rw-r--r-- 1 user user 84050944 Jul 16 21:11 core-image-minimal-msrzg2ul-20230716170958.rootfs.ext4
    -rw-r--r-- 1 user user     3147 Jul 16 21:11 core-image-minimal-msrzg2ul-20230716170958.rootfs.manifest
    -rw-r--r-- 1 user user 17361487 Jul 16 21:11 core-image-minimal-msrzg2ul-20230716170958.rootfs.tar.bz2
    -rw-r--r-- 1 user user 20006010 Jul 16 21:11 core-image-minimal-msrzg2ul-20230716170958.rootfs.tar.gz
    -rw-r--r-- 1 user user   334010 Jul 16 21:11 core-image-minimal-msrzg2ul-20230716170958.testdata.json
    lrwxrwxrwx 1 user user       54 Jul 16 21:11 core-image-minimal-msrzg2ul.ext4 -> core-image-minimal-msrzg2ul-20230716170958.rootfs.ext4
    lrwxrwxrwx 1 user user       58 Jul 16 21:11 core-image-minimal-msrzg2ul.manifest -> core-image-minimal-msrzg2ul-20230716170958.rootfs.manifest
    lrwxrwxrwx 1 user user       57 Jul 16 21:11 core-image-minimal-msrzg2ul.tar.bz2 -> core-image-minimal-msrzg2ul-20230716170958.rootfs.tar.bz2
    lrwxrwxrwx 1 user user       56 Jul 16 21:11 core-image-minimal-msrzg2ul.tar.gz -> core-image-minimal-msrzg2ul-20230716170958.rootfs.tar.gz
    lrwxrwxrwx 1 user user       56 Jul 16 21:11 core-image-minimal-msrzg2ul.testdata.json -> core-image-minimal-msrzg2ul-20230716170958.testdata.json
    lrwxrwxrwx 1 user user       74 Jul 16 21:10 Image -> Image--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    -rw-r--r-- 1 user user 13053960 Jul 16 21:10 Image--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 Image.gz -> Image.gz--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    -rw-r--r-- 1 user user  5506427 Jul 16 21:10 Image.gz--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 Image.gz-msrzg2ul.bin -> Image.gz--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 Image.gz-msrzg2ul.dtb -> msrzg2ul--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.dtb
    lrwxrwxrwx 1 user user       74 Jul 16 21:10 Image-msrzg2ul.bin -> Image--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.bin
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 Image-msrzg2ul.dtb -> msrzg2ul--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.dtb
    -rw-r--r-- 1 user user   126328 Jul 16 21:10 modules--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.tgz
    lrwxrwxrwx 1 user user       76 Jul 16 21:10 modules-msrzg2ul.tgz -> modules--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.tgz
    -rw-r--r-- 1 user user    25830 Jul 16 21:10 msrzg2ul--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.dtb
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 msrzg2ul.dtb -> msrzg2ul--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.dtb
    lrwxrwxrwx 1 user user       77 Jul 16 21:10 msrzg2ul-msrzg2ul.dtb -> msrzg2ul--5.10.158-cip22+gitAUTOINC+2a8e3b2bcb-r1-msrzg2ul-20230716170958.dtb
```

