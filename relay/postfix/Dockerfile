FROM debian:buster-slim
LABEL maintainer="n.vogels@aves-it.nl"

RUN	apt-get update && apt-get install -y --no-install-recommends postfix rsyslog ca-certificates postfix-mysql postfix-pgsql postfix-ldap postfix-pcre postfix-lmdb postfix-sqlite \
                   && rm -rf /var/lib/apt/lists/* /var/tmp/*

ENV USE_RSPAMD 1

# RUN << IETS OM DE CONFIG TE VULLEN VOOR EEN RELAY >>

CMD [ "/usr/sbin/postfix", "start-fg" ]
