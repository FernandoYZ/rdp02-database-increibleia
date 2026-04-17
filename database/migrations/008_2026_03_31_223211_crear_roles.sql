-- Migración: roles
-- Creada el: 31/03/2026 22:32:11
-- Secuencia: 008

CREATE TABLE roles (
    id_rol INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rol VARCHAR(50) UNIQUE NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_actualizar_fecha_modificacion_roles
BEFORE UPDATE ON roles
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();
