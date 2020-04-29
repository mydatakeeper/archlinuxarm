FROM scratch
ADD ArchLinuxARM-%CARCH%-latest.tar.gz /

COPY qemu-%ARCH%-static /usr/bin/qemu-%ARCH%-static

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman -Syu --noconfirm --needed file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && pacman -D --noconfirm --asdeps $(pacman -Qqe) \
    && pacman -D --noconfirm --asexplicit file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && pacman -Rsnu --noconfirm $(pacman -Qdtq) \
    && pacman-db-upgrade \
    && update-ca-trust \
    && pacman -Scc --noconfirm

CMD ["/bin/bash"]

