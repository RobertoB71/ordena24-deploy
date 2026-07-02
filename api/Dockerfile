FROM ubuntu:24.04

LABEL maintainer="Roberto Bethancourt"
LABEL project="Ordena24 API"

RUN apt-get update && \
    apt-get install supervisor nano git build-essential libssl-dev libffi-dev python3-pip python3-dev python3-venv -y

WORKDIR /var/www/html

RUN git clone https://github.com/RobertoB71/ordena24-api.git .

RUN mkdir -p /opt/ordena24_api/workspace/envs && \
    python3 -m venv /opt/ordena24_api/workspace/envs/ordena24_api

RUN . /opt/ordena24_api/workspace/envs/ordena24_api/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install gunicorn

RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN cat > /etc/supervisor/conf.d/ordena24_api.conf << "EOF"
[program:ordena24_api]
command=/opt/ordena24_api/workspace/envs/ordena24_api/bin/gunicorn --bind 0.0.0.0:8000 -w 2 -k uvicorn.workers.UvicornWorker main:app
directory=/var/www/html
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/ordena24_api.out.log
stderr_logfile=/var/log/supervisor/ordena24_api.err.log
environment=DB_HOST="ordena24_api_db",DB_PORT="5432",DB_NAME="ordena24_api_db",DB_USER="ordena24_user",DB_PASSWORD="ordena24_pass",PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EOF

EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]