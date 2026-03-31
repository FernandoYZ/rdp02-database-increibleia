-- Migración: personas
-- Creada el: 31/03/2026 15:24:50
-- Secuencia: 006

CREATE TABLE personas (
    id_persona INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombres VARCHAR(255) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    celular VARCHAR(20),
    correo VARCHAR(255),
    id_tipo_documento INTEGER REFERENCES tipos_documento_identidad(id_tipo_documento) ON DELETE SET NULL,
    id_imagen INTEGER REFERENCES imagenes(id_imagen) ON DELETE CASCADE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX unique_documento_activo
ON personas (numero_documento)
WHERE activo = TRUE;

CREATE TRIGGER tr_actualizar_fecha_modificacion_personas
BEFORE UPDATE ON personas
FOR EACH ROW
WHEN (
    OLD.nombre_completo IS DISTINCT FROM NEW.nombre_completo OR
    OLD.apellido_paterno IS DISTINCT FROM NEW.apellido_paterno OR
    OLD.apellido_materno IS DISTINCT FROM NEW.apellido_materno OR
    OLD.numero_documento IS DISTINCT FROM NEW.numero_documento OR
    OLD.fecha_nacimiento IS DISTINCT FROM NEW.fecha_nacimiento OR
    OLD.celular IS DISTINCT FROM NEW.celular OR
    OLD.correo IS DISTINCT FROM NEW.correo OR
    OLD.id_tipo_documento IS DISTINCT FROM NEW.id_tipo_documento OR
    OLD.id_imagen IS DISTINCT FROM NEW.id_imagen OR
    OLD.activo IS DISTINCT FROM NEW.activo
) EXECUTE FUNCTION fn_actualizar_fecha_modificacion();
