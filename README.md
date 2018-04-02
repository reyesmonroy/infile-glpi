# GLPI desplegar con Docker

Despliega y corre GLPI (alguna version) con Docker.

Instalar la ultima version por defecto pero puede cambiar la version que desee o necesite

Puedes:
- conectar con una base de datos existente.
- o crea uno nuevo facilmente con docker-compose.

## Desplegar solo GLPI (sin base de datos)

```docker run -it -d -p 80:80 ferweb2018/glpi-infile```

## Desplegar con docker-compose

Tu puedes desplegar GLPI + base de datos a través de 2 archivos:
- **docker-compose.yml**
- **glpi.env**

### docker-compose.yml

```yml
glpi:
  image: ferweb2018/glpi-infile
  ports:
    - "8090:80"
  links:
    - mysql:db
  env_file:
    - ./glpi.env

mysql:
  image: mariadb
  env_file:
    - ./glpi.env
```

### glpi.env

```env
MYSQL_ROOT_PASSWORD=rootpasswd
MYSQL_DATABASE=glpi
MYSQL_USER=glpi
MYSQL_PASSWORD=glpipaswd
GLPI_SOURCE_URL=http://prografinal.hol.es/glpi-9.1.6.tar.gz
```

### Correr docker-compose

```bash
docker-compose build
docker-compose up
```

### Configurar nueva base de datos

Accesar a tu container con HTTP.
Utilizar la informacion en el archivo glpi.env

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/glpi-db-setup.png)

-Seleccionar la base de datos correcta de glpi

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/glpi-db-seleccionar.png)

## Cambiar el color del tema de GLPI

- Ingresar a preferencias con el símbolo de engranaje que se encuentra en la parte superior izquierda de nuestro navegador al lado izquierdo del salir del sistema. Después seleccionar la pestaña personalización.

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/seleccion-tema-color.png)

-Seleccionar el tema Flood, puede seleccionar cualquiera a su gusto para personalizarlo y darle click al botón de registrar.

## Instalar plugin de manejo de tema de GLPI

-Ejecutar comando para mostrar el listado de contenedores

```bash
sudo docker ps -a
```
![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/comando%20ps.png)

-Ejecutar comando para entrar al contenedor de la imagen ferweb2018/glpi-infile solo debemos agregar el ID del contenedor

```bash
sudo docker exec -i -t ID_CONTAINER /bin/bash
```

-Estando en el contenedor debemos ingresar a la carpeta de plugin con el siguiente comando

```bash
cd /var/www/html/glpi/plugins
```

-En la carpeta plugin descomprimir el paquete tar con el comando siguiente para instalarlo desde GLPI Configuracion>Plugins instalarlo.  

```bash
tar -xvzf Plugin_mod-9.1.6-1.1.3.tar.gz
```

-Para salir del contenedor y regresar a la terminal estandar.  

```bash
exit
```

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/instalacion-tema.png)

-Ya instalado hay que activarlo desde la interfaz gráfica.

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/activar-tema.png)

-Ahora configuralo dándole click sobre el nombre del plugin.

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/temas.png)

-Vista de la configuración del plugin en donde se puede seleccionar fondo de pagina de inicio de sesión y el logotipo.

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/configurar-plugin.png)

## FAQ

### Do I have to use Mariadb?

Nope, you can replace con mysql image in docker-compose.yml if prefer

### How to make my database persistent?

Check docker-compose.sample.yml.

Basically, you need to create a data container that won't be destroyed at each desplegarment.

### How can I install a different version of GLPI?

- Choose a version at: https://forge.glpi-project.org/projects/glpi/files
- Copy URL and paste it in glpi.env:

```
GLPI_SOURCE_URL=https://forge.glpi-project.org/attachments/download/2020/glpi-0.85.4.tar.gz
```

- Run ```docker-compose build```
- Run ```docker-compose up```
