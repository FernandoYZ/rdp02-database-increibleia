-- Migración: tipos_empresa
-- Creada el: 30/03/2026 08:09:33
-- Secuencia: 002

CREATE TABLE tipos_empresa (
    id_tipo_empresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_empresa VARCHAR(50) NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Se agregarán algunos datos para la tabla "tipos_empresa"
INSERT INTO tipos_empresa (tipo_empresa) VALUES
    ('Organizadora'),
    ('Participante');

CREATE TRIGGER tr_actualizar_fecha_modificacion_tipos_empresa
BEFORE UPDATE ON tipos_empresa
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();
