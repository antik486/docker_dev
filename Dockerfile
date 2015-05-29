FROM centos:centos7
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
        KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build 17.5 r17; \
        kerl install r17 /opt/erl; \
        kerl cleanup all; \
        rm -f /.kerl/archives/*.tar.gz; \
        ln -s /opt/erl /usr/lib/erlang

ENV PATH /usr/lib/erlang/bin:$PATH

VOLUME ["/opt/app"]

WORKDIR /opt/app

ENTRYPOINT ["bash"]
