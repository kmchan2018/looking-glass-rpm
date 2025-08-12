#!/bin/bash

set -e

#
# Installs some essential tools
#

dnf install -y dnf-plugins-core redhat-rpm-config rpm-build rpmdevtools rpmlint

#
# Setup the build environemnt
#

rpmdev-setuptree

#
# Download the source tarball
#

spectool -g -a -R looking-glass.spec

#
# Install build dependencies
#

dnf builddep -y --spec looking-glass.spec

#
# Build the packages
#

rpmbuild -ba looking-glass.spec

#
# Copy the packages out of the container
#

cp -a /root/rpmbuild/RPMS/*/*.rpm .
cp -a /root/rpmbuild/SRPMS/*.src.rpm .

