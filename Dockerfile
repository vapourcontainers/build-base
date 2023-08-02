# syntax=docker/dockerfile:1.4

FROM debian:bookworm

ENV STD_CONFIGURE_ARGS="--prefix=/usr/local --libdir=/usr/local/lib --disable-debug"
ENV STD_CMAKE_ARGS="-DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_LIBDIR=/usr/local/lib -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE=ON -DBUILD_TESTING=OFF"

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends build-essential \
    git curl ca-certificates \
    autoconf automake libtool \
    cmake ninja-build pkg-config
apt-get autoremove -y --purge
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
echo "deb http://www.deb-multimedia.org bookworm main" >> /etc/apt/sources.list
apt-get update -oAcquire::AllowInsecureRepositories=true
apt-get install -y --allow-unauthenticated --no-install-recommends deb-multimedia-keyring vapoursynth-dev
apt-get autoremove -y --purge
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF
