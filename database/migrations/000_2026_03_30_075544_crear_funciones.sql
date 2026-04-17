-- Migración: trigger_actualizar_fecha
-- Creada el: 30/03/2026 08:16:40
-- Secuencia: 003

CREATE OR REPLACE FUNCTION fn_actualizar_fecha_modificacion()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_modificacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE EXTENSION IF NOT EXISTS btree_gist;

-- Función para generar el código automáticamente (ej: SEG-001)
CREATE OR REPLACE FUNCTION fn_generar_codigo_especialidad()
RETURNS TRIGGER AS $$
DECLARE
    prefijo TEXT;
BEGIN
    -- 1. Obtener el prefijo (primeras 3 letras en mayúsculas)
    prefijo := UPPER(SUBSTRING(NEW.especialidad FROM 1 FOR 3));
    
    -- 2. El ID ya fue generado por el sistema IDENTITY antes de este trigger.
    -- Simplemente lo usamos para el código.
    IF NEW.codigo_especialidad IS NULL OR NEW.codigo_especialidad = '' THEN
        NEW.codigo_especialidad := prefijo || '-' || LPAD(NEW.id_especialidad::TEXT, 3, '0');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
