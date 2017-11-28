#!/bin/bash
set -ev

# Checkout poky, the bsp layers, and oe-core / oe-security, and our layer.
git clone -b rocko git://git.yoctoproject.org/poky.git poky-rocko
git clone -b rocko git://git.openembedded.org/meta-openembedded poky-rocko/meta-openembedded
git clone -b rocko git://git.yoctoproject.org/meta-security poky-rocko/meta-security
git clone -b rocko git://git.yoctoproject.org/meta-raspberrypi poky-rocko/meta-raspberrypi
git clone -b rocko https://github.com/bvarner/meta-bvarner-embedded.git poky-rocko/meta-bvarner-embedded
# Setup the shared dir.. .because I have these scripts setup to work on my local box as well...
mkdir -p shared/sources
mkdir -p shared/tmp
# Setup the oe-init-build-env.
source poky-rocko/oe-init-build-env .
# Customize the bblayers and the local.conf
cp -f poky-rocko/meta-bvarner-embedded/project-templates/garage-door-opener/*.conf ./conf
export YOCTO_DIR=`pwd`
echo "My yocto dir is: $YOCTO_DIR"
sed -i 's|%YOCTO_DIR%|'$YOCTO_DIR'|g' conf/bblayers.conf
sed -i 's|%SHARED_DIR%|'$YOCTO_DIR'/shared|g' conf/local.conf
sed -i 's|%PROJECT_DIR%|'$YOCTO_DIR'|g' conf/local.conf
cat conf/local.conf
cat conf/bblayers.conf

