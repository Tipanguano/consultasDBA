----------------------------------------------------------
/*para crear una base de datos*/
CREATE DATABASE desarrollo
  	WITH OWNER = javer
	ENCODING= 'UTF8'
	CONNECTION LIMMIT =-1;  --ilimitado
----------------------------------------------------------
/*crear tablas*/
create table rrt_xt_usuarios_tmp(
id_usuario	int NOT NULL, 
usuario     	varchar(50),
nombre		character varying(155),
apellido	character(100),
constraint	id_usuario primary key(id_usuario)
)
with(
 OIDS=FALSE  --añade un identificador unico global a los objetos de postgre (puede repetirse a >volumen)
);
ALTER TABLE "rrt_xt_usuarios_tmp" owner to javier;
comment on table "rrt_xt_usuarios_tmp" is 'tabla de pruebas de inicializacion';
----------------------------------------------------------
/*crear secuencias*/
CREATE SEQUENCE sec_usuarios_tmp
 INCREMENT BY 1
 MINVALUE 1
 MAXVALUE 99999999999
 START 1
 CACHE 1;
 ALTER TABLE rrt_xt_usuarios_tmp owner to javier;
--llamadas
select nextval('sec_usuarios_tmp');
--en tablas
 create table libros(
  codigo nextval('sec_codigolibros'),
  titulo varchar(30),
  autor varchar(30),
  editorial varchar(15),
  primary key (codigo)
 );
 --asignar
 alter table rrt_xt_usuarios_tmp
 alter column id_usuario set default nextval('sec_usuarios_tmp');
 ----
 /*alterar un campo*/
 alter table rrt_xt_usuarios_tmp
    alter column apellido type character(150),
    alter column apellido set default 'N/A'; 
----------------------------------------------------------
/*get version*/
select version();
/*get date*/
select now()::timestamp;
-----

select row_number() over (partition by x.fecha), x.*
from (
select now()::timestamp as fecha
union all
select now()::timestamp as fecha
union all
select now()::timestamp as fecha
union all
select now()::timestamp as fecha
)as x;

--------
 






