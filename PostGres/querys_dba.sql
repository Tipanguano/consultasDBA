/*listar las tablas de la base*/
select *
from information_schema.tables;
-------
/*listar los campos de un tabla*/
select  UPPER(r.table_name) nombre_tabla,
	md5(r.column_name) ,
	r.*
from information_schema.columns r
where table_name ='rrt_xt_usuarios_tmp'
--------


