FROM alpine:edge
LABEL org.opencontainers.image.authors="<chasing0806@gmail.com>"
ARG ALPINE_GLIBC_PACKAGE_VERSION="2.33-r0"
ARG ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-${ALPINE_GLIBC_PACKAGE_VERSION}.apk" \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-${ALPINE_GLIBC_PACKAGE_VERSION}.apk" \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-${ALPINE_GLIBC_PACKAGE_VERSION}.apk"
RUN apk add --no-cache --virtual=.build-dependencies wget \
    && wget "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
    "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
    "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    && apk add --no-cache --allow-untrusted \
    "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    &&  /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && echo "export LANG=$LANG" > /etc/profile.d/locale.sh \
    && apk del glibc-i18n && rm "/root/.wget-hsts" && apk del .build-dependencies wget \
    && rm "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" \
    && apk add --no-cache ca-certificates
ENV email=chasing0806@gmail.com

# Add http server to serve the test.log
RUN apk add --no-cache --update python3 py3-pip bash
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt
# Add our code
ADD ./webapp /root/webapp/
WORKDIR /root/webapp
# Expose is NOT supported by Heroku
# EXPOSE 5000 

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
ENTRYPOINT ["sh", "-c", "/root/webapp/entrypoint.sh"]
