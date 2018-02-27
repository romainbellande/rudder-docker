# https://www.rudder-project.org/doc-4.3/install-server.html

FROM debian:wheezy

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /srv/rudder

RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN echo "deb https://download.virtualbox.org/virtualbox/debian wheezy contrib" >> /etc/apt/sources.list.d/virtualbox.list
RUN apt-get update -y

# RUN /bin/sh -c $(cat > /usr/sbin/policy-rc.d <<EOF
# #!/bin/sh
# exit 101
# EOF)
RUN chmod +x /usr/sbin/policy-rc.d
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

RUN apt-get install -y wget build-essential
RUN wget --quiet -O- "https://www.rudder-project.org/apt-repos/rudder_apt_key.pub" | apt-key add -
RUN echo "deb http://www.rudder-project.org/apt-4.3/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/rudder.list
RUN apt-get update -y
RUN apt-get install -y rudder-server-root

EXPOSE 8081

CMD ["vagrant", "up"]

