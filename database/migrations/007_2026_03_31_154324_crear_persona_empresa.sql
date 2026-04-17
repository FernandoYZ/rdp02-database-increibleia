-- Migración: persona_empresa
-- Creada el: 31/03/2026 15:43:24
-- Secuencia: 007

CREATE TABLE persona_empresa (
    id_persona_empresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_persona BIGINT NOT NULL REFERENCES personas(id_persona) ON DELETE CASCADE,
    id_empresa INT NOT NULL REFERENCES empresas(id_empresa) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_fechas_validas 
        CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),

    CONSTRAINT uq_persona_empresa 
        UNIQUE (id_persona, id_empresa, fecha_inicio),

    CONSTRAINT no_solapamiento
        EXCLUDE USING gist (
            id_persona WITH =,
            id_empresa WITH =,
            daterange(fecha_inicio, COALESCE(fecha_fin, 'infinity'), '[]') WITH &&
        )
);

CREATE TRIGGER tr_actualizar_fecha_modificacion_persona_empresa
BEFORE UPDATE ON persona_empresa
FOR EACH ROW
WHEN (OLD IS DISTINCT FROM NEW)
EXECUTE FUNCTION fn_actualizar_fecha_modificacion();
