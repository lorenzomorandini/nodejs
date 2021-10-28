FROM node:12-buster-slim

RUN apt-get update && apt-get install -y nginx gosu \
    # cleannup
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean && apt-get autoremove \
    # forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN useradd --no-create-home nginx

COPY docker /docker/
COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["nginx"]
