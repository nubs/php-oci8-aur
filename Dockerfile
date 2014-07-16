FROM base/devel:minimal

RUN echo -e "[oracle]\nSigLevel = Optional TrustAll\nServer = http://linux.shikadi.net/arch/\$repo/\$arch/" >>/etc/pacman.conf

RUN pacman --sync --refresh --noconfirm --noprogressbar --quiet
RUN pacman --sync --noconfirm --noprogressbar --quiet php oracle-instantclient-sdk git

RUN useradd --create-home build
RUN echo -e "build\tALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /home/build

RUN curl -sS https://aur.archlinux.org/packages/pk/pkgbuild-introspection-git/pkgbuild-introspection-git.tar.gz | tar -xz
RUN cd pkgbuild-introspection-git && makepkg --clean --install --noconfirm --noprogressbar

ENV ORACLE_HOME /usr

VOLUME ["/package"]
WORKDIR /package

CMD ["makepkg", "--force"]
