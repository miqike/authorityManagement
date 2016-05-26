--创建DB LINK
create database link dbl_cpsi connect to cpsi_interface identified by cpsi_interface using '(DESCRIPTION=
    (CONNECT_DATA=(SERVICE_NAME=orcl))
	(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.5.133)(PORT=1521)))';
--创建同义词
create or replace synonym V_NB_GDCZ for V_NB_GDCZ@dbl_cpsi;
create or replace synonym V_HCRW for V_HCRW@dbl_cpsi;
create or replace synonym V_NB for V_NB@dbl_cpsi;
create or replace synonym V_NB_WD for V_NB_WD@dbl_cpsi;
create or replace synonym V_NB_DWTZ for V_NB_DWTZ@dbl_cpsi;
create or replace synonym V_NB_DWDB for V_NB_DWDB@dbl_cpsi;
create or replace synonym V_NB_GQBG for V_NB_GQBG@dbl_cpsi;
create or replace synonym V_JS_ZSCQ for V_JS_ZSCQ@dbl_cpsi;
create or replace synonym V_JS_GDCZ for V_JS_GDCZ@dbl_cpsi;
create or replace synonym V_JS_GQBG for V_JS_GQBG@dbl_cpsi;
create or replace synonym V_JS_XZXK for V_JS_XZXK@dbl_cpsi;
create or replace synonym V_JS_XZCF for V_JS_XZCF@dbl_cpsi;
