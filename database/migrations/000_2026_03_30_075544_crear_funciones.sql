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
