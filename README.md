# rdp02-database-increibleia

Por el momento tengo así la arquitectura
```
mi-proyecto/
├── docker-compose.yml
├── .gitignore
├── .env
├── .env.example
├── database/
│   ├── migrations/
│   │   ├── 001_crear_tabla_1.sql
│   │   ├── 002_crear_tabla_2.sql
│   │   └── 003_crear_tabla_3.sql
│   └── seed/
│       └── seed.sql # Por ahora es una idea
└── scripts/
    ├── init-db.bat  # para Windows
    └── init-db.sh   # para Debian
```
