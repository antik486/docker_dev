FROM antik486/centos71
MAINTAINER antik486 <antik486@gmail.com>

RUN yum -y update; \
    yum -y install \
        tar \
        gcc \
        glibc-devel \
        make \
        ncurses-devel \
        openssl-devel \
        autoconf \
        curl \
        git; \
        yum clean all

RUN curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl; \
        chmod +x kerl; \
        mv kerl /usr/bin; \
        kerl update releases; \
        KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build 18.2.1 r18; \
        kerl install r18 /DATA/erl; \
        kerl cleanup all; \
        rm -f .kerl/archives/*.tar.gz; \
        ln -s /DATA/erl /usr/lib/erlang

ENV PATH /usr/lib/erlang/bin:$PATH

VOLUME ["/DATA"]

WORKDIR /DATA
