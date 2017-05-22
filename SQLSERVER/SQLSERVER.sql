---CONSULTAS DBA SQLSERVER
---Version de la base
select @@version
---Revisar si las tablas tienen campo identity
SELECT SCHEMA_NAME(OBJECTPROPERTY(OBJECT_ID,'SchemaId')) AS SchemaName,
       OBJECT_NAME(OBJECT_ID) AS TableName,
       name AS ColumnName
FROM  SYS.COLUMNS
WHERE is_identity = 1
ORDER BY SchemaName, TableName, ColumnName;
---listar los SP
SELECT *--Name
FROM sys.procedures;
---listar las dependencias de una tabla
select *
from sys.sql_expression_dependencies
where referenced_entity_name like '%MSP_RESOURCES%'

exec sp_depends MSP_RESOURCES
---listar las referencias de una tabla
select *
from sys.dm_sql_referencing_entities('dbo.MSP_RESOURCES', 'OBJECT');

----generar id de tabla
select newid()