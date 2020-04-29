FROM scratch
ADD ArchLinuxARM-%CARCH%-latest.tar.gz /

COPY qemu-%ARCH%-static /usr/bin/qemu-%ARCH%-static

RUN set -xe \
    && pacman-key --init \
    && pacman-key --populate archlinuxarm \
    && pacman -Syu --noconfirm --needed file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && pacman -D --noconfirm --asdeps $(pacman -Qqn) \
    && pacman -D --noconfirm --asexplicit file gawk grep gzip licenses pacman procps-ng sed systemd tar \
    && while true; do \
        PKGS=$(pacman -Qdtq) \
        && if [ -z "$PKGS" ]; then \
            break; \
        fi \
        && pacman -Rsnu --noconfirm $PKGS; \
    done \
    && pacman-db-upgrade \
    && update-ca-trust \
    && pacman -Scc --noconfirm

CMD ["/bin/bash"]

