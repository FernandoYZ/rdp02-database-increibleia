-- Migración: persona_empresa
-- Creada el: 31/03/2026 15:43:24
-- Secuencia: 007

CREATE TABLE persona_empresa (
    id_persona_empresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_persona INTEGER REFERENCES personas(id_persona) ON DELETE CASCADE,
    id_empresa INTEGER REFERENCES empresas(id_empresa) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    -- activo BOOLEAN NOT NULL DEFAULT TRUE, -- esta columna ya está en personas
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT persona_empresa_fecha_fin CHECK (fecha_fin >= fecha_inicio)
);

CREATE TRIGGER tr_actualizar_fecha_modificacion_persona_empresa
BEFORE UPDATE ON persona_empresa
FOR EACH ROW
WHEN (
    OLD.id_persona IS DISTINCT FROM NEW.id_persona OR
    OLD.id_empresa IS DISTINCT FROM NEW.id_empresa OR
    OLD.fecha_inicio IS DISTINCT FROM NEW.fecha_inicio OR
    OLD.fecha_fin IS DISTINCT FROM NEW.fecha_fin
) EXECUTE FUNCTION fn_actualizar_fecha_modificacion();

