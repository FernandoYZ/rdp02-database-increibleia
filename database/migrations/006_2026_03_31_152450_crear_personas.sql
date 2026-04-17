-- Migración: personas
-- Creada el: 31/03/2026 15:24:50
-- Secuencia: 006

CREATE TABLE personas (
    id_persona BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombres VARCHAR(255) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    numero_documento VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    celular VARCHAR(20),
    correo VARCHAR(255),
    id_tipo_documento INTEGER REFERENCES tipos_documento_identidad(id_tipo_documento) ON DELETE SET NULL,
    id_imagen INTEGER REFERENCES imagenes(id_imagen) ON DELETE SET NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uq_personas_documento_activo
ON personas (numero_documento)
WHERE activo = TRUE;

CREATE UNIQUE INDEX uq_personas_correo_activo
ON personas (correo)
WHERE activo = TRUE;

CREATE TRIGGER tr_actualizar_fecha_modificacion_personas
BEFORE UPDATE ON personas
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();
