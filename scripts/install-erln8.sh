#!/bin/bash

cd /root/erln8

./install.sh || /bin/true

echo $'min=--without-termcap --enable-builtin-zlib --without-cosEvent --without-cosEventDomain --without-cosFileTransfer --without-cosNotification --without-cosProperty --without-cosTime --without-cosTransactions --without-snmp --without-megaco --without-wx --without-otp_mibs --without-ssh --without-ose --without-webtools --without-observer --without-dialyzer --without-odbc --without-os_mon --without-diameter --without-eldap --without-gs --without-jinterface --without-et --without-edoc --without-erl_docgen --without-debugger' >> /root/.erln8.d/config

