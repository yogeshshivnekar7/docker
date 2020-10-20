FROM ubuntu:20.04
MAINTAINER Yogesh Shivnekar

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:yogesh' | chpasswd
RUN useradd -d /home/ansfsadmin -s /bin/bash -m ansfsadmin && echo "ansfsadmin:ansfsadmin" | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

EXPOSE 80
CMD [“apachectl”, “-DFOREGROUND”]
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
