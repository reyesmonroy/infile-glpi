# GLPI desplegar con Docker

Despliega y corre GLPI (any version) con Docker.

Install latest version by default but you can specify the version you want by passing

You can:
- conectar con una base de datos existente.
- o crea uno nuevo facilmente con docker-compose.

## desplegar solo GLPI (sin base de datos)

```docker run -it -d -p 80:80 ferweb2018/glpi-infile```

## desplegar con docker-compose

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

Access your container con HTTP.
Use infos you setup in glpi.env file

![alt tag]( https://github.com/reyesmonroy/infile-glpi/blob/master/doc/glpi-db-setup.png)

## Instalar plugin de manejo de tema de GLPI



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
