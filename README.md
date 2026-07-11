# Encender por primera vez
docker compose up -d --build

# Apagar
docker compose down

# Reconstruir WebApp después de cambios en GitHub
docker compose build --no-cache ordena24_webapp
docker compose up -d

# Reconstruir API después de cambios en GitHub
docker compose build --no-cache ordena24_api
docker compose up -d
