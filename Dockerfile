FROM ubuntu:kinetic
LABEL maintainer="[Stan S](https://dotfiles.download)"

ENV DEBIAN_FRONTEND noninteractive

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PATH=./bin/:$PATH
ENV TZ=Europe/Paris

#RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
#RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

#RUN echo $'#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d
#RUN chmod +x /usr/sbin/policy-rc.d

RUN \
  apt-get update && \
  apt-get -y install \
          software-properties-common \
          vim \
          pwgen \
          unzip \
          curl \
          zsh \
          locales \
          git-core && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN locale-gen en_US.UTF-8

WORKDIR /dotfiles
COPY . .
COPY ../ .
# CMD ["zsh"]
