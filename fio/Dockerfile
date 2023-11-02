# Use Alpine Linux as the base image
FROM alpine:latest

# Install build dependencies
RUN apk add --no-cache \
    gcc \
    libc-dev \
    make \
    git \
    linux-headers \
    libaio-dev \
    zlib-dev \
    util-linux-dev \
    coreutils \
    perl \
    bash \
    && git clone https://github.com/axboe/fio.git /tmp/fio \
    && cd /tmp/fio \
    && ./configure \
    && make \
    && make install \
    # Clean up build dependencies and temp files
    && apk del \
    gcc \
    libc-dev \
    make \
    git \
    linux-headers \
    zlib-dev \
    util-linux-dev \
    coreutils \
    && rm -rf /var/cache/apk/* /tmp/fio

# Set an entrypoint for the fio command
ENTRYPOINT ["fio"]
