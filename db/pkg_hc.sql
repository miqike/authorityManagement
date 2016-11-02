create or replace package pkg_hc is

  -- Author  : YQH
  -- Created : 2016/6/21 9:42:15
  -- Purpose : 核查相关的过程和方法
  -- 此程序是在将接口数据导入过来之后才执行，只针对导入后的数据进行核对
  
  CONS_HCSXJG_TG constant integer := 1;--核查结果通过标志
  CONS_HCSXJG_BTG constant integer := 2;--核查结果不通过标志
  CONS_BD_SJLY_DJ constant integer := 1;--比对数据来源 业务登记系统
  CONS_BD_SJLY_SJ constant integer := 2;--比对数据来源 实际数据
  CONS_HCSXJG_DBXXLY_NBDJ constant integer := 1;--核查事项对比信息来源 年报+业务登记
  CONS_HCSXJG_DBXXLY_NBSJ constant integer := 2;--核查事项对比信息来源 年报+实际    
  CONS_HCSXJG_DBXXLY_All constant integer := 3;--核查事项对比信息来源 全部
  CONS_HCSXJG_DBXXLY_JSGS constant integer := 4;--核查事项对比信息来源 即时+公示
  CONS_HCSXJG_DBXXLY_JSSJ constant integer := 5;--核查事项对比信息来源 即时+实际
  CONS_HCJH_PLAN_TYPE_SSJ constant integer := 1;--双随机计划
  CONS_HCJH_PLAN_TYPE_RC constant integer := 2;--日常监管计划
  CONS_HCLX_JH constant integer := 1;--年报核查 操作T_HCRW和T_HCSXJG表
  CONS_HCLX_JS constant integer := 2;--即时核查 操作T_JS_HCRW和T_JS_HCSXJG表 T_JS_HCSXJG表中插入t_hcsx 表中 hclx=2 的所有核查事项
  
  function fun_get_xcr(xh in number,xcr in varchar2) return varchar2;
  function fun_cal_hcsxjg(p_DBXXLY integer,p_nb varchar2,p_dj varchar2,p_sj varchar2 ) return integer;
  FUNCTION MD5_DIGEST(vin_string IN VARCHAR2) RETURN VARCHAR2;
  function func_cal_hcsxjg_wz(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_hcsxjg_dwtz(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_hcsxjg_gqbg(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_hcsxjg_dwdb(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_hcsxjg_xzxk(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_hcsxjg_gdcz(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_js_hcsxjg_gdcz(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_js_hcsxjg_gqbg(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_js_hcsxjg_zscq(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_js_hcsxjg_xzcf(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  function func_cal_js_hcsxjg_xzxk(p_HCRWID varchar2,p_DBXXLY integer) return integer;
  FUNCTION FUN_CAL_ORG_ID_00(P_ID IN VARCHAR2) RETURN VARCHAR2;
  
  procedure prc_bidui_hc(p_HCRWID in varchar2);
  procedure prc_getHcsxjg(p_HCRWID in varchar2,p_out out clob);
  procedure prc_insertAvailableAuditItem(p_hcjhId in varchar2/*, p_result out number, p_errorMsg out VARCHAR2*/);
  
  procedure prc_bidui_js_hc(p_HCRWID in varchar2);
  procedure prc_js_getHcsxjg(p_HCRWID in varchar2,p_out out clob);
  
end pkg_hc;
