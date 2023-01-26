FROM registry.redhat.io/rhel8/httpd-24@sha256:aa47279b61a85228bfe34e5e9bdd2628a6aee88f26f44d02e06345f4ed479b8e

MAINTAINER issam.mejri@machin.com

ENV PORT 8080

RUN yum install -y httpd && \
    yum clean all

RUN sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf && \
    chown -R apache:apache /etc/httpd/logs/ && \
    chown -R apache:apache /run/httpd/

USER apache

EXPOSE ${PORT}

COPY index.html /var/www/html

CMD ["httpd", "-D", "FOREGROUND"]
