# PRACTICA-APACHE-MYSQL

<h1>¿Qué contiene esta estructura LAMP?</h1>

En esta práctica crearemos una estructura LAMP que tendrá una máquina Apache con direccionamiento de puertos y que podrá salir a internet y a la cuál le daremos una ip pública y otra privada para poder comunicarse con la otra máquina MySQL con la que cuenta está estructura, esta última no tendrá acceso a internet por lo que solo se comunicará con la máquina apache por esa red privada.

Para conseguir esto tendremos crear la siguiente estructura:

<h2>1.-Fichero Vagranfile:</h2> Este contiene lo necesario para configurar las máquinas de Apache y MySQL, así como la asignación de direcciones ip y un enlace a los scripts de aprovisionamiento de cada una. Además de la ISO que tendrá cada máquina.

![image](https://github.com/user-attachments/assets/1904d57c-4124-42c9-b5a5-85b734f7c7d8)

Como podemos observar a cada máquina se le da un nombre, una dirección de red interna(Apache:192.168.20.34 y MySQL:192.168.20.35) y un enlace al fichero provision, y en el caso de Apache se le da una dirección de red pública y el direccionamiento de puertos.

<h2>2.-Fichero de provisión de Apache:</h2> Este incluirá un script de los comandos para instalar los servicios que necesitamos, los ficheros que tenemos que copiar, editar y habilitar.


![image](https://github.com/user-attachments/assets/ec22a7e2-a8aa-4128-935c-be9d31d8b5a0)

<h2>FUNCIONAMIENTO</h2> 

Este script primero actualiza los repositorios y luego instala los componentes necesarios para un servidor web LAMP:

<b>Apache:</b> Servidor web que permitirá servir las páginas de la aplicación.

<b>PHP:</b> Lenguaje de programación que se ejecuta en el servidor y permite crear aplicaciones web dinámicas.

<b>Módulo PHP-MySQL:</b> Permite que PHP se comunique con MySQL.

<b>Git:</b> Para clonar el repositorio que contiene la aplicación web.

<b>Net-Tools:</b> Herramientas de red adicionales.

Utilizamos Git para descargar el código de la aplicación de un repositorio público en GitHub, el cuál colocaremos en el directorio /var/www/practica1.

Una vez clonado el repositorio, sacamos los archivos de src fuera y le damos los permisos adecuados para que Apache tenga acceso de lectura y ejecución en este directorio.

Vamos al directorio de los sitios disponibles de Apache, copiamos el fichero por defecto y le asignamos el nombre de practica1.conf, dentro de ese fichero le cambiamos la línea del DocumentRoot para que apunte al directorio donde se encuentra en config.php. Habilitamos el fichero que acabamos de crear y deshabilitamos el de por defecto, y después reiniciamos el servicio de Apache.

Para permitir que la aplicación PHP se conecte a la base de datos MySQL, el script crea un archivo config.php que contiene:

<b>DB_HOST:</b> La dirección IP del servidor MySQL.

<b>DB_NAME:</b> El nombre de la base de datos.

<b>DB_USER y DB_PASSWORD:</b> Nombre de usuario y contraseña de MySQL.

Y por último vuelve a reiniciar Apache.

<h2>3.-Fichero de provisión de MySQL:</h2> 
Incluye los comandos para instalar los servicios necesarios y además crea una base de datos y un usuario.

![image](https://github.com/user-attachments/assets/2c6b52ed-3295-43c6-a6b0-4394dbd3db10)

<h2>FUNCIONAMIENTO</h2>

El script actualiza la lista de paquetes y luego instala los paquetes necesarios: MySQL, Git y Net-Tools.

Inicia el servicio de MySQL

Utilizamos git para clonar el mismo repositorio que copiamos en la máquina Apache

Se loguea como root, importa la estructura y los datos de la base de datos y luego, crea un usuario MySQL llamado alberto, que tiene todos los permisos sobre la base de datos lamp_db y está configurado para poder conectarse desde la IP 192.68.20.34

Para que el servidor MySQL pueda ser accedido desde la otra máquina en la red, el script modifica la configuración de MySQL, cambiando el bind-address para permitir conexiones desde una dirección IP específica (192.168.20.35 en este caso).

Iniciamos la máquina y nos metemos a la máquina de MySQL por ssh y eliminamos la siguiente línea destacada del fichero <b>/etc/mysql/mysql.conf.d/mysqld.cnf:</b>

![image](https://github.com/user-attachments/assets/5facc9a9-53de-4f7e-8b0c-a08b9b153a06)

Y por último aplicamos el comando <b>sudo ip route del default</b> para quitarle la puerta de enlace y así no tener acceso a internet.

Y ya estaría montada nuestra estructura, solo quedaría probar que todo funciona correctamente.
