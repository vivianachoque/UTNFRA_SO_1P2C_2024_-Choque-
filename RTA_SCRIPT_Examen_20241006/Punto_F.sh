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
ip_publica=$(curl -s ifconfig.me)
usuario=$(whoami)
url_repo=$(git remote get-url origin)

# Obtener el hash de la contraseña del usuario
hash_usuario=$(sudo grep ^$USER /etc/shadow | cut -d: -f2)
if [ -z "$hash_usuario" ]; then
    hash_usuario="No se pudo obtener el hash. Asegúrate de tener los permisos necesarios."
fi

# Crear el contenido del archivo
contenido="Mi IP Pública es: $ip_publica
Mi usuario es: $usuario
El hash de mi usuario es: $hash_usuario
La URL de mi repositorio es: $url_repo"

# Agregar el contenido al archivo (append)
echo "$contenido" >> "$archivo"

echo "Información guardada en $archivo"
echo -e "$contenido"
