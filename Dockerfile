FROM scratch
ADD ArchLinuxARM-%CARCH%-latest.tar.gz /

COPY qemu-%ARCH%-static /usr/bin/qemu-%ARCH%-static

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman -Syu --needed file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && pacman -D --asdeps $(pacman -Qqn) \
    && pacman -D --asexplicit file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && pacman -Rsn $(pacman -Qdtq) \
    && pacman-db-upgrade \
    && update-ca-trust \
    && pacman -Scc --noconfirm

CMD ["/bin/bash"]

