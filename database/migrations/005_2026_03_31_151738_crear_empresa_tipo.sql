-- Migración: empresa_tipo
-- Creada el: 31/03/2026 15:17:38
-- Secuencia: 005

-- CREATE TABLE empresa_tipo (
--     id_empresa INTEGER REFERENCES empresas(id_empresa) ON DELETE CASCADE,
--     id_tipo_empresa INTEGER REFERENCES tipos_empresa(id_tipo_empresa) ON DELETE CASCADE,
--     PRIMARY KEY (id_empresa, id_tipo_empresa)
-- );