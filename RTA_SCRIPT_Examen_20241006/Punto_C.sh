
#!/bin/bash

# Obtener el hash de la contraseña del usuario actual
PASSWORD_HASH=$(grep $USER /etc/shadow | awk -F ':' '{print $2}')

# Verificar si se obtuvo el hash
if [ -z "$PASSWORD_HASH" ]; then
    echo "Error: No se pudo obtener el hash de la contraseña del usuario actual." #Esto es otra validación por las dudas
    exit 1
fi

# Crear los grupos secundarios
groupadd p1c2_2024_gAlumno
groupadd p1c2_2024_gProfesores

# Función para crear usuario
create_user() {
    local username=$1
    local group=$2

    # Crear el usuario que se pide en el Punto_C
    sudo useradd -m -s /bin/bash -g $group -G $group -p "$PASSWORD_HASH" $username

    echo "Usuario $username creado con éxito en el grupo $group."
}

# Crear usuarios de alumnos
create_user p1c2_2024_A1 p1c2_2024_gAlumno
create_user p1c2_2024_A2 p1c2_2024_gAlumno
create_user p1c2_2024_A3 p1c2_2024_gAlumno

# Crear usuario de profesor
create_user p1c2_2024_P1 p1c2_2024_gProfesores

echo "Un éxito! Se crearon todos los usuarios que solicitaste"

