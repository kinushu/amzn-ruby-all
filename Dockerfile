FROM amazonlinux:2

# install

RUN yum update -y --security &&\
    yum install -y epel-release yum-utils &&\
    yum install -y gcc gcc-c++ make &&\
    yum install -y git zlib-devel libxml2-devel libxslt-devel readline-devel \
        tar openssl-devel curl-devel bind-utils bzip2

# ruby install

RUN echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc &&\
    mkdir -v /usr/local/rbenv &&\
    groupadd rbenv &&\
    chgrp -R rbenv /usr/local/rbenv &&\
    chmod -R g+rwxXs /usr/local/rbenv &&\
    git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv &&\
    git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH ${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:${PATH}

# ruby setup

RUN rbenv install 2.1.10 &&\
    rbenv global 2.1.10 &&\
    rbenv rehash
RUN gem install bundler -v '1.11.2'

RUN rbenv install 2.2.10 &&\
    rbenv global 2.2.10 &&\
    rbenv rehash
RUN gem install bundler -v '1.11.2'

RUN rbenv install 2.3.8 &&\
    rbenv global 2.3.8 &&\
    rbenv rehash
RUN gem install bundler -v '1.11.2'

RUN rbenv install 2.4.5 &&\
    rbenv global 2.4.5 &&\
    rbenv rehash
RUN gem install bundler -v '1.11.2'

# run
CMD ["/bin/sh"]