----Dependencia de una tabla 
select owner, name, type
  from all_dependencies
 where/* referenced_owner = 'MI_ESQUEMA'
   and*/ referenced_name = 'AS_RCC_REPORTE_SIM_ATM'
 
--objetos del usuario
select *from USER_OBJECTS
where status='INVALID'

--buscar campos de una tabla
select * 
from all_tab_columns 
where column_name='nombre_columna_buscada' 
and data_type='NVARCHAR2' 
and owner='propietario_buscado' 
order by table_name;