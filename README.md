# RPM Spec File for Looking Glass on Fedora

This repository contains the RPM spec file for [looking glass](https://looking-glass.io/)
on Fedora.

## Build Instruction

The spec file in the repository can be built using normal rpm development
tools like mock, rpmbuild, etc.

Note that the source tarball should be downloaded directly from the 
[official download page](https://looking-glass.io/downloads) instead of
Github release page. The tarballs from the official download page includes
the required submodules, while the Github release tarballs do not.

### Build with Podman

It is less intrusive to build the packages inside a rootless podman container
than using the standard build tools.

To do so, the first step is to create the container:

    podman run -it --rm -v <repository>:/mnt:rw,z fedora:<release> /bin/bash

The image tag (the `<release>` part) decides the fedora release the package
will be compiled for. The value `latest` means the latest stable release. To
compile for a specific Fedora release, change the part accordingly.

The volume option mounts the repository directory (the `<repository>` part)
into the container under /mnt. The volume option `rw` allows writes to the
repsoitory directory from the container. The volume option `z` tells podman
to fix the selinux label for the repository directory.

The option `-it` makes the container interactive and usable on the terminal.
The option `--rm` tells podman to remove the container and any allocated 
resources when the container stops.

After creating the container, change to the `/mnt` directory in the container
and run the `build-in-docker.sh` script:

    cd /mnt
    bash build-in-docker.sh

The compiled packages will be placed in the repository directory.

## Support

The repository is primarily for personal use only. No support will be
provided.

