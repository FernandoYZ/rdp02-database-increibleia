-- Migración: imagenes
-- Creada el: 31/03/2026 14:39:00
-- Secuencia: 003

CREATE TABLE imagenes (
    id_imagen INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_imagen VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    mime_type VARCHAR(50),
    size_bytes INT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_actualizar_fecha_modificacion_imagenes
BEFORE UPDATE ON imagenes
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();

