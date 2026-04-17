-- Migración: persona_empresa_rol
-- Creada el: 31/03/2026 22:34:28
-- Secuencia: 009

CREATE TABLE persona_empresa_rol (
    id_persona_empresa INTEGER REFERENCES persona_empresa(id_persona_empresa) ON DELETE CASCADE,
    id_rol INTEGER REFERENCES roles(id_rol) ON DELETE CASCADE,
    PRIMARY KEY (id_persona_empresa, id_rol)
);
