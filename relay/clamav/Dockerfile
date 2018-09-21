FROM debian:stretch-slim
LABEL maintainer="n.vogels@aves-it.nl"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://deb.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y -qq clamav-daemon clamav-freshclam clamav-unofficial-sigs ca-certificates geoip-database libclamunrar7 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

RUN curl -o /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd \
    && curl -o /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd \
    && curl -o /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd \
    && chown clamav:clamav /var/lib/clamav/*.cvd

RUN mkdir /var/run/clamav \
    && chown clamav:clamav /var/run/clamav \
    && chmod 750 /var/run/clamav

EXPOSE 3310

COPY assets/run.sh /

RUN chmod 755 /run.sh

CMD     [ "/run.sh" ]

