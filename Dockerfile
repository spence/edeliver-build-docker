FROM ubuntu:14.04.4

RUN apt-get update && apt-get install -y curl

RUN \
  curl -fsSL -o /tmp/erlang-solutions_1.0_all.deb https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i /tmp/erlang-solutions_1.0_all.deb && \
  curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
  apt-get update && \
  apt-get install -y esl-erlang elixir=1.2.0-1 openssh-server git nodejs
  # apt-get clean && \
  # rm -rf /var/lib/apt/lists/*

RUN \
  mkdir -p /var/run/sshd && \
  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY ssh-key.pub /root/.ssh/authorized_keys

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
