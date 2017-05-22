/*revisar las sesiones activas*/
--select * from v$session_longops
select /*+ rule */  oc.sql_text, sp.*
--from sys.v_$open_cursor oc, (       -- esta vista no muestra el sqltext completo
from v$sqlarea oc, (
    --select  'kill -9 '||b.spid,   --------
    select  b.spid, --pid sistema
    a.SID, 
    a.SERIAL#,
    lpad(to_char(trunc(a.LAST_CALL_ET/3600)),2,0)||':'||
    lpad(to_char(trunc(a.LAST_CALL_ET/60)-(trunc(a.LAST_CALL_ET/3600)*60)),2,0)||':'||
    lpad(to_char(a.LAST_CALL_ET-(trunc(a.LAST_CALL_ET/60)*60)),2,0) Last_Call,
    a.USERNAME,
    a.OSUSER,
    a.fixed_table_sequence,
    a.server,
    a.machine,
    a.PROGRAM program_p,
    b.program program_s,
    a.module,
    a.STATUS,
    a.TYPE,
    a.LOGON_TIME,
    a.client_info,
    a.sql_address,
    a.sql_hash_value,
    'execute sys.dbms_system.set_sql_trace_in_session('||   ---oo--oo--oo--
    a.SID ||','||
    a.SERIAL# ||',true)' "Enable trace command",            ---oo--oo--oo--
    'alter system kill session '''||          --==--==--==--
    a.SID ||','||
    a.SERIAL# ||''';'   "Kill command",       --==--==--==--
    'dba_oskill('|| a.sid||','||a.serial#||')'
    --a.SERIAL# ||''' immediate;'   "Kill command"       --==--==--==--
    from     sys.v_$session a, sys.v_$process b
    where a.paddr = b.addr
    --and ( a.machine like '%SCO_CCI_001%' or a.machine like '%SCO_TOW_001%' )
--and a.machine = 'pgccussd'
--cuando es paquete
--and a.sid in (select distinct session_id from DBA_DDL_LOCKS where name like '%GCK_TRX_CONTROL_DETALLES%')
--AND a.sid = '1719'--uio
--and b.spid='29794'
--cuando es tabla
--and a.sid in (select session_id from DBA_DML_LOCKS where name like '%GCK_TRX_CONTROL_DETALLES%')
and  a.status = 'ACTIVE' 
and a.type='USER'
--and  a.status = 'KILLED'  1154363
--and a.paddr in (select  paddr  from v$shared_server where status like '%ENQ%')
--and a.USERNAME like '%HESTEVEZ%'
--and lower(a.OSUSER) like '%rasinc%'
--and a.server not like 'SHARED'
--and a.machine like '%pgccbancos%'
--and a.program like 'CMS cms_trx_real_%'
--and a.last_call_et >600   ------
--and a.server='SHARED'
--order by a.USERNAME, a.OSUSER
    ) sp
where sp.SQL_ADDRESS = oc.ADDRESS
and sp.SQL_HASH_VALUE = oc.HASH_VALUE   -------
--and oc.sql_text like 'SELECT "TIME_SUBMISSION","NUMBER%'   --==--==--==--
--and upper(oc.sql_text) like '%CRK_TRX_DATACREDITO%'   --==--==--==--
--and upper(oc.sql_text) like '%GCK_TRX_CONTROL_DETALLES%'  
order by 5 desc
