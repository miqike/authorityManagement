drop database link dbl_sxgs;
create database link dbl_sxgs connect to sxgs identified by sxgs 
using '(DESCRIPTION=
    (CONNECT_DATA=(SERVICE_NAME=orcl))
  (ADDRESS=(PROTOCOL=TCP)(HOST=192.168.217.128)(PORT=1521)))';

drop database link   dbl_sxnb;
create database link dbl_sxnb connect to sxnb identified by sxnb 
using '(DESCRIPTION=
    (CONNECT_DATA=(SERVICE_NAME=orcl))
  (ADDRESS=(PROTOCOL=TCP)(HOST=192.168.217.128)(PORT=1521)))'  ;

drop database link   dbl_ztjg;
create database link dbl_ztjg connect to ztjg identified by ztjg
using '(DESCRIPTION=
    (CONNECT_DATA=(SERVICE_NAME=orcl))
  (ADDRESS=(PROTOCOL=TCP)(HOST=192.168.217.128)(PORT=1521)))'  ;

select 'create or replace synonym '||table_name||' for '||table_name||'@dbl_'||owner||';'
from all_tables where owner in ('SXGS','SXNB','ZTJG');
  
