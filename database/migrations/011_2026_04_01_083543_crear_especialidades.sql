-- Migración: especialidades
-- Creada el: 01/04/2026 08:35:43
-- Secuencia: 011

CREATE TABLE especialidades (
    id_especialidad INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    especialidad VARCHAR(255) NOT NULL,
    codigo_especialidad VARCHAR(20) UNIQUE, -- Se permite NULL inicialmente para que el trigger lo genere
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para generar el código ANTES de la inserción
CREATE TRIGGER tr_generar_codigo_especialidad
BEFORE INSERT ON especialidades
FOR EACH ROW
EXECUTE FUNCTION fn_generar_codigo_especialidad();

-- Trigger para actualizar fecha de modificación
CREATE TRIGGER tr_actualizar_fecha_modificacion_especialidades
BEFORE UPDATE ON especialidades
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();

INSERT INTO especialidades (especialidad) VALUES
    ('Seguridad'),
    ('Psicología'),
    ('Biotecnología'),
    ('Biología'),
    ('Tareas'),
    ('Urgencia'),
    ('Telecomunicaciones'),
    ('Ingeniería'),
    ('Matemática'),
    ('Topografía'),
    ('Salud');