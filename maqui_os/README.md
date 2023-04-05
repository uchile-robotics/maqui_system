# maqui_os

Este repositorio contiene scripts para compilar e instalar uchile_ws en el robot Maqui (Pepper, Softbank Robotics) utilizando el sistema  pepper_os (Gentoo prefix over ros overlay) de Sam Pfeiffer. Se utiliza como imagen base la creada en [https://github.com/awesomebytes/pepper_os](https://github.com/awesomebytes/pepper_os). Con esta se puede realizar compilación cruzada para el robot Pepper, y ya contiene instalado ROS Melodic y sus dependencias. 

Gentoo Prefix permite que sea posible compilar software en el propio Pepper, pero esto no siempre es deseable por varios motivos: el robot no siempre esta disponible, no queremos romper lo que ya está corriendo, puede tomar mucho tiempo en los recursos limitados del robot, etc. Por lo que hacer eso es recomendado solo para casos donde se hagan pequeños arreglos sobre repositorios de uchile_ws. La idea principal es usar este sistema como herramienta de compilación cruzada, donde se puede hacer de dos maneras:

- Correr un contenedor de la última imagen de maqui_os disponible, añadir el código a compilar, utilizar la línea de comandos para compilar, una vez esté listo se pueden pasar los archivos desde el contenedor al robot.

- Escribir un Dockerfile con las instrucciones para compilar, construir la imagen y luego lanzar un contenedor para copiar todo al robot.

La metodología para compilar es una mezcla de ambos, dado que la primera opción es flexible, ya que se usa la línea de comando se puede ir probando y solucionando errores en el momento. Pero una vez que se encuentra la forma ideal de compilar, se debe escribir un script para realizar esa compilación, esto con la idea de que compilar sea replicable. Ese script luego puede ser añadido al Dockerfile, para actualizar la imagen de maqui_os con la última versión del software utilizado.


### Resumen para compilar nuevo software para el Pepper!
- Lanzar un contenedor de la última versión de maqui_os
- Compilar código utilizando la línea de comando (prueba y error)
- Una vez que se haya descubierto los pasos necesarios para compilar: escribir script o modificar los ya existentes! (Garantiza reproducibilidad)
- Actualizar Dockerfile.
- Pasar archivos desde contenedor a Pepper (antes o después de actualizar Dockerfile)


### Nota Importante:
- Si se quiere recompilar cambios en los repositorios de uchile_ws, no es necesario escribir un script o modificar el dockerfile, se puede simplemente hace build nuevamente.
- Si se quiere añadir repositorios a uchile_ws, notar que existen los scripts maqui_install_base_ws.sh, maqui_install_fork_ws.sh, maqui_install_soft_ws.sh y maqui_install_high_ws.sh, si se quiere añadir un repositorio a algunos de estos ws, se deben modificar estos scripts.


### shell
- TODO: Se debe portar la shell de uchile_system para Pepper, se debe crear una versión abreviada compatible con Maqui. Check [uchile_system](https://github.com/uchile-robotics/uchile_system). (Esto estaba hecho pero por problemas de pandemia este desarrollo se perdió :sob:)