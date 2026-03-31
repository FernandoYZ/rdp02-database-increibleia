#!/bin/bash

# Colores y formato
VERDE='\033[0;32m'
CIAN='\033[0;36m'
ROJO='\033[0;31m'
NC='\033[0m'

# 0. Cargar variables de entorno si existe el archivo
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo -e "${ROJO}Error: Archivo .env no encontrado.${NC}"
    exit 1
fi

echo -e "${CIAN}Iniciando limpieza y despliegue...${NC}"

# 1. Limpieza total (Contenedores, volúmenes y huérfanos)
docker compose down -v --remove-orphans

# 2. Levantar con build por si acaso cambias algo en el Dockerfile futuro
docker compose up -d

# 3. Esperar al Healthcheck
echo -n "Esperando a PostgreSQL "
until [ "$(docker inspect -f {{.State.Health.Status}} postgres-increibleia 2>/dev/null)" == "healthy" ]; do
    printf "."
    sleep 1
done

echo -e "\n${VERDE}¡PostgreSQL está Healthy!${NC}"

# 4. Listar las tablas creadas para confirmar visualmente
echo -e "${CIAN}Esquema actual:${NC}"
docker exec -it postgres-increibleia psql -U ${DB_USER} -d ${DB_NAME} -c "\dt"

echo -e "\n${VERDE}¡Entorno listo para desarrollo!${NC}"

# 4. Opcional: Ejecutar el seed si existe
# docker exec -i postgres-increibleia psql -U postgres -d ${DB_NAME} < database/seed/seed.sql
