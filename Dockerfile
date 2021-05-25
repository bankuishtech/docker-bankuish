FROM openjdk:14-alpine AS jlink

ENV JAVA_HOME /opt/jdk
ENV PATH $JAVA_HOME/bin:$PATH

RUN mkdir -p $JAVA_HOME

RUN jlink --compress=2 \
        --module-path /opt/jdk/jmods \
        --add-modules java.base,java.logging,java.naming,java.instrument,java.management,java.sql,java.desktop,java.xml,jdk.sctp,jdk.unsupported,java.security.jgss,jdk.management.agent,java.prefs,jdk.crypto.cryptoki  \
        --no-header-files \
        --no-man-pages \
        --output /jlinked

FROM alpine
COPY --from=jlink /jlinked /opt/jdk/


RUN apk --update add --no-cache ca-certificates curl openssl binutils xz \
    && GLIBC_VER="2.28-r0" \
    && ALPINE_GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    && GCC_LIBS_URL="https://archive.archlinux.org/packages/g/gcc-libs/gcc-libs-8.2.1%2B20180831-1-x86_64.pkg.tar.xz" \
    && GCC_LIBS_SHA256=e4b39fb1f5957c5aab5c2ce0c46e03d30426f3b94b9992b009d417ff2d56af4d \
    && ZLIB_URL="https://archive.archlinux.org/packages/z/zlib/zlib-1%3A1.2.9-1-x86_64.pkg.tar.xz" \
    && ZLIB_SHA256=bb0959c08c1735de27abf01440a6f8a17c5c51e61c3b4c707e988c906d3b7f67 \
    && curl -Ls https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-${GLIBC_VER}.apk > /tmp/${GLIBC_VER}.apk \
    && apk add /tmp/${GLIBC_VER}.apk \
    && curl -Ls ${GCC_LIBS_URL} -o /tmp/gcc-libs.tar.xz \
    && echo "${GCC_LIBS_SHA256}  /tmp/gcc-libs.tar.xz" | sha256sum -c - \
    && mkdir /tmp/gcc \
    && tar -xf /tmp/gcc-libs.tar.xz -C /tmp/gcc \
    && mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib \
    && strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* \
    && curl -Ls ${ZLIB_URL} -o /tmp/libz.tar.xz \
    && echo "${ZLIB_SHA256}  /tmp/libz.tar.xz" | sha256sum -c - \
    && mkdir /tmp/libz \
    && tar -xf /tmp/libz.tar.xz -C /tmp/libz \
    && mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib \
    && apk del binutils \
	&& rm -rf /tmp/${GLIBC_VER}.apk /tmp/gcc /tmp/gcc-libs.tar.xz /tmp/libz /tmp/libz.tar.xz /var/cache/apk

ENV PATH /opt/jdk/bin:$PATH

ARG NRA_VERSION=5.14.0

ENV NEW_RELIC_ZIP=http://download.newrelic.com/newrelic/java-agent/newrelic-agent/$NRA_VERSION/newrelic-java-$NRA_VERSION.zip

COPY entrypoint-vault.sh /entrypoint/

COPY app.jar /app.jar

RUN apk --no-cache add curl unzip jq bash fontconfig ttf-dejavu\
    && chmod +x /entrypoint/entrypoint-vault.sh \
    && curl -sSL $NEW_RELIC_ZIP -o /tmp/nr.zip \
    && unzip /tmp/nr.zip -d /opt/ \
    && rm /tmp/nr.zip \
    && addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && chmod -R 777 /var/log/


USER appuser

ARG NEW_RELIC_LICENSE_KEY
ENV NEW_RELIC_LICENSE_KEY=$NEW_RELIC_LICENSE_KEY
ARG NEW_RELIC_APP_NAME
ENV NEW_RELIC_APP_NAME=$NEW_RELIC_APP_NAME
ARG VAULT_URL
ENV VAULT_URL=$VAULT_URL
ARG VAULT_TOKEN
ENV VAULT_TOKEN=$VAULT_TOKEN

ENTRYPOINT ["/entrypoint/entrypoint-vault.sh"]


CMD ["java", "-javaagent:/opt/newrelic/newrelic.jar","-Dnewrelic.config.distributed_tracing.enabled=true", "--enable-preview", "-jar", "/app.jar"]
