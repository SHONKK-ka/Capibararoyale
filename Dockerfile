FROM devkitpro/devkita64:latest
RUN apt-get update && apt-get install -y git make
RUN dkp-pacman -Syu --noconfirm
RUN dkp-pacman -S --noconfirm wiiu-dev wiiu-sdl2 wiiu-sdl2_image wiiu-sdl2_mixer wiiu-sdl2_ttf
WORKDIR /work
