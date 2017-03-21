# Maqui system

Este repositorio contiene los scripts para instalar los packages de ROS para trabajar con el robot Maqui (Pepper, Softbank Robotics) y para su simulación.


## Instalación de paquetes para Maqui

Se utiliza el script `maqui_external_installer.sh`. 

```bash
# descargar y ejecutar maqui_external_installer.sh
wget -q -O - https://raw.githubusercontent.com/uchile-robotics/maqui_system/master/maqui_external_installer.sh | bash

# build
sudo apt-get install python-catkin-tools
catkin build --summarize
```

Luego, se debe modificar el archivo de inicio de la consola de interés (bash o zsh):
```bash
echo "source ~/maqui_ws/devel/setup.bash" >> ~/.bashrc
echo "source ~/maqui_ws/devel/setup.zsh" >> ~/.zshrc
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

## Configuración de máquina virtual OpenNaoVM en virtualbox

[Documentación oficial](http://doc.aldebaran.com/1-14/dev/tools/vm-setup.html)

Usuario: `nao`
Contraseña: `nao`

Configuración de la asignación del puerto para SSH (por defecto es el puerto 2222) se realiza en VirtualBox > Configuración > Red > Reenvío de puertos.

```
ssh nao@localhost -p 2222
```
Usando nautilus, se pueden crear marcadores y abrir terminar remota usando la extensión `nautilus-open-terminal`.
```
nautilus sftp://nao@localhost:2222
```
Si se usa modo de red en puente la máquina adquiere una IP en la misma subred que el host. Se debe usar el puerto original para SSH (puerto 22).
```
ssh nao@[VM-IP] -p 22
```

Para averiguar la IP asignada a la máquina virtual se puede usar el comando `ìfconfig`.

Instalación ROS OpenNao VM
--------------------------

```
wget https://raw.githubusercontent.com/uchile-robotics/maqui_system/master/maqui_internal_installer.sh
chmod +x maqui_internal_installer.sh
./maqui_internal_installer.sh
```
