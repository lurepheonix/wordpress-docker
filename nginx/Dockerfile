FROM alpine:3.16
RUN set -x \
    && deluser xfs \
    && sed -i 's/www-data:x:82:/www-data:x:33:/g' /etc/group \
    && adduser -S -D -H -u 33 -h /var/cache/nginx -s /sbin/nologin -G www-data -g www-data www-data \
    && apk add --no-cache \
    tzdata \
    curl \
    ca-certificates \
    nginx \
    nginx-mod-http-cookie-flag \
    nginx-mod-http-brotli \
    nginx-mod-http-naxsi \
    nginx-mod-http-geoip2 \
    certbot \
    && mkdir /docker-entrypoint.d \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY docker-entrypoint.sh /
COPY 10-listen-on-ipv6-by-default.sh /docker-entrypoint.d
COPY 20-envsubst-on-templates.sh /docker-entrypoint.d
COPY 30-tune-worker-processes.sh /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]