FROM ubuntu:24.04

LABEL maintainer="Roberto Bethancourt"
LABEL project="Ordena24 APIs"

RUN apt-get update && \
    apt-get install supervisor nano git -y

EXPOSE 8000

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]