#!/bin/bash

# Configuración de rutas
CARPETA_MIGRACIONES="./database/migrations"
FECHA=$(date +%Y_%m_%d_%H%M%S)

# 1. Validar si se pasó el nombre de la migración
if [ -z "$1" ]; then
    echo "⚠️  Error: Debes proporcionar un nombre para la migración."
    echo "Uso: ./scripts/create_migration.sh nombre_de_la_tabla"
    exit 1
fi

# Limpiar el nombre (reemplazar espacios por guiones bajos si los hay)
NOMBRE_LIMPIO=$(echo "$1" | tr ' ' '_')

# 2. Asegurar que la carpeta exista
mkdir -p "$CARPETA_MIGRACIONES"

# 3. Obtener el último número de secuencia (ej: 003)
# Buscamos archivos que inicien con 3 dígitos seguidos de un guion bajo
ULTIMO_ARCHIVO=$(ls "$CARPETA_MIGRACIONES" | grep -E '^[0-9]{3}_' | sort | tail -n 1)

if [ -z "$ULTIMO_ARCHIVO" ]; then
    SIGUIENTE_NRO=1
else
    # Extraer los primeros 3 caracteres y convertirlos a base 10 para sumar
    ULTIMO_NRO=$(echo "$ULTIMO_ARCHIVO" | cut -c1-3)
    SIGUIENTE_NRO=$((10#$ULTIMO_NRO + 1))
fi

# 4. Formatear el número a 3 dígitos (ej: 004)
NRO_FORMATEADO=$(printf "%03d" $SIGUIENTE_NRO)

# 5. Construir el nombre final al estilo Laravel
# Formato: {NRO}_{FECHA}_crear_{NOMBRE}.sql
NOMBRE_ARCHIVO="${NRO_FORMATEADO}_${FECHA}_crear_${NOMBRE_LIMPIO}.sql"

# 6. Crear el archivo con un comentario inicial
cat <<EOF > "$CARPETA_MIGRACIONES/$NOMBRE_ARCHIVO"
-- Migración: $NOMBRE_LIMPIO
-- Creada el: $(date '+%d/%m/%Y %H:%M:%S')
-- Secuencia: $NRO_FORMATEADO

EOF

echo "Migración creada con éxito: $CARPETA_MIGRACIONES/$NOMBRE_ARCHIVO"