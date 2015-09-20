FROM ubuntu

MAINTAINER ivlis

COPY scripts/* /root/

WORKDIR /root

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/erlang/bin/

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential gawk m4 libcurl3 xdg-utils autoconf \
    git-core ca-certificates wget openssh-client\
    libncurses-dev libssl-dev && \
    tar -zxvf erln8_ubuntu1404.tgz && \
    /bin/bash /root/install-erln8.sh && \
    /bin/bash /root/build_erlang.sh && \
    mkdir -p /opt/erlang/ && \
    cp -a /root/.erln8.d/otps/OTP-18.0.3/dist/bin /opt/erlang/ && \
    cp -a /root/.erln8.d/otps/OTP-18.0.3/dist/lib /opt/erlang/ && \
    sed -e 's|/root/.erln8.d/otps/OTP-18.0.3/dist|/opt/erlang|g' -i /opt/erlang/bin/erl && \
    erln8/reo --build 2.6.0 && \
    mv  /root/.erln8.d/rebars/2.6.0/rebar  /opt/erlang/bin/ && \
    rm -rf /root/.erln8.d && \
    rm -rf /tmp/* && \
    apt-get purge -y \
    build-essential gawk m4 autoconf \
    git-core ca-certificates wget \
    libncurses-dev libssl-dev && \
    apt-get autoremove -y && \
    apt-get clean


