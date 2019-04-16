FROM node:10.15.3-stretch-slim

RUN    /bin/true \
    \
    # Required packages
    && apt-get update \
    && apt-get install -y gosu nginx \
    \
    # Cleanup
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y --purge autoremove \
    \
    # forward nginx logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    \
    && /bin/true

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
