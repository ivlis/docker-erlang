#!/bin/bash

cd /root/erln8

./install.sh || /bin/true

echo $'min=--without-termcap --enable-builtin-zlib --without-hipe --disable-hipe --without-orber --without-ic --without-cosEvent --without-cosEventDomain --without-cosFileTransfer --without-cosNotification --without-cosProperty --without-cosTime --without-cosTransactions --without-snmp --without-megaco --without-wx --without-otp_mibs --without-ssh --without-ose --without-ct --without-eunit --without-webtools --without-observer --without-dialyzer --without-odbc --without-os_mon --without-asn1 --without-diameter --without-eldap --without-gs --without-jinterface --without-et --without-edoc --without-erl_docgen --without-debugger' >> /root/.erln8.d/config

