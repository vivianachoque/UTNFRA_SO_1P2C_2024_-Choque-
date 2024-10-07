#!/bin/bash

# Verifica si ya existe el archivo, porque si no lo chequeás te lo crea dos veces.
mkdir -p /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/

if [ ! -f /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt ]; then
    echo "Creando el archivo Filtro_Basico.txt..."
    touch /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt
else
    echo "El archivo Filtro_Basico.txt ya existe. Se agregará información sin sobrescribirlo."
fi

# Mensaje para avisar que se está guardando la info de la memoria total.
echo "Guardando la información de la memoria total en Filtro_Basico.txt..."
cat /proc/meminfo | grep -i MemTotal >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt

#  Acá usás dmidecode con sudo para ver info del chassis. FILTRAS la palabra "Chassis" y la agregás al archivo !
echo "Añadiendo información del chassis a Filtro_Basico.txt..."
sudo dmidecode -t chassis | grep "Chassis" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt

#  Otra vez dmidecode, pero esta vez querés ver quién fabricó el chassis (Manufacturer), y también lo sumás al archivo.
echo "Añadiendo información del fabricante del chassis a Filtro_Basico.txt..."
sudo dmidecode -t chassis | grep "Manufacturer" >> /home/osboxes/repogit/UTNFRA_SO_1P2C_2024_-Choque-/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt

# Mensaje final que avisa que todo se generó exitosamente.
echo "Toda la información se guardó correctamente en Filtro_Basico.txt."

