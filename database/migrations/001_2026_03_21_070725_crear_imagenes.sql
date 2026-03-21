-- Migración: imagenes
-- Creada el: 21/03/2026 07:07:25
-- Secuencia: 001

CREATE TABLE imagenes (
    id_imagen SERIAL PRIMARY KEY,
    nombre_imagen VARCHAR(255) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);