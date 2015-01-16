FROM centos:centos7
MAINTAINER antik486 <antik486@gmail.com>

RUN yum -y update
RUN yum -y install tar gcc glibc-devel make ncurses-devel openssl-devel autoconf; yum clean all
RUN yum -y install epel-release
RUN yum -y install git; yum clean all

RUN curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
RUN chmod +x kerl
RUN mv kerl /usr/bin
RUN kerl update releases

RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build 17.4 r17
RUN kerl install r17 /DATA/erl
RUN kerl cleanup all
RUN rm -f /.kerl/archives/*.tar.gz

RUN ln -s /DATA/erl /usr/lib/erlang
ENV PATH /usr/lib/erlang/bin:$PATH

VOLUME ["/DATA/app"]

WORKDIR /DATA/app

ENTRYPOINT ["bash"]
