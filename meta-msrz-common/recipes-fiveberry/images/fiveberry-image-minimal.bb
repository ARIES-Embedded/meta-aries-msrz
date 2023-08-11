SUMMARY = "A console-only image that fully supports the target device hardware."

IMAGE_FEATURES += "splash"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL += " \
    packagegroup-fiveberry-base \
    packagegroup-fiveberry-bringup \
    "
