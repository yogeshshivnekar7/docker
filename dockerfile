FROM ubuntu:20.04
MAINTAINER Yogesh Shivnekar

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:yogesh' | chpasswd
RUN useradd -d /home/ansfsadmin -s /bin/bash -m ansfsadmin && echo "ansfsadmin:ansfsadmin" | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

RUN apt-get install apache2 -y

RUN mkdir -p /var/www/html/website1.com/

RUN touch /etc/apache2/sites-enabled/website1.conf

RUN touch /var/www/html/website1.com/index.html

RUN echo ' \
<VirtualHost *:80> \n\
ServerAdmin webmaster@localhost \n\
ServerName website1.com \n\
DocumentRoot /var/www/html/website1.com/ \n\
</VirtualHost> ' >> /etc/apache2/sites-enabled/website1.conf

RUN echo "website1.com" >> /var/www/html/website1.com/index.html

RUN touch /home/ansfsadmin/service.sh && chmod 777 /home/ansfsadmin/service.sh

EXPOSE 80
CMD [“apachectl”, “-DFOREGROUND”]
CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
