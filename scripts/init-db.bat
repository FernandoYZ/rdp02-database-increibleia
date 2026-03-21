@echo off
echo Reiniciando entorno de base de datos...

:: 1. Detener y limpiar volúmenes
docker compose down -v

:: 2. Levantar
docker compose up -d

echo Base de datos levantada. 
echo Recuerda verificar el estado con "docker ps".
pause