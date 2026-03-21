#!/bin/bash

VERDE='\033[0-32m'
NC='\033[0m'

echo -e "${VERDE}Reiniciando entorno de base de datos...${NC}"

# 1. Detener contenedores y BORRAR volúmenes (limpia la DB por completo)
docker compose down -v

# 2. Levantar los contenedores en segundo plano
docker compose up -d

# 3. Esperar a que el Healthcheck diga que está listo
echo "Esperando a que PostgreSQL esté listo..."
until [ "$(docker inspect -f {{.State.Health.Status}} postgres-increibleia)" == "healthy" ]; do
    printf "."
    sleep 1
done

echo -e "\n${VERDE}¡Base de datos lista y migraciones aplicadas!${NC}"

# 4. Opcional: Ejecutar el seed si existe
# docker exec -i postgres-increibleia psql -U postgres -d ${DB_NAME} < database/seed/seed.sql

# NOTA: Por mientras se están borrando los volúmenes en la fase de desarrollo.