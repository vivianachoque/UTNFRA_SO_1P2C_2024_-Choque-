#!/bin/bash

# Verifica si ya existe el archivo y lo crea si es necesario
archivo="/home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt"
mkdir -p "$(dirname "$archivo")"
touch "$archivo"

# Verifica si curl está instalado
if ! command -v curl &> /dev/null; then
  echo "El comando 'curl' no está instalado. Por favor, instálalo antes de continuar."
  exit 1
fi

# Obtener la IP pública, nombre de usuario y URL del repositorio
ip_publica=$(curl -s https://api.ipify.org)  # Cambiado a api.ipify.org
usuario=$(whoami)
url_repo=$(git remote get-url origin)

# Crear el contenido del archivo
contenido="Mi IP Pública es: $ip_publica\nMi usuario es: $usuario\nLa URL de mi repositorio es: $url_repo"

# Agregar el contenido al archivo (append)
echo -e "$contenido" >> "$archivo"  # Agregando -e para procesar los saltos de línea

echo "Información guardada en $archiv $contenido"

