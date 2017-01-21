Instalación ROS OpenNao VM
--------------------------

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

Para averiguar la IP asignada a la máquina virtual se puede usar el comando `ìfconfig`. Una vez abierta la sesión, se deben ejecutar los siguientes comandos en la máquina virtual:


```
wget https://raw.githubusercontent.com/uchile-robotics/pepper_system/master/pepper_internal_installer.sh
chmod +x pepper_install.sh
./pepper_install.sh
```
