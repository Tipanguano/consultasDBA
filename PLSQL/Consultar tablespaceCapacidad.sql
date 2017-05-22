SELECT /* + RULE */  df.tablespace_name "Tablespace",
       df.bytes / (1024 * 1024) "Size (MB)",
       SUM(fs.bytes) / (1024 * 1024) "Free (MB)",
       Nvl(Round(SUM(fs.bytes) * 100 / df.bytes),1) "% Free",
       Round((df.bytes - SUM(fs.bytes)) * 100 / df.bytes) "% Used"
  FROM dba_free_space fs,
       (SELECT tablespace_name,SUM(bytes) bytes
          FROM dba_data_files
         GROUP BY tablespace_name) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,df.bytes
UNION ALL
SELECT /* + RULE */ df.tablespace_name tspace,
       fs.bytes / (1024 * 1024),
       SUM(df.bytes_free) / (1024 * 1024),
       Nvl(Round((SUM(fs.bytes) - df.bytes_used) * 100 / fs.bytes), 1),
       Round((SUM(fs.bytes) - df.bytes_free) * 100 / fs.bytes)
  FROM dba_temp_files fs,
       (SELECT tablespace_name,bytes_free,bytes_used
          FROM v$temp_space_header
         GROUP BY tablespace_name,bytes_free,bytes_used) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,fs.bytes,df.bytes_free,df.bytes_used
 ORDER BY 4 DESC; 
-------------------------------------------
--TABLAS DE MAYOR TAMAÑO
select /**--*/  owner, segment_name, bytes, segment_type
from dba_segments
where TABLESPACE_NAME = 'REPCDR_GSI_DAT'
order by bytes desc;

---TODOS LOS TABLESPACES
select
b.tablespace_name Tablespace_name,
round(b.total/1024/1024,1) total_space,
round((b.total - nvl(a.free,0))/1024/1024,1) Used_space,
round(nvl(a.free,0)/1024/1024,1) Free_space,
round((b.total - nvl(a.free,0))*100/b.total,1) "Usado%"
from
(  select sum(fs.bytes) free, tablespace_name from dba_free_space fs
     group by tablespace_name ) a, 
(  select sum(df.bytes) total, tablespace_name from dba_data_files df
    group by tablespace_name ) b
where a.tablespace_name (+) like b.tablespace_name
order by a.free desc
----
---Buscar tableSpace
select
b.tablespace_name Tablespace_name,
round(b.total/1024/1024,1) total_space,
round((b.total - nvl(a.free,0))/1024/1024,1) Used_space,
round(nvl(a.free,0)/1024/1024,1) Free_space,
round((b.total - nvl(a.free,0))*100/b.total,1) "Usado%"
from
(  select sum(fs.bytes) free, tablespace_name from dba_free_space fs
     group by tablespace_name ) a, 
(  select sum(df.bytes) total, tablespace_name from dba_data_files df
    group by tablespace_name ) b
where a.tablespace_name (+) like b.tablespace_name 
and a.tablespace_name like '%REPCDR_GSI_DAT%';
