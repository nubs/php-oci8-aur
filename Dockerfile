FROM base/devel:minimal

RUN echo -e "[oracle]\nSigLevel = Optional TrustAll\nServer = http://linux.shikadi.net/arch/\$repo/\$arch/" >>/etc/pacman.conf

RUN pacman --sync --refresh --noconfirm --noprogressbar --quiet
RUN pacman --sync --noconfirm --noprogressbar --quiet php oracle-instantclient-sdk

ENV ORACLE_HOME /usr

VOLUME ["/package"]
WORKDIR /package

ENTRYPOINT ["makepkg"]
CMD ["--asroot", "--force"]
