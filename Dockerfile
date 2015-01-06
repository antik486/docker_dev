# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER 24pay <antik486@gmail.com>

ENV http_proxy http_proxy=http://10.1.202.135:3128/
ENV https_proxy https_proxy=http://10.1.202.135:3128/

RUN yum -y update
RUN yum -y install tar gcc glibc-devel make ncurses-devel openssl-devel autoconf; yum clean all
RUN yum -y install epel-release
RUN yum -y install git; yum clean all

# install kerl using curl (don't confuse the two)
RUN curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
RUN chmod +x kerl
RUN mv kerl /usr/bin
RUN kerl update releases

# install erlang using kerl
RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build 17.4 r17
RUN kerl install r17 /DATA/erl
RUN kerl cleanup all
RUN rm -f /.kerl/archives/*.tar.gz

# configure it as the default erlang
RUN ln -s /DATA/erl /usr/lib/erlang
ENV PATH /usr/lib/erlang/bin:$PATH

WORKDIR /DATA/app
