FROM scratch
ADD ArchLinuxARM-aarch64-latest.tar.gz /

COPY qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN set -xe \
 && pacman-key --init \
 && pacman-key --populate archlinuxarm \
 && pacman --noconfirm -Syu \
 && rm -fr /var/lib/pacman/sync /var/cache/pacman/pkg /etc/pacman.d/gnupg

CMD ["/bin/bash"]

