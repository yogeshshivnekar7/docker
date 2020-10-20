FROM ubuntu:20.04
MAINTAINER Yogesh Shivnekar

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:yogesh' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 80
CMD [“apachectl”, “-DFOREGROUND”]
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
