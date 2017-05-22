------------------creacion de directorios
create or replace directory texternal_data as '/u01/app/oracle/texternal/data';

------------------LISTAR DIRECTORIOS
select *from all_directories

------------------creacion de tablas externas
CREATE TABLE XX_EMPLOYEES_ALL(
  Codigo NUMBER(4),
  Empleado CHAR(50),
  Fecha_inicio  CHAR(10))
ORGANIZATION EXTERNAL(
  TYPE ORACLE_LOADER DEFAULT DIRECTORY dir_externo
  ACCESS PARAMETERS
  (RECORDS DELIMITED BY NEWLINE
   SKIP 0  
   BADFILE '%a_%p.bad'
   LOGFILE '%a_%p.log'
   FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'  LRTRIM
   MISSING FIELD VALUES ARE NULL
   REJECT ROWS WITH ALL NULL FIELDS
    (Codigo INTEGER EXTERNAL (4),
     Empleado CHAR(50),
     Fecha_inicio CHAR(10) DATE_FORMAT DATE MASK "dd/mm/yyyy"))
   LOCATION ('test.txt')

REJECT LIMIT 0; 

