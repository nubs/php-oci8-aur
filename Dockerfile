FROM nubs/arch-build

MAINTAINER Spencer Rinehart <anubis@overthemonkey.com>

RUN sudo bash -c 'echo -e "[oracle]\nSigLevel = Optional TrustAll\nServer = http://linux.shikadi.net/arch/\$repo/\$arch/" >>/etc/pacman.conf'

RUN sudo pacman --sync --refresh --noconfirm --noprogressbar --quiet
RUN sudo pacman --sync --noconfirm --noprogressbar --quiet php oracle-instantclient-sdk
