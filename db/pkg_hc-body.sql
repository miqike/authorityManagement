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
  --转换字符串成日期
  function func_convertToDate(dateStr in varchar2) return date is
    FunctionResult date;
    v_year number;
    v_month number;
    v_day number;
    v_dateStrNew varchar2(100);
    begin
      v_dateStrNew:=dateStr;
      v_year:=substr(v_dateStrNew,1,instr(v_dateStrNew,'-')-1);

      v_dateStrNew:=substr(v_dateStrNew,instr(v_dateStrNew,'-')+1,length(v_dateStrNew));
      v_month:=substr(v_dateStrNew,1,instr(v_dateStrNew,'-')-1);
      v_month:=100+v_month;

      v_dateStrNew:=substr(v_dateStrNew,instr(v_dateStrNew,'-')+1,length(v_dateStrNew));
      v_day:=v_dateStrNew;
      v_day:=100+v_day;

      FunctionResult:=to_date(v_year||'-'||substr(to_char(v_month),2)||'-'||substr(to_char(v_day),2),'yyyy-mm-dd');
      return FunctionResult;
      exception
      when others then
      return null;
    end func_convertToDate;
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
  --计算对比结果
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
  --计算核查结果 通信地址
  function func_cal_hcsxjg_address(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_gs:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.txdz||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.txdz||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.txdz||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if instr(v_nb_bd_dj.txdz,v_nb_gs.txdz)>0 and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if instr(v_nb_bd_sj.txdz,v_nb_gs.txdz)>0 and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if instr(v_nb_bd_dj.txdz,v_nb_gs.txdz)>0 and instr(v_nb_bd_sj.txdz,v_nb_gs.txdz)>0 and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_address;
  --计算核查结果 电子邮箱
  function func_cal_hcsxjg_dzyx(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.mail||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.mail||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.mail||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_bd_dj.mail=v_nb_gs.mail and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_bd_sj.mail=v_nb_gs.mail and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_bd_dj.mail=v_nb_gs.mail and v_nb_bd_sj.mail=v_nb_gs.mail and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_dzyx;
  --计算核查结果 联系电话
  function func_cal_hcsxjg_lxdh(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.lxdh||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.lxdh||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.lxdh||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_bd_dj.lxdh=v_nb_gs.lxdh and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_bd_sj.lxdh=v_nb_gs.lxdh and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_bd_dj.lxdh=v_nb_gs.lxdh and v_nb_bd_sj.lxdh=v_nb_gs.lxdh and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_lxdh;
  --计算核查结果 经营状态
  function func_cal_hcsxjg_jyzt(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.jyzt||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.jyzt||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.jyzt||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_bd_dj.jyzt=v_nb_gs.jyzt and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_bd_sj.jyzt=v_nb_gs.jyzt and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_bd_dj.jyzt=v_nb_gs.jyzt and v_nb_bd_sj.jyzt=v_nb_gs.jyzt and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_jyzt;
  --计算核查结果 邮政编码
  function func_cal_hcsxjg_yzbm(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.yzbm||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.yzbm||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.yzbm||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_bd_dj.yzbm=v_nb_gs.yzbm and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_bd_sj.yzbm=v_nb_gs.yzbm and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_bd_dj.yzbm=v_nb_gs.yzbm and v_nb_bd_sj.yzbm=v_nb_gs.yzbm and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_yzbm;
  --计算核查结果 党建信息
  function func_cal_hcsxjg_djxx(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.DJ_FRSFDY||','||v_nb_gs.DJ_LXDH||','||v_nb_gs.DJ_QTZW||','||v_nb_gs.DJ_DYZS||','||v_nb_gs.DJ_ZCDYS||','||v_nb_gs.DJ_WZRS||','||v_nb_gs.DJ_FZDYS||','||v_nb_gs.DJ_JJFZS||','||v_nb_gs.DJ_SFJLZZ||','||v_nb_gs.DJ_WJLZZYY||','||v_nb_gs.DJ_DZZJZ||','||v_nb_gs.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.DJ_FRSFDY||','||v_nb_bd_dj.DJ_LXDH||','||v_nb_bd_dj.DJ_QTZW||','||v_nb_bd_dj.DJ_DYZS||','||v_nb_bd_dj.DJ_ZCDYS||','||v_nb_bd_dj.DJ_WZRS||','||v_nb_bd_dj.DJ_FZDYS||','||v_nb_bd_dj.DJ_JJFZS||','||v_nb_bd_dj.DJ_SFJLZZ||','||v_nb_bd_dj.DJ_WJLZZYY||','||v_nb_bd_dj.DJ_DZZJZ||','||v_nb_bd_dj.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.DJ_FRSFDY||','||v_nb_bd_sj.DJ_LXDH||','||v_nb_bd_sj.DJ_QTZW||','||v_nb_bd_sj.DJ_DYZS||','||v_nb_bd_sj.DJ_ZCDYS||','||v_nb_bd_sj.DJ_WZRS||','||v_nb_bd_sj.DJ_FZDYS||','||v_nb_bd_sj.DJ_JJFZS||','||v_nb_bd_sj.DJ_SFJLZZ||','||v_nb_bd_sj.DJ_WJLZZYY||','||v_nb_bd_sj.DJ_DZZJZ||','||v_nb_bd_sj.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.DJ_FRSFDY=v_nb_bd_dj.DJ_FRSFDY and v_nb_gs.DJ_LXDH=v_nb_bd_dj.DJ_LXDH and v_nb_gs.DJ_QTZW=v_nb_bd_dj.DJ_QTZW
             and v_nb_gs.DJ_DYZS=v_nb_bd_dj.DJ_DYZS and v_nb_gs.DJ_ZCDYS=v_nb_bd_dj.DJ_ZCDYS and v_nb_gs.DJ_WZRS=v_nb_bd_dj.DJ_WZRS
             and v_nb_gs.DJ_FZDYS=v_nb_bd_dj.DJ_FZDYS and v_nb_gs.DJ_JJFZS=v_nb_bd_dj.DJ_JJFZS and v_nb_gs.DJ_SFJLZZ=v_nb_bd_dj.DJ_SFJLZZ
             and v_nb_gs.DJ_WJLZZYY=v_nb_bd_dj.DJ_WJLZZYY and v_nb_gs.DJ_DZZJZ=v_nb_bd_dj.DJ_DZZJZ and v_nb_gs.DJ_FRDBSFDZZSJ=v_nb_bd_dj.DJ_FRDBSFDZZSJ
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.DJ_FRSFDY=v_nb_bd_sj.DJ_FRSFDY and v_nb_gs.DJ_LXDH=v_nb_bd_sj.DJ_LXDH and v_nb_gs.DJ_QTZW=v_nb_bd_sj.DJ_QTZW
             and v_nb_gs.DJ_DYZS=v_nb_bd_sj.DJ_DYZS and v_nb_gs.DJ_ZCDYS=v_nb_bd_sj.DJ_ZCDYS and v_nb_gs.DJ_WZRS=v_nb_bd_sj.DJ_WZRS
             and v_nb_gs.DJ_FZDYS=v_nb_bd_sj.DJ_FZDYS and v_nb_gs.DJ_JJFZS=v_nb_bd_sj.DJ_JJFZS and v_nb_gs.DJ_SFJLZZ=v_nb_bd_sj.DJ_SFJLZZ
             and v_nb_gs.DJ_WJLZZYY=v_nb_bd_sj.DJ_WJLZZYY and v_nb_gs.DJ_DZZJZ=v_nb_bd_sj.DJ_DZZJZ and v_nb_gs.DJ_FRDBSFDZZSJ=v_nb_bd_sj.DJ_FRDBSFDZZSJ
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.DJ_FRSFDY=v_nb_bd_dj.DJ_FRSFDY and v_nb_gs.DJ_LXDH=v_nb_bd_dj.DJ_LXDH and v_nb_gs.DJ_QTZW=v_nb_bd_dj.DJ_QTZW
             and v_nb_gs.DJ_DYZS=v_nb_bd_dj.DJ_DYZS and v_nb_gs.DJ_ZCDYS=v_nb_bd_dj.DJ_ZCDYS and v_nb_gs.DJ_WZRS=v_nb_bd_dj.DJ_WZRS
             and v_nb_gs.DJ_FZDYS=v_nb_bd_dj.DJ_FZDYS and v_nb_gs.DJ_JJFZS=v_nb_bd_dj.DJ_JJFZS and v_nb_gs.DJ_SFJLZZ=v_nb_bd_dj.DJ_SFJLZZ
             and v_nb_gs.DJ_WJLZZYY=v_nb_bd_dj.DJ_WJLZZYY and v_nb_gs.DJ_DZZJZ=v_nb_bd_dj.DJ_DZZJZ and v_nb_gs.DJ_FRDBSFDZZSJ=v_nb_bd_dj.DJ_FRDBSFDZZSJ
             and v_nb_gs.DJ_FRSFDY=v_nb_bd_sj.DJ_FRSFDY and v_nb_gs.DJ_LXDH=v_nb_bd_sj.DJ_LXDH and v_nb_gs.DJ_QTZW=v_nb_bd_sj.DJ_QTZW
             and v_nb_gs.DJ_DYZS=v_nb_bd_sj.DJ_DYZS and v_nb_gs.DJ_ZCDYS=v_nb_bd_sj.DJ_ZCDYS and v_nb_gs.DJ_WZRS=v_nb_bd_sj.DJ_WZRS
             and v_nb_gs.DJ_FZDYS=v_nb_bd_sj.DJ_FZDYS and v_nb_gs.DJ_JJFZS=v_nb_bd_sj.DJ_JJFZS and v_nb_gs.DJ_SFJLZZ=v_nb_bd_sj.DJ_SFJLZZ
             and v_nb_gs.DJ_WJLZZYY=v_nb_bd_sj.DJ_WJLZZYY and v_nb_gs.DJ_DZZJZ=v_nb_bd_sj.DJ_DZZJZ and v_nb_gs.DJ_FRDBSFDZZSJ=v_nb_bd_sj.DJ_FRDBSFDZZSJ
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_djxx;
  --计算核查结果 从业人员信息
  function func_cal_hcsxjg_cyryxx(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.cyrs||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.cyrs||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.cyrs||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.cyrs=v_nb_bd_dj.cyrs and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.cyrs=v_nb_bd_sj.cyrs and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.cyrs=v_nb_bd_dj.cyrs and v_nb_gs.cyrs=v_nb_bd_sj.cyrs and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_cyryxx;
  --计算核查结果 资产信息
  function func_cal_hcsxjg_zcxx(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.SYZQYHJ||','||v_nb_gs.LRZE||','||v_nb_gs.ZYYWSR||','||v_nb_gs.JLR||','||v_nb_gs.NSZE||','||v_nb_gs.FZZE||','||v_nb_gs.ZCZE||','||v_nb_gs.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.SYZQYHJ||','||v_nb_bd_dj.LRZE||','||v_nb_bd_dj.ZYYWSR||','||v_nb_bd_dj.JLR||','||v_nb_bd_dj.NSZE||','||v_nb_bd_dj.FZZE||','||v_nb_bd_dj.ZCZE||','||v_nb_bd_dj.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.SYZQYHJ||','||v_nb_bd_sj.LRZE||','||v_nb_bd_sj.ZYYWSR||','||v_nb_bd_sj.JLR||','||v_nb_bd_sj.NSZE||','||v_nb_bd_sj.FZZE||','||v_nb_bd_sj.ZCZE||','||v_nb_bd_sj.YYZSR||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.SYZQYHJ=v_nb_bd_dj.SYZQYHJ and v_nb_gs.LRZE=v_nb_bd_dj.LRZE and v_nb_gs.ZYYWSR=v_nb_bd_dj.ZYYWSR
             and v_nb_gs.JLR=v_nb_bd_dj.JLR and v_nb_gs.NSZE=v_nb_bd_dj.NSZE and v_nb_gs.FZZE=v_nb_bd_dj.FZZE
             and v_nb_gs.ZCZE=v_nb_bd_dj.ZCZE and v_nb_gs.YYZSR=v_nb_bd_dj.YYZSR
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.SYZQYHJ=v_nb_bd_sj.SYZQYHJ and v_nb_gs.LRZE=v_nb_bd_sj.LRZE and v_nb_gs.ZYYWSR=v_nb_bd_sj.ZYYWSR
             and v_nb_gs.JLR=v_nb_bd_sj.JLR and v_nb_gs.NSZE=v_nb_bd_sj.NSZE and v_nb_gs.FZZE=v_nb_bd_sj.FZZE
             and v_nb_gs.ZCZE=v_nb_bd_sj.ZCZE and v_nb_gs.YYZSR=v_nb_bd_sj.YYZSR
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.SYZQYHJ=v_nb_bd_dj.SYZQYHJ and v_nb_gs.LRZE=v_nb_bd_dj.LRZE and v_nb_gs.ZYYWSR=v_nb_bd_dj.ZYYWSR
             and v_nb_gs.JLR=v_nb_bd_dj.JLR and v_nb_gs.NSZE=v_nb_bd_dj.NSZE and v_nb_gs.FZZE=v_nb_bd_dj.FZZE
             and v_nb_gs.ZCZE=v_nb_bd_dj.ZCZE and v_nb_gs.YYZSR=v_nb_bd_dj.YYZSR
             and v_nb_gs.SYZQYHJ=v_nb_bd_sj.SYZQYHJ and v_nb_gs.LRZE=v_nb_bd_sj.LRZE and v_nb_gs.ZYYWSR=v_nb_bd_sj.ZYYWSR
             and v_nb_gs.JLR=v_nb_bd_sj.JLR and v_nb_gs.NSZE=v_nb_bd_sj.NSZE and v_nb_gs.FZZE=v_nb_bd_sj.FZZE
             and v_nb_gs.ZCZE=v_nb_bd_sj.ZCZE and v_nb_gs.YYZSR=v_nb_bd_sj.YYZSR
             and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx;
  --计算核查结果 资产信息 资产总额
  function func_cal_hcsxjg_zcxx_zcze(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.zcze||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.zcze||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.zcze||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.zcze=v_nb_bd_dj.zcze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.zcze=v_nb_bd_sj.zcze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.zcze=v_nb_bd_dj.zcze and v_nb_gs.zcze=v_nb_bd_sj.zcze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_zcze;
  --计算核查结果 资产信息 负债总额
  function func_cal_hcsxjg_zcxx_fzze(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.fzze||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.fzze||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.fzze||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.fzze=v_nb_bd_dj.fzze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.fzze=v_nb_bd_sj.fzze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.fzze=v_nb_bd_dj.fzze and v_nb_gs.fzze=v_nb_bd_sj.fzze and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_fzze;
  --计算核查结果 资产信息 所有者权益合计
  function func_cal_hcsxjg_zcxx_SYZQYHJ(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.SYZQYHJ||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.SYZQYHJ||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.SYZQYHJ||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.SYZQYHJ=v_nb_bd_dj.SYZQYHJ and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.SYZQYHJ=v_nb_bd_sj.SYZQYHJ and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.SYZQYHJ=v_nb_bd_dj.SYZQYHJ and v_nb_gs.SYZQYHJ=v_nb_bd_sj.SYZQYHJ and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_SYZQYHJ;
  --计算核查结果 资产信息 营业总收入
  function func_cal_hcsxjg_zcxx_YYZSR(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.YYZSR||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.YYZSR=v_nb_bd_dj.YYZSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.YYZSR=v_nb_bd_sj.YYZSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.YYZSR=v_nb_bd_dj.YYZSR and v_nb_gs.YYZSR=v_nb_bd_sj.YYZSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_YYZSR;
  --计算核查结果 资产信息 主营业务收入
  function func_cal_hcsxjg_zcxx_ZYYWSR(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.ZYYWSR||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.ZYYWSR||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.ZYYWSR||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.ZYYWSR=v_nb_bd_dj.ZYYWSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.ZYYWSR=v_nb_bd_sj.ZYYWSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.ZYYWSR=v_nb_bd_dj.ZYYWSR and v_nb_gs.ZYYWSR=v_nb_bd_sj.ZYYWSR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_ZYYWSR;
  --计算核查结果 资产信息 利润总额
  function func_cal_hcsxjg_zcxx_LRZE(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.LRZE||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.LRZE||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.LRZE||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.LRZE=v_nb_bd_dj.LRZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.LRZE=v_nb_bd_sj.LRZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.LRZE=v_nb_bd_dj.LRZE and v_nb_gs.LRZE=v_nb_bd_sj.LRZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_LRZE;
  --计算核查结果 资产信息 净利润
  function func_cal_hcsxjg_zcxx_JLR(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.JLR||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.JLR||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.JLR||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.JLR=v_nb_bd_dj.JLR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.JLR=v_nb_bd_sj.JLR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.JLR=v_nb_bd_dj.JLR and v_nb_gs.JLR=v_nb_bd_sj.JLR and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_JLR;
  --计算核查结果 资产信息 纳税总额
  function func_cal_hcsxjg_zcxx_NSZE(p_hcrwId varchar2,p_DBXXLY integer,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) return integer is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_hcjg number;
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_hcjg:=CONS_HCSXJG_BTG;
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.NSZE||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.NSZE||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.NSZE||CONS_YEAR_DATA_SPLIT;
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          if v_nb_gs.NSZE=v_nb_bd_dj.NSZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
          when CONS_HCSXJG_DBXXLY_NBSJ then
          if v_nb_gs.NSZE=v_nb_bd_sj.NSZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        else
          if v_nb_gs.NSZE=v_nb_bd_dj.NSZE and v_nb_gs.NSZE=v_nb_bd_sj.NSZE and v_hcjg=CONS_HCSXJG_TG then
            v_hcjg:=CONS_HCSXJG_TG;
          else
            v_hcjg:=CONS_HCSXJG_BTG;
          end if;
        end case;
      end loop;
      return(v_hcjg);
    end func_cal_hcsxjg_zcxx_NSZE;
  --比对网址网店
  function func_cal_hcsxjg_wz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg number;--核查结果
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
                                                                                                         minus
                                                                                                         select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
                                                                                                         minus
                                                                                                         select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
                                                                                                         minus
                                                                                                         select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_dbxxly
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=CONS_BD_SJLY_DJ
            minus
            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=CONS_BD_SJLY_SJ
            minus
            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select TYPE,NAME,WZ from t_nb_bd_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
                                                                                                            minus
                                                                                                            select TYPE,NAME,WZ from t_nb_wd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
    end func_cal_hcsxjg_wz;
  --比对对外投资
  function func_cal_hcsxjg_dwtz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
            minus
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
            minus
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select tzqymc,TZQY_ZCH from T_NB_bd_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select tzqymc,TZQY_ZCH from T_NB_DWTZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
    end func_cal_hcsxjg_dwtz;
  --比对股权变更
  function func_cal_hcsxjg_gqbg(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_bd_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select gd,bgq_gqbl,bgh_gqbl,func_convertToDate(bgrq) from T_NB_GQBG where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
    end func_cal_hcsxjg_gqbg;
  --比对对外担保
  function func_cal_hcsxjg_dwdb(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_bd_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select ZQR,ZWR,ZZQZL,ZZQSE,func_convertToDate(LXZWQX),BZQJ,BZFS,BZDBFW from T_NB_DWDB where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
    end func_cal_hcsxjg_dwdb;
  --比对行政许可
  function func_cal_hcsxjg_xzxk(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
            minus
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
            minus
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select xkwjmc,yxq from T_NB_bd_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select xkwjmc,yxq from T_NB_XZXK where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
    end func_cal_hcsxjg_xzxk;
  --比对股东出资 修改成只比对实缴数据（将来需要改成将认缴和实缴分开）
  function func_cal_hcsxjg_gdcz(p_HCRWID varchar2,p_DBXXLY integer) return integer is
    v_hcjg integer;
    v_cnt_gs number;--公示表数据个数
    v_cnt_bd number;--比对表数据个数
    begin
      v_hcjg:=CONS_HCSXJG_TG;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --首先找出公示表中数据是否在比对表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_gs
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_gs
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
          );
        else
          select count(1) into v_cnt_gs
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        --再找出比对表中数据是否在公示表中都存在
        case p_DBXXLY
          when CONS_HCSXJG_DBXXLY_NBDJ then
          select count(1) into v_cnt_bd
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_DJ
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
          when CONS_HCSXJG_DBXXLY_NBSJ then
          select count(1) into v_cnt_bd
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=CONS_BD_SJLY_SJ
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        else
          select count(1) into v_cnt_bd
          from(
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_bd_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
            minus
            select GD/*,RJCZE,RJCZDQSJ,RJCZFS*/,SJCZE,func_convertToDate(SJCZSJ),SJCZFS from T_NB_GDCZ where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd
          );
        end case;
        if(v_cnt_gs=0 and v_cnt_bd=0) and v_hcjg=CONS_HCSXJG_TG then--正确匹配
          v_hcjg:=CONS_HCSXJG_TG;
        else
          v_hcjg:=CONS_HCSXJG_BTG;
        end if;
      end loop;
      return v_hcjg;
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
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_JSGS then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      else
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_BD_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from T_JS_GDCZ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
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
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSGS
        );
        when CONS_HCSXJG_DBXXLY_JSSJ then
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) AND SJLY=CONS_HCSXJG_DBXXLY_JSSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_BD_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      else
        select count(1) into v_cnt_bd
        from(
          select GD,BGRQ,BGQBL,BGHBL from T_JS_bd_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select GD,BGRQ,BGQBL,BGHBL from T_JS_GQBG where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
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
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      else
        select count(1) into v_cnt_bd
        from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_bd_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from T_JS_ZSCQ where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
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
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      else
        select count(1) into v_cnt_bd
        from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_bd_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,func_convertToDate(CFRQ),BZ from T_JS_XZCF where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
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
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_gs
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
        );
      else
        select count(1) into v_cnt_gs
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      --再找出比对表中数据是否在即时表中都存在
      case p_DBXXLY
        when CONS_HCSXJG_DBXXLY_jsgs then
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsgs
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
        when CONS_HCSXJG_DBXXLY_jsSJ then
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_jsSJ
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      else
        select count(1) into v_cnt_bd
        from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_bd_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from T_JS_XZXK where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)
        );
      end case;
      if(v_cnt_gs=0 and v_cnt_bd=0) then--正确匹配
        FunctionResult:=CONS_HCSXJG_TG;
      else
        FunctionResult:=CONS_HCSXJG_BTG;
      end if;
      return FunctionResult;
    end func_cal_js_hcsxjg_xzxk;
  --根据核查任务ID将企业录入的自查数据更新到比对接口表中
  procedure prc_update_nb_bd(p_HCRWID in varchar2) is
    v_xydm t_nb.xydm%type;
    v_cnt number;
    begin
      select hcdw_xydm into v_xydm from t_hcrw where id=p_HCRWID;
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwid) loop
        select count(1) into v_cnt from sct_gsxxzcb where xydm=v_xydm and nd=o.nd;
        if(v_cnt>0) then
          delete from t_nb_bd where xydm=v_xydm and nd=o.nd and sjly=2;
          insert into t_nb_bd(ND,XYDM,QYMC,TXDZ,MAIL,SFTZGMGQ,JYZT,SFYWZWD,SFYDWDBXX,CYRS,SYZQYHJ,LRZE,ZYYWSR,JLR,NSZE,FZZE,LXDH,YZBM,ZCZE,GXBYS_JY,GXBYS_GG,TYSBS_JY,TYSBS_GG,CJRS_JY,CJRS_GG,ZJYS_JY,ZJYS_GG,DJ_FRSFDY,DJ_LXDH,DJ_QTZW,DJ_DYZS,DJ_ZCDYS,DJ_WZRS,DJ_FZDYS,DJ_JJFZS,DJ_SFJLZZ,DJ_WJLZZYY,YYZSR,DJ_DZZJZ,DJ_FRDBSFDZZSJ,SJLY)
            select a.ND,a.XYDM,a.QYMC,a.SJJYDZ TXDZ,a.dzyx MAIL,a.SFY_DWTZ SFTZGMGQ,a.JYZT,
                                      case when WZWD is not null then '是' else '否' end SFYWZWD,a.SFY_DWDB SFYDWDBXX,a.CYRS,
                                      round(c.item48_qms/10000,2) SYZQYHJ,
                                      round((b.item7_bqfse-b.item10_bqfse-b.item13_bqfse-b.item14_bqfse-b.item15_bqfse-b.item16_bqfse-b.item17_bqfse+b.item19_bqfse+b.item20_bqfse+b.item22_bqfse-b.item24_bqfse)/10000,2) LRZE,
                                      round(b.item8_bqfse/10000,2) ZYYWSR,
                                      round((b.item7_bqfse-b.item10_bqfse-b.item13_bqfse-b.item14_bqfse-b.item15_bqfse-b.item16_bqfse-b.item17_bqfse+b.item19_bqfse+b.item20_bqfse+b.item22_bqfse-b.item24_bqfse-b.item27_bqfse)/10000,2) JLR,
                                      round(b.item10_bqfse/10000,2) NSZE,round(b.item36_bqfse/10000,2) FZZE,
              a.LXDH,a.YZBM,round(c.item49_qms/10000,2) ZCZE,null GXBYS_JY,null GXBYS_GG,null TYSBS_JY,null TYSBS_GG,null CJRS_JY,
                                      null CJRS_GG,null ZJYS_JY,null ZJYS_GG,null DJ_FRSFDY,null DJ_LXDH,null DJ_QTZW,null DJ_DYZS,null DJ_ZCDYS,
                                      null DJ_WZRS,null DJ_FZDYS,null DJ_JJFZS,null DJ_SFJLZZ,null DJ_WJLZZYY,
                                      round(b.item7_bqfse/10000,2) YYZSR,null DJ_DZZJZ,null DJ_FRDBSFDZZSJ,2 SJLY
            from sct_gsxxzcb a,sct_lrb b,sct_zcfzb c
            where a.xydm=b.xydm(+) and a.nd=b.nd(+)
                  and a.xydm=c.xydm(+) and a.nd=c.nd(+)
                  and a.xydm=v_xydm and a.nd=o.nd;
        end if;
      end loop;
    end prc_update_nb_bd;
  --年报核查结果比对 根据导入的数据，更新HCSXJG表中每个核查事项的内容
  procedure prc_bidui_hc(p_HCRWID in varchar2) is
    v_hcsxjg_1 number;--核查事项结果中通过个数
    v_hcsxjg_2 number;--核查事项结果中未通过个数
    v_gsnr varchar2(4000);--公示信息内容
    v_bznr varchar2(4000);--注册登录内容
    v_sjnr varchar2(4000);--实际内容
    v_hcjg number;--核查结果
    v_cnt_gs number;--公示表数据个数
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

      select count(1) into v_cnt_gs from t_nb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      v_step:=0;
      prc_update_nb_bd(p_HCRWID);--更新自查表数据
      if(v_cnt_gs>0) then
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
            v_hcjg:=func_cal_hcsxjg_address(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            v_step:=911;
            update t_hcsxjg set qygsnr=v_gsnr,BZNR=v_bznr,sjNR=v_sjnr,
              hcjg=v_hcjg,
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            v_step:=912;
            when '1d7e3138a58a4709bb3a328fb767a82e' then--电子邮箱
            v_step:=10;
            v_hcjg:=func_cal_hcsxjg_dzyx(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set qygsnr=v_gsnr,BZNR=v_bznr ,sjNR=v_sjnr ,
              hcjg=v_hcjg,
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'c47e67dcd4b9445bb962efa7f262149c' then--联系电话
            v_step:=11;
            v_hcjg:=func_cal_hcsxjg_lxdh(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set qygsnr=v_gsnr,BZNR=v_bznr ,sjNR=v_sjnr ,
              hcjg=v_hcjg,
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '08f630ac1b3947d2ab91e572c3f75e01' then --存续状态 经营状态
            v_step:=12;
            v_hcjg:=func_cal_hcsxjg_jyzt(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set qygsnr=v_gsnr,BZNR=v_bznr ,sjNR=v_sjnr ,
              hcjg=v_hcjg,
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8588a435261e485eb72f0d986082bfdb' then --邮政编码
            v_step:=13;
            v_hcjg:=func_cal_hcsxjg_yzbm(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set qygsnr=v_gsnr,BZNR=v_bznr ,sjNR=v_sjnr ,
              hcjg=v_hcjg,
              dbxxly=o.dbxxly,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'ae9230ddad3e4505ac03c966fd8bac3d' then --党建信息
            v_step:=15;
            v_hcjg:=func_cal_hcsxjg_djxx(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set hcjg=v_hcjg,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_TG then null else v_hcsx_sm end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'ae9230ddad3e4505ac03c966fd8bac3e' then --从业人员信息
            v_step:=16;
            v_hcjg:=func_cal_hcsxjg_cyryxx(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set hcjg=v_hcjg,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_TG then null else v_hcsx_sm end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8dd2b47ff88046679dabe66012ba1d35' then --资产总额、负债总额等资产财务数据
            v_step:=17;
            v_hcjg:=func_cal_hcsxjg_zcxx(p_hcrwId,o.dbxxly,v_gsnr,v_bznr,v_sjnr);
            update t_hcsxjg set hcjg=v_hcjg,
              dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_TG then null else v_hcsx_sm||(select zcb_result from t_hcrw where id=p_HCRWID) end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'cf8c476dad384a078f2278ac24f702f3' then--企业网站及从事经营的网店的名称和网址
            v_step:=18;
            v_hcjg:=func_cal_hcsxjg_wz(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...',
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when 'c8be232576294f32adc7ee8484b6f60a' then --企业投资设立企业、购买股权信息
            v_step:=19;
            v_hcjg:=func_cal_hcsxjg_dwtz(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '5b76bf93df5d418ca809d3ab77230b38' then --有限公司股东股权转让等股权变更信息
            v_step:=20;
            v_hcjg:=func_cal_hcsxjg_gqbg(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '5634e28ac294407c91ce60a85318ccac' then --对外提供保证担保信息
            v_step:=21;
            v_hcjg:=func_cal_hcsxjg_dwdb(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '0ede0c58e04e4e7d82819e6fb3cdd779' then --股东或发起人认缴和实缴的出资额等信息
            v_step:=23;
            v_hcjg:=func_cal_hcsxjg_gdcz(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id),
              sm= case when v_hcjg=CONS_HCSXJG_BTG then v_hcsx_sm else null end
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '34A194D475854B32E050A8C085050AD8' then --即时 股东或发起人认缴和实缴信息
            v_step:=24;
            v_hcjg:=func_cal_js_hcsxjg_gdcz(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg, dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
            v_step:=25;
            v_hcjg:=func_cal_js_hcsxjg_gqbg(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
            v_step:=26;
            v_hcjg:=func_cal_js_hcsxjg_zscq(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
            v_step:=27;
            v_hcjg:=func_cal_js_hcsxjg_xzcf(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
              page=(select page from t_hcsx where id=o.hcsx_id)
            where hcrw_id=p_HCRWID and hcsx_id=o.hcsx_id;
            when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
            v_step:=28;
            v_hcjg:=func_cal_js_hcsxjg_xzxk(p_HCRWID,o.dbxxly);
            update t_hcsxjg set hcjg=v_hcjg,dbxxly=o.dbxxly,qygsnr='...',BZNR='...',sjNR='...' ,
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
    v_hcjg number;
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
          v_hcjg:=func_cal_js_hcsxjg_gdcz(p_HCRWID,o.dbxxly);
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,v_hcjg,null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '9559686ef987488f8df0e064632153f3' then --即时 有限公司股东股权转让等变更信息
          v_step:=25;
          v_hcjg:=func_cal_js_hcsxjg_gqbg(p_HCRWID,o.dbxxly);
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,v_hcjg,null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '87604e472fda4faaa9247d7c8b9b989a' then --即时 知识产权出质登记信息
          v_step:=26;
          v_hcjg:=func_cal_js_hcsxjg_zscq(p_HCRWID,o.dbxxly);
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,v_hcjg,null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '8c253dfa317746b8a4441bb4fe8d9c63' then --即时 行政处罚信息
          v_step:=27;
          v_hcjg:=func_cal_js_hcsxjg_xzcf(p_HCRWID,o.dbxxly);
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,v_hcjg,null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
          when '3c9015ebd3a942eab8dfc72b1374a473' then --即时 行政许可取得、变更、延续信息
          v_step:=28;
          v_hcjg:=func_cal_js_hcsxjg_xzxk(p_HCRWID,o.dbxxly);
          insert into t_js_hcsxjg(JH_GS_SJ,SJ_GS_SJ,HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
          values(null,null,o.id,p_HCRWID,o.name,v_hcjg,null,'...','...',v_jsrw.rwzt,v_hcsx_sm,o.page,o.hclx,'...',o.dbxxly);
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
  --取得核查内容 党建信息
  procedure proc_get_hcsxjg_djxx(p_hcrwId varchar2,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      p_nb:='';
      p_dj:='';
      p_sj:='';
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.DJ_FRSFDY||','||v_nb_gs.DJ_LXDH||','||v_nb_gs.DJ_QTZW||','||v_nb_gs.DJ_DYZS||','||v_nb_gs.DJ_ZCDYS||','||v_nb_gs.DJ_WZRS||','||v_nb_gs.DJ_FZDYS||','||v_nb_gs.DJ_JJFZS||','||v_nb_gs.DJ_SFJLZZ||','||v_nb_gs.DJ_WJLZZYY||','||v_nb_gs.DJ_DZZJZ||','||v_nb_gs.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.DJ_FRSFDY||','||v_nb_bd_dj.DJ_LXDH||','||v_nb_bd_dj.DJ_QTZW||','||v_nb_bd_dj.DJ_DYZS||','||v_nb_bd_dj.DJ_ZCDYS||','||v_nb_bd_dj.DJ_WZRS||','||v_nb_bd_dj.DJ_FZDYS||','||v_nb_bd_dj.DJ_JJFZS||','||v_nb_bd_dj.DJ_SFJLZZ||','||v_nb_bd_dj.DJ_WJLZZYY||','||v_nb_bd_dj.DJ_DZZJZ||','||v_nb_bd_dj.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.DJ_FRSFDY||','||v_nb_bd_sj.DJ_LXDH||','||v_nb_bd_sj.DJ_QTZW||','||v_nb_bd_sj.DJ_DYZS||','||v_nb_bd_sj.DJ_ZCDYS||','||v_nb_bd_sj.DJ_WZRS||','||v_nb_bd_sj.DJ_FZDYS||','||v_nb_bd_sj.DJ_JJFZS||','||v_nb_bd_sj.DJ_SFJLZZ||','||v_nb_bd_sj.DJ_WJLZZYY||','||v_nb_bd_sj.DJ_DZZJZ||','||v_nb_bd_sj.DJ_FRDBSFDZZSJ||CONS_YEAR_DATA_SPLIT;
      end loop;
    end proc_get_hcsxjg_djxx;
  --取得核查内容 从业人员信息
  procedure proc_get_hcsxjg_cyryxx(p_hcrwId varchar2,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.cyrs||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.cyrs||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.cyrs||CONS_YEAR_DATA_SPLIT;
      end loop;
    end proc_get_hcsxjg_cyryxx;
  --取得核查内容 资产信息
  procedure proc_get_hcsxjg_zcxx(p_hcrwId varchar2,p_nb out varchar2,p_dj out varchar2,p_sj out varchar2 ) is
    v_nb_gs t_nb%rowtype;--年报数据
    v_nb_bd_dj t_nb_bd%rowtype;--业务登记数据
    v_nb_bd_sj t_nb_bd%rowtype;--实际数据
    v_cnt_bd number;
    v_cnt_nb number;
    begin
      for o in(select nd from t_hcrw_nd where hcrw_id=p_hcrwId order by nd) loop
        --取得公示系统数据
        select count(1) into v_cnt_nb from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        if(v_cnt_nb=0) then
          v_nb_bd_dj:=null;
        else
          select * into v_nb_gs from t_nb where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd;
        end if;
        --取得业务登记系统数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_dj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd and sjly=1;
        else
          v_nb_bd_dj:=null;
        end if;
        --取得实际数据
        select count(1) into v_cnt_bd from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        if(v_cnt_bd>0) then
          select * into v_nb_bd_sj from t_nb_bd where xydm=(select hcdw_xydm from t_hcrw where id=p_hcrwid) and nd=o.nd  and sjly=2;
        else
          v_nb_bd_sj:=null;
        end if;
        p_nb:=p_nb||v_nb_gs.SYZQYHJ||','||v_nb_gs.LRZE||','||v_nb_gs.ZYYWSR||','||v_nb_gs.JLR||','||v_nb_gs.NSZE||','||v_nb_gs.FZZE||','||v_nb_gs.ZCZE||','||v_nb_gs.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_dj:=p_dj||v_nb_bd_dj.SYZQYHJ||','||v_nb_bd_dj.LRZE||','||v_nb_bd_dj.ZYYWSR||','||v_nb_bd_dj.JLR||','||v_nb_bd_dj.NSZE||','||v_nb_bd_dj.FZZE||','||v_nb_bd_dj.ZCZE||','||v_nb_bd_dj.YYZSR||CONS_YEAR_DATA_SPLIT;
        p_sj:=p_sj||v_nb_bd_sj.SYZQYHJ||','||v_nb_bd_sj.LRZE||','||v_nb_bd_sj.ZYYWSR||','||v_nb_bd_sj.JLR||','||v_nb_bd_sj.NSZE||','||v_nb_bd_sj.FZZE||','||v_nb_bd_sj.ZCZE||','||v_nb_bd_sj.YYZSR||CONS_YEAR_DATA_SPLIT;
      end loop;
    end proc_get_hcsxjg_zcxx;
  --取得核查事项结果内容，根据ID不同，取得详细的内容并组织成JSON字符串返回，供报表使用
  procedure prc_getHcsxjg(p_HCRWID in varchar2,p_out out clob) is
    v_hcsxjg clob;
    v_qygsnr clob;
    v_bznr clob;
    v_sjnr clob;
    v_hcjg number;
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
          proc_get_hcsxjg_djxx(p_HCRWID,v_qygsnr,v_bznr,v_sjnr);
          v_qygsnr:='"qygsnr":"'||v_qygsnr||'"';
          v_bznr:='"bznr":"'||v_bznr||'"';
          v_sjnr:='"sjnr":"'||v_sjnr||'"';
          when 'ae9230ddad3e4505ac03c966fd8bac3e' then --从业人员信息
          proc_get_hcsxjg_cyryxx(p_HCRWID,v_qygsnr,v_bznr,v_sjnr);
          v_qygsnr:='"qygsnr":"'||v_qygsnr||'"';
          v_bznr:='"bznr":"'||v_bznr||'"';
          v_sjnr:='"sjnr":"'||v_sjnr||'"';
          when '8dd2b47ff88046679dabe66012ba1d35' then --资产总额、负债总额等资产财务数据
          proc_get_hcsxjg_zcxx(p_HCRWID,v_qygsnr,v_bznr,v_sjnr);
          v_qygsnr:='"qygsnr":"'||v_qygsnr||'"';
          v_bznr:='"bznr":"'||v_bznr||'"';
          v_sjnr:='"sjnr":"'||v_sjnr||'"';
          when 'cf8c476dad384a078f2278ac24f702f3' then--企业网站及从事经营的网店的名称和网址
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_nb_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) order by nd) loop
              v_qygsnr:=v_qygsnr||o.type||','
                        ||o.NAME||','
                        ||o.WZ||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1  order by nd) loop
              v_bznr:=v_bznr||o.type||','
                      ||o.NAME||','
                      ||o.WZ||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2 order by nd) loop
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
          select count(1) into v_cnt from t_nb_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_nb_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) order by nd) loop
              v_qygsnr:=v_qygsnr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_qygsnr:=substr(v_qygsnr,1,length(v_qygsnr)-1)||'"';
          else
            v_qygsnr:=v_qygsnr||'"';
          end if;

          v_bznr:='"bznr":"';
          select count(1) into v_cnt from t_nb_bd_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1 order by nd) loop
              v_bznr:=v_bznr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_bznr:=substr(v_bznr,1,length(v_bznr)-1)||'"';
          else
            v_bznr:=v_bznr||'"';
          end if;

          v_sjnr:='"sjnr":"';
          select count(1) into v_cnt from t_nb_bd_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2 order by nd) loop
              v_sjnr:=v_sjnr||o.tzqymc||','||o.tzqy_zch||';';
            end loop;
            v_sjnr:=substr(v_sjnr,1,length(v_sjnr)-1)||'"';
          else
            v_sjnr:=v_sjnr||'"';
          end if;
          when '5b76bf93df5d418ca809d3ab77230b38' then --有限公司股东股权转让等股权变更信息
          v_qygsnr:='"qygsnr":"';
          select count(1) into v_cnt from t_nb_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_nb_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1 order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gqbg where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2 order by nd) loop
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
          select count(1) into v_cnt from t_nb_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_nb_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid)  order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1 order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2 order by nd) loop
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
          select count(1) into v_cnt from t_nb_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_nb_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1 order by nd) loop
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
          select count(1) into v_cnt from t_nb_bd_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2;
          if(v_cnt>0) then
            for o in(select * from t_nb_bd_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=2 order by nd) loop
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
          select count(1) into v_cnt from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSGS;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)  and sjly=CONS_HCSXJG_DBXXLY_JSGS) loop
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
          select count(1) into v_cnt from t_js_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSSJ;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)  and sjly=CONS_HCSXJG_DBXXLY_JSSJ) loop
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
          select count(1) into v_cnt from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) ;
          if(v_cnt>0) then
            for o in(select * from t_js_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
      v_hcjg:=func_cal_hcsxjg_zcxx_zcze(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'资产总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_fzze(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'负债总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_SYZQYHJ(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'所有者权益合计（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_YYZSR(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'营业总收入（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_ZYYWSR(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'主营业务收入（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_LRZE(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'利润总额（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_JLR(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"name":"'||'净利润（万元）'||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
      p_out:=p_out||v_hcsxjg;
      v_hcjg:=func_cal_hcsxjg_zcxx_NSZE(v_t_hcsxjg.HCRW_ID,v_t_hcsxjg.dbxxly,v_qygsnr,v_bznr,v_sjnr);
      p_out:=p_out||'"name":"'||'纳税总额（万元）'||'",';
      p_out:=p_out||'"hcjg":"'||v_hcjg||'",';
      p_out:=p_out||'"qygsnr":"'||v_qygsnr||'"'||',';
      p_out:=p_out||'"bznr":"'||v_bznr||'"'||',';
      p_out:=p_out||'"sjnr":"'||v_sjnr||'"'||'},';
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
          select count(1) into v_cnt from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSGS;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)  and sjly=CONS_HCSXJG_DBXXLY_JSGS) loop
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
          select count(1) into v_cnt from t_js_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSSJ;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gdcz where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)  and sjly=CONS_HCSXJG_DBXXLY_JSSJ) loop
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
          select count(1) into v_cnt from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) ;
          if(v_cnt>0) then
            for o in(select * from t_js_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_gqbg where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_zscq where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzcf where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSsj) loop
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
          select count(1) into v_cnt from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
          select count(1) into v_cnt from t_js_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
          if(v_cnt>0) then
            for o in(select * from t_js_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid)) loop
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
          select count(1) into v_cnt from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs;
          if(v_cnt>0) then
            for o in(select * from t_js_bd_xzxk where xydm=(select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid) and sjly=CONS_HCSXJG_DBXXLY_JSgs) loop
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
