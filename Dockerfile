FROM ubuntu:xenial

MAINTAINER Fabio Rodrigues <fabio_rodrigues@student-partners.com>

#Set up proxy values if needed here 
#ENV http_proxy 
#ENV https_proxy 

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		subversion \
		build-essential \
		xvfb \
		firefox \
		openjdk-8-jre-headless \
		gawk \
		libreadline6-dev \
		zlib1g-dev \
		libssl-dev \
		libyaml-dev \
		libsqlite3-dev \
		sqlite3 \
		autoconf \
		libgmp-dev \
		libgdbm-dev \
		libncurses5-dev \
		automake \
		libtool \
		bison \
		pkg-config \
		libffi-dev \
		openssh-server \
&& rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "curl -sSL https://rvm.io/mpapis.asc | gpg --import"
RUN /bin/bash -c "curl -sSL https://get.rvm.io | bash -s stable"

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c "rvm install 2.3.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"



RUN useradd -m -d /home/jenkins -s /bin/sh jenkins &&\
    echo "jenkins:jenkins" | chpasswd
# Standard SSH port
EXPOSE 22
RUN /bin/bash -l -c "mkdir /var/run/sshd && mkdir -p /root/.ssh"
# Default command
CMD ["/usr/sbin/sshd", "-D"]
