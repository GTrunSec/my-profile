FROM base/archlinux:latest
# Locales keyboard
RUN echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen \
 && echo 'LANG="fr_FR.UTF-8"' > /etc/locale.conf
ENV LANG="fr_FR.UTF-8"
# Archlinux Deps
RUN pacman -Syu --noconfirm \ 
      sudo \
      binutils \
      util-linux \
      fakeroot \
      file \
      python \
      yajl \
      make \
      gcc \
      pkg-config \
      which \
      perl \
      automake \
      autoconf \
      gettext \
      patch \
      xorg-server-xephyr 
ENV PATH="${PATH}:/usr/bin/core_perl"
# Project deps
RUN pacman -S --noconfirm \ 
      ansible \
      jshon \
      git
# Fix tmp dir perms
RUN chmod 1777 /tmp
# Create test user
RUN useradd -m test \
 && chown -R test:test /home/test \
 && echo -e "test\ntest" | passwd test
RUN echo "test ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
# User run
USER test
WORKDIR /home/test/
ENV LANG="fr_FR.UTF-8"
RUN cd /tmp; curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer-git
RUN cd /tmp; makepkg PKGBUILD --install --needed --noconfirm
RUN mkdir dotfiles
COPY . dotfiles/
RUN cd dotfiles; ./install.sh desktop | tee ansible.log
RUN echo -e "test" | chsh -s '/usr/bin/zsh'
ENTRYPOINT /usr/bin/zsh
