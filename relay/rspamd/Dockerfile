FROM debian:stretch-slim
LABEL maintainer="n.vogels@aves-it.nl"

ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr && rm -rf /var/lib/apt/lists/*

RUN	set -x \
# gpg: key FFA232EDBF21E25E: public key "Rspamd Nightly Builds (Rspamd Nightly Builds) <vsevolod@highsecure.ru>" imported
	&& key='3FA347D5E599BE4595CA2576FFA232EDBF21E25E' \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys "$key" \
	&& gpg --export "$key" > /etc/apt/trusted.gpg.d/rspamd.gpg \
	&& rm -rf "$GNUPGHOME" \
	&& apt-key list > /dev/null

RUN	echo "deb http://rspamd.com/apt-stable/ stretch main" > /etc/apt/sources.list.d/rspamd.list

RUN	apt-get update \
	&& apt-get install -y --no-install-recommends rspamd rsyslog \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/tmp/*

RUN	echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc

COPY assets/rsyslog.conf /etc/rsyslog.conf
COPY assets/run.sh /run.sh

RUN chmod 755 /run.sh

VOLUME	[ "/var/lib/rspamd", "/etc/rspamd/local.d", "/maps", "/dkim" ]

#CMD	[ "/usr/bin/rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd" ]
CMD     [ "/run.sh" ]
EXPOSE	11332 11333 11334
