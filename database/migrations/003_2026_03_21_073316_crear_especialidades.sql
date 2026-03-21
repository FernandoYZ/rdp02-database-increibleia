-- Migración: especialidades
-- Creada el: 21/03/2026 07:33:16
-- Secuencia: 003

CREATE TABLE especialidades (
    id_especialidad SERIAL PRIMARY KEY,
    nombre_especialidad VARCHAR(255) NOT NULL,       -- Seguridad
    codigo_especialidad VARCHAR(20) UNIQUE NOT NULL, -- SEG
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);