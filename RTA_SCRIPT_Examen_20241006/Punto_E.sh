#!/bin/bash

# Verifica si ya existe el archivo, porque si no lo chequeás te lo crea dos veces.
mkdir -p /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/

if [ ! -f /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt ]; then
  echo "Creando el archivo Filtro_Avanzado.txt..."
  touch /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt
else
  echo "El archivo Filtro_Avanzado.txt ya existe. Se agregará información sin sobrescribirlo."
fi

# Obtener la IP pública
ip_publica=$(curl -s ifconfig.me)

# Obtener el nombre de usuario
usuario=$(whoami)

# Obtener la URL del repositorio remoto
url_repo=$(git remote get-url origin)

# Contenido de archiiivo
contenido="Mi IP Publica es: $ip_publica\nMi usuario es: $usuario\nLa URL de mi repositorio es: $url_repo"

# Escribir el contenido en el archivo
echo "$contenido" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt
