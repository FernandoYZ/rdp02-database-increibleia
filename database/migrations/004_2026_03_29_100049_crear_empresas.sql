-- Migración: empresas
-- Creada el: 29/03/2026 10:00:49
-- Secuencia: 004

CREATE TABLE empresas (
    -- Agrega las columnas de la tabla
    id_empresa SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    ruc VARCHAR(20) NOT NULL,
    celular VARCHAR(15),
    correo VARCHAR(255) UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)

