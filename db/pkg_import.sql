create or replace package pkg_import is

  -- Author  : YQH
  -- Created : 2016/8/5 9:38:51
  -- Purpose : 接口相关的存储过程，只负责从接口中取得数据
  -- Area : 此接口程序只针对陕西
  
  procedure prc_importRcRw(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2);
  procedure prc_importRcRwShortcut(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2);
  procedure prc_removeRcRw(p_hcjhId in varchar2,p_hcrwList varchar2) ;
  procedure prc_importByJhid(p_hcjhId in varchar2,p_step out number);
  procedure prc_importDblink(p_hcjhId in varchar2);
  procedure prc_import_hc(p_HCRWID in varchar2);
  procedure prc_testDblink(p_hcjhId in varchar2,p_rws out number,p_rys out number);
  procedure prc_job_hcrw;
  
  procedure prc_importJsRw;
  procedure prc_import_js_hc(p_HCRWID in varchar2,p_hclx in number);
  procedure prc_rc_autohandle;
end pkg_import;
