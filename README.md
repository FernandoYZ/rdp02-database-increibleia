# rdp02-database-increibleia

Repositorio para la gestión y despliegue de la base de datos del proyecto **increibleia**. Este proyecto utiliza Docker y PostgreSQL, e incluye un sistema de migraciones personalizado mediante scripts de Bash.

## 📋 Requisitos Previos

Para poder ejecutar este proyecto, necesitas tener instalado:

- [Docker](https://www.docker.com/products/docker-desktop/) y Docker Compose.
- Un entorno de terminal compatible con Bash (Linux, macOS, o [Git Bash](https://gitforwindows.org/) / WSL en Windows) para ejecutar los scripts.

## Estructura del Proyecto

La estructura principal del repositorio es la siguiente:

```text
rdp02-database-increibleia/
├── .env.example           # Plantilla de variables de entorno
├── docker-compose.yml     # Configuración del contenedor de PostgreSQL 17
├── database/
│   └── migrations/        # Scripts SQL que se ejecutan al iniciar la BD
│       ├── 000_*_crear_funciones.sql
│       ├── 001_*_crear_tipos_documento_identidad.sql
│       └── ...
└── scripts/
    ├── create_migration.sh # Script para generar un nuevo archivo de migración
    └── init-db.sh          # Script para levantar y reiniciar la base de datos limpia
```

## ⚙️ Configuración Inicial

1. **Clonar el repositorio:**
   ```bash
   git clone <url-del-repositorio>
   cd rdp02-database-increibleia
   ```

2. **Configurar variables de entorno:**
   Copia el archivo de ejemplo para crear tu propio archivo `.env`:
   ```bash
   cp .env.example .env
   ```
   Abre el archivo `.env` y ajusta las variables si es necesario (nombre de la BD, usuario, contraseña y puerto).

## 🚀 Uso y Comandos

### Levantar la Base de Datos

Para iniciar la base de datos desde cero (esto eliminará volúmenes anteriores para aplicar las migraciones frescas), ejecuta el script de inicialización:

```bash
./scripts/init-db.sh
```

**¿Qué hace este script?**
1. Carga las variables del archivo `.env`.
2. Detiene y elimina contenedores y volúmenes previos para asegurar un entorno limpio.
3. Levanta el contenedor de PostgreSQL en segundo plano.
4. Espera a que la base de datos esté lista (*healthy*).
5. Muestra las tablas creadas actualmente en la base de datos.

*Nota: PostgreSQL ejecuta automáticamente todos los archivos `.sql` ubicados en `database/migrations` en orden alfabético cuando el contenedor se crea por primera vez.*

### Crear una Nueva Migración

Para mantener un orden estándar en las tablas, utiliza el script generador de migraciones. Esto creará un archivo SQL con el formato correcto de prefijo numérico y fecha.

```bash
./scripts/create_migration.sh nombre_de_la_tabla
```

Por ejemplo:
```bash
./scripts/create_migration.sh usuarios
```

Esto generará un archivo en `database/migrations/` con un nombre similar a `008_2026_03_31_160000_crear_usuarios.sql` que incluirá una estructura base (comentada) para que definas tu tabla.

## 🛠️ Detalles Técnicos

- **Motor de Base de Datos:** PostgreSQL 17
- **Manejo de Migraciones:** Se aprovecha la característica de la imagen oficial de PostgreSQL en Docker (`/docker-entrypoint-initdb.d/`) mapeando la carpeta `database/migrations/` para que los scripts SQL se ejecuten automáticamente al inicializar un volumen de datos vacío.
- **Persistencia:** Los datos de la base de datos se guardan en un volumen de Docker llamado `pgdata`.