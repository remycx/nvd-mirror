FROM httpd:alpine

ENV NIST_DATA_MIRROR_VERSION=1.2.0

EXPOSE 80
VOLUME /usr/local/apache2/htdocs

ADD /root /
ADD https://github.com/stevespringett/nist-data-mirror/releases/download/nist-data-mirror-${NIST_DATA_MIRROR_VERSION}/nist-data-mirror-${NIST_DATA_MIRROR_VERSION}.jar /usr/local/bin/nist-data-mirror.jar

RUN apk update \
    && apk add --no-cache openjdk8-jre dcron nss \
    && rm -f /usr/local/apache2/htdocs/*.html \
    && chmod +x /usr/local/bin/nist-data-mirror.jar \
    && mkdir -m 0644 -p /var/spool/cron/crontabs \
    && mkdir -m 0644 -p /etc/cron.d \
    && mkdir -p /var/log/cron \
    && touch /var/log/cron.log

ENTRYPOINT ["entrypoint.sh"]
