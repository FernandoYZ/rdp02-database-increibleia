-- Migración: empresas
-- Creada el: 31/03/2026 14:47:04
-- Secuencia: 004

CREATE TABLE empresas (
    id_empresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_empresa VARCHAR(255) NOT NULL,
    ruc VARCHAR(20) NOT NULL,
    celular VARCHAR(20),
    correo VARCHAR(255),
    id_imagen INTEGER REFERENCES imagenes(id_imagen) ON DELETE SET NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER tr_actualizar_fecha_modificacion_empresas
BEFORE UPDATE ON empresas
FOR EACH ROW
WHEN (
    OLD.nombre_empresa IS DISTINCT FROM NEW.nombre_empresa OR
    OLD.activo IS DISTINCT FROM NEW.activo OR
    OLD.ruc IS DISTINCT FROM NEW.ruc OR
    OLD.celular IS DISTINCT FROM NEW.celular OR
    OLD.correo IS DISTINCT FROM NEW.correo
) EXECUTE FUNCTION fn_actualizar_fecha_modificacion();

