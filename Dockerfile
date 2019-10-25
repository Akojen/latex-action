FROM alpine:latest

RUN apk --no-cache add \
        ghostscript \
        gnupg \
        perl \
        python \
        tar \
        wget \
        xz \
        xclip \
        ffsend --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        ca-certificates && rm -rf /var/cache/apk/*

ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"
WORKDIR /root

COPY \
  LICENSE \
  README.md \
  entrypoint.sh \
  setup.sh \
  texlive.profile \
  texlive_pgp_keys.asc \
  ./mycert.crt \
  /root/
RUN update-ca-certificates && /root/setup.sh

ENTRYPOINT ["/root/entrypoint.sh"]
