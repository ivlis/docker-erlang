FROM alpine

MAINTAINER ivlis

COPY scripts/* /root/

WORKDIR /root

ENV ERLANG_VER OTP-18.3.3
ENV REBAR_VER 2.6.0

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/erlang/bin/

RUN apk add --update curl \
      ca-certificates \
      bash \
      git \
      openssl-dev \
      readline-dev \
      bzip2-dev \
      sqlite-dev \
      ncurses-dev \
      linux-headers \
      autoconf \
      gawk \
      m4 \
      openssh \
      bash \
      tar \
      build-base && \
      update-ca-certificates && apk add openssl && \
      wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
      wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && \
      apk add glibc-2.23-r3.apk

RUN tar -zxvf erln8_ubuntu1404.tgz
RUN /bin/bash /root/install-erln8.sh
RUN erln8/erln8 --build ${ERLANG_VER} --config=min &&\
     mkdir -p /opt/erlang/ && \
     cp -a /root/.erln8.d/otps/${ERLANG_VER}/dist/bin /opt/erlang/ && \
     cp -a /root/.erln8.d/otps/${ERLANG_VER}/dist/lib /opt/erlang/ && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/bin/erl && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/lib/erlang/bin/erl && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/lib/erlang/bin/start && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/lib/erlang/releases/RELEASES && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/lib/erlang/erts-*/bin/erl && \
     sed -e "s|/root/.erln8.d/otps/${ERLANG_VER}/dist|/opt/erlang|g" -i /opt/erlang/lib/erlang/erts-*/bin/start && \
     erln8/reo --build ${REBAR_VER} && \
     mv  /root/.erln8.d/rebars/${REBAR_VER}/rebar  /opt/erlang/bin/
RUN rm -rf /root/.erln8.d && \
    rm -rf /root/erln8/ && \
    rm -rf /tmp/*

RUN apk del curl \
      ca-certificates \
      bash \
      git \
      openssl-dev \
      readline-dev \
      bzip2-dev \
      sqlite-dev \
      linux-headers \
      autoconf \
      gawk \
      m4 \
      openssh \
      bash \
      tar \
      build-base && \
      rm -rf /var/cache/apk/*
#    apt-get purge -y \
#    build-essential gawk m4 autoconf \
#    git-core ca-certificates wget \
#    libncurses-dev libssl-dev && \
#    apt-get autoremove -y && \
#    apt-get clean
