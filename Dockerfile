FROM ubuntu

MAINTAINER ivlis

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
   build-essential gawk m4 gcc-multilib libcurl3 xdg-utils autoconf \
   git-core ca-certificates wget openssh-client

RUN apt-get install -y libncurses-dev
#RUN apt-get update -y \
  #&& apt-get install -y --no-install-recommends \
    #build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev libglib2.0-dev \
	#autoconf xdg-utils

#RUN apt-get install -y --no-install-recommends wget

COPY scripts/erln8_ubuntu1404.tgz /root/
WORKDIR /root

RUN tar -zxvf erln8_ubuntu1404.tgz
COPY scripts/install-erln8.sh /root/
RUN /bin/bash /root/install-erln8.sh

RUN apt-get install -y libssl-dev

COPY scripts/build_erlang.sh /root/
RUN /bin/bash /root/build_erlang.sh

RUN mkdir /opt/erlang/
RUN cp -a /root/.erln8.d/otps/OTP-18.0.3/dist/bin /opt/erlang/
RUN cp -a /root/.erln8.d/otps/OTP-18.0.3/dist/lib /opt/erlang/
RUN sed -e 's|/root/.erln8.d/otps/OTP-18.0.3/dist|/opt/erlang|g' -i /opt/erlang/bin/erl

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/erlang/bin/

RUN erln8/reo --build 2.6.0
RUN mv    /root/.erln8.d/rebars/2.6.0/rebar  /opt/erlang/bin/

RUN rm -rf /root/.erln8.d
RUN rm -rf /tmp
