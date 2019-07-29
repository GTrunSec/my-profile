FROM centos:7
# Locales keyboard
RUN sed -i 's/^\(override_install_langs.*\)$/#\1/' /etc/yum.conf \
 && yum -y -q reinstall glibc-common \
 && echo 'LANG="fr_FR.UTF-8"' > /etc/locale.conf
ENV LANG fr_FR.UTF-8
# Debian Deps
RUN yum update -y && yum install -y \ 
      sudo \
      binutils \
      util-linux \
      fakeroot \
      file \
      python \
      make \
      gcc \
      pkg-config \
      perl \
      gnupg2
ENV PATH="${PATH}:/usr/bin/core_perl"
# Project deps
RUN yum install -y \ 
      ansible \
      git
# Create test user
RUN useradd -m test \
 && chown -R test:test /home/test \
 && echo -e "dockerpass\ndockerpass" | passwd test
RUN echo "test ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
# User run
USER test
WORKDIR /home/test/
ENV LANG="fr_FR.UTF-8"
RUN mkdir dotfiles
COPY . dotfiles/
RUN cd dotfiles; ./install.sh server | tee ansible.log
RUN echo -e "dockerpass" | chsh -s /bin/zsh
ENTRYPOINT /usr/bin/zsh
