# Maqui system

Este repositorio contiene scripts para instalar ROS y dependencias en el robot Maqui (Pepper, Softbank Robotics). Además, permite configurar la simulación del robot mediante una máquina virtual.


## Instalación fuera del robot

Para eso, se recomienda seguir las instrucciones de [uchile_system](https://github.com/uchile-robotics/uchile_system).


### Instalación de otras dependencias... (verificar)

```bash
# build
cdb base
sudo apt-get install python-catkin-tools
catkin build --summarize
```

E instalar lo que falta:
```bash
# Install Pepper meshes on maqui_ws/src/pepper_meshes
./devel/tmp/installer.run --prefix ~/maqui_ws/src/pepper_meshes --mode unattended
```

### Revisar instalación:

```bash
# Test in a new terminal
# Open RViz with Pepper model
roslaunch pepper_description display.launch

# Open Gazebo with Pepper robot
# Remember kill "Gazebo controllers" terminal first
roslaunch maqui_sim maqui.launch
```

---

## Configuración de máquina virtual OpenNaoVM en virtualbox

**Paso 1:** Instalar virtualbox:
```bash
sudo apt-get install virtualbox
```

**Paso 2:** Conseguir una copia de la máquina virtual oficial `opennao-vm-2.1.2.17.ova`. Más info en la [documentación oficial](http://doc.aldebaran.com/1-14/dev/tools/vm-setup.html)


**Paso 3:** Probar la máquina:

Se debe importar la máquina descargada (Archivo > Importar Servicio Virtualizado). Las credenciales de acceso son 
- usuario: `nao`
- contraseña: `nao`

El SO está configurado en modo de sólo consola de comandos.


**Paso 4:** Acceso mediante SSH y FTP:

Para evitar trabajar directamente sobre la VM, conviene acceder mediante ssh desde una consola local y configurar FTP para ver las carpetas localmente. 

Para acceder desde el mismo PC, el puerto por defecto es el `2222`, el que puede ser modificado en (VirtualBox > Configuración > Red > Reenvío de puertos).

Acceder mediante (la máquina debe estar andando!):
```bash
ssh nao@localhost -p 2222
```

Analogamente, se puede acceder mediante FTP utilizando nautilus. Aprovechar de crear un marcador a la carpeta, para futuros accesos.
```bash
nautilus sftp://nao@localhost:2222
```
Además, con la extensión `nautilus-open-terminal` se puede abrir una terminal remota fácilmente usando click derecho en la carpeta del ftp.
```bash
sudo apt-get install nautilus-open-terminal
```

### Si la VM corre en otro computador(host)

Se recomienda configurar la VM para usar el modo de red en *Adaptador puente* (Máquina > Configuración > Red). Con esto, la máquina adquiere una IP en la misma subred que el host. Tal IP puede ser obtenida mediante el comando `ifconfig` desde la VM.

Luego, para acceder a la VM desde otra máquina, o desde el mismo host, ya no se puede usar `localhost`, sino que acceder a la IP asignada mediante el puerto `22`. 
```bash
# ssh
ssh nao@[VM-IP] -p 22

# sftp
nautilus sftp://nao@[VM-IP]:22
```


---

## Instalación de paquetes ROS requeridos en la OpenNao VM

Ejecutar lo siguiente en una terminal de la máquina virtual.
```bash
wget -q -O - https://raw.githubusercontent.com/uchile-robotics/maqui_system/master/maqui_internal_installer.sh | bash
```

### Sobre el desarrollo de Software para Pepper y el uso de la VM para compilar

Los pasos anteriormente descritos son para replicar la instalación de ROS indigo y uchile_ws para maqui desde 0. Esto no es algo que se realiza comúnmente dado que es largo y tedioso. En los archivos del laboratorio  se tiene una versión actualizada de la VM con el último software utilizado en el robot Pepper (preguntar a su respectivo senpai/tutor como conseguirla). El ciclo de desarrollo común corresponde a:

- Conseguir la última versión de la VM
- Lanzar la VM y desde la línea de comando compilar lo que se necesita
- Antes de subir cambios drásticos al robot (y menores también), asegúrate de tener un respaldo para poder restaurar la última versión funcional
- Subir y probar en el robot, si es exitoso, esta VM se convierte en la última versión y debe ser salvaguardada
- Si falla, seguir probando, es probable que necesites compilar dependencias cuyas versiones discrepan entre el robot y la máquina virtual. Si falla de manera drástica, restaurar la versión anterior.
- Escribir script para replicar el proceso de compilación y subirlo a este repositorio, de manera que el proceso sea replicable.