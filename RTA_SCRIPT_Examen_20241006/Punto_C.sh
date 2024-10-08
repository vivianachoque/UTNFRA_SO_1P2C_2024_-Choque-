#!/bin/bash

# Función para establecer permisos en una carpeta
set_permissions() {
  local user=$1
  local group=$2
  local directory=$3
  local user_perms=$4
  local group_perms=$5
  local other_perms=$6

  # Establecer permisos en formato octal
  chmod "$user_perms$group_perms$other_perms" "$directory"
}

# Función para crear usuario si no existe
create_user() {
  local username=$1
  local group=$2
  local directory=$3
  local user_perms=$4
  local group_perms=$5
  local other_perms=$6

  # Verificar si el usuario existe
  if ! getent passwd "$username" > /dev/null; then
    # Crear usuario y establecer permisos
    useradd -m -g $group -p "$PASSWORD_HASH" $username
    chown $username:$group "$directory"
    set_permissions $user $group "$directory" $user_perms $group_perms $other_perms

    # Crear archivo de validación
    su - $username -c "cd $directory && whoami > validar.txt"

    echo "Usuario $username creado con éxito."
  else
    echo "El usuario $username ya existe. Saltando creación..."
  fi
}

# Obtener el hash de la contraseña del usuario actual
PASSWORD_HASH=$(grep "$(whoami)" /etc/shadow | awk -F ':' '{print $2}')
#No sé si habria que hardcodear acá el usuario directamente porque en otro punto no me funcionaba llamando desde whoami
# Verificar si se obtuvo el hash
if [ -z "$PASSWORD_HASH" ]; then
  echo "Error: No se pudo obtener el hash de la contraseña del usuario actual."
  exit 1
fi

# Crear grupos secundarios
groupadd p1c2_2024_gAlumno
groupadd p1c2_2024_gProfesores

# Crear usuarios y establecer permisos
create_user p1c2_2024_A1 p1c2_2024_gAlumno /Examenes-UTN/alumno_1 rwx r-x ---
create_user p1c2_2024_A2 p1c2_2024_gAlumno /Examenes-UTN/alumno_2 rwx rw- ---
create_user p1c2_2024_A3 p1c2_2024_gAlumno /Examenes-UTN/alumno_3 rwx --- ---
create_user p1c2_2024_P1 p1c2_2024_gProfesores /Examenes-UTN/profesores rwx r-x r-x

echo "Todos los usuarios y grupos han sido creados con los permisos correspondientes."
