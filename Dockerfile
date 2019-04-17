FROM scratch
ADD ArchLinuxARM-%CARCH%-latest.tar.gz /

COPY qemu-%ARCH%-static /usr/bin/qemu-%ARCH%-static

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman --noconfirm -Syu \
    && rm -fr /var/lib/pacman/sync /var/cache/pacman/pkg /etc/pacman.d/gnupg

CMD ["/bin/bash"]

