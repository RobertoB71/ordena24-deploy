FROM ubuntu:24.04

LABEL maintainer="Roberto Bethancourt"
LABEL project="Ordena24 WebApp"

RUN apt-get update && \
    apt-get install supervisor nano git curl ca-certificates -y

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install nodejs -y && \
    npm install -g pnpm

WORKDIR /var/www/html

RUN git clone https://github.com/RobertoB71/ordena24-frontend.git .

RUN pnpm install

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN cat > /etc/supervisor/conf.d/ordena24_webapp.conf << "EOF"
[program:ordena24_webapp]
command=/usr/bin/pnpm dev --host 0.0.0.0 --port 8000
directory=/var/www/html
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/ordena24_webapp.out.log
stderr_logfile=/var/log/supervisor/ordena24_webapp.err.log
environment=PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EOF

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]