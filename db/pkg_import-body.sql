create or replace package body pkg_import is

  --导入日常核查任务，单独的过程
  procedure prc_importRcRwAll(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2,p_rlbz number,p_parent_xh number default null) is
    v_hcjhId varchar2(100);--计划主键
    v_jhmc varchar2(200);--计划名称
    v_cnt number;--任务数量
    v_gshcjh varchar2(100);--公示系统核查计划
    v_nr number;--核查内容
    v_jhbh varchar2(100);--计划编号
    v_XDRQ t_hcjh.XDRQ%type;--下达日期
    v_YQWCSJ t_hcjh.YQWCSJ%type;--计划完成时间
    v_plan_type t_hcjh.plan_type%type;--计划类型
    v_requiredFiles number;--任务中必须要上传的文件个数
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    v_zch  varchar2(100);--企业注册号码，写日志时使用
    v_jhnd number;--计划年度
    v_zfryId varchar2(100);--执法人员代码
    v_userName varchar2(100);--认领人名称，即p_userId对应的名称
    v_rlrq date;--认领日期
    v_rwzt number;--任务状态
    v_rlr varchar2(100);--认领人代码
    v_rwid number;--任务编码
    v_clnd number;--企业成立年度
    begin
      pkg_log.INFO('pkg_import.prc_importRcRwAll','导入日常核查任务','导入日常核查任务'||p_parent_xh,p_hcjhId,v_log_xh);
      select zfry into v_zfryId from sys_user where user_id=p_userId;
      if(p_hcjhId is null) then
        v_hcjhId := sys_guid();
      else
        v_hcjhId:=p_hcjhId;
      end if;
      select jhmc,gsjhbh,nr,jhbh,XDRQ,YQWCSJ,plan_type,nd into v_jhmc,v_gshcjh,v_nr,v_jhbh,v_XDRQ,v_YQWCSJ,v_plan_type,v_jhnd
      from t_hcjh where ID=v_hcjhid;
      if(p_rlbz=1) then
        select name into v_userName from sys_user where user_id=p_userId;
        v_rlrq:=sysdate;
        v_rwzt:=2;
        v_rlr:=p_userId;
      else
        select null into v_userName from dual;
        v_rlrq:=null;
        v_rwzt:=null;
        v_userName:='';
      end if;
      --核查任务数量
      select count(1) into v_cnt from (SELECT REGEXP_SUBSTR (p_zchList, '[^,]+', 1,rownum) zch,rownum rn
                                       FROM DUAL
                                       CONNECT BY ROWNUM <=
                                                  LENGTH (p_zchList) - LENGTH (REPLACE (p_zchList, ',', ''))+1);
      select count(1)+v_cnt into v_cnt from t_hcrw where hcjh_id=v_hcjhId;

      select count(1) into v_requiredFiles from t_hcjh_hcsx a,t_hccl b
      where a.hcsx_id=b.hcsx_id
            and b.sfbyx=1
            and a.hcjh_id=p_hcjhId;
      --insert new data
      v_step:=1;
      for o in(SELECT REGEXP_SUBSTR (p_zchList, '[^,]+', 1,rownum) zch,rownum rn
               FROM DUAL
               CONNECT BY ROWNUM <=
                          LENGTH (p_zchList) - LENGTH (REPLACE (p_zchList, ',', ''))+1) loop
        v_step:=11;
        v_zch:=o.zch;
        --获取企业成立年度 重庆和陕西可能会不一样
        select extract(year from ESTDATE) into v_clnd from hz_qyhznr where PRIPID=(select NBXH from gov_nbcc_rc_qy where zch=o.zch and rownum<=1);
        --经营异常计划，循环增加3个任务，任务年度是计划年度-1 -2 -3，如2017年计划，则任务年度为2016 2015 2014
        --同时判断企业成立日期，成立年不核查，不增加任务
        for p in(select v_jhnd-rownum rwnd from dual connect by level<=3) loop
          if v_clnd<=p.rwnd then
            v_rwid:=seq_hcrw.nextval;
            merge into t_hcrw
            using(select v_hcjhId HCJH_ID,zch HCDW_XYDM,qymc HCDW_NAME,
                         (select user_name from xt_user b where b.full_name=pkg_hc.fun_get_xcr(1,xcr) and b.djjg=a.djjg and rownum<=1) ZFRY_CODE1,--存储名称重复的情况
                         (select user_name from xt_user b where b.full_name=pkg_hc.fun_get_xcr(2,xcr) and b.djjg=a.djjg and rownum<=1) ZFRY_CODE2,
                         null RWZT,1 HCFL,a.jdjg HCJG,null HCJIEGUO,1 JYZT,null HCJGGSQK,null RLR,null RLRQ,null SJWCRQ,
                         pkg_hc.fun_get_xcr(1,xcr) ZFRY_NAME1,pkg_hc.fun_get_xcr(2,xcr) ZFRY_NAME2,
                         a.jdjg_mc HCJGMC,a.djjg_mc DJJGMC,DJJG,qylxdl ZTLX,qyzzxs ZZXS,
                         GXDW QYBM,a.gxdw_mc QYMC,
                         null RLRMC,v_YQWCSJ JHWCRQ, ND,v_jhmc JHMC,v_XDRQ JHXDRQ,v_nr nr,v_jhbh jhbh,clrq,zs,lrrq
                  from (select rownum XH,v_jhbh JHXH,NBXH,ZCH,QYMC,FDDBR,QYLXDL,DJJG,GXDW,
                          xcr,XCSJ,0 WCBJ,ND,clrq,zs,lrrq,qyzzxs,jdjg,jdjg_mc,djjg_mc,gxdw_mc
                        from gov_nbcc_rc_qy where zch=o.zch and rownum<=1 and jdjg is not null) a) i_hcrw
            on(i_hcrw.hcjh_id=t_hcrw.hcjh_id and i_hcrw.hcdw_xydm=t_hcrw.hcdw_xydm and t_hcrw.nd=p.rwnd)
            WHEN MATCHED THEN
            update set HCDW_NAME=i_hcrw.HCDW_NAME,
              zfry_code1=i_hcrw.zfry_code1,
              zfry_code2=i_hcrw.zfry_code2,
              zfry_name1=i_hcrw.zfry_name1,
              zfry_name2=i_hcrw.zfry_name2,
              REQUIRED_FILES=v_requiredFiles
            WHEN NOT MATCHED THEN
            insert(ID,HCJH_ID,HCDW_XYDM,HCDW_NAME,ZFRY_CODE1,ZFRY_CODE2,RWZT,HCFL,HCJG,HCJIEGUO,JYZT,HCJGGSQK,RLR,RLRQ,SJWCRQ,ZFRY_NAME1,ZFRY_NAME2,
                   HCJGMC,DJJGMC,DJJG,ZTLX,ZZXS,QYBM,QYMC,RLRMC,JHWCRQ,ND,JHMC,JHXDRQ,NR,JHBH,required_files,clrq,zs,plan_type,jhnd,lrrq)
            values(v_rwid,i_hcrw.HCJH_ID,i_hcrw.HCDW_XYDM,i_hcrw.HCDW_NAME,v_zfryId,null,v_RWZT,i_hcrw.HCFL,i_hcrw.HCJG,
              i_hcrw.HCJIEGUO,i_hcrw.JYZT,i_hcrw.HCJGGSQK,v_rlr,v_rlrq,i_hcrw.SJWCRQ,p_zfryName,i_hcrw.ZFRY_NAME2,
              i_hcrw.HCJGMC,i_hcrw.DJJGMC,i_hcrw.DJJG,i_hcrw.ZTLX,i_hcrw.ZZXS,i_hcrw.QYBM,i_hcrw.QYMC,v_userName,i_hcrw.JHWCRQ,p.rwnd,i_hcrw.JHMC,
              i_hcrw.JHXDRQ,i_hcrw.NR,i_hcrw.JHBH,v_requiredFiles,i_hcrw.clrq,i_hcrw.zs,v_plan_type,v_jhnd,i_hcrw.lrrq);
            --插入核查任务-年度数据 默认是插入计划年度的前三年 如计划年度2015，则任务年度列表插入2015 20014 2013(现改成一个计划增加三个任务，所以此处只加一个年度)
            MERGE INTO t_hcrw_nd
            USING ( select hcdw_xydm,jhnd,nd,id from t_hcrw a where id=v_rwid) hcrw
            ON (hcrw.id = t_hcrw_nd.hcrw_id and t_hcrw_nd.nd=p.rwnd)
            WHEN NOT MATCHED THEN
            insert(hcrw_id,nd) values(hcrw.id,p.rwnd);
          end if;
        end loop;
        --merge sczt data from hcrw
        v_step:=14;
        MERGE INTO t_sczt
        USING ( select rownum XH,v_jhbh JHXH,NBXH,ZCH,QYMC,FDDBR,QYLXDL,DJJG,GXDW,null XCR,sysdate XCSJ,0 WCBJ,to_char(sysdate,'yyyy') ND,
                       (select content from bm_djjg b where a.djjg=b.code) djjgmc,
                       (select content from bm_gxdw b where a.gxdw=b.code) gxdwmc,
                  clrq,zs
                from gov_nbcc_rc_qy a where zch=o.zch and rownum<=1) hcrw
        ON (hcrw.zch = t_sczt.xydm)
        WHEN MATCHED THEN
        update set name=hcrw.qymc,djjg=hcrw.djjg
        WHEN NOT MATCHED THEN
        insert(XYDM,NAME,ZTLX,HYFL,ZZXS,JYZT,FR,LXDH,MAIL,DJJG,JYDZ,LLR,QYBM,QYMC,clrq,zs)
        values(hcrw.zch,hcrw.qymc,hcrw.qylxdl,null,null,1,hcrw.FDDBR ,null ,null,hcrw.djjg,null ,null ,hcrw.gxdw,hcrw.gxdwmc,hcrw.clrq,hcrw.zs);
      end loop;
      --update hcjh table
      v_step:=2;
      update t_hcjh a set hcrwsl=v_cnt,
        YRLSL=(select count(1) from t_hcrw b where b.hcjh_id=a.id and rlr is not null),
        WRLSL=(select count(1) from t_hcrw b where b.hcjh_id=a.id and rlr is null)
      where id=v_hcjhid;
      --delete old data of statistics by hcjhid
      delete from t_hcrw_tj where hcjh_id=v_hcjhId;
      --insert statistics data of hcrw
      v_step:=3;
      insert into t_hcrw_tj(hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,HCRWS,RLS,WCS,ZLZ,WWCS)
        select distinct hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,sum(HCRWS) hcrws,sum(RLS) rls,sum(WCS) wcs,sum(ZLZ) zlz,sum(WWCS) wwcs from(
          select hcjh_id,ZFRY_CODE1 ZFRY_CODE,HCJG,ZFRY_NAME1 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code1 is not null
          group by hcjh_id,ZFRY_CODE1,HCJG,ZFRY_NAME1,HCJGMC
          union all
          select hcjh_id,ZFRY_CODE2 ZFRY_CODE,HCJG,ZFRY_NAME2 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code2 is not null
          group by hcjh_id,ZFRY_CODE2,HCJG,ZFRY_NAME2,HCJGMC
        ) group by hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'-'||v_zch||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'-'||v_zch||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_importRcRwAll;
  --导入日常任务，不自动更新认领人
  procedure prc_importRcRw(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2) is
    begin
      prc_importRcRwAll(p_hcjhId ,p_zchList ,p_userId ,p_zfryName,0);
    end prc_importRcRw;
  --导入日常任务，自动更新认领人
  procedure prc_importRcRwShortcut(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2) is
    begin
      prc_importRcRwAll(p_hcjhId ,p_zchList ,p_userId ,p_zfryName,1);
    end prc_importRcRwShortcut;
  --从计划中移除日常核查任务
  procedure prc_removeRcRw(p_hcjhId in varchar2,p_hcrwList varchar2) is
    v_hcjhId varchar2(100);--计划主键
    v_hcrwId varchar2(100);--计划主键
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_import.prc_removeRcRw','移除日常核查任务','移除日常核查任务',p_hcjhId, v_log_xh);
      v_hcjhId:=p_hcjhId;

      for o in(SELECT REGEXP_SUBSTR (p_hcrwList, '[^,]+', 1,rownum) hcrwId,rownum rn
               FROM DUAL
               CONNECT BY ROWNUM <=
                          LENGTH (p_hcrwList) - LENGTH (REPLACE (p_hcrwList, ',', ''))+1) loop
        v_step:=11;
        v_hcrwId:=o.hcrwId;
        DELETE FROM T_HCRW WHERE ID=o.hcrwId;
        delete from t_hcrw_nd where hcrw_id=o.hcrwId;
      end loop;

      update t_hcjh a set hcrwsl=(select count(1) from t_hcrw b where b.hcjh_id=a.id),
        YRLSL=(select count(1) from t_hcrw b where b.hcjh_id=a.id and rlr is not null),
        WRLSL=(select count(1) from t_hcrw b where b.hcjh_id=a.id and rlr is null)
      where id=v_hcjhid;

      delete from t_hcrw_tj where hcjh_id=v_hcjhId;
      --insert statistics data of hcrw
      v_step:=3;
      insert into t_hcrw_tj(hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,HCRWS,RLS,WCS,ZLZ,WWCS)
        select distinct hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,sum(HCRWS) hcrws,sum(RLS) rls,sum(WCS) wcs,sum(ZLZ) zlz,sum(WWCS) wwcs from(
          select hcjh_id,ZFRY_CODE1 ZFRY_CODE,HCJG,ZFRY_NAME1 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code1 is not null
          group by hcjh_id,ZFRY_CODE1,HCJG,ZFRY_NAME1,HCJGMC
          union all
          select hcjh_id,ZFRY_CODE2 ZFRY_CODE,HCJG,ZFRY_NAME2 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code2 is not null
          group by hcjh_id,ZFRY_CODE2,HCJG,ZFRY_NAME2,HCJGMC
        ) group by hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'-'||v_hcjhId||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'-'||v_hcjhId||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_removeRcRw;
  --导入核查任务，此处只导入双随机核查任务，日常监管任务是通过页面来手工增加
  procedure prc_importByJhid(p_hcjhId in varchar2,p_step out number) is
    v_hcjhId varchar2(100);--计划主键
    v_jhmc varchar2(200);--计划名称
    v_cnt number;--任务数量
    v_gshcjh varchar2(100);--公示核查计划
    v_nr number;--计划内容
    v_jhbh varchar2(100);--计划编号
    v_XDRQ t_hcjh.XDRQ%type;--计划下达日期
    v_YQWCSJ t_hcjh.YQWCSJ%type;--计划完成日期
    v_plan_type t_hcjh.plan_type%type;--计划类型
    v_requiredFiles number;--任务中必须要上传的文件个数
    v_jhnd number;--计划年度
    begin
      if(p_hcjhId is null) then
        v_hcjhId := sys_guid();
      else
        v_hcjhId:=p_hcjhId;
      end if;
      select jhmc,gsjhbh,nr,jhbh,XDRQ,YQWCSJ,plan_type,nd into v_jhmc,v_gshcjh,v_nr,v_jhbh,v_XDRQ,v_YQWCSJ,v_plan_type,v_jhnd
      from t_hcjh where ID=v_hcjhid;
      select count(1) into v_cnt from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh;

      select count(1) into v_requiredFiles from t_hcjh_hcsx a,t_hccl b
      where a.hcsx_id=b.hcsx_id
            and b.sfbyx=1
            and a.hcjh_id=p_hcjhId;
      --insert new data
      p_step:=1;
      merge into t_hcrw
      using(select v_hcjhId HCJH_ID,zch HCDW_XYDM,qymc HCDW_NAME,
                   (select user_name from xt_user b where b.full_name=pkg_hc.fun_get_xcr(1,xcr) and b.djjg=a.djjg and rownum<=1) ZFRY_CODE1,--存储名称重复的情况
                   (select user_name from xt_user b where b.full_name=pkg_hc.fun_get_xcr(2,xcr) and b.djjg=a.djjg and rownum<=1) ZFRY_CODE2,
                   null RWZT,1 HCFL,a.djjg HCJG,null HCJIEGUO,1 JYZT,null HCJGGSQK,null RLR,null RLRQ,null SJWCRQ,
                   pkg_hc.fun_get_xcr(1,xcr) ZFRY_NAME1,pkg_hc.fun_get_xcr(2,xcr) ZFRY_NAME2,
                   (select content from bm_djjg b where b.code=a.djjg) HCJGMC,(select content from bm_djjg b where b.code=a.djjg) DJJGMC,DJJG,qylxdl ZTLX,ZZXS,
                   GXDW QYBM,(select content from bm_gxdw b where b.code=a.gxdw) QYMC,
                   null RLRMC,v_YQWCSJ JHWCRQ, ND,v_jhmc JHMC,v_XDRQ JHXDRQ,v_nr nr,v_jhbh jhbh,clrq,zs
            from (select XH,JHXH,NBXH,ZCH,QYMC,FDDBR,QYLXDL,DJJG,GXDW,
                    replace(replace(replace(replace(XCR,'，',','),'  ',','),' ',','),'、',',') xcr,
                    XCSJ,WCBJ,ND,
                    (select estdate from hz_qyhznr where gov_nbcc_jh_qy.nbxh=hz_qyhznr.pripid) CLRQ,
                    (select dom from hz_qyhznr where gov_nbcc_jh_qy.nbxh=hz_qyhznr.pripid) ZS,zzxs
                  from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh) a) i_hcrw
      on(i_hcrw.hcjh_id=t_hcrw.hcjh_id and i_hcrw.hcdw_xydm=t_hcrw.hcdw_xydm)
      WHEN MATCHED THEN
      update set HCDW_NAME=i_hcrw.HCDW_NAME,
        zfry_code1=i_hcrw.zfry_code1,
        zfry_code2=i_hcrw.zfry_code2,
        zfry_name1=i_hcrw.zfry_name1,
        zfry_name2=i_hcrw.zfry_name2,
        REQUIRED_FILES=v_requiredFiles
      WHEN NOT MATCHED THEN
      insert(ID,HCJH_ID,HCDW_XYDM,HCDW_NAME,ZFRY_CODE1,ZFRY_CODE2,RWZT,HCFL,HCJG,HCJIEGUO,JYZT,HCJGGSQK,RLR,RLRQ,SJWCRQ,ZFRY_NAME1,ZFRY_NAME2,
             HCJGMC,DJJGMC,DJJG,ZTLX,ZZXS,QYBM,QYMC,RLRMC,JHWCRQ,ND,JHMC,JHXDRQ,NR,JHBH,required_files,clrq,zs,plan_type,jhnd)
      values( seq_hcrw.nextval,i_hcrw.HCJH_ID,i_hcrw.HCDW_XYDM,i_hcrw.HCDW_NAME,i_hcrw.ZFRY_CODE1,i_hcrw.ZFRY_CODE2,i_hcrw.RWZT,i_hcrw.HCFL,
        i_hcrw.HCJG,i_hcrw.HCJIEGUO,i_hcrw.JYZT,i_hcrw.HCJGGSQK,i_hcrw.RLR,i_hcrw.RLRQ,i_hcrw.SJWCRQ,i_hcrw.ZFRY_NAME1,i_hcrw.ZFRY_NAME2,
        i_hcrw.HCJGMC,i_hcrw.DJJGMC,i_hcrw.DJJG,i_hcrw.ZTLX,i_hcrw.ZZXS,i_hcrw.QYBM,i_hcrw.QYMC,i_hcrw.RLRMC,i_hcrw.JHWCRQ,i_hcrw.ND,i_hcrw.JHMC,
        i_hcrw.JHXDRQ,i_hcrw.NR,i_hcrw.JHBH,v_requiredFiles,i_hcrw.clrq,i_hcrw.zs,v_plan_type,v_jhnd);
      --update hcjh table
      p_step:=2;
      update t_hcjh set hcrwsl=v_cnt,ypfsl=0,yrlsl=0,wrlsl=0 where id=v_hcjhid;
      --delete old data of statistics by hcjhid
      delete from t_hcrw_tj where hcjh_id=v_hcjhId;
      --insert statistics data of hcrw
      p_step:=3;
      insert into t_hcrw_tj(hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,HCRWS,RLS,WCS,ZLZ,WWCS)
        select hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC,sum(HCRWS) hcrws,sum(RLS) rls,sum(WCS) wcs,sum(ZLZ) zlz,sum(WWCS) wwcs from(
          select hcjh_id,ZFRY_CODE1 ZFRY_CODE,HCJG,ZFRY_NAME1 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code1 is not null
          group by hcjh_id,ZFRY_CODE1,HCJG,ZFRY_NAME1,HCJGMC
          union all
          select hcjh_id,ZFRY_CODE2 ZFRY_CODE,HCJG,ZFRY_NAME2 ZFRY_NAME,HCJGMC,count(1) HCRWS,0 RLS,0 WCS,0 ZLZ,0 WWCS
          from t_hcrw
          where hcjh_id=v_hcjhId and zfry_code2 is not null
          group by hcjh_id,ZFRY_CODE2,HCJG,ZFRY_NAME2,HCJGMC
        ) group by hcjh_id,ZFRY_CODE,HCJG,ZFRY_NAME,HCJGMC;
      --merge sczt data from hcrw
      p_step:=4;
      MERGE INTO t_sczt
      USING ( select XH,JHXH,NBXH,ZCH,QYMC,FDDBR,QYLXDL,DJJG,GXDW,XCR,XCSJ,WCBJ,ND,
                (select content from bm_djjg b where a.djjg=b.code) djjgmc,
                (select content from bm_gxdw b where a.gxdw=b.code) gxdwmc,
                (select estdate from hz_qyhznr where a.nbxh=hz_qyhznr.pripid) clrq,
                (select dom from hz_qyhznr where a.nbxh = hz_qyhznr.pripid) zs
              from gov_nbcc_jh_qy a where jhxh=v_gshcjh ) hcrw
      ON (hcrw.zch = t_sczt.xydm)
      WHEN MATCHED THEN
      update set name=hcrw.qymc,djjg=hcrw.djjg
      WHEN NOT MATCHED THEN
      insert(XYDM,NAME,ZTLX,HYFL,ZZXS,JYZT,FR,LXDH,MAIL,DJJG,JYDZ,LLR,QYBM,QYMC,clrq,zs)
      values(hcrw.zch,hcrw.qymc,hcrw.qylxdl,null,null,1,hcrw.FDDBR ,null ,null,hcrw.djjg,null ,null ,hcrw.gxdw,hcrw.gxdwmc,hcrw.clrq,hcrw.zs);
      p_step:=4;
      --插入双随机计划的核查年度列表，每个任务应该只有一个年度
      merge into t_hcrw_nd
      using(select id,nd from t_hcrw where plan_type=1) i_hcrw
      on(i_hcrw.id=t_hcrw_nd.hcrw_id and i_hcrw.nd=t_hcrw_nd.nd)
      WHEN NOT MATCHED THEN
      insert(hcrw_id,nd) values( i_hcrw.id,i_hcrw.nd);
    end prc_importByJhid;
  procedure prc_importDblink(p_hcjhId in varchar2) is
    v_hcjhId varchar2(100);
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_import.prc_importDblink','导入核查任务','导入核查任务',p_hcjhId,v_log_xh);
      --delete all old rows by jhid
      delete from t_hcrw where hcjh_id=v_hcjhId;
      v_step:=0;
      prc_importByJhid(p_hcjhId,v_step);
      v_step:=5;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_importDblink;
  --导入核查数据
  procedure prc_import_hc(p_HCRWID in varchar2) is
    v_xydm varchar2(400);--企业信用代码
    v_gsjhxh varchar2(200);--公示系统中的计划序号
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    v_sjly number:=1;
    v_plan_type t_hcjh.plan_type%type;
    v_nbxh varchar2(100);--企业内部序号
    v_nd number;--核查企业年报年度
    v_qymc varchar2(1000);--被核查企业名称
    v_zch varchar2(100);--被核查企业统一信用代码
    begin
      pkg_log.INFO('pkg_import.prc_import_hc','导入核查单位数据','导入核查单位数据',p_HCRWID,v_log_xh);
      /**
      根据核查任务编号，通过DBLINK从接口表中取得数据
      **/
      v_step:=0;
      select a.HCDW_XYDM,b.GSJHBH,a.plan_type into v_xydm,v_gsjhxh,v_plan_type from t_hcrw a,t_hcjh b where a.ID=p_hcrwid and a.hcjh_id=b.id;
      --根据计划类型，从不同的任务接口表中取得企业相关数据
      if(v_plan_type=pkg_hc.CONS_HCJH_PLAN_TYPE_SSJ) then
        select nbxh,nd,qymc,zch into v_nbxh,v_nd,v_qymc,v_zch from gov_nbcc_jh_qy where jhxh=v_gsjhxh and (zch=v_xydm or xydm=v_xydm);
      elsif(v_plan_type=pkg_hc.CONS_HCJH_PLAN_TYPE_RC) then
        select nbxh, nd,qymc,zch into v_nbxh,v_nd,v_qymc,v_zch from gov_nbcc_rc_qy where zch=v_xydm and rownum<=1;
        select b.nd into v_nd from t_hcjh a,t_hcrw b where a.id=b.hcjh_id and b.id=p_HCRWID;
      else
        v_nbxh:=null;
        v_nd:=null;
      end if;
      --删除历史数据
      v_step:=0;
      delete from t_nb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_dwdb where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_dwtz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_gdcz where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_GQBG where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_GQBG where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_wd where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      delete from t_nb_xzxk where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      delete from t_nb_bd_xzxk where (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid) and sjly=1;
      --年报基本情况
      v_step:=1;
      insert into t_nb(ND, XYDM, QYMC, TXDZ, MAIL, SFTZGMGQ, JYZT, SFYWZWD,
                       SFYDWDBXX, CYRS, SYZQYHJ, LRZE, ZYYWSR, JLR, NSZE, FZZE, LXDH,
                       gxbys_jy, gxbys_gg, tysbs_jy, tysbs_gg, cjrs_jy, cjrs_gg, zjys_jy, zjys_gg,
                       dj_frsfdy, dj_lxdh, dj_qtzw, dj_dyzs, dj_zcdys, dj_wzrs, dj_fzdys, dj_jjfzs, dj_sfjlzz, dj_wjlzzyy,zcze,YZBM,yyzsr,dj_dzzjz,dj_frdbsfdzzsj)
        select a.nd ND,v_zch XYDM,v_qymc QYMC, f.txdz TXDZ, f.dzyx MAIL, decode(trim(e.sfydwtz),'0','否','是') SFTZGMGQ,
               (select content from BM_TCKYQK g where g.code=a.yyzk) JYZT, decode(trim(e.sfywzwd),'0','否','是') SFYWZWD,
               case when (select count(1) from nnb_dwdb g where g.nd=v_nd and g.nbxh=v_nbxh)>0 then '是' else '否' end  SFYDWDBXX,
               e.cyrs CYRS, c.syzqyhj SYZQYHJ, c.LRZE LRZE, c.zyywsr ZYYWSR, c.jlr JLR, c.nsze NSZE, c.fzze FZZE,f.lxdh lxdh,
               nvl(e.COLGRANUM,0) gxbys_jy, nvl(e.COLEMPLNUM,0)  gxbys_gg, nvl(e.RETSOLNUM,0) tysbs_jy, nvl(e.RETEMPLNUM,0) tysbs_gg, nvl(e.DISPERNUM,0) cjrs_jy,
               nvl(e.DISEMPLNUM,0) cjrs_gg, nvl(e.UNENUM,0) zjys_jy, nvl(e.UNEEMPLNUM,0) zjys_gg,
               decode(trim(d.RESPARMSIGN),'1','是','2','否','其他') dj_frsfdy, d.lxdh dj_lxdh, d.RESPARSECSIGN dj_qtzw, d.NUMPARM dj_dyzs, d.ZCDYS dj_zcdys,
               d.WZRS dj_wzrs, d.BNXZDYRS dj_fzdys, d.jjfzs dj_jjfzs,
               case when d.parins=9 then '否' else '是' end dj_sfjlzz, d.wjlzzyy dj_wjlzzyy,
               c.zcze zcze,f.yzbm YZBM,c.QNYYSR yyzsr,d.dzzjz dj_dzzjz,d.frdbsfdzzsj dj_frdbsfdzzsj
        from nnb_jbqk a,nnb_zczk c,nnb_fgdj d,nnb_qtxx e,nnb_txxx f
        where a.nbxh=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid)
              and c.nbxh(+)=a.nbxh and c.nd(+)=a.nd
              and d.nbxh(+)=a.nbxh and d.nd(+)=a.nd
              and e.nbxh(+)=a.nbxh and e.nd(+)=a.nd
              and f.nbxh(+)=a.nbxh and f.nd(+)=a.nd;
      v_step:=11;
      insert into t_nb_bd(ND, XYDM, QYMC, TXDZ, MAIL, SFTZGMGQ, JYZT, SFYWZWD,
                          SFYDWDBXX, CYRS, SYZQYHJ, LRZE, ZYYWSR, JLR, NSZE, FZZE,LXDH,
                          gxbys_jy, gxbys_gg, tysbs_jy, tysbs_gg, cjrs_jy, cjrs_gg, zjys_jy, zjys_gg,
                          dj_frsfdy, dj_lxdh, dj_qtzw, dj_dyzs, dj_zcdys, dj_wzrs, dj_fzdys, dj_jjfzs, dj_sfjlzz, dj_wjlzzyy,zcze,YZBM,yyzsr,dj_dzzjz,dj_frdbsfdzzsj,sjly)
        select v_nd ND,v_zch XYDM,v_qymc QYMC, a.dom TXDZ, a.email MAIL,
               case when(select count(1) from hz_dwtz c where c.pripid=v_nbxh)>0 then '是' else '否' end SFTZGMGQ,
               '开业' JYZT, null SFYWZWD,
               null SFYDWDBXX,
               a.empnum CYRS, null SYZQYHJ, null LRZE, null ZYYWSR, null JLR, null NSZE, null FZZE,a.tel lxdh,
               0 gxbys_jy, 0  gxbys_gg, 0 tysbs_jy, 0 tysbs_gg, 0 cjrs_jy, 0 cjrs_gg, 0 zjys_jy, 0 zjys_gg,
               decode(trim(c.frdybz),'1','是','2','否','其他') dj_frsfdy, c.lxdh dj_lxdh, c.qtzw dj_qtzw, c.dyrs dj_dyzs, c.dyrs dj_zcdys, c.wzrs dj_wzrs, c.bnxzdyrs dj_fzdys,
               c.jjfzs dj_jjfzs, case when c.dzzjz=9 then '否' else '是' end dj_sfjlzz, c.wjlzzyy dj_wjlzzyy,
               null zcze,a.POSTALCODE YZBM,null yyzsr,c.dzzjz dj_dzzjz,decode(trim(c.FRDZZSJBZ),'1','是','2','否','其他') dj_frdbsfdzzsj,v_sjly sjly
        from hz_qyhznr a,hz_fgdj c
        where a.pripid=v_nbxh and c.pripid(+)=a.pripid;
      --对外担保
      v_step:=2;
      insert into t_nb_dwdb(id,ND, XYDM,ZQR, ZWR, ZZQZL, ZZQSE, LXZWQX, BZQJ, BZFS, BZDBFW)
        select sys_guid() id, a.ND nd,v_zch XYDM,a.more ZQR,a.MORTGAGOR ZWR,
               case trim(a.PRICLASECKIND) when '1' then '合同' when '2' then '其他' else '无' end ZZQZL, a.PRICLASECAM ZZQSE,
               to_char(a.PEFPERFORM,'yyyy/mm/dd')||'----'||to_char(a.PEFPERTO,'yyyy/mm/dd') LXZWQX,
               case trim(a.GUARANPERIOD) when '1' then '期限' when '2' then '未约定' else '无' end BZQJ,
               case trim(a.GATYPE) when '1' then '一般保证' when '2' then '连带保证' when '3' then '未约定' else '无' end BZFS,
               null BZDBFW
        from nnb_dwdb a
        where a.nbxh=v_nbxh and a.nd  in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      insert into t_nb_bd_dwdb(id,ND, XYDM,ZQR,ZWR, ZZQZL, ZZQSE, LXZWQX, BZQJ, BZFS, BZDBFW,sjly)
        select sys_guid() id, a.ND nd,v_zch XYDM,a.more ZQR,a.MORTGAGOR ZWR,PRICLASECKIND ZZQZL,a.PRICLASECAM ZZQSE,
               to_char(a.PEFPERFORM,'yyyy/mm/dd')||'----'||to_char(a.PEFPERTO,'yyyy/mm/dd') LXZWQX, GUARANPERIOD BZQJ, GATYPE BZFS,null BZDBFW,
               v_sjly sjly
        from hz_dwdb a
        where a.pripid=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      --对外投资
      v_step:=3;
      insert into t_nb_dwtz (id,ND, XYDM, TZQYMC,tzqy_zch)
        select sys_guid() id,a.ND, v_zch XYDM, a.entname TZQYMC,a.REGNO tzqy_zch
        from nnb_tz a
        where a.nbxh=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      v_step:=31;
      insert into t_nb_bd_dwtz (id,ND, XYDM, TZQYMC,tzqy_zch,sjly)
        select sys_guid() id,v_nd ND, v_zch XYDM, a.intentname TZQYMC,a.REGNO tzqy_zch,v_sjly sjly
        from hz_dwtz a
        where a.pripid=v_nbxh;
      --股东出资
      v_step:=4;
      insert into t_nb_gdcz (id,ND, XYDM, GD, RJCZE, RJCZDQSJ, RJCZFS, SJCZE, SJCZSJ, SJCZFS)
        select sys_guid() id,e.nd nd,e.xydm xydm, e.name gd,
               e.cze rjcze,e.czrq rjczrq,e.czfs rjczfs,f.cze sjcze,f.czrq sjczrq,f.czfs sjczfs
        from
          (select d.nbxh,d.nd,d.name,d.seq seq,
                                     (select content from BM_CZXS e where e.code=c.czfs) czfs,c.czrq,c.cze,v_zch xydm
           from nnb_fr d,nnb_frczqk c
           where d.nbxh=c.nbxh and d.seq=c.seq and d.nd=c.nd
                 and c.nbxh=v_nbxh and c.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid)
                 and c.czlx='1') e,
          (select d.nbxh,d.nd,d.name,d.seq seq,
                                     (select content from BM_CZXS e where e.code=c.czfs) czfs,c.czrq,c.cze,v_zch xydm
           from nnb_fr d,nnb_frczqk c
           where d.nbxh=c.nbxh and d.seq=c.seq and d.nd=c.nd
                 and c.nbxh=v_nbxh and c.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid)
                 and czlx='2') f
        where e.nbxh=f.nbxh(+) and e.nd=f.nd(+) and e.seq=f.seq(+);
      v_step:=41;
      insert into t_nb_bd_gdcz (id,ND, XYDM, GD, RJCZE, RJCZDQSJ, RJCZFS, SJCZE, SJCZSJ, SJCZFS,sjly)
        select sys_guid() id,v_nd ND, v_zch XYDM, a.inv GD, a.subconam RJCZE, a.baldelper RJCZDQSJ,
               (select content from BM_CZXS e where e.code=a.conform) RJCZFS,a.acconam SJCZE,a.condate SJCZSJ,
               (select content from BM_CZXS e where e.code=a.conform) SJCZFS,v_sjly sjly
        from hz_qytzf a
        where a.pripid=v_nbxh
              and substr(a.condate,1,4)<= (select max(b.nd) from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      --股权变更
      v_step:=5;
      insert into t_nb_GQBG (id,ND, XYDM, GD, BGQ_GQBL, BGH_GQBL, BGRQ)
        select sys_guid() id,a.ND, v_zch XYDM,a.INV GD, a.TRANSAMPR BGQ_GQBL, a.TRANSAMOR BGH_GQBL,a.ALTDATE BGRQ
        from NNB_GQBG a
        where a.nbxh=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      insert into t_nb_bd_GQBG (id,ND, XYDM, GD, BGQ_GQBL, BGH_GQBL, BGRQ,sjly)
        select sys_guid() id,v_nd ND, v_zch XYDM,a.INV GD, a.TRANSAMPR BGQ_GQBL, a.TRANSAMOR BGH_GQBL,a.ALTDATE BGRQ,v_sjly sjly
        from hz_gqbg a
        where a.pripid=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      --网店
      v_step:=6;
      insert into t_nb_wd (id,TYPE, NAME, WZ, ND, XYDM)
        select sys_guid() id,(select content from BM_WZLX c where c.code=a.WEBTYPE) TYPE,a.WEBSITNAME NAME,a.DOMAIN WZ, a.ND,v_zch XYDM
      from nnb_wzxx a
      where a.nbxh=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      insert into t_nb_bd_wd (id,TYPE, NAME, WZ, ND, XYDM,sjly)
        select sys_guid() id,a.WEBTYPE TYPE,a.WEBSITNAME NAME,a.DOMAIN WZ, a.ND,v_zch XYDM,v_sjly sjly
      from nnb_wzxx a
      where a.nbxh=v_nbxh and a.nd in(select b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=p_hcrwid);
      --导入即时数据
      v_step:=7;
      pkg_import.prc_import_js_hc(p_hcrwid,pkg_hc.CONS_HCLX_JH);
      v_step:=8;
      update t_hcrw set data_loaded=1 where id=p_hcrwId;--更新核查任务数据加载标志
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_import_hc;
  --导入任务前进行测试，目前只针对双随机计划进行测试
  procedure prc_testDblink(p_hcjhId in varchar2,p_rws out number,p_rys out number) is
    v_rws number;
    v_rys number;
    v_hcjhId varchar2(100);
    v_jhmc varchar2(200);
    v_cnt number;
    v_gshcjh varchar2(100);
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_import.prc_testDblink','测试核查计划','测试核查计划',p_hcjhId,v_log_xh);
      if(p_hcjhId is null) then
        v_hcjhId := sys_guid();
      else
        v_hcjhId:=p_hcjhId;
      end if;
      select jhmc,gsjhbh into v_jhmc,v_gshcjh from t_hcjh where ID=v_hcjhid;
      select count(1) into v_cnt from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh;

      select a.rws,b.rys1+c.rys2 into v_rws,v_rys from
        (select count(distinct zch) rws from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh) a,
        (select count(distinct pkg_hc.fun_get_xcr(1,xcr)) rys1 from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh) b,
        (select count(distinct pkg_hc.fun_get_xcr(2,xcr)) rys2 from gov_nbcc_jh_qy where xcr is not null and jhxh=v_gshcjh) c;
      p_rws := v_rws;
      p_rys :=v_rys;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_testDblink;
  --通过ORACLE JOB循环核查计划导入核查任务，只处理双随机计划
  procedure prc_job_hcrw is
    v_hcjh t_hcjh.id%type;
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    cursor hcjh is
      select * from t_hcjh where plan_type=pkg_hc.CONS_HCJH_PLAN_TYPE_SSJ;
    begin
      pkg_log.INFO('pkg_import.prc_job_hcrw','核查任务自动导入','核查计划建立后，开始自动导入后续产生的任务',null,v_log_xh);
      for o in hcjh loop
        v_hcjh:=o.id;
        prc_importByJhid(o.id,v_step);
      end loop;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      commit;
      exception
      when others then
      rollback;
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败，计划编号：'||v_hcjh||'；'||SQLERRM);
    end prc_job_hcrw;
  --导入即时核查任务，单独的过程，主要是从接口表中取得即时信息有变化的企业，将企业信息写入到T_JS_HCRW表中
  --应该是在JOB中自动运行此过程，前台程序只负责展示数据
  procedure prc_importJsRw is
    v_requiredFiles number;--任务中必须要上传的文件个数
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    v_zch  varchar2(100);--企业注册号码，写日志时使用
    v_hcrwid t_js_hcrw.id%type;--核查任务ID
    v_cnt number;--个数变量
    cursor cur_jsrw is --查询出所有有即时信息的企业及相对应的数据ID
      select distinct regno from(
        select regno from JS_HZ_GDCZ where read_flag=0
        union all
        select regno from JS_HZ_GQBG where read_flag=0
        union all
        select regno from JS_HZ_XZCF where read_flag=0
        union all
        select regno from JS_HZ_XZXK where read_flag=0
        union all
        select regno from JS_HZ_ZSCQ where read_flag=0
      );
    begin
      pkg_log.INFO('pkg_import.prc_importJsRw','导入即时核查任务','导入即时核查任务',null,v_log_xh);

      select count(1) into v_requiredFiles from t_hccl b
      where b.hcsx_id in(select id from t_hcsx where hclx=2)
            and b.sfbyx=1;
      --insert new data
      v_step:=1;
      for o in cur_jsrw loop
        v_step:=11;
        v_zch:=o.regno;
        v_hcrwid:=seq_hcrw.nextval;
        merge into t_js_hcrw
        using(select regno HCDW_XYDM,entname HCDW_NAME,
                     null ZFRY_CODE,null RWZT,1 HCFL,a.regorg HCJG,null HCJIEGUO,1 JYZT,null HCJGGSQK,null RLR,null RLRQ,null SJWCRQ,
                     null ZFRY_NAME,
                     (select content from bm_djjg b where b.code=a.regorg) HCJGMC,(select content from bm_djjg b where b.code=a.regorg) DJJGMC,regorg DJJG,qylxdl ZTLX,ZZXS,
                     localadm QYBM,(select content from bm_gxdw b where b.code=a.localadm) QYMC,
                     null RLRMC,ND,estdate clrq,dom zs
              from hz_qyhznr a where regno=o.regno) i_hcrw
        on(i_hcrw.hcdw_xydm=t_js_hcrw.hcdw_xydm)
        WHEN MATCHED THEN
        update set HCDW_NAME=i_hcrw.HCDW_NAME,
          JS_GS_FLAG=0,
          REQUIRED_FILES=v_requiredFiles
        WHEN NOT MATCHED THEN
        insert(ID,HCDW_XYDM,HCDW_NAME,ZFRY_CODE,RWZT,HCJG,HCJIEGUO,JYZT,HCJGGSQK,RLR,RLRQ,SJWCRQ,ZFRY_NAME,
               HCJGMC,DJJGMC,DJJG,ZTLX,ZZXS,QYBM,QYMC,RLRMC,ND,required_files,clrq,zs,JS_GS_FLAG)
        values(v_hcrwid,i_hcrw.HCDW_XYDM,i_hcrw.HCDW_NAME,i_hcrw.zfry_code,i_hcrw.RWZT,i_hcrw.HCJG,
          i_hcrw.HCJIEGUO,i_hcrw.JYZT,i_hcrw.HCJGGSQK,i_hcrw.zfry_code,sysdate,i_hcrw.SJWCRQ,i_hcrw.zfry_Name,
          i_hcrw.HCJGMC,i_hcrw.DJJGMC,i_hcrw.DJJG,i_hcrw.ZTLX,i_hcrw.ZZXS,i_hcrw.QYBM,i_hcrw.QYMC,i_hcrw.RLRMC,i_hcrw.ND,
          v_requiredFiles,i_hcrw.clrq,i_hcrw.zs,0);
        --merge sczt data from hcrw
        v_step:=14;
        MERGE INTO t_sczt
        USING ( select pripid NBXH,regno ZCH,entname QYMC,lerep FDDBR,QYLXDL,regorg DJJG,localadm GXDW,null XCR,sysdate XCSJ,0 WCBJ,to_char(sysdate,'yyyy') ND,
                       (select content from bm_djjg b where a.regorg=b.code) djjgmc,
                       (select content from bm_gxdw b where a.localadm=b.code) gxdwmc,
                       estdate clrq,dom zs
                from hz_qyhznr a where regno=o.regno ) hcrw
        ON (hcrw.zch = t_sczt.xydm)
        WHEN MATCHED THEN
        update set name=hcrw.qymc,djjg=hcrw.djjg
        WHEN NOT MATCHED THEN
        insert(XYDM,NAME,ZTLX,HYFL,ZZXS,JYZT,FR,LXDH,MAIL,DJJG,JYDZ,LLR,QYBM,QYMC,clrq,zs)
        values(hcrw.zch,hcrw.qymc,hcrw.qylxdl,null,null,1,hcrw.FDDBR ,null ,null,hcrw.djjg,null ,null ,hcrw.gxdw,hcrw.gxdwmc,hcrw.clrq,hcrw.zs);
        v_step:=15;
        --merge hcsxjg
        MERGE INTO t_js_hcsxjg
        USING ( select id HCSX_ID,v_hcrwid HCRW_ID,NAME,null HCJG,4 HCFS,null QYGSNR,null BZNR,1 HCZT,null SM,PAGE,HCLX,null SJNR,DBXXLY
                from t_hcsx where hclx=2) hcsxjg
        ON (t_js_hcsxjg.HCSX_ID = hcsxjg.HCSX_ID and t_js_hcsxjg.HCRW_ID = hcsxjg.HCRW_ID )
        WHEN MATCHED THEN
        update set DBXXLY=hcsxjg.DBXXLY
        WHEN NOT MATCHED THEN
        insert(HCSX_ID,HCRW_ID,NAME,HCJG,HCFS,QYGSNR,BZNR,HCZT,SM,PAGE,HCLX,SJNR,DBXXLY)
        values(hcsxjg.HCSX_ID,hcsxjg.HCRW_ID,hcsxjg.NAME,hcsxjg.HCJG,hcsxjg.HCFS,hcsxjg.QYGSNR,hcsxjg.BZNR,hcsxjg.HCZT,hcsxjg.SM,hcsxjg.PAGE,hcsxjg.HCLX,hcsxjg.SJNR,hcsxjg.DBXXLY);
      end loop;
      --循环处理有即时信息的企业，从接口表中判断即时信息是否已经全部公示
      for o in(select * from t_js_hcrw where JS_GS_FLAG=0) loop
        --首先把JS_GS_FLAG设置成1，标明已经全部公示，然后再挨个表进行判断，如果没有全部公示，再改成0
        update t_js_hcrw set JS_GS_FLAG=1 where id=o.id;
        --股东出资即时信息
        select count(1) into v_cnt from(
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from JS_HZ_GDCZ
          minus
          select GD,BGRQ,RJE,SJE,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ from JS_GS_GDCZ
        );
        if(v_cnt>0) then
          update t_js_hcrw set JS_GS_FLAG=0 where id=o.id;
          return;--有未公示信息，修改JS_GS_FLAG=0后直接返回
        end if;
        --股权变更即时信息
        select count(1) into v_cnt from(
          select GD,BGRQ,BGQBL,BGHBL from JS_HZ_GQBG
          minus
          select GD,BGRQ,BGQBL,BGHBL from JS_GS_GQBG
        );
        if(v_cnt>0) then
          update t_js_hcrw set JS_GS_FLAG=0 where id=o.id;
          return;--有未公示信息，修改JS_GS_FLAG=0后直接返回
        end if;
        --行政处罚即时信息
        select count(1) into v_cnt from(
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from JS_HZ_XZCF
          minus
          select XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ from JS_GS_XZCF
        );
        if(v_cnt>0) then
          update t_js_hcrw set JS_GS_FLAG=0 where id=o.id;
          return;--有未公示信息，修改JS_GS_FLAG=0后直接返回
        end if;
        --行政许可即时信息
        select count(1) into v_cnt from(
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from JS_HZ_XZXK
          minus
          select XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,XQ from JS_GS_XZXK
        );
        if(v_cnt>0) then
          update t_js_hcrw set JS_GS_FLAG=0 where id=o.id;
          return;--有未公示信息，修改JS_GS_FLAG=0后直接返回
        end if;
        --知识产权即时信息
        select count(1) into v_cnt from(
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from JS_HZ_ZSCQ
          minus
          select CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,BHQK from JS_GS_ZSCQ
        );
        if(v_cnt>0) then
          update t_js_hcrw set JS_GS_FLAG=0 where id=o.id;
          return;--有未公示信息，修改JS_GS_FLAG=0后直接返回
        end if;
      end loop;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      commit;
      exception
      when others then
      rollback;
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'-'||v_zch||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'-'||v_zch||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_importJsRw;
  --导入即时核查数据 p_hclx标明是年报核查还是即时核查
  procedure prc_import_js_hc(p_HCRWID in varchar2,p_hclx in number) is
    v_xydm varchar2(400);--企业信用代码
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    begin
      pkg_log.INFO('pkg_import.prc_import_js_hc','导入核查单位即时数据','导入核查单位即时数据',p_HCRWID||':'||to_char(p_hclx),v_log_xh);
      /**
      根据核查任务编号，通过DBLINK从接口表中取得数据
      **/
      v_step:=0;
      if(p_hclx=pkg_hc.CONS_HCLX_JH) then
        select a.HCDW_XYDM into v_xydm from t_hcrw a where a.ID=p_hcrwid;
      else
        select a.HCDW_XYDM into v_xydm from t_js_hcrw a where a.ID=p_hcrwid;
      end if;
      --删除历史数据
      v_step:=0.1;
      delete from t_js_gdcz where id not in(select id from js_hz_gdcz) and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_bd_gdcz where id not in(select id from js_gs_gdcz) and sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_gqbg where id not in(select id from JS_HZ_GQBG) and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_bd_gqbg where id not in(select id from JS_gs_GQBG) and sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_xzcf where id not in(select id from JS_HZ_XZCF) and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_bd_xzcf where id not in(select id from JS_gs_XZCF) and sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_xzxk where id not in(select id from JS_HZ_XZXK) and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_bd_xzxk where id not in(select id from JS_gs_XZXK) and sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_zscq where id not in(select id from JS_HZ_ZSCQ) and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);
      delete from t_js_bd_zscq where id not in(select id from JS_gs_ZSCQ) and sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS and xydm= (select a.hcdw_xydm from t_hcrw a where a.id=p_hcrwid);

      --股东出资
      v_step:=1;
      insert into t_js_gdcz(XYDM,GD,BGRQ,RJE,SJE,GSSJ,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ,ID)
        select regno XYDM,GD,BGRQ,RJE,SJE,GSSJ,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ,ID
        from js_hz_gdcz a
        where a.regno=v_xydm and id not in(select id from t_js_gdcz);
      v_step:=11;
      insert into t_js_bd_gdcz(SJLY,ID,XYDM,GD,BGRQ,RJE,SJE,GSSJ,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ)
        select pkg_hc.CONS_HCSXJG_DBXXLY_JSGS SJLY,ID,regno XYDM,GD,BGRQ,RJE,SJE,GSSJ,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ
        from js_gs_gdcz a
        where a.regno=v_xydm and id not in(select id from t_js_bd_gdcz where sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS);
      --update js_hz_gdcz set read_flag=1 where read_flag=0;
      --update js_gs_gdcz set read_flag=1 where read_flag=0;
      --股权变更
      v_step:=2;
      insert into t_js_gqbg(XYDM,GD,BGRQ,BGQBL,BGHBL,GSSJ,ID)
        select regno XYDM,GD,BGRQ,BGQBL,BGHBL,GSSJ,ID
        from JS_HZ_GQBG a
        where a.regno=v_xydm and id not in(select id from t_js_gqbg);
      v_step:=21;
      insert into t_js_bd_gqbg(SJLY,XYDM,GD,BGRQ,BGQBL,BGHBL,GSSJ,ID)
        select pkg_hc.CONS_HCSXJG_DBXXLY_JSGS SJLY,regno XYDM,GD,BGRQ,BGQBL,BGHBL,GSSJ,ID
        from JS_GS_GQBG a
        where a.regno=v_xydm and id not in(select id from t_js_bd_gqbg where sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS);
      --update JS_HZ_GQBG set read_flag=1 where read_flag=0;
      --update JS_GS_GQBG set read_flag=1 where read_flag=0;
      --行政处罚
      v_step:=3;
      insert into t_js_xzcf(XYDM,XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ,GSSJ,ID)
        select regno XYDM,XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ,GSSJ,ID
        from JS_HZ_XZCF a
        where a.regno=v_xydm and id not in(select id from t_js_xzcf);
      v_step:=31;
      insert into t_js_bd_xzcf(SJLY,ID,XYDM,XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ,GSSJ)
        select pkg_hc.CONS_HCSXJG_DBXXLY_JSGS SJLY,ID,regno XYDM,XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ,GSSJ
        from JS_GS_XZCF a
        where a.regno=v_xydm and id not in(select id from t_js_bd_xzcf where sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS);
      --update JS_HZ_XZCF set read_flag=1 where read_flag=0;
      --update JS_GS_XZCF set read_flag=1 where read_flag=0;
      --行政许可
      v_step:=4;
      insert into t_js_xzxk(XYDM,XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,GSSJ,XQ,HDRQ,ID)
        select regno XYDM,XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,GSSJ,XQ,HDRQ,ID
        from JS_HZ_XZXK a
        where a.regno=v_xydm and id not in(select id from t_js_xzxk);
      v_step:=41;
      insert into t_js_bd_xzxk(HDRQ,ID,SJLY,XYDM,XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,GSSJ,XQ)
        select HDRQ,ID,pkg_hc.CONS_HCSXJG_DBXXLY_JSGS SJLY,regno XYDM,XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,GSSJ,XQ
        from JS_GS_XZXK a
        where a.regno=v_xydm and id not in(select id from t_js_bd_xzxk where sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS);
      --update JS_HZ_XZXK set read_flag=1 where read_flag=0;
      --update JS_GS_XZXK set read_flag=1 where read_flag=0;
      --知识产权
      v_step:=5;
      insert into t_js_zscq(ID,XYDM,CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,GSSJ,BHQK)
        select ID,regno XYDM,CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,GSSJ,BHQK
        from JS_HZ_zscq a
        where a.regno=v_xydm and id not in(select id from t_js_zscq);
      v_step:=51;
      insert into t_js_bd_zscq(ID,SJLY,XYDM,CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,GSSJ,BHQK)
        select ID,pkg_hc.CONS_HCSXJG_DBXXLY_JSGS SJLY,regno XYDM,CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,GSSJ,BHQK
        from JS_GS_zscq a
        where a.regno=v_xydm and id not in(select id from t_js_bd_zscq where sjly=pkg_hc.CONS_HCSXJG_DBXXLY_JSGS);
      --update JS_HZ_zscq set read_flag=1 where read_flag=0;
      --update JS_GS_zscq set read_flag=1 where read_flag=0;
      v_step:=6;
      update t_js_hcrw set data_loaded=1 where id=p_hcrwId;--更新核查任务数据加载标志
      pkg_log.UPDATELOG(v_log_xh,'成功');
      exception
      when others then
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败；'||SQLERRM);
      RAISE_APPLICATION_ERROR(-20010, v_step||'；运行失败；'||SQLCODE||'；'||SQLERRM);
    end prc_import_js_hc;
  --循环GOV_NBCC_RC_QY表，根据规则，将企业自动加入到对应的核查计划中；需要将此过程放在自动任务中执行
  /*
    规则如下：
    1、各单位增加一个日常监管的经营异常计划，指定计划编号，每年新建核查计划时手动修改存储过程。检查单位是各个登记机关。
    交换数据规则：按照gov_nbcc_rc_qy表中的hcjg关联t_hcjh表的检查机关，多条经营异常记录只取一条。
    核查人根据登记机关随机选取一个
  */
  procedure prc_rc_autohandle is
    cursor cur_djjg is--gov_nbcc_rc_qy表中的全部决定机关，做为登记机关来循环处理
      select distinct djjg from gov_nbcc_rc_qy where djjg is not null and lrsy like '%《企业信息公示暂行条例》%';
    cursor cur_djjg_rc_qy(p_jdjg in varchar2,p_jhbh in varchar2) is
      select distinct a.id,b.zch from t_hcjh a,gov_nbcc_rc_qy b
      where a.jhbh =p_jhbh
            and b.jdjg=p_jdjg
            and a.plan_type=2
            and b.lrsy like '%《企业信息公示暂行条例》%'
            and not exists(select 1 from t_hcrw c where c.hcjh_id=a.id and c.hcdw_xydm=b.zch and (select count(1) from t_hcrw d where d.hcjh_id=a.id and d.hcdw_xydm=b.zch)=3);
    v_zfry varchar2(100);--执法人员代码
    v_zfry_name varchar2(100);--执法人员名称
    v_handle_cnt number;--一次处理的个数
    v_handle_all number;--共处理的个数
    v_zchs varchar2(4000);--注册号列表
    v_jhid varchar2(100);--核查计划主键代码
    v_log_xh number;--日志序号
    v_step number;
    v_jhbh varchar2(100);--计算出来的计划编号
    begin
      for o in cur_djjg loop
        begin
          v_step:=1;
          v_handle_cnt:=0;
          v_handle_all:=0;
          v_zchs:='';
          pkg_log.INFO('pkg_import.prc_rc_autohandle','导入日常核查任务','自动导入日常核查任务',o.djjg,v_log_xh);
          select user_id,name into v_zfry,v_zfry_name from sys_user where org_id=o.djjg and rownum<=1;
          v_step:=2;
          v_jhbh:=o.djjg||'16';--根据规则计算计划编号
          select id into v_jhid from t_hcjh where jhbh=v_jhbh;--根据计算出来的计划编号查询对应的计划主键
          for p in cur_djjg_rc_qy(o.djjg,v_jhbh) loop
            v_handle_cnt:=v_handle_cnt+1;
            v_handle_all:=v_handle_all+1;
            v_step:=3;
            v_zchs:=v_zchs||p.zch||',';
            if(v_handle_cnt>=200) then
              v_step:=4;
              v_zchs:=substr(v_zchs,1,length(v_zchs)-1);
              prc_importRcRwAll(v_jhid,v_zchs,v_zfry,v_zfry_name,1,v_log_xh);
              v_step:=5;
              v_handle_cnt:=0;
              v_zchs:='';
            end if;
          end loop;
          if(length(v_zchs)>1) then
            v_zchs:=substr(v_zchs,1,length(v_zchs)-1);
            v_step:=6;
            prc_importRcRwAll(v_jhid,v_zchs,v_zfry,v_zfry_name,1,v_log_xh);
            v_step:=7;
          end if;
          v_step:=8;
          pkg_log.UPDATELOG(v_log_xh,'成功，共处理'||v_handle_all||'个企业');
          commit;
          exception
          when others then
          rollback;
          pkg_log.updatelog(v_log_xh,SQLCODE,v_step||':计划编号-'||v_jhbh||'；运行失败'||'；'||SQLERRM);
        end;
      end loop;
      --陕西特有
      update t_hcrw set zfry_code1='100918',zfry_code2='100905',zfry_name1='庞国锋',zfry_name2='周迅',rlr='100918',rlrmc='庞国锋',rlrq=sysdate
      where hcjg='610000' and jhbh like '610000%';
      update t_hcrw set djjg=hcjg,djjgmc=hcjgmc where hcjg<>djjg and jhbh like '610%';
      commit;
      --陕西特有
    end prc_rc_autohandle;

  --部分企业有统一信用代码，将此企业XYDM字段更新成统一信用代码
  --此过程应该放到JOB中运行
  procedure prc_job_updateXydmFromZch is
    v_xydm varchar2(100);
    v_log_xh number;--日志序号
    v_step number;--运行的步骤，日志中使用
    cursor qys is
      select * from
        (select distinct nbxh,zch_old zch,xydm from gov_nbcc_jh_qy union all select distinct nbxh,zch_old zch,xydm from gov_nbcc_rc_qy) a
      where exists(select 1 from t_sczt b where b.xydm=a.zch)
            and not exists(select 1 from t_sczt b where b.xydm=a.xydm)
            and a.xydm is not null;
    begin
      v_step:=1;
      pkg_log.INFO('pkg_import.prc_job_updateXydmFromZch','更新企业XYDM字段','部分企业有统一信用代码，将此企业XYDM字段更新成统一信用代码',null,v_log_xh);
      for o in qys loop
        v_xydm:=o.xydm;
        v_step:=2;
        update t_sczt set xydm=o.xydm where xydm=o.zch;
        v_step:=3;
        update T_GZXX set HCDW_XYDM=o.xydm where HCDW_XYDM=o.zch;
        v_step:=4;
        update T_HCCLMX set HCDW_XYDM=o.xydm where HCDW_XYDM=o.zch;
        v_step:=5;
        update T_HCCL_FUR set HCDW_XYDM=o.xydm where HCDW_XYDM=o.zch;
        v_step:=6;
        update T_HCRW set HCDW_XYDM=o.xydm where HCDW_XYDM=o.zch;
        v_step:=7;
        update T_TOKEN set xydm=o.xydm where xydm=o.zch;
        v_step:=8;
        update T_XGJL set xydm=o.xydm where xydm=o.zch;
        v_step:=9;
        update T_JS_BD_GDCZ set xydm=o.xydm where xydm=o.zch;
        v_step:=10;
        update T_JS_BD_GQBG set xydm=o.xydm where xydm=o.zch;
        v_step:=11;
        update T_JS_BD_XZCF set xydm=o.xydm where xydm=o.zch;
        v_step:=12;
        update T_JS_BD_XZXK set xydm=o.xydm where xydm=o.zch;
        v_step:=13;
        update T_JS_BD_ZSCQ set xydm=o.xydm where xydm=o.zch;
        v_step:=14;
        update T_JS_GDCZ set xydm=o.xydm where xydm=o.zch;
        v_step:=15;
        update T_JS_GQBG set xydm=o.xydm where xydm=o.zch;
        v_step:=16;
        update T_JS_HCRW set hcdw_xydm=o.xydm where hcdw_xydm=o.zch;
        v_step:=17;
        update T_JS_XZCF set xydm=o.xydm where xydm=o.zch;
        v_step:=18;
        update T_JS_XZXK set xydm=o.xydm where xydm=o.zch;
        v_step:=19;
        update T_JS_ZSCQ set xydm=o.xydm where xydm=o.zch;
        v_step:=20;
        update T_NB set xydm=o.xydm where xydm=o.zch;
        v_step:=21;
        update T_NB_BD set xydm=o.xydm where xydm=o.zch;
        v_step:=22;
        update T_NB_BD_DWDB set xydm=o.xydm where xydm=o.zch;
        v_step:=23;
        update T_NB_BD_DWTZ set xydm=o.xydm where xydm=o.zch;
        v_step:=24;
        update T_NB_BD_GDCZ set xydm=o.xydm where xydm=o.zch;
        v_step:=25;
        update T_NB_BD_GQBG set xydm=o.xydm where xydm=o.zch;
        v_step:=26;
        update T_NB_BD_WD set xydm=o.xydm where xydm=o.zch;
        v_step:=27;
        update T_NB_BD_XZXK set xydm=o.xydm where xydm=o.zch;
        v_step:=28;
        update T_NB_DWDB set xydm=o.xydm where xydm=o.zch;
        v_step:=29;
        update T_NB_DWTZ set xydm=o.xydm where xydm=o.zch;
        v_step:=30;
        update T_NB_GDCZ set xydm=o.xydm where xydm=o.zch;
        v_step:=31;
        update T_NB_GQBG set xydm=o.xydm where xydm=o.zch;
        v_step:=32;
        update T_NB_WD set xydm=o.xydm where xydm=o.zch;
        v_step:=33;
        update T_NB_XZXK set xydm=o.xydm where xydm=o.zch;
      end loop;
      v_step:=9;
      pkg_log.UPDATELOG(v_log_xh,'成功');
      commit;
      exception
      when others then
      rollback;
      pkg_log.updatelog(v_log_xh,SQLCODE,v_step||'；运行失败，企业信用代码：'||v_xydm||'；'||SQLERRM);
    end prc_job_updateXydmFromZch;

end pkg_import;
