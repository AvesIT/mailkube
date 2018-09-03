#!/bin/bash

if [ ${RSPAMD_PWD} != "" ]; then
  echo "password = \"${RSPAMD_PWD}\";" >> /etc/rspamd/local.d/worker-controller.inc
fi

if [ ${RSPAMD_PWADMIN} != "" ]; then
  echo "enable_password = \"${RSPAMD_PWADMIN}\";" >> /etc/rspamd/local.d/worker-controller.inc
fi

if [ ! -e /maps/whitelist.map ];
then
    echo "127.0.0.1" >> /maps/whitelist.map
    echo "192.168.1.1" >> /maps/whitelist.map
    echo "192.168.2.0/24" >> /maps/whitelist.map
    echo "172.17.0.0/16" >> /maps/whitelist.map
fi

rspamUser=$(grep rspamd /etc/passwd | cut -d: -f3)
rspamGroup=$(grep rspamd /etc/passwd | cut -d: -f4)

chown ${rspamUser}:${rspamGroup} /var/lib/rspamd -R
chown ${rspamUser}:${rspamGroup} /maps -R
chown ${rspamUser}:${rspamGroup} /dkim -R
chmod 0600 /dkim -R
chmod 0700 /dkim

rm -f /var/run/rsyslogd.pid

rspamd -u _rspamd -g _rspamd -f