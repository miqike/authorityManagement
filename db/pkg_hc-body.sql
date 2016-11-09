create or replace package body pkg_hc is

  -- Private type declarations
  --type <TypeName> is <Datatype>;

  -- Private constant declarations


  -- Private variable declarations
  --<VariableName> <Datatype>;

  -- Function and procedure implementations
  --MD5加密
  FUNCTION MD5_DIGEST(vin_string IN VARCHAR2)
    RETURN VARCHAR2 IS
    BEGIN
      RETURN upper(dbms_obfuscation_toolkit.md5(input => utl_raw.cast_to_raw(vin_string)));
    END md5_digest;

  --拆分核查人
  function fun_get_xcr(xh in number,xcr in varchar2) return varchar2 is
    FunctionResult varchar2(100);
    begin
      select xcr into FunctionResult from(
        SELECT REGEXP_SUBSTR (xcr, '[^,]+', 1,rownum) xcr,rownum rn
        FROM DUAL
        CONNECT BY ROWNUM <=
                   LENGTH (xcr) - LENGTH (REPLACE (xcr, ',', ''))+1)
      where rn=xh;
      return(FunctionResult);
    end fun_get_xcr;
  --将组织机构代码后面连续的两个零去掉
  FUNCTION FUN_CAL_ORG_ID_00(P_ID IN VARCHAR2) RETURN VARCHAR2 IS
    V_LAST VARCHAR2(10);
    BEGIN
      V_LAST:=SUBSTR(P_ID,length(P_ID)-1,2);
      IF(V_LAST!='00') THEN
        RETURN P_ID;
      ELSE
        RETURN FUN_CAL_ORG_ID_00(SUBSTR(P_ID,1,length(P_ID)-2));
      END IF;
    END FUN_CAL_ORG_ID_00;
  --计算核查结果
  function fun_cal_hcsxjg(p_DBXXLY integer,p_nb varchar2,p_dj varchar2,p_sj varchar2 ) return integer is
    FunctionResult integer;
    begin
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        if(p_nb=p_dj) then
          FunctionResult:=CONS_HCSXJG_TG;
        else
          FunctionResult:=CONS_HCSXJG_BTG;
        end if;
        when CONS_HCSXJG_DBXXLY_NBSJ then
        if(p_nb=p_sj) then
          FunctionResult:=CONS_HCSXJG_TG;
        else
          FunctionResult:=CONS_HCSXJG_BTG;
        end if;
      else
        if(p_nb=p_sj and p_nb=p_dj) then
          FunctionResult:=CONS_HCSXJG_TG;
        else
          FunctionResult:=CONS_HCSXJG_BTG;
        end if;
      end case;
      return(FunctionResult);
    end fun_cal_hcsxjg;
  --比对网址网店
  function func_cal_hcsxjg_wz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
          minus
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
          minus
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
          minus
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_dbxxly
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select TYPE,NAME,WZ from t_nb_bd_wd where HCRW_ID=p_HCRWID
          minus
          select TYPE,NAME,WZ from t_nb_wd where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_wz;
  --比对对外投资
  function func_cal_hcsxjg_dwtz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
          minus
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
          minus
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
          minus
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where HCRW_ID=p_HCRWID
          minus
          select tzqymc,TZQY_ZCH from T_NB_DWTZ where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_dwtz;
  --比对股权变更
  function func_cal_hcsxjg_gqbg(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_bd_GQBG where HCRW_ID=p_HCRWID
          minus
          select gd,bgq_gqbl,bgh_gqbl,bgrq from T_NB_GQBG where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_gqbg;
  --比对对外担保
  function func_cal_hcsxjg_dwdb(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where HCRW_ID=p_HCRWID
          minus
          select ZQR,ZWR,ZZQZL,ZZQSE,LXZWQX,BZQJ,BZFS,BZDBFW from T_NB_DWDB where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_dwdb;
  --比对行政许可
  function func_cal_hcsxjg_xzxk(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
          minus
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
          minus
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
          minus
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select xkwjmc,yxq from T_NB_bd_XZXK where HCRW_ID=p_HCRWID
          minus
          select xkwjmc,yxq from T_NB_XZXK where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_xzxk;
  --比对股东出资
  function func_cal_hcsxjg_gdcz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出公示表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_gs
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_gs
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在公示表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        select count(1) into v_cnt_bd
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_DJ
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_NBSJ then
        select count(1) into v_cnt_bd
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID and sjly=CONS_BD_SJLY_SJ
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_bd_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,RJCZE,RJCZDQSJ,RJCZFS,SJCZE,SJCZSJ,SJCZFS from T_NB_GDCZ where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_hcsxjg_gdcz;
  --比对即时股东出资
  function func_cal_js_hcsxjg_gdcz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出即时表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_JSGS then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID  AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_JSGS then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_gdcz;
  --比对即时股权变更
  function func_cal_js_hcsxjg_gqbg(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出即时表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_JSGS then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where HCRW_ID=p_HCRWID AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where HCRW_ID=p_HCRWID AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where HCRW_ID=p_HCRWID
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_gqbg;
  --比对即时知识产权
  function func_cal_js_hcsxjg_zscq(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出即时表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_gs
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where HCRW_ID=p_HCRWID
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_zscq;
  --比对即时行政处罚
  function func_cal_js_hcsxjg_xzcf(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出即时表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_gs
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_bd_XZCF where HCRW_ID=p_HCRWID
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from T_JS_XZCF where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_xzcf;
  --比对即时行政许可
  function func_cal_js_hcsxjg_xzxk(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    FunctionResult integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      --首先找出即时表中数据是否在比对表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_gs
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
        );
      else
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where HCRW_ID=p_HCRWID
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where HCRW_ID=p_HCRWID
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_xzxk;
  --计划三个数值的对比结果
  function func_cal_nb_compare_result(p_DBXXLY integer,p_nb_value varchar2,p_nb_bd_dj varchar2,p_nb_bd_sj varchar2) return integer is
    v_result integer;
    begin
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_NBDJ then
        if(p_nb_value=p_nb_bd_dj) then
          v_result:=1;
        else
          v_result:=2;
        end if;
        when CONS_HCSXJG_DBXXLY_NBSJ then
        if(p_nb_value=p_nb_bd_sj) then
          v_result:=1;
        else
          v_result:=2;
        end if;
      else
        if(p_nb_value=p_nb_bd_dj and p_nb_value = p_nb_bd_sj) then
          v_result:=1;
        else
          v_result:=2;
        end if;
      end case;
      return v_result;
    end func_cal_nb_compare_result;
  --年报核查结果比对 根据导入的数据，更新HCSXJG表中每个核查事项的内容
  procedure prc_bidui_hc(p_HCRWID in varchar2) is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcsxjg_1 number;--核查事项结果中通过个数
    v_hcsxjg_2 number;--核查事项结果中未通过个数
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    v_hcsx_sm t_hcsx_sm.content%type;--核查结果说明
    cursor cur_hcsx is
      select a.hcsx_id,a.hcrw_id,a.name,a.hcjg,a.hcfs,a.qygsnr,a.bznr,a.sjnr,a.hczt,a.sm,a.page,a.hclx,
        (select b.dbxxly from t_hcsx b where b.id=a.hcsx_id) dbxxly
      from t_hcsxjg a where hcrw_id=p_HCRWID;
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_hc.prc_bidui_hc','比对核查数据','比对核查数据',p_HCRWID,v_log_xh);
      v_hcsxjg_1:=0;
      v_hcsxjg_2:=0;

      select count(1) into v_cnt_gs from t_nb where hcrw_id=p_HCRWID;
      v_step:=0;

      if(v_cnt_gs>0) then
        v_step:=1;
        select * into v_nb_gs from t_nb where hcrw_id=p_HCRWID;
        v_step:=2;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where hcrw_id=p_HCRWID and sjly=1;
        if(v_cnt_bd>0) then
          v_step:=3;
          select * into v_nb_bd_dj from t_nb_bd where hcrw_id=p_HCRWID and sjly=1;
        else
          v_step:=4;
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where hcrw_id=p_HCRWID and sjly=2;
        v_step:=5;
        if(v_cnt_bd>0) then
          v_step:=6;
          select * into v_nb_bd_sj from t_nb_bd where hcrw_id=p_HCRWID and sjly=2;
        else
          v_step:=7;
          v_nb_bd_sj:=null;
        end if;
        --开始循环核查事项进行比对
        v_step:=8;
        for o in cur_hcsx loop
          --取得核查事项结果说明
          begin
            select content into v_hcsx_sm from (select * from t_hcsx_sm where hcsx_id=o.hcsx_id and dbxxly =o.dbxxly order by weight)
            where rownum<=1;
            exception
            when others then
            v_hcsx_sm:=null;
          end;
          case o.hcsx_id
            when '10a5cbafa03044239b8bedafb301d0a8' then--企业通信地址
            v_step:=9;
            update t_hcsxjg set qygsnr=v_nb_gs.txdz,BZNR=v_nb_bd_dj.txdz,sjNR=v_nb_bd_sj.txdz,
              hcjg=fun_cal_hcsxjg(o.dbxxly,v_nb_gs.txdz,v_nb_bd_dj.txdz,v_nb_bd_sj.txdz),
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.txdz,v_nb_bd_dj.txdz,v_nb_bd_sj.txdz)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '1d7e3138a58a4709bb3a328fb767a82e' then--电子邮箱
            v_step:=10;
            update t_hcsxjg set qygsnr=v_nb_gs.mail,BZNR=v_nb_bd_dj.mail ,sjNR=v_nb_bd_sj.mail ,
              hcjg=fun_cal_hcsxjg(o.dbxxly,v_nb_gs.mail,v_nb_bd_dj.mail,v_nb_bd_sj.mail),
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.mail,v_nb_bd_dj.mail,v_nb_bd_sj.mail)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'c47e67dcd4b9445bb962efa7f262149c' then--联系电话
            v_step:=11;
            update t_hcsxjg set qygsnr=v_nb_gs.lxdh,BZNR=v_nb_bd_dj.lxdh ,sjNR=v_nb_bd_sj.lxdh ,
              hcjg=fun_cal_hcsxjg(o.dbxxly,v_nb_gs.lxdh,v_nb_bd_dj.lxdh,v_nb_bd_sj.lxdh),
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.lxdh,v_nb_bd_dj.lxdh,v_nb_bd_sj.lxdh)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '08f630ac1b3947d2ab91e572c3f75e01' then --存续状态 经营状态
            v_step:=12;
            update t_hcsxjg set qygsnr=v_nb_gs.jyzt,BZNR=v_nb_bd_dj.jyzt ,sjNR=v_nb_bd_sj.jyzt ,
              hcjg=fun_cal_hcsxjg(o.dbxxly,v_nb_gs.jyzt,v_nb_bd_dj.jyzt,v_nb_bd_sj.jyzt),
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.jyzt,v_nb_bd_dj.jyzt,v_nb_bd_sj.jyzt)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8588a435261e485eb72f0d986082bfdb' then --邮政编码
            v_step:=13;
            update t_hcsxjg set qygsnr=v_nb_gs.yzbm,BZNR=v_nb_bd_dj.yzbm ,sjNR=v_nb_bd_sj.yzbm ,
              hcjg=fun_cal_hcsxjg(o.dbxxly,v_nb_gs.yzbm,v_nb_bd_dj.yzbm,v_nb_bd_sj.yzbm),
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.yzbm,v_nb_bd_dj.yzbm,v_nb_bd_sj.yzbm)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'ae9230ddad3e4505ac03c966fd8bac3d' then --党建信息
            v_step:=15;
            update t_hcsxjg set hcjg=case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FRSFDY,v_nb_bd_dj.DJ_FRSFDY,v_nb_bd_sj.DJ_FRSFDY)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_LXDH,v_nb_bd_dj.DJ_LXDH,v_nb_bd_sj.DJ_LXDH)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_QTZW,v_nb_bd_dj.DJ_QTZW,v_nb_bd_sj.DJ_QTZW)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_DYZS,v_nb_bd_dj.DJ_DYZS,v_nb_bd_sj.DJ_DYZS)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_ZCDYS,v_nb_bd_dj.DJ_ZCDYS,v_nb_bd_sj.DJ_ZCDYS)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_WZRS,v_nb_bd_dj.DJ_WZRS,v_nb_bd_sj.DJ_WZRS)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FZDYS,v_nb_bd_dj.DJ_FZDYS,v_nb_bd_sj.DJ_FZDYS)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_JJFZS,v_nb_bd_dj.DJ_JJFZS,v_nb_bd_sj.DJ_JJFZS)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_SFJLZZ,v_nb_bd_dj.DJ_SFJLZZ,v_nb_bd_sj.DJ_SFJLZZ)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_WJLZZYY,v_nb_bd_dj.DJ_WJLZZYY,v_nb_bd_sj.DJ_WJLZZYY)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_DZZJZ,v_nb_bd_dj.DJ_DZZJZ,v_nb_bd_sj.DJ_DZZJZ)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FRDBSFDZZSJ,v_nb_bd_dj.DJ_FRDBSFDZZSJ,v_nb_bd_sj.DJ_FRDBSFDZZSJ)=CONS_HCSXJG_TG
              then CONS_HCSXJG_TG else CONS_HCSXJG_BTG end,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FRSFDY,v_nb_bd_dj.DJ_FRSFDY,v_nb_bd_sj.DJ_FRSFDY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_LXDH,v_nb_bd_dj.DJ_LXDH,v_nb_bd_sj.DJ_LXDH)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_QTZW,v_nb_bd_dj.DJ_QTZW,v_nb_bd_sj.DJ_QTZW)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_DYZS,v_nb_bd_dj.DJ_DYZS,v_nb_bd_sj.DJ_DYZS)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_ZCDYS,v_nb_bd_dj.DJ_ZCDYS,v_nb_bd_sj.DJ_ZCDYS)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_WZRS,v_nb_bd_dj.DJ_WZRS,v_nb_bd_sj.DJ_WZRS)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FZDYS,v_nb_bd_dj.DJ_FZDYS,v_nb_bd_sj.DJ_FZDYS)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_JJFZS,v_nb_bd_dj.DJ_JJFZS,v_nb_bd_sj.DJ_JJFZS)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_SFJLZZ,v_nb_bd_dj.DJ_SFJLZZ,v_nb_bd_sj.DJ_SFJLZZ)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_WJLZZYY,v_nb_bd_dj.DJ_WJLZZYY,v_nb_bd_sj.DJ_WJLZZYY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_DZZJZ,v_nb_bd_dj.DJ_DZZJZ,v_nb_bd_sj.DJ_DZZJZ)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.DJ_FRDBSFDZZSJ,v_nb_bd_dj.DJ_FRDBSFDZZSJ,v_nb_bd_sj.DJ_FRDBSFDZZSJ)=CONS_HCSXJG_TG
                then null else v_hcsx_sm end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'ae9230ddad3e4505ac03c966fd8bac3e' then --从业人员信息
            v_step:=16;
            update t_hcsxjg set hcjg=case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.cyrs,v_nb_bd_dj.Cyrs,v_nb_bd_sj.Cyrs)=CONS_HCSXJG_TG
              /*and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.GXBYS_JY,v_nb_bd_dj.GXBYS_JY,v_nb_bd_sj.GXBYS_JY)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.GXBYS_GG,v_nb_bd_dj.GXBYS_GG,v_nb_bd_sj.GXBYS_GG)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.TYSBS_JY,v_nb_bd_dj.TYSBS_JY,v_nb_bd_sj.TYSBS_JY)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.TYSBS_GG,v_nb_bd_dj.TYSBS_GG,v_nb_bd_sj.TYSBS_GG)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.CJRS_JY,v_nb_bd_dj.CJRS_JY,v_nb_bd_sj.CJRS_JY)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.CJRS_GG,v_nb_bd_dj.CJRS_GG,v_nb_bd_sj.CJRS_GG)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZJYS_JY,v_nb_bd_dj.ZJYS_JY,v_nb_bd_sj.ZJYS_JY)=CONS_HCSXJG_TG
              and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZJYS_GG,v_nb_bd_dj.ZJYS_GG,v_nb_bd_sj.ZJYS_GG)=CONS_HCSXJG_TG*/
              then CONS_HCSXJG_TG else CONS_HCSXJG_BTG end,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.GXBYS_JY,v_nb_bd_dj.GXBYS_JY,v_nb_bd_sj.GXBYS_JY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.GXBYS_GG,v_nb_bd_dj.GXBYS_GG,v_nb_bd_sj.GXBYS_GG)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.TYSBS_JY,v_nb_bd_dj.TYSBS_JY,v_nb_bd_sj.TYSBS_JY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.TYSBS_GG,v_nb_bd_dj.TYSBS_GG,v_nb_bd_sj.TYSBS_GG)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.CJRS_JY,v_nb_bd_dj.CJRS_JY,v_nb_bd_sj.CJRS_JY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.CJRS_GG,v_nb_bd_dj.CJRS_GG,v_nb_bd_sj.CJRS_GG)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZJYS_JY,v_nb_bd_dj.ZJYS_JY,v_nb_bd_sj.ZJYS_JY)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZJYS_GG,v_nb_bd_dj.ZJYS_GG,v_nb_bd_sj.ZJYS_GG)=CONS_HCSXJG_TG
                then null else v_hcsx_sm end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8dd2b47ff88046679dabe66012ba1d35' then --资产总额、负债总额等资产财务数据
            v_step:=17;
            update t_hcsxjg set hcjg=case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.SYZQYHJ,v_nb_bd_dj.SYZQYHJ,v_nb_bd_sj.SYZQYHJ)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.LRZE,v_nb_bd_dj.LRZE,v_nb_bd_sj.LRZE)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZYYWSR,v_nb_bd_dj.ZYYWSR,v_nb_bd_sj.ZYYWSR)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.JLR,v_nb_bd_dj.JLR,v_nb_bd_sj.JLR)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.NSZE,v_nb_bd_dj.NSZE,v_nb_bd_sj.NSZE)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.FZZE,v_nb_bd_dj.FZZE,v_nb_bd_sj.FZZE)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZCZE,v_nb_bd_dj.ZCZE,v_nb_bd_sj.ZCZE)=CONS_HCSXJG_TG
                                               and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.YYZSR,v_nb_bd_dj.YYZSR,v_nb_bd_sj.YYZSR)=CONS_HCSXJG_TG
              then CONS_HCSXJG_TG else CONS_HCSXJG_BTG end,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when fun_cal_hcsxjg(o.dbxxly,v_nb_gs.SYZQYHJ,v_nb_bd_dj.SYZQYHJ,v_nb_bd_sj.SYZQYHJ)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.LRZE,v_nb_bd_dj.LRZE,v_nb_bd_sj.LRZE)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZYYWSR,v_nb_bd_dj.ZYYWSR,v_nb_bd_sj.ZYYWSR)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.JLR,v_nb_bd_dj.JLR,v_nb_bd_sj.JLR)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.NSZE,v_nb_bd_dj.NSZE,v_nb_bd_sj.NSZE)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.FZZE,v_nb_bd_dj.FZZE,v_nb_bd_sj.FZZE)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.ZCZE,v_nb_bd_dj.ZCZE,v_nb_bd_sj.ZCZE)=CONS_HCSXJG_TG
                            and fun_cal_hcsxjg(o.dbxxly,v_nb_gs.YYZSR,v_nb_bd_dj.YYZSR,v_nb_bd_sj.YYZSR)=CONS_HCSXJG_TG
                then null else v_hcsx_sm||(select zcb_result from t_hcrw where id=p_HCRWID) end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'cf8c476dad384a078f2278ac24f702f3' then--企业网站及从事经营的网店的名称和网址
            v_step:=18;
            update t_hcsxjg set hcjg=func_cal_hcsxjg_wz(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when func_cal_hcsxjg_wz(p_HCRWID,o.dbxxly)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'c8be232576294f32adc7ee8484b6f60a' then --企业投资设立企业、购买股权信息
            v_step:=19;
            update t_hcsxjg set hcjg=func_cal_hcsxjg_dwtz(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when func_cal_hcsxjg_dwtz(p_HCRWID,o.dbxxly)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '5b76bf93df5d418ca809d3ab77230b38' then --有限公司股东股权转让等股权变更信息
            v_step:=20;
            update t_hcsxjg set hcjg=func_cal_hcsxjg_gqbg(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when func_cal_hcsxjg_gqbg(p_HCRWID,o.dbxxly)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '5634e28ac294407c91ce60a85318ccac' then --对外提供保证担保信息
            v_step:=21;
            update t_hcsxjg set hcjg=func_cal_hcsxjg_dwdb(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when func_cal_hcsxjg_dwdb(p_HCRWID,o.dbxxly)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '0ede0c58e04e4e7d82819e6fb3cdd779' then --股东或发起人认缴和实缴的出资额等信息
            v_step:=23;
            update t_hcsxjg set hcjg=func_cal_hcsxjg_gdcz(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when func_cal_hcsxjg_gdcz(p_HCRWID,o.dbxxly)=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '34A194D475854B32E050A8C085050AD8' then --即时 股东或发起人认缴和实缴信息
            v_step:=24;
            update t_hcsxjg set hcjg=func_cal_js_hcsxjg_gdcz(p_HCRWID,o.dbxxly), dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
            v_step:=25;
            update t_hcsxjg set hcjg=func_cal_js_hcsxjg_gqbg(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
            v_step:=26;
            update t_hcsxjg set hcjg=func_cal_js_hcsxjg_zscq(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
            v_step:=27;
            update t_hcsxjg set hcjg=func_cal_js_hcsxjg_xzcf(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
            v_step:=28;
            update t_hcsxjg set hcjg=func_cal_js_hcsxjg_xzxk(p_HCRWID,o.dbxxly),dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
          else
            null;
          end case;
        end loop;
        /**
        根据HCSXJG表中的数据，更新HCSXJG中的结果状态和HCJH表中的结果状态
        **/
        v_step:=40;
        select count(1) into v_hcsxjg_1 from t_hcsxjg where hcrw_id=p_HCRWID and hcjg=CONS_HCSXJG_TG;
        select count(1) into v_hcsxjg_2 from t_hcsxjg where hcrw_id=p_HCRWID and hcjg=CONS_HCSXJG_BTG;
        v_step:=41;
        if(v_hcsxjg_2>0 and v_hcsxjg_1>0) then--有未通过的事项
          v_step:=42;
          update t_hcrw set HCJIEGUO=null where id=p_HCRWID;
        elsif(v_hcsxjg_2=0 and v_hcsxjg_1>0) then--全部通过 更新任务结果为 正常
          v_step:=43;
          update t_hcrw set HCJIEGUO=1 where id=p_HCRWID;
        elsif(v_hcsxjg_2>=0 and v_hcsxjg_1=0) then--全部未通过
          v_step:=44;
          update t_hcrw set HCJIEGUO=null where id=p_HCRWID;
        else
          v_step:=45;
          update t_hcrw set HCJIEGUO=2 where id=p_HCRWID;--一个事项也没有 更新任务结果为 未按规定公示年报
        end if;
      else
        --未找到公示系统数据，更新任务结果为 未按规定公示年报
        v_step:=50;
        update t_hcrw set HCJIEGUO=2 where id=p_HCRWID;
      end if;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_bidui_hc;
  --即时核查结果比对 根据导入的数据，更新js_HCSXJG表中每个核查事项的内容
  procedure prc_bidui_js_hc(p_HCRWID in varchar2) is
    v_hcsxjg_1 number;--核查事项结果中通过个数
    v_hcsxjg_2 number;--核查事项结果中未通过个数
    v_hcsx_sm t_hcsx_sm.content%type;--核查结果说明
    cursor cur_hcsx is
      select a.id,a.name,a.page,a.hclx,a.dbxxly
      from t_hcsx a where hclx=2;
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    v_jsrw t_js_hcrw%Rowtype;
    begin
      pkg_log.INFO('pkg_hc.prc_bidui_js_hc','比对即时核查数据','比对即时核查数据',p_HCRWID,v_log_xh);
      v_hcsxjg_1:=0;
      v_hcsxjg_2:=0;

      v_step:=0;
      --首先删除HCSXJG内容
      delete from t_js_hcsxjg where hcrw_id=p_HCRWID;
      --取得即时任务信息
      select * into v_jsrw from t_js_hcrw where id=p_HCRWID;
      for o in cur_hcsx loop
        --取得核查事项结果说明
        begin
          select content into v_hcsx_sm from (select * from t_hcsx_sm where hcsx_id=o.id and dbxxly =o.dbxxly order by weight)
          where rownum<=1;
          exception
          when others then
          v_hcsx_sm:=null;
        end;
        case o.id
          when '34A194D475854B32E050A8C085050AD8' then --即时 股东或发起人认缴和实缴信息
          v_step:=24;
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,func_cal_js_hcsxjg_gdcz(p_HCRWID,o.dbxxly),null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
          v_step:=25;
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,func_cal_js_hcsxjg_gqbg(p_HCRWID,o.dbxxly),null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
          v_step:=26;
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,func_cal_js_hcsxjg_zscq(p_HCRWID,o.dbxxly),null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
          v_step:=27;
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,func_cal_js_hcsxjg_xzcf(p_HCRWID,o.dbxxly),null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
          v_step:=28;
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,func_cal_js_hcsxjg_xzxk(p_HCRWID,o.dbxxly),null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
        else
          null;
        end case;
      end loop;
      /**
      根据HCSXJG表中的数据，更新HCSXJG中的结果状态和HCJH表中的结果状态
      **/
      v_step:=40;
      select count(1) into v_hcsxjg_1 from t_js_hcsxjg where hcrw_id=p_HCRWID and hcjg=CONS_HCSXJG_TG;
      select count(1) into v_hcsxjg_2 from t_js_hcsxjg where hcrw_id=p_HCRWID and hcjg=CONS_HCSXJG_BTG;
      v_step:=41;
      if(v_hcsxjg_2>0 and v_hcsxjg_1>0) then--有未通过的事项
        v_step:=42;
        update t_js_hcrw set HCJIEGUO=null where id=p_HCRWID;
      elsif(v_hcsxjg_2=0 and v_hcsxjg_1>0) then--全部通过 更新任务结果为 正常
        v_step:=43;
        update t_js_hcrw set HCJIEGUO=1 where id=p_HCRWID;
      elsif(v_hcsxjg_2>=0 and v_hcsxjg_1=0) then--全部未通过
        v_step:=44;
        update t_js_hcrw set HCJIEGUO=null where id=p_HCRWID;
      else
        v_step:=45;
        update t_js_hcrw set HCJIEGUO=2 where id=p_HCRWID;--一个事项也没有 更新任务结果为 未按规定公示年报
      end if;

      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_bidui_js_hc;
  --取得核查事项结果内容，根据ID不同，取得详细的内容并组织成JSON字符串返回，供报表使用
  procedure prc_getHcsxjg(p_HCRWID in varchar2,p_out out clob) is
    v_hcsxjg clob;
    v_qygsnr clob;
    v_bznr clob;
    v_sjnr clob;
    v_t_nb t_nb%rowtype;
    v_t_nb_bd_1 t_nb_bd%rowtype;
    v_t_nb_bd_2 t_nb_bd%rowtype;
    v_t_hcrw t_hcrw%rowtype;
    v_t_hcsxjg t_hcsxjg%rowtype;
    v_cnt number;

    cursor cur_hcsx is
      select a.hcsx_id,a.hcrw_id,a.name,a.hcjg,a.hcfs,a.qygsnr,a.bznr,a.sjnr,a.hczt,a.sm,a.page,a.hclx,
        (select b.dbxxly from t_hcsx b where b.id=a.hcsx_id) dbxxly,
        (select hcxxfl from t_hcsx b where b.id=a.hcsx_id) hcxxfl
      from t_hcsxjg a where hcrw_id=p_HCRWID;
    begin
      --取得任务信息
      select * into v_t_hcrw from t_hcrw where id=p_HCRWID;
      --初始化返回值
      p_out:='[';
      --单独取出T_NB数据
      select * into v_t_nb from t_nb where nd=v_t_hcrw.nd and xydm=v_t_hcrw.hcdw_xydm;
      begin
        select * into v_t_nb_bd_1 from t_nb_bd where nd=v_t_hcrw.nd and xydm=v_t_hcrw.hcdw_xydm and sjly=1;
        exception
        when others then
        v_t_nb_bd_1:=null;
      end;
      begin
        select * into v_t_nb_bd_2 from t_nb_bd where nd=v_t_hcrw.nd and xydm=v_t_hcrw.hcdw_xydm and sjly=2;
        exception
        when others then
        v_t_nb_bd_2:=null;
      end;
      --循环取得核查事项结果内容
      for o in cur_hcsx loop
        v_hcsxjg:='{"hcsxId":"'||o.hcsx_id||'",';
        v_hcsxjg:=v_hcsxjg||'"hcrwId":"'||o.hcrw_id||'",';
        v_hcsxjg:=v_hcsxjg||'"name":"'||o.name||'",';
        v_hcsxjg:=v_hcsxjg||'"hcjg":"'||o.hcjg||'",';
        v_hcsxjg:=v_hcsxjg||'"hcfs":"'||o.hcfs||'",';
        v_hcsxjg:=v_hcsxjg||'"hczt":"'||o.hczt||'",';
        v_hcsxjg:=v_hcsxjg||'"sm":"'||o.sm||'",';
        v_hcsxjg:=v_hcsxjg||'"page":"'||o.page||'",';
        v_hcsxjg:=v_hcsxjg||'"hclx":"'||o.hclx||'",';
        v_hcsxjg:=v_hcsxjg||'"dbxxly":"'||o.dbxxly||'",';
        v_hcsxjg:=v_hcsxjg||'"hcxxfl":"'||o.hcxxfl||'",';
        case o.hcsx_id
          when '10a5cbafa03044239b8bedafb301d0a8' then--企业通信地址
          v_qygsnr:='"qygsnr":"'||o.qygsnr||'"';
          v_bznr:='"bznr":"'||o.bznr||'"';
          v_sjnr:='"sjnr":"'||o.sjnr||'"';
          when '1d7e3138a58a4709bb3a328fb767a82e' then--电子邮箱
          v_qygsnr:='"qygsnr":"'||o.qygsnr||'"';
          v_bznr:='"bznr":"'||o.bznr||'"';
          v_sjnr:='"sjnr":"'||o.sjnr||'"';
          when 'c47e67dcd4b9445bb962efa7f262149c' then--联系电话
          v_qygsnr:='"qygsnr":"'||o.qygsnr||'"';
          v_bznr:='"bznr":"'||o.bznr||'"';
          v_sjnr:='"sjnr":"'||o.sjnr||'"';
          when '08f630ac1b3947d2ab91e572c3f75e01' then --存续状态 经营状态
          v_qygsnr:='"qygsnr":"'||o.qygsnr||'"';
          v_bznr:='"bznr":"'||o.bznr||'"';
          v_sjnr:='"sjnr":"'||o.sjnr||'"';
          when '8588a435261e485eb72f0d986082bfdb' then --邮政编码
          v_qygsnr:='"qygsnr":"'||o.qygsnr||'"';
          v_bznr:='"bznr":"'||o.bznr||'"';
          v_sjnr:='"sjnr":"'||o.sjnr||'"';
          when 'ae9230ddad3e4505ac03c966fd8bac3d' then --党建信息
          v_qygsnr:='"qygsnr":"'||v_t_nb.DJ_FRSFDY||','
                    ||v_t_nb.DJ_LXDH||','
                    ||v_t_nb.DJ_QTZW||','
                    ||v_t_nb.DJ_LXDH||','
                    ||v_t_nb.DJ_DYZS||','
                    ||v_t_nb.DJ_WZRS||','
                    ||v_t_nb.DJ_FZDYS||','
                    ||v_t_nb.DJ_JJFZS||','
                    ||v_t_nb.DJ_SFJLZZ||','
                    ||v_t_nb.DJ_WJLZZYY||','
                    ||v_t_nb.DJ_DZZJZ||','
                    ||v_t_nb.DJ_FRDBSFDZZSJ
                    ||'"';
          v_bznr:='"bznr":"'||v_t_nb_bd_1.DJ_FRSFDY||','
                  ||v_t_nb_bd_1.DJ_LXDH||','
                  ||v_t_nb_bd_1.DJ_QTZW||','
                  ||v_t_nb_bd_1.DJ_LXDH||','
                  ||v_t_nb_bd_1.DJ_DYZS||','
                  ||v_t_nb_bd_1.DJ_WZRS||','
                  ||v_t_nb_bd_1.DJ_FZDYS||','
                  ||v_t_nb_bd_1.DJ_JJFZS||','
                  ||v_t_nb_bd_1.DJ_SFJLZZ||','
                  ||v_t_nb_bd_1.DJ_WJLZZYY||','
                  ||v_t_nb_bd_1.DJ_DZZJZ||','
                  ||v_t_nb_bd_1.DJ_FRDBSFDZZSJ
                  ||'"';
          v_sjnr:='"sjnr":"'||v_t_nb_bd_2.DJ_FRSFDY||','
                  ||v_t_nb_bd_2.DJ_LXDH||','
                  ||v_t_nb_bd_2.DJ_QTZW||','
                  ||v_t_nb_bd_2.DJ_LXDH||','
                  ||v_t_nb_bd_2.DJ_DYZS||','
                  ||v_t_nb_bd_2.DJ_WZRS||','
                  ||v_t_nb_bd_2.DJ_FZDYS||','
                  ||v_t_nb_bd_2.DJ_JJFZS||','
                  ||v_t_nb_bd_2.DJ_SFJLZZ||','
                  ||v_t_nb_bd_2.DJ_WJLZZYY||','
                  ||v_t_nb_bd_2.DJ_DZZJZ||','
                  ||v_t_nb_bd_2.DJ_FRDBSFDZZSJ
                  ||'"';
          when 'ae9230ddad3e4505ac03c966fd8bac3e' then --从业人员信息
          v_qygsnr:='"qygsnr":"'||v_t_nb.cyrs
                    /*||','v_t_nb.GXBYS_JY||','
                    ||v_t_nb.GXBYS_GG||','
                    ||v_t_nb.TYSBS_JY||','
                    ||v_t_nb.TYSBS_GG||','
                    ||v_t_nb.CJRS_JY||','
                    ||v_t_nb.CJRS_GG||','
                    ||v_t_nb.ZJYS_JY||','
                    ||v_t_nb.ZJYS_GG*/
                    ||'"';
          v_bznr:='"bznr":"'||v_t_nb_bd_1.cyrs
                  /*||','v_t_nb_bd_1.GXBYS_JY||','
                  ||v_t_nb_bd_1.GXBYS_GG||','
                  ||v_t_nb_bd_1.TYSBS_JY||','
                  ||v_t_nb_bd_1.TYSBS_GG||','
                  ||v_t_nb_bd_1.CJRS_JY||','
                  ||v_t_nb_bd_1.CJRS_GG||','
                  ||v_t_nb_bd_1.ZJYS_JY||','
                  ||v_t_nb_bd_1.ZJYS_GG*/
                  ||'"';
          v_sjnr:='"sjnr":"'||v_t_nb_bd_2.cyrs
                  /*||','v_t_nb_bd_2.GXBYS_JY||','
                  ||v_t_nb_bd_2.GXBYS_GG||','
                  ||v_t_nb_bd_2.TYSBS_JY||','
                  ||v_t_nb_bd_2.TYSBS_GG||','
                  ||v_t_nb_bd_2.CJRS_JY||','
                  ||v_t_nb_bd_2.CJRS_GG||','
                  ||v_t_nb_bd_2.ZJYS_JY||','
                  ||v_t_nb_bd_2.ZJYS_GG*/
                  ||'"';
          when '8dd2b47ff88046679dabe66012ba1d35' then --资产总额、负债总额等资产财务数据
          v_qygsnr:='"qygsnr":"'||v_t_nb.SYZQYHJ||','
                    ||v_t_nb.LRZE||','
                    ||v_t_nb.ZYYWSR||','
                    ||v_t_nb.JLR||','
                    ||v_t_nb.NSZE||','
                    ||v_t_nb.FZZE||','
                    ||v_t_nb.ZCZE||','
                    ||v_t_nb.YYZSR
                    ||'"';
          v_bznr:='"bznr":"'||v_t_nb_bd_1.SYZQYHJ||','
                  ||v_t_nb_bd_1.LRZE||','
                  ||v_t_nb_bd_1.ZYYWSR||','
                  ||v_t_nb_bd_1.JLR||','
                  ||v_t_nb_bd_1.NSZE||','
                  ||v_t_nb_bd_1.FZZE||','
                  ||v_t_nb_bd_1.ZCZE||','
                  ||v_t_nb_bd_1.YYZSR
                  ||'"';
          v_sjnr:='"sjnr":"'||v_t_nb_bd_2.SYZQYHJ||','
                  ||v_t_nb_bd_2.LRZE||','
                  ||v_t_nb_bd_2.ZYYWSR||','
                  ||v_t_nb_bd_2.JLR||','
                  ||v_t_nb_bd_2.NSZE||','
                  ||v_t_nb_bd_2.FZZE||','
                  ||v_t_nb_bd_2.ZCZE||','
                  ||v_t_nb_bd_2.YYZSR
                  ||'"';
          when 'cf8c476dad384a078f2278ac24f702f3' then--企业网站及从事经营的网店的名称和网址
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_wd where HCRW_ID=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_nb_wd where HCRW_ID=p_HCRWID) loop
              v_qygsnr:=v_qygsnr||o.type||','
                        ||o.NAME||','
                        ||o.WZ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=1) loop
              v_bznr:=v_bznr||o.type||','
                      ||o.NAME||','
                      ||o.WZ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_wd where HCRW_ID=p_HCRWID and sjly=2) loop
              v_sjnr:=v_sjnr||o.type||','
                      ||o.NAME||','
                      ||o.WZ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when 'c8be232576294f32adc7ee8484b6f60a' then --企业投资设立企业、购买股权信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_dwtz where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_nb_dwtz where hcrw_id=p_HCRWID) loop
              v_qygsnr:=v_qygsnr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_dwtz where hcrw_id=p_HCRWID and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwtz where hcrw_id=p_HCRWID and sjly=1) loop
              v_bznr:=v_bznr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_dwtz where hcrw_id=p_HCRWID and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwtz where hcrw_id=p_HCRWID and sjly=2) loop
              v_sjnr:=v_sjnr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '5b76bf93df5d418ca809d3ab77230b38' then --有限公司股东股权转让等股权变更信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_gqbg where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_nb_gqbg where hcrw_id=p_HCRWID) loop
              v_qygsnr:=v_qygsnr||o.gd||','
                        ||o.bgq_gqbl||','
                        ||o.bgh_gqbl||','
                        ||o.bgrq
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_gqbg where hcrw_id=p_HCRWID and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gqbg where hcrw_id=p_HCRWID and sjly=1) loop
              v_bznr:=v_bznr||o.gd||','
                      ||o.bgq_gqbl||','
                      ||o.bgh_gqbl||','
                      ||o.bgrq
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_gqbg where hcrw_id=p_HCRWID and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gqbg where hcrw_id=p_HCRWID and sjly=2) loop
              v_sjnr:=v_sjnr||o.gd||','
                      ||o.bgq_gqbl||','
                      ||o.bgh_gqbl||','
                      ||o.bgrq
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '5634e28ac294407c91ce60a85318ccac' then --对外提供保证担保信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_dwdb where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_nb_dwdb where hcrw_id=p_HCRWID ) loop
              v_qygsnr:=v_qygsnr||o.ZQR||','
                        ||o.ZWR||','
                        ||o.ZZQZL||','
                        ||o.ZZQSE||','
                        ||o.LXZWQX||','
                        ||o.BZQJ||','
                        ||o.BZFS||','
                        ||o.BZDBFW
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_dwdb where hcrw_id=p_HCRWID and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwdb where hcrw_id=p_HCRWID and sjly=1) loop
              v_bznr:=v_bznr||o.ZQR||','
                      ||o.ZWR||','
                      ||o.ZZQZL||','
                      ||o.ZZQSE||','
                      ||o.LXZWQX||','
                      ||o.BZQJ||','
                      ||o.BZFS||','
                      ||o.BZDBFW
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_dwdb where hcrw_id=p_HCRWID and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwdb where hcrw_id=p_HCRWID and sjly=2) loop
              v_sjnr:='"sjnr":"'||o.ZQR||','
                      ||o.ZWR||','
                      ||o.ZZQZL||','
                      ||o.ZZQSE||','
                      ||o.LXZWQX||','
                      ||o.BZQJ||','
                      ||o.BZFS||','
                      ||o.BZDBFW
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '0ede0c58e04e4e7d82819e6fb3cdd779' then --股东或发起人认缴和实缴的出资额等信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_gdcz where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_nb_gdcz where hcrw_id=p_HCRWID) loop
              v_qygsnr:=v_qygsnr||o.GD||','
                        ||o.RJCZE||','
                        ||o.RJCZDQSJ||','
                        ||o.RJCZFS||','
                        ||o.SJCZE||','
                        ||o.SJCZSJ||','
                        ||o.SJCZFS
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_gdcz where hcrw_id=p_HCRWID and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gdcz where hcrw_id=p_HCRWID and sjly=1) loop
              v_bznr:=v_bznr||o.GD||','
                      ||o.RJCZE||','
                      ||o.RJCZDQSJ||','
                      ||o.RJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZSJ||','
                      ||o.SJCZFS
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_gdcz where hcrw_id=p_HCRWID and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gdcz where hcrw_id=p_HCRWID and sjly=2) loop
              v_sjnr:=v_sjnr||o.GD||','
                      ||o.RJCZE||','
                      ||o.RJCZDQSJ||','
                      ||o.RJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZSJ||','
                      ||o.SJCZFS
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '34A194D475854B32E050A8C085050AD8' then --即时 股东或发起人认缴和实缴信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_gdcz where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSGS;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where hcrw_id=p_HCRWID  and sjly=CONS_HCSXJG_DBXXLY_JSGS) loop
              v_qygsnr:=v_qygsnr||o.GD||','
                        ||o.BGRQ||','
                        ||o.RJE||','
                        ||o.SJE||','
                        ||o.GSSJ||','
                        ||o.RJCZFS||','
                        ||o.RJCZE||','
                        ||o.RJCZRQ||','
                        ||o.SJCZFS||','
                        ||o.SJCZE||','
                        ||o.SJCZRQ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_gdcz where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_gdcz where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.GD||','
                      ||o.BGRQ||','
                      ||o.RJE||','
                      ||o.SJE||','
                      ||o.GSSJ||','
                      ||o.RJCZFS||','
                      ||o.RJCZE||','
                      ||o.RJCZRQ||','
                      ||o.SJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZRQ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_gdcz where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSSJ;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where hcrw_id=p_HCRWID  and sjly=CONS_HCSXJG_DBXXLY_JSSJ) loop
              v_sjnr:=v_sjnr||o.GD||','
                      ||o.BGRQ||','
                      ||o.RJE||','
                      ||o.SJE||','
                      ||o.GSSJ||','
                      ||o.RJCZFS||','
                      ||o.RJCZE||','
                      ||o.RJCZRQ||','
                      ||o.SJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZRQ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.GD||','
                        ||o.BGRQ||','
                        ||o.BGQBL||','
                        ||o.BGHBL||','
                        ||o.GSSJ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_gqbg where hcrw_id=p_HCRWID ;
          if(v_cnt>0) then
            for o in(select * from t_js_gqbg where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.GD||','
                      ||o.BGRQ||','
                      ||o.BGQBL||','
                      ||o.BGHBL||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.GD||','
                      ||o.BGRQ||','
                      ||o.BGQBL||','
                      ||o.BGHBL||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.CZRMC||','
                        ||o.ZL||','
                        ||o.QYMC||','
                        ||o.ZQRMC||','
                        ||o.ZQDJRQ||','
                        ||o.ZT||','
                        ||o.GSSJ||','
                        ||o.BHQK
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_zscq where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_zscq where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.CZRMC||','
                      ||o.ZL||','
                      ||o.QYMC||','
                      ||o.ZQRMC||','
                      ||o.ZQDJRQ||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.BHQK
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.CZRMC||','
                      ||o.ZL||','
                      ||o.QYMC||','
                      ||o.ZQRMC||','
                      ||o.ZQDJRQ||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.BHQK
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.XZCFJDSWH||','
                        ||o.WFLX||','
                        ||o.XZCFNR||','
                        ||o.CFJG||','
                        ||o.CFRQ||','
                        ||o.BZ||','
                        ||o.GSSJ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_xzcf where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_xzcf where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.XZCFJDSWH||','
                      ||o.WFLX||','
                      ||o.XZCFNR||','
                      ||o.CFJG||','
                      ||o.CFRQ||','
                      ||o.BZ||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.XZCFJDSWH||','
                      ||o.WFLX||','
                      ||o.XZCFNR||','
                      ||o.CFJG||','
                      ||o.CFRQ||','
                      ||o.BZ||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.XKWJBH||','
                        ||o.YXQ_KS||','
                        ||o.YXQ_JS||','
                        ||o.XKWJMC||','
                        ||o.XKJG||','
                        ||o.XKNR||','
                        ||o.ZT||','
                        ||o.GSSJ||','
                        ||o.XQ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_xzxk where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_xzxk where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.XKWJBH||','
                      ||o.YXQ_KS||','
                      ||o.YXQ_JS||','
                      ||o.XKWJMC||','
                      ||o.XKJG||','
                      ||o.XKNR||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.XQ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_sjnr:=v_sjnr||o.XKWJBH||','
                      ||o.YXQ_KS||','
                      ||o.YXQ_JS||','
                      ||o.XKWJMC||','
                      ||o.XKJG||','
                      ||o.XKNR||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.XQ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
        else
          null;
        end case;
        v_hcsxjg:=v_hcsxjg||v_qygsnr||','||v_bznr||','||v_sjnr||'},';
        p_out:=p_out||v_hcsxjg;
      end loop;
      dbms_output.put_line(p_out);
      --返回财务明细信息(资产总额、负债总额等资产财务数据)
      select * into v_t_hcsxjg from t_hcsxjg where hcrw_id=p_HCRWID and hcsx_id='8dd2b47ff88046679dabe66012ba1d35';
      v_hcsxjg:='{"hcsxId":"'||'8dd2b47ff88046679dabe66012ba1d35'||'",';
      v_hcsxjg:=v_hcsxjg||'"hcrwId":"'||v_t_hcsxjg.HCRW_ID||'",';
      v_hcsxjg:=v_hcsxjg||'"hcfs":"'||v_t_hcsxjg.hcfs||'",';
      v_hcsxjg:=v_hcsxjg||'"hczt":"'||v_t_hcsxjg.hczt||'",';
      v_hcsxjg:=v_hcsxjg||'"sm":"'||v_t_hcsxjg.sm||'",';
      v_hcsxjg:=v_hcsxjg||'"page":"'||v_t_hcsxjg.page||'",';
      v_hcsxjg:=v_hcsxjg||'"hclx":"'||v_t_hcsxjg.hclx||'",';
      v_hcsxjg:=v_hcsxjg||'"dbxxly":"'||v_t_hcsxjg.dbxxly||'",';
      v_hcsxjg:=v_hcsxjg||'"hcxxfl":"'||''||'",';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.ZCZE,0),nvl(v_t_nb_bd_1.ZCZE,0),nvl(v_t_nb_bd_2.ZCZE,0))||'",';
      p_out:=p_out||'"name":"'||'资产总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.ZCZE||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.ZCZE||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.ZCZE||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.FZZE,0),nvl(v_t_nb_bd_1.FZZE,0),nvl(v_t_nb_bd_2.FZZE,0))||'",';
      p_out:=p_out||'"name":"'||'负债总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.FZZE||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.FZZE||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.FZZE||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.SYZQYHJ,0),nvl(v_t_nb_bd_1.SYZQYHJ,0),nvl(v_t_nb_bd_2.SYZQYHJ,0))||'",';
      p_out:=p_out||'"name":"'||'所有者权益合计（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.SYZQYHJ||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.SYZQYHJ||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.SYZQYHJ||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.YYZSR,0),nvl(v_t_nb_bd_1.YYZSR,0),nvl(v_t_nb_bd_2.YYZSR,0))||'",';
      p_out:=p_out||'"name":"'||'营业总收入（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.YYZSR||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.YYZSR||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.YYZSR||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.ZYYWSR,0),nvl(v_t_nb_bd_1.ZYYWSR,0),nvl(v_t_nb_bd_2.ZYYWSR,0))||'",';
      p_out:=p_out||'"name":"'||'主营业务收入（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.ZYYWSR||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.ZYYWSR||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.ZYYWSR||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.LRZE,0),nvl(v_t_nb_bd_1.LRZE,0),nvl(v_t_nb_bd_2.LRZE,0))||'",';
      p_out:=p_out||'"name":"'||'利润总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.LRZE||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.LRZE||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.LRZE||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.JLR,0),nvl(v_t_nb_bd_1.JLR,0),nvl(v_t_nb_bd_2.JLR,0))||'",';
      p_out:=p_out||'"name":"'||'净利润（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.JLR||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.JLR||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.JLR||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      p_out:=p_out||'"name":"'||'纳税总额（万元）'||'",';
      p_out:=p_out||'"hcjg":"'||func_cal_nb_compare_result(v_t_hcsxjg.dbxxly,nvl(v_t_nb.NSZE,0),nvl(v_t_nb_bd_1.NSZE,0),nvl(v_t_nb_bd_2.NSZE,0))||'",';
      p_out:=p_out||'"qygsnr":"'||v_t_nb.NSZE||'"'||',';
      p_out:=p_out||'"bznr":"'||v_t_nb_bd_1.NSZE||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_t_nb_bd_2.NSZE||'"'||'},';
      p_out:=substr(p_out,1,length(p_out)-1)||']';
    end prc_getHcsxjg;
  --取得核查事项结果内容，根据ID不同，取得详细的内容并组织成JSON字符串返回，供报表使用
  procedure prc_js_getHcsxjg(p_HCRWID in varchar2,p_out out clob) is
    v_hcsxjg clob;
    v_qygsnr clob;
    v_bznr clob;
    v_sjnr clob;
    v_t_hcrw t_js_hcrw%rowtype;
    v_cnt number;

    cursor cur_hcsx is
      select a.hcsx_id,a.hcrw_id,a.name,a.hcjg,a.hcfs,a.qygsnr,a.bznr,a.sjnr,a.hczt,a.sm,a.page,a.hclx,
        (select b.dbxxly from t_hcsx b where b.id=a.hcsx_id) dbxxly,
        (select hcxxfl from t_hcsx b where b.id=a.hcsx_id) hcxxfl
      from t_js_hcsxjg a where hcrw_id=p_HCRWID;
    begin
      --取得任务信息
      select * into v_t_hcrw from t_js_hcrw where id=p_HCRWID;
      --初始化返回值
      p_out:='[';
      --循环取得核查事项结果内容
      for o in cur_hcsx loop
        v_hcsxjg:='{"hcsxId":"'||o.hcsx_id||'",';
        v_hcsxjg:=v_hcsxjg||'"hcrwId":"'||o.hcrw_id||'",';
        v_hcsxjg:=v_hcsxjg||'"name":"'||o.name||'",';
        v_hcsxjg:=v_hcsxjg||'"hcjg":"'||o.hcjg||'",';
        v_hcsxjg:=v_hcsxjg||'"hcfs":"'||o.hcfs||'",';
        v_hcsxjg:=v_hcsxjg||'"hczt":"'||o.hczt||'",';
        v_hcsxjg:=v_hcsxjg||'"sm":"'||o.sm||'",';
        v_hcsxjg:=v_hcsxjg||'"page":"'||o.page||'",';
        v_hcsxjg:=v_hcsxjg||'"hclx":"'||o.hclx||'",';
        v_hcsxjg:=v_hcsxjg||'"dbxxly":"'||o.dbxxly||'",';
        v_hcsxjg:=v_hcsxjg||'"hcxxfl":"'||o.hcxxfl||'",';
        case o.hcsx_id
          when '34A194D475854B32E050A8C085050AD8' then --即时 股东或发起人认缴和实缴信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_gdcz where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSGS;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where hcrw_id=p_HCRWID  and sjly=CONS_HCSXJG_DBXXLY_JSGS) loop
              v_qygsnr:=v_qygsnr||o.GD||','
                        ||o.BGRQ||','
                        ||o.RJE||','
                        ||o.SJE||','
                        ||o.GSSJ||','
                        ||o.RJCZFS||','
                        ||o.RJCZE||','
                        ||o.RJCZRQ||','
                        ||o.SJCZFS||','
                        ||o.SJCZE||','
                        ||o.SJCZRQ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_gdcz where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_gdcz where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.GD||','
                      ||o.BGRQ||','
                      ||o.RJE||','
                      ||o.SJE||','
                      ||o.GSSJ||','
                      ||o.RJCZFS||','
                      ||o.RJCZE||','
                      ||o.RJCZRQ||','
                      ||o.SJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZRQ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_gdcz where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSSJ;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where hcrw_id=p_HCRWID  and sjly=CONS_HCSXJG_DBXXLY_JSSJ) loop
              v_sjnr:=v_sjnr||o.GD||','
                      ||o.BGRQ||','
                      ||o.RJE||','
                      ||o.SJE||','
                      ||o.GSSJ||','
                      ||o.RJCZFS||','
                      ||o.RJCZE||','
                      ||o.RJCZRQ||','
                      ||o.SJCZFS||','
                      ||o.SJCZE||','
                      ||o.SJCZRQ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.GD||','
                        ||o.BGRQ||','
                        ||o.BGQBL||','
                        ||o.BGHBL||','
                        ||o.GSSJ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_gqbg where hcrw_id=p_HCRWID ;
          if(v_cnt>0) then
            for o in(select * from t_js_gqbg where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.GD||','
                      ||o.BGRQ||','
                      ||o.BGQBL||','
                      ||o.BGHBL||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.GD||','
                      ||o.BGRQ||','
                      ||o.BGQBL||','
                      ||o.BGHBL||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.CZRMC||','
                        ||o.ZL||','
                        ||o.QYMC||','
                        ||o.ZQRMC||','
                        ||o.ZQDJRQ||','
                        ||o.ZT||','
                        ||o.GSSJ||','
                        ||o.BHQK
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_zscq where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_zscq where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.CZRMC||','
                      ||o.ZL||','
                      ||o.QYMC||','
                      ||o.ZQRMC||','
                      ||o.ZQDJRQ||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.BHQK
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.CZRMC||','
                      ||o.ZL||','
                      ||o.QYMC||','
                      ||o.ZQRMC||','
                      ||o.ZQDJRQ||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.BHQK
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.XZCFJDSWH||','
                        ||o.WFLX||','
                        ||o.XZCFNR||','
                        ||o.CFJG||','
                        ||o.CFRQ||','
                        ||o.BZ||','
                        ||o.GSSJ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_xzcf where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_xzcf where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.XZCFJDSWH||','
                      ||o.WFLX||','
                      ||o.XZCFNR||','
                      ||o.CFJG||','
                      ||o.CFRQ||','
                      ||o.BZ||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
              v_sjnr:=v_sjnr||o.XZCFJDSWH||','
                      ||o.WFLX||','
                      ||o.XZCFNR||','
                      ||o.CFJG||','
                      ||o.CFRQ||','
                      ||o.BZ||','
                      ||o.GSSJ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_qygsnr:=v_qygsnr||o.XKWJBH||','
                        ||o.YXQ_KS||','
                        ||o.YXQ_JS||','
                        ||o.XKWJMC||','
                        ||o.XKJG||','
                        ||o.XKNR||','
                        ||o.ZT||','
                        ||o.GSSJ||','
                        ||o.XQ
                        ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_js_xzxk where hcrw_id=p_HCRWID;
          if(v_cnt>0) then
            for o in(select * from t_js_xzxk where hcrw_id=p_HCRWID) loop
              v_bznr:=v_bznr||o.XKWJBH||','
                      ||o.YXQ_KS||','
                      ||o.YXQ_JS||','
                      ||o.XKWJMC||','
                      ||o.XKJG||','
                      ||o.XKNR||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.XQ
                      ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where hcrw_id=p_HCRWID and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
              v_sjnr:=v_sjnr||o.XKWJBH||','
                      ||o.YXQ_KS||','
                      ||o.YXQ_JS||','
                      ||o.XKWJMC||','
                      ||o.XKJG||','
                      ||o.XKNR||','
                      ||o.ZT||','
                      ||o.GSSJ||','
                      ||o.XQ
                      ||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
        else
          null;
        end case;
        v_hcsxjg:=v_hcsxjg||v_qygsnr||','||v_bznr||','||v_sjnr||'},';
        p_out:=p_out||v_hcsxjg;
      end loop;
      p_out:=substr(p_out,1,length(p_out)-1)||']';
    end prc_js_getHcsxjg;
  --插入可用的核查事项
  procedure prc_insertAvailableAuditItem(p_hcjhId in varchar2) is
    v_hcjh t_hcjh%rowtype;
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_hc.prc_insertAvailableAuditItem','插入可用的核查事项','插入可用的核查事项',p_hcjhId,v_log_xh);
      select * into v_hcjh from t_hcjh where id=p_hcjhid;
      if(v_hcjh.nr=3) then
        insert into t_hcjh_hcsx(hcsx_id,hcjh_id)
          select p_hcjhId,id from t_hcsx a
          where not exists(select 1 from t_hcjh_hcsx b where b.hcjh_id=p_hcjhId and b.hcsx_id=a.id);
      else
        insert into t_hcjh_hcsx(hcsx_id,hcjh_id)
          select p_hcjhId,id from t_hcsx a
          where not exists(select 1 from t_hcjh_hcsx b where b.hcjh_id=p_hcjhId and b.hcsx_id=a.id)
                and a.hclx=v_hcjh.nr;
      end if;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_insertAvailableAuditItem;

begin
  -- Initialization
  execute immediate 'alter session set nls_date_format=''yyyy-mm-dd hh24:mi:ss''';
  null;
end pkg_hc;
