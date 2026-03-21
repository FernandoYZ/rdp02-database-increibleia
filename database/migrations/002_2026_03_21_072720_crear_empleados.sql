-- Migración: empleados
-- Creada el: 21/03/2026 07:27:20
-- Secuencia: 002

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombres VARCHAR(255) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    numero_documento VARCHAR(15) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    correo VARCHAR(255) UNIQUE NOT NULL,
    celular VARCHAR(20) UNIQUE,
    id_imagen INTEGER REFERENCES imagenes(id_imagen),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);