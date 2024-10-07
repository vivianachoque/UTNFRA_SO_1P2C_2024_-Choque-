#!/bin/bash

# Directorio base (cambia esto si quieres otra ubicación)
directorio_base="$HOME/Estructura_Asimetrica"

# Creamos la estructura principal
mkdir -p "$directorio_base"/{correo,clientes}

# Crear las subcarpetas con nombres del 1 al 100
for carpeta in correo clientes; do
  for i in {1..100}; do
    mkdir "$directorio_base"/"$carpeta"/cartas_$i
  done
  # Crear carpetas carteros solo en la carpeta correo del 1 al 10
  if [ "$carpeta" = "correo" ]; then
    for j in {1..10}; do
      mkdir "$directorio_base"/"$carpeta"/carteros_$j
    done
  fi
done

# Validación de la estructuira
echo "Validando la estructura..."
tree "$directorio_base" --noreport | pr -T -s' ' -w 80 --column 4
