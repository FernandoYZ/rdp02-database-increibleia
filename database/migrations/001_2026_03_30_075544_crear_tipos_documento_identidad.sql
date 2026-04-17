-- Migración: tipos_documento_identidad
-- Creada el: 30/03/2026 07:55:44
-- Secuencia: 018

CREATE TABLE tipos_documento_identidad (
    id_tipo_documento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_documento_identidad VARCHAR(50) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Se agregarán algunos datos para la tabla "tipos_documento_identidad"
INSERT INTO tipos_documento_identidad (tipo_documento_identidad) VALUES
    ('DNI'),
    ('Carnet de extranjeria'),
    ('Pasaporte'),
    ('Sin documento');

CREATE TRIGGER tr_actualizar_fecha_modificacion_tipos_documento_identidad
BEFORE UPDATE ON tipos_documento_identidad
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();