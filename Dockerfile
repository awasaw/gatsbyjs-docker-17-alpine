FROM node:17-alpine

EXPOSE 8008

RUN \
  apk update && \
  apk add --no-cache python3 make g++ util-linux git && \
  apk add vips-dev fftw-dev --update-cache \
  && rm -fR /var/cache/apk/*

RUN npm install --global gatsby-cli && gatsby telemetry --disable

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]