# maqui_system


Este repositorio contiene los scripts necesarios para compilar UChile ROS Framework para el robot Pepper (Maqui). En realidad se compila una versión reducida del framework que contiene solo lo necesario para Pepper, tener en cuenta que no todo el software corre dentro de Pepper, se tiene un sistema híbrido donde ciertas cosas corren en computadores externos (aunque también puede funcionar sin estos, a costo de menor desempeño).



### ¿Por qué es complicado compilar cosas para Pepper?

El principal problema es que no se puede compilar cosas dentro del robot utilizando su propio hardware, ya que se encuentra restringido el uso de superusuario y además no posee compilador de C ni ninguna herramienta para compilar. Esta es una decisión de diseño como medida de seguridad por el fabricante.

Otros problemas son que el Sistema Operativo que tiene Pepper es una versión limitada de Gentoo, a la cual le fueron removidas herramientas útiles para el desarrollo de software y la instalación de dependencias tales como el gestor de paquetes. También la arquitectura es una mezcla extraña, a pesar de que el procesador es de 64 bits, todo está compilado para 32 para asegurar la compatibilidad con la versión de Naoqi que usaba el Pepper con la del Nao, aunque esto debería cambiar para las versiones 2.7 y 2.9 de Naoqi. Por último, el procesador del robot es lento y compilar cosas muy pesadas tomaría mucho tiempo.



### Máquina Virtual

La solución disponible para la compilación en el momento en que llegó el robot al laboratorio (año 2017) correspondía a utilizar una máquina virtual (VM) del robot nao dispuesta por Aldebaran en la que se pueden compilar cosas en espacio de usuario, es una versión antigua de Naoqi (~2.1 creo). La máquina virtual se utiliza como herramienta para compilación cruzada, se compilan cosas en la máquina en el computador propio las cuales luego son empaquetadas y subidas al robot.

Detalles de como usar la Máquina Virtual la encuentran en [vm](/vm/README.md). En esta se tiene compilador ROS indigo y uchile_ws (set limitado para Pepper).

Tener en cuenta que hay un snapshot de la VM con lo última versión, dado que muchas cosas se compilaron sobre lo que se había trabajado en esa VM,  es posible que no todo lo que ha sido compilado en la VM haya sido registrado en los scripts que se encuentran en este repositorio, por lo que es posible no sea pueda replicar el estado exacto del último snapshot de la VM utilizando este repositorio.
 
Una de las grandes limitaciones de la Máquina Virtual es que no corresponde a la versión exacta de Naoqi que tiene el Pepper, por lo que muchas librerías base que incluye tienen otra versión que provoca errores, estas librerías luego deben ser compiladas dentro de la Máquina Virtual y luego re-compilar. 



### Gentoo prefix en Imagen de Docker

Es un desarrollo realizado por [Sam Pfeiffer](https://github.com/awesomebytes), corresponde a la construcción de un clon del sistema de Pepper en una image de Docker, sobre la cual compiló [Gentoo Prefix](https://wiki.gentoo.org/wiki/Prefix) y sobre lo cual compiló ROS (Kinetic o Melodic), además que incluye el gestor de paquetes Portage de Gentoo que hace más sencilla la instalación de dependencias y catkin_make para compilar paquetes de ROS.

Gentoo Prefix es una herramienta de Gentoo para correr software de Gentoo en otras máquinas, en este caso se utiliza sobre el Sistema Operativo Gentoo limitado que tiene el Pepper para poder correr una instalación completa de Gentoo con todas las herramientas de este disponible.

Repositorios involucrados en este desarrollado:
- [https://github.com/awesomebytes/gentoo_prefix_ci](https://github.com/awesomebytes/gentoo_prefix_ci)
- [https://github.com/awesomebytes/ros_overlay_on_gentoo_prefix](https://github.com/awesomebytes/ros_overlay_on_gentoo_prefix)
- [https://github.com/awesomebytes/pepper_os](https://github.com/awesomebytes/pepper_os)

Hay una versiones de la imagen de Docker lista para usar en dockerhub:
- [https://hub.docker.com/r/awesomebytes/pepper_os_image](https://hub.docker.com/r/awesomebytes/pepper_os_image)
- [https://hub.docker.com/r/awesomebytes/pepper_os_image_melodic](https://hub.docker.com/r/awesomebytes/pepper_os_image_melodic)

Además se cuenta con una versión desarrollada por Aldebaran, la que permite correr esto sobre Naoqi 2.7 y 2.9:

- [https://github.com/softbankrobotics-research/sbre_robot_ros_gentoo_prefix](https://github.com/softbankrobotics-research/sbre_robot_ros_gentoo_prefix)


#### maqui_os
En este caso en [maqui_os](/maqui_os/README.md) pueden encontrar un Dockerfile que utiliza como imagen base [pepper_os](https://github.com/awesomebytes/pepper_os) y compila uchile_ws para Pepper, además se incluyen scripts para compilar tensorflow y pytorch para poder usarlos dentro de Pepper (solo cpu, obviamente). Revisar [maqui_os](/maqui_os/README.md) para más detalle de como usar pepper_os y maqui_os para compilar software para el Pepper.



### Otras soluciones
Aldebaran dispone de un toolchain para la compilación cruzada, algunos equipos lo utilizan, ver: [https://github.com/esteve/ros2_pepper](https://github.com/esteve/ros2_pepper)