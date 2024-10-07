#!/bin/bash

# Variables
DISCO="/dev/sdb"  # Reemplaza con el disco que deseas particionar
TAMANO_PARTICION=$((1024*1024*1024))  # Tamaño de cada partición en bytes
DIRECTORIO_BASE="/Examenes-UTN"

# Función para verificar si una carpeta existe
existe_carpeta() {
    if [ ! -d "$1" ]; then
        echo "La carpeta '$1' no existe. Te la voy a crear."
        mkdir -p "$1"
    fi
}

# Verificar si el disco ya está particionado
fdisk -l $DISCO | grep -q $DISCO && { echo "Alerta!!! El disco ya está particionado. Saliendo..."; exit 1; }

# Verificar y crear las carpetas de destino
for i in {1..3}; do
    existe_carpeta "$DIRECTORIO_BASE/alumno_$i"
done
existe_carpeta "$DIRECTORIO_BASE/profesores"

# Crear y formatear las particiones, y montarlas en las carpetas correspondientes
for i in {1..10}; do
    inicio=$((TAMANO_PARTICION * (i-1)))
    fin=$((TAMANO_PARTICION * i))

    # Crear la partición con fdisk
    fdisk $DISCO <<EOF
n
p
$i
$inicio
$fin
w
EOF

    # Formatear la partición con ext4
    mkfs.ext4 -F "${DISCO}${i}"

    # Determinar la carpeta de montaje
    if [ $i -le 3 ]; then
        CARPETA="$DIRECTORIO_BASE/alumno_1/parcial_$i"
    elif [ $i -le 6 ]; then
        CARPETA="$DIRECTORIO_BASE/alumno_2/parcial_$((i-3))"
    elif [ $i -le 9 ]; then
        CARPETA="$DIRECTORIO_BASE/alumno_3/parcial_$((i-6))"
    else
        CARPETA="$DIRECTORIO_BASE/profesores"
    fi

    # Montar la partición y agregarla al fstab
    mount "${DISCO}${i}" $CARPETA
    sudo tee -a /etc/fstab <<< "${DISCO}${i} $CARPETA ext4 defaults,auto 0 2"
done

echo "¡Listo! El disco ha sido partiionadoo"
