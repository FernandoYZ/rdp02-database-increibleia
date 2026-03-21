#!/bin/bash

PATH_MIGRACION="./database/migrations"
DATE=$(date +%Y%m%d)

# 1. Obtener el nombre de la migración del primer argumento
if [ -z "$1" ]; then
    echo "Uso: ./scripts/create_migration.sh <nombre_de_la_migracion>"
    exit 1
fi

NOMBRE_MIGRACION=$1

# 2. Encontrar el último número de secuencia
# Buscamos archivos que empiecen con 3 dígitos, los ordenamos y tomamos el último
ULTIMO_NUM=$(ls $PATH_MIGRACION | grep -E '^[0-9]{3}_' | sort -r | head -n 1 | cut -d'_' -f1)

# 3. Calcular el siguiente número (si no hay archivos, empezar en 001)
if [ -z "$ULTIMO_NUM" ]; then
    SIGUIENTE_NUM=1
else
    # Eliminamos ceros a la izquierda para la suma y luego los reponemos
    SIGUIENTE_NUM=$((10#$ULTIMO_NUM + 1))
fi

# 4. Formatear el número a 3 dígitos (ej: 005)
NUMERO_FORMATEADO=$(printf "%03d" $SIGUIENTE_NUM)

# 5. Crear el nombre del archivo
# Formato: {nro}_fecha_{nombre}
FILENAME="${NUMERO_FORMATEADO}_${DATE}_${NOMBRE_MIGRACION}.sql"

# 6. Crear el archivo vacío
touch "$PATH_MIGRACION/$FILENAME"

echo "Migración creada: $PATH_MIGRACION/$FILENAME"