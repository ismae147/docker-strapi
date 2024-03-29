FROM node:10.16.0-alpine

LABEL maintainer="Luca Perret <perret.luca@gmail.com>" \
  org.label-schema.vendor="Strapi" \
  org.label-schema.name="Strapi Docker image" \
  org.label-schema.description="Strapi containerized" \
  org.label-schema.url="https://strapi.io" \
  org.label-schema.vcs-url="https://github.com/strapi/strapi-docker" \
  org.label-schema.version=latest \
  org.label-schema.schema-version="1.0"

WORKDIR /usr/src/api

EXPOSE 1337

RUN echo "unsafe-perm = true" >> ~/.npmrc

RUN npm install -g strapi@3.0.0-alpha.21

COPY strapi.sh ./
RUN chmod +x ./strapi.sh

COPY healthcheck.js ./
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s \
  CMD node /usr/src/api/healthcheck.js

CMD ["./strapi.sh"]

