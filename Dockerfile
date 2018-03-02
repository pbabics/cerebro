FROM openjdk:8u131-jre-alpine

ARG CEREBRO_VERSION=0.7.2
RUN addgroup -S cerebro && adduser -S -G cerebro cerebro \
    && apk add --no-cache 'su-exec>=0.2' curl tar bash \
    && /bin/mkdir -p /opt/cerebro/logs /opt/cerebro/tmp

RUN cd /opt/ \
    && /usr/bin/curl -Lo cerebro.tgz https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz \
    && /bin/tar zvxf cerebro.tgz -C /opt/cerebro --strip-components=1 \
    && /bin/rm -f cerebro.tgz \
    && /bin/chown -R cerebro:cerebro /opt/cerebro \
    && su-exec cerebro /bin/ln -s /opt/cerebro/lib/cerebro.cerebro-${CEREBRO_VERSION}-launcher.jar /opt/cerebro/lib/cerebro.cerebro-launcher.jar

WORKDIR /opt/cerebro
EXPOSE 9000

COPY run.sh /

ENTRYPOINT [ "/run.sh" ]
