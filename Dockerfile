FROM scratch
ADD ArchLinuxARM-%CARCH%-latest.tar.gz /

COPY qemu-%ARCH%-static /usr/bin/qemu-%ARCH%-static

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman --noconfirm --needed -Syu gzip pacman sed systemd \
    && mapfile -t packages < <(pacman -Qqn | grep -Ev "(^gzip$|^pacman$|^sed$|^systemd$)") \
    && pacman --noconfirm -Rnsu "${packages[@]}" \
    && pacman-db-upgrade \
    && update-ca-trust \
    && pacman -Scc --noconfirm

CMD ["/bin/bash"]

