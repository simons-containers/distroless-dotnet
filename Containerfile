FROM archlinux:base-devel-20260809.0.570793 AS builder

ARG GCC_VERSION
ARG ZLIB_VERSION
ARG OPENSSL_VERSION
ARG LIBUNWIND_VERSION
ARG ICU_VERSION
ARG DOTNET_VERSION

ARG GCC_SOURCE
ARG ZLIB_SOURCE
ARG OPENSSL_SOURCE
ARG LIBUNWIND_SOURCE
ARG ICU_SOURCE
ARG DOTNET_RELEASE

RUN pacman -Sy --noconfirm cmake python wget >/dev/null

WORKDIR /build/gcc
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output gcc.tar.gz "${GCC_SOURCE}" \
    && tar xf gcc.tar.gz --strip-components=1 \
    && ./contrib/download_prerequisites \
    && mkdir build && cd build \
    && ../configure \
        --prefix=/usr \
        --libdir=/usr/lib \
        --libexecdir=/usr/lib \
        --disable-multilib \
        --disable-bootstrap \
        --enable-languages=c,c++ \
    && make -j$(nproc) all-target-libgcc all-target-libstdc++-v3 \
    && mkdir -p /base/usr/lib && ln -s lib /base/usr/lib64 \
    && make install-target-libgcc DESTDIR=/base \
    && make install-target-libstdc++-v3 DESTDIR=/base

WORKDIR /build/zlib
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output zlib.tar.gz "${ZLIB_SOURCE}" \
    && tar xf zlib.tar.gz --strip-components=1 \
    && ./configure --prefix=/usr \
    && make -s -j$(nproc) \
    && make install DESTDIR=/base

WORKDIR /build/openssl
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output openssl.tar.gz "${OPENSSL_SOURCE}" \
    && tar xf openssl.tar.gz --strip-components=1 \
    && ./Configure linux-x86_64 \
         --prefix=/usr \
         --libdir=/usr/lib \
         --with-zlib-include=/base/usr/include \
         --with-zlib-lib=/base/usr/lib \
    && make -s -j$(nproc) \
    && make install_sw DESTDIR=/base

WORKDIR /build/libunwind
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output libunwind.tar.gz "${LIBUNWIND_SOURCE}" \
    && tar xf libunwind.tar.gz --strip-components=1 \
    && ./configure --prefix=/usr --disable-tests \
    && make -s -j$(nproc) \
    && make install DESTDIR=/base

WORKDIR /build/icu
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output icu.tar.gz "${ICU_SOURCE}" \
    && tar xf icu.tar.gz --strip-components=1 \
    && cd source \
    && ./configure \
         --prefix=/usr \
         --disable-tests \
         --disable-samples \
    && make -s -j$(nproc) \
    && make install DESTDIR=/base

WORKDIR /extract/dotnet
RUN curl --silent --show-error --location  \
    --retry 5 --retry-max-time 30 \
    --output dotnet.tar.gz "${DOTNET_RELEASE}" \
    && mkdir dotnet \
    && tar xf dotnet.tar.gz -C dotnet \
    && mkdir -p /base/usr/share \
    && cp -r dotnet /base/usr/share/dotnet

RUN find /base/usr/lib -type f \( -name '*.so' -o -name '*.so.*' \) \
        -exec sh -c 'strip --strip-unneeded "$1" || :' _ {} \; \
    && find /base/usr -type f \
        \( -name '*.h' -o -name '*.a' -o -name '*.o' -o -name '*.la' \) -delete \
    && rm -rf \
        /base/usr/include \
        /base/usr/lib/{cmake,pkgconfig,gconv} \
        /base/usr/lib/gcc /base/usr/share/gcc-${GCC_VERSION} \
        /base/usr/lib/icu /base/usr/share/icu \
        /base/usr/sbin \
        /base/usr/lib64 \
        /base/usr/share/man \
        /base/usr/bin/{pkgdata,openssl,gencfu,derb,icuexportdata,uconv} \
        /base/usr/bin/{icu-config,genrb,c_rehash,icuinfo,genbrk,gencnval} \
        /base/usr/bin/{gendict,makeconv}

FROM ghcr.io/simons-containers/distroless-glibc:2.44

ARG GCC_VERSION
ARG ZLIB_VERSION
ARG OPENSSL_VERSION
ARG LIBUNWIND_VERSION
ARG ICU_VERSION
ARG DOTNET_VERSION

COPY --from=builder /base/usr/ /usr/

ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH="/usr/share/dotnet:${PATH}"

LABEL org.opencontainers.image.title="distroless dotnet"
LABEL org.opencontainers.image.description="distroless dotnet"
LABEL org.opencontainers.image.version="${DOTNET_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/simons-containers/distroless-dotnet"
LABEL org.opencontainers.image.base.libs="gcc@${GCC_VERSION},zlib@${ZLIB_VERSION},openssl@${OPENSSL_VERSION},libunwind@${LIBUNWIND_VERSION},icu@${ICU_VERSION},dotnet@${DOTNET_VERSION}"
