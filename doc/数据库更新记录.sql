--20160902  已经全部更新
        ----------------------------
        --  Changed table t_hccl  --
        ----------------------------
        -- Add/modify columns
        alter table T_HCCL add dxn_type INTEGER;
        -- Add comments to the columns
        comment on column T_HCCL.dxn_type
          is '财务核查关联标志: 1:电子财务数据,2:报表数据';
        --------------------------------
        --  Changed table t_material  --
        --------------------------------
        -- Add/modify columns
        alter table T_MATERIAL add dxn_type INTEGER;
        -- Add comments to the columns
        comment on column T_MATERIAL.dxn_type
          is '1:电子财务数据,2:报表数据';
        --新数据
        insert into x_codelist (NAME, VALUE, LITERAL, EDIT_FLAG, STYLE, DESCN)
        values ('dxnType', '1', '财务电子数据', 1, null, '财务核查数据标志');
        insert into x_codelist (NAME, VALUE, LITERAL, EDIT_FLAG, STYLE, DESCN)
        values ('dxnType', '2', '企业公示信息自查表', 1, null, '财务核查数据标志');
        commit;

--20160908  已经全部更新
          --pkg_hc;
        update t_hcsx set page='subsistStatus' where id='08f630ac1b3947d2ab91e572c3f75e01';
        update sys_res set name= '财务深度查账' where id='4102';
--20160921   已经全部更新
        /**
        更新pkh_import存储过程
          将prc_importRcRw改成prc_importRcRwAll并增加参数变量p_rlbz，参看21-24行 34-44 85-91 108-111
          prc_importRcRw直接调用prc_importRcRwAll，并设置p_rlbz=0
          增加prc_importRcRwShortcut过程，调用prc_importRcRwAll，并设置p_rlbz=1

          prc_removeRcRw 162-165
        */
        update t_hcsx set page='stockRightChange' where id='5b76bf93df5d418ca809d3ab77230b38';
        --更新ztlx字段为字符型
        alter table t_sczt add ztlx2 varchar2(100);
        update t_sczt set ztlx2=ztlx;
        update t_sczt set ztlx=null;
        alter table t_sczt modify ztlx varchar2(100);
        update t_sczt set ztlx=ztlx2;
        alter table t_sczt drop column ztlx2;

        alter table t_hcrw add ztlx2 varchar2(100);
        update t_hcrw set ztlx2=ztlx;
        update t_hcrw set ztlx=null;
        alter table t_hcrw modify ztlx varchar2(100);
        update t_hcrw set ztlx=ztlx2;
        alter table t_hcrw drop column ztlx2;

        truncate table t_hcsx_qylx;
        alter table t_hcsx_qylx modify ztlx_id varchar2(100);
        insert into t_hcsx_qylx
          select value,LITERAL,id,b.name from x_codelist a,t_hcsx b where a.name='qylxdl';
        commit;
        --修改接口表数据主键设置
        alter table T_NB_BD_XZXK
          drop constraint PK_T_BD_XZXKXX cascade drop index;

        alter table T_JS_BD_GDCZ modify hcrw_id not null;
        alter table T_JS_BD_GDCZ modify sjly not null;
        alter table T_JS_BD_GQBG modify hcrw_id not null;
        alter table T_JS_BD_GQBG modify sjly not null;
        alter table T_JS_BD_XZCF modify hcrw_id not null;
        alter table T_JS_BD_XZCF modify sjly not null;
        alter table T_JS_BD_XZXK modify hcrw_id not null;
        alter table T_JS_BD_XZXK modify sjly not null;
        alter table T_JS_BD_ZSCQ modify hcrw_id not null;
        alter table T_JS_BD_ZSCQ modify sjly not null;
        alter table T_JS_GDCZ modify hcrw_id not null;
        alter table T_JS_GQBG modify hcrw_id not null;
        alter table T_JS_XZCF modify hcrw_id not null;
        alter table T_JS_XZXK modify hcrw_id not null;
        alter table T_JS_ZSCQ modify hcrw_id not null;
        alter table T_NB_BD modify hcrw_id not null;

        alter table T_JS_BD_GDCZ
        drop constraint PK_T_JS_BD_GDCZ cascade drop index;
        alter table T_JS_BD_GDCZ
        add constraint PK_T_JS_BD_GDCZ primary key (HCRW_ID, XYDM, GD, BGRQ, SJLY);
        alter table T_JS_BD_GQBG
        drop constraint PK_T_JS_BD_GQBG cascade drop index;
        alter table T_JS_BD_GQBG
        add constraint PK_T_JS_BD_GQBG primary key (HCRW_ID, XYDM, GD, BGRQ, SJLY);
        alter table T_JS_BD_XZCF
        drop constraint PK_T_JS_BD_XZCF cascade drop index;
        alter table T_JS_BD_XZCF
        add constraint PK_T_JS_BD_XZCF primary key (HCRW_ID, XYDM, XZCFJDSWH, SJLY);
        alter table T_JS_BD_XZXK
        drop constraint PK_T_JS_BD_XZXK cascade drop index;
        alter table T_JS_BD_XZXK
        add constraint PK_T_JS_BD_XZXK primary key (HCRW_ID, XYDM, XKWJBH, SJLY);
        alter table T_JS_BD_ZSCQ
        drop constraint PK_T_JS_BD_ZSCQ cascade drop index;
        alter table T_JS_BD_ZSCQ
        add constraint PK_T_JS_BD_ZSCQ primary key (HCRW_ID, XYDM, CZRMC, ZL, SJLY);
        alter table T_JS_GDCZ
        drop constraint PK_T_JS_GDCZ cascade drop index;
        alter table T_JS_GDCZ
        add constraint PK_T_JS_GDCZ primary key (HCRW_ID, XYDM, GD, BGRQ);
        alter table T_JS_GQBG
        drop constraint PK_T_JS_GQBG cascade drop index;
        alter table T_JS_GQBG
        add constraint PK_T_JS_GQBG primary key (HCRW_ID, XYDM, GD, BGRQ);
        alter table T_JS_XZCF
        drop constraint PK_T_JS_XZCF cascade drop index;
        alter table T_JS_XZCF
        add constraint PK_T_JS_XZCF primary key (HCRW_ID, XYDM, XZCFJDSWH);
        alter table T_JS_XZXK
        drop constraint PK_T_JS_XZXK cascade drop index;
        alter table T_JS_XZXK
        add constraint PK_T_JS_XZXK primary key (HCRW_ID, XYDM, XKWJBH);
        alter table T_JS_ZSCQ
        drop constraint PK_T_JS_ZSCQ cascade drop index;
        alter table T_JS_ZSCQ
        add constraint PK_T_JS_ZSCQ primary key (HCRW_ID, XYDM, CZRMC, ZL);
        alter table T_NB_BD
          drop constraint PK_T_NB_BD cascade drop index;
        alter table T_NB_BD
          add constraint PK_T_NB_BD primary key (HCRW_ID, ND, XYDM, SJLY);
        alter table T_NB_BD_DWTZ
          drop constraint PK_T_NB_BD_DWTZ cascade drop index;
        alter table T_NB_BD_DWTZ
          add constraint PK_T_NB_BD_DWTZ primary key (ID);
        alter table T_NB_BD_GDCZ
          drop constraint PK_T_NB_BD_GDCZ cascade drop index;
        alter table T_NB_BD_GDCZ
          add constraint PK_T_NB_BD_GDCZ primary key (ID);
        alter table T_NB_BD_GQBG
          drop constraint PK_T_NB_BD_GQBG cascade drop index;
        alter table T_NB_BD_GQBG
          add constraint PK_T_NB_BD_GQBG primary key (ID);
        alter table T_NB_BD_WD
          drop constraint PK_T_NB_BD_WD cascade drop index;
        alter table T_NB_BD_WD
          add constraint PK_T_NB_BD_WD primary key (ID);
        alter table T_NB_BD_XZXK
          drop constraint PK_T_NB_BD_XZXK cascade drop index;
        alter table T_NB_BD_XZXK
          add constraint PK_T_NB_BD_XZXK primary key (ID);

        create index IDX_T_NB_BD_DWDB_1 on T_NB_BD_DWDB (HCRW_ID);
        create index IDX_T_NB_BD_DWTZ_1 on T_NB_BD_DWTZ (HCRW_ID);
        create index IDX_T_NB_BD_GDCZ_1 on T_NB_BD_GDCZ (HCRW_ID);
        create index IDX_T_NB_BD_GQBG_1 on T_NB_BD_GQBG (HCRW_ID);
        create index IDX_T_NB_BD_WD_1 on T_NB_BD_WD (HCRW_ID);
        create index IDX_T_NB_BD_XZXK_1 on T_NB_BD_XZXK (HCRW_ID);
        create index IDX_T_NB_DWDB_1 on T_NB_DWDB (HCRW_ID);
        create index IDX_T_NB_DWTZ_1 on T_NB_DWTZ (HCRW_ID);
        create index IDX_T_NB_GDCZ_1 on T_NB_GDCZ (HCRW_ID);
        create index IDX_T_NB_GQBG_1 on T_NB_GQBG (HCRW_ID);
        create index IDX_T_NB_WD_1 on T_NB_WD (HCRW_ID);
        create index IDX_T_XZXKXX_1 on T_NB_XZXK (HCRW_ID);
        comment on column T_SCZT.ztlx is '主体类型';
        comment on column T_HCRW.ztlx is '企业主体类型';

--20161013 陕西更新 重庆更新
        alter table t_hcrw add zcb_result varchar2(4000);
        --pkg_hc 915
        --  v_hcsx_sm||(select zcb_result from t_hcrw where id=p_HCRWID)
--20161018 陕西更新  重庆更新
        update t_hcsx_sm set content='企业填报信息与登记系统中登记/备案信息不一致' where id='637ad23f755b459ebe5979c5d4ce8bfb';
        update t_hcsx_sm set content='企业填报邮政编码信息与登记备案的信息不一致。' where id='cb256913b57a4d869904eba74e053733';
        update t_hcsx_sm set content='企业填报邮政编码信息与根据企业提供的通讯地址的实际邮政编码信息不一致。' where id='0b33abd176294168a8e095b37aea2471';
        commit;
        --pkg_hc 1114
        /*begin
          select * into v_t_nb_bd_1 from t_nb_bd where nd=v_t_hcrw.nd and xydm=v_t_hcrw.hcdw_xydm and sjly=1;
          exception
          when others then
          v_t_nb_bd_1:=null;
        end;*/
        update t_hcrw set sjwcrq = null where rwzt<>5 and sjwcrq is not null;
        INSERT INTO SYS_RES T (ID, NAME, PARENT_ID, IDENTITY, URL, PARENT_IDS, ICON, WEIGHT, TYPE)
        VALUES (510801, '审核', 5108, '5108' || CHR(58) || 'btnShowAuditDialog', NULL, '0/5/51/5108/', 'r12_c19', 1, NULL);
        INSERT INTO SYS_RES T (ID, NAME, PARENT_ID, IDENTITY, URL, PARENT_IDS, ICON, WEIGHT, TYPE)
        VALUES (510802, '取消审核', 5108, '5108' || CHR(58) || 'btnCancelAuditStatus', NULL, '0/5/51/5108/', 'r12_c19', 1, NULL);
        COMMIT;
--20101021 陕西更新 数据库日常监管修改的内容重庆不更新
        --pkg_hc prc_getHcsxjg
        --20161026
        --pkg_import 89  /*i_hcrw.ND*/v_jhnd-1
        --pkg_import 323 select a.nd-1 into v_nd from t_hcjh a,t_hcrw b where a.id=b.hcjh_id and b.id=p_HCRWID;--日常监管计划的任务年度直接取计划年度减1
        -- Create/Recreate indexes
        create unique index idx_t_hcjh_1 on T_HCJH (jhmc);
--20161031 陕西更新 数据库日常监管修改的内容重庆不更新
        --pkg_import 64-90 hcrw表中的djjg从接口表中的hcjg取得
        /*merge into t_hcrw
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
                    from gov_nbcc_rc_qy where zch=o.zch and rownum<=1) a) i_hcrw
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
               HCJGMC,DJJGMC,DJJG,ZTLX,ZZXS,QYBM,QYMC,RLRMC,JHWCRQ,ND,JHMC,JHXDRQ,NR,JHBH,required_files,clrq,zs,plan_type,jhnd,lrrq)
        values(seq_hcrw.nextval,i_hcrw.HCJH_ID,i_hcrw.HCDW_XYDM,i_hcrw.HCDW_NAME,v_zfryId,null,v_RWZT,i_hcrw.HCFL,i_hcrw.HCJG,
          i_hcrw.HCJIEGUO,i_hcrw.JYZT,i_hcrw.HCJGGSQK,v_rlr,v_rlrq,i_hcrw.SJWCRQ,p_zfryName,i_hcrw.ZFRY_NAME2,
          i_hcrw.HCJGMC,i_hcrw.DJJGMC,i_hcrw.DJJG,i_hcrw.ZTLX,i_hcrw.ZZXS,i_hcrw.QYBM,i_hcrw.QYMC,v_userName,i_hcrw.JHWCRQ,*//*i_hcrw.ND*//*v_jhnd-1,i_hcrw.JHMC,
          i_hcrw.JHXDRQ,i_hcrw.NR,i_hcrw.JHBH,v_requiredFiles,i_hcrw.clrq,i_hcrw.zs,v_plan_type,v_jhnd,i_hcrw.lrrq);*/
--20161101 陕西更新 数据库日常监管修改的内容重庆不更新
    --pkg_import 4 procedure prc_importRcRwAll(p_hcjhId in varchar2,p_zchList varchar2,p_userId varchar2,p_zfryName varchar2,p_rlbz number,p_parent_xh number default null)
    --        25 pkg_log.INFO('pkg_import.prc_importRcRw','导入日常核查任务','导入日常核查任务'||p_parent_xh,p_hcjhId,v_log_xh);
    --pkg_import 增加 procedure prc_rc_autohandle is
--20161109 陕西更新 数据库日常监管修改的内容重庆不更新
    --pkg_import 人员数如果为空则转为0
    --PKG_hc 898 人数比较中只比较cyrs
    --pkg_hc 1226 prc_gethcsxjg 人员数据只取从业人员
--20161115 陕西更新
    --pkg_import 372  '开业' JYZT

--20170103  陕西更新
  --pkg_import
  --pkg_hc
create table SCT_DWDB
(
        xydm   VARCHAR2(100) not null,
        nd     NUMBER not null,
        tbrq   DATE,
        xh     NUMBER not null,
        zqr    VARCHAR2(1000),
        zwr    VARCHAR2(1000),
        zzqzl  VARCHAR2(100),
        zzqse  NUMBER,
        lxzwqx DATE,
        bzqj   VARCHAR2(100),
        bzfs   VARCHAR2(100),
        bzdbfw VARCHAR2(1000)
)
;
comment on table SCT_DWDB
is '企业自查表 对外担保信息';
comment on column SCT_DWDB.xydm
is '信用代码';
comment on column SCT_DWDB.nd
is '年度';
comment on column SCT_DWDB.tbrq
is '填报日期';
comment on column SCT_DWDB.xh
is '序号';
comment on column SCT_DWDB.zqr
is '债权人';
comment on column SCT_DWDB.zwr
is '债务人';
comment on column SCT_DWDB.zzqzl
is '主债权种类';
comment on column SCT_DWDB.zzqse
is '主债权数额';
comment on column SCT_DWDB.lxzwqx
is '履行债务的期限';
comment on column SCT_DWDB.bzqj
is '保证期间';
comment on column SCT_DWDB.bzfs
is '保证方式';
comment on column SCT_DWDB.bzdbfw
is '保证担保范围';
alter table SCT_DWDB
        add constraint PK_SCT_DWDB primary key (XYDM, ND, XH);

create table SCT_DWTZ
(
        xydm     VARCHAR2(100) not null,
        nd       NUMBER not null,
        tbrq     DATE,
        xh       NUMBER not null,
        slqymc   VARCHAR2(1000),
        slqyxydm VARCHAR2(100)
)
;
comment on table SCT_DWTZ
is '企业自查表 对外投资信息';
comment on column SCT_DWTZ.xydm
is '信用代码';
comment on column SCT_DWTZ.nd
is '年度';
comment on column SCT_DWTZ.tbrq
is '填报日期';
comment on column SCT_DWTZ.xh
is '序号';
comment on column SCT_DWTZ.slqymc
is '设立企业名称';
comment on column SCT_DWTZ.slqyxydm
is '设立企业信用代码';
alter table SCT_DWTZ
        add constraint PK_SCT_DWTZ primary key (XYDM, ND, XH);

create table SCT_GDCZ
(
        xydm   VARCHAR2(100) not null,
        nd     NUMBER not null,
        tbrq   DATE,
        xh     NUMBER not null,
        gd     VARCHAR2(1000),
        sjcze  NUMBER,
        sjczsj DATE,
        czfs   VARCHAR2(100),
        jzrq   DATE,
        pzh    VARCHAR2(100)
)
;
comment on table SCT_GDCZ
is '企业自查表 股东出资信息';
comment on column SCT_GDCZ.xydm
is '信用代码';
comment on column SCT_GDCZ.nd
is '年度';
comment on column SCT_GDCZ.tbrq
is '填报日期';
comment on column SCT_GDCZ.xh
is '序号';
comment on column SCT_GDCZ.gd
is '股东';
comment on column SCT_GDCZ.sjcze
is '实缴出资额';
comment on column SCT_GDCZ.sjczsj
is '实缴出资时间';
comment on column SCT_GDCZ.czfs
is '出资方式';
comment on column SCT_GDCZ.jzrq
is '记账日期';
comment on column SCT_GDCZ.pzh
is '凭证号';
alter table SCT_GDCZ
        add constraint PK_SCT_GDCZ primary key (XYDM, ND, XH);

create table SCT_GQBG
(
        xydm  VARCHAR2(100) not null,
        nd    NUMBER not null,
        tbrq  DATE,
        xh    NUMBER not null,
        gd    VARCHAR2(1000),
        bgqbl NUMBER,
        bghbl NUMBER,
        jzrq  DATE,
        pzh   VARCHAR2(100)
)
;
comment on table SCT_GQBG
is '企业自查表 股权变更信息';
comment on column SCT_GQBG.xydm
is '信用代码';
comment on column SCT_GQBG.nd
is '年度';
comment on column SCT_GQBG.tbrq
is '填报日期';
comment on column SCT_GQBG.xh
is '序号';
comment on column SCT_GQBG.gd
is '股东';
comment on column SCT_GQBG.bgqbl
is '变更前比例';
comment on column SCT_GQBG.bghbl
is '变更后比例';
comment on column SCT_GQBG.jzrq
is '记账日期';
comment on column SCT_GQBG.pzh
is '凭证号';
alter table SCT_GQBG
        add constraint PK_SCT_GQBG primary key (XYDM, ND, XH);

create table SCT_GSXXZCB
(
        xydm     VARCHAR2(100) not null,
        nd       NUMBER not null,
        tbrq     DATE,
        qymc     VARCHAR2(100),
        fddbr    VARCHAR2(100),
        gslly    VARCHAR2(100),
        lxdh     VARCHAR2(100),
        sjjydz   VARCHAR2(100),
        dzyx     VARCHAR2(100),
        wzwd     VARCHAR2(100),
        cyrs     NUMBER,
        jyzt     VARCHAR2(100),
        yzbm     VARCHAR2(100),
        qngzze   NUMBER,
        qnnsze   NUMBER,
        sfy_gdcz NUMBER,
        sfy_gqbg NUMBER,
        sfy_dwtz NUMBER,
        sfy_dwdb NUMBER,
        sfy_xzxk NUMBER,
        sfy_zscq NUMBER,
        sfy_xzcf NUMBER
)
;
comment on table SCT_GSXXZCB
is '企业自查表 公示信息自查表';
comment on column SCT_GSXXZCB.xydm
is '信用代码';
comment on column SCT_GSXXZCB.nd
is '年度';
comment on column SCT_GSXXZCB.tbrq
is '填报日期';
comment on column SCT_GSXXZCB.qymc
is '企业名称';
comment on column SCT_GSXXZCB.fddbr
is '法定代表人';
comment on column SCT_GSXXZCB.gslly
is '工商联络人';
comment on column SCT_GSXXZCB.lxdh
is '联系电话';
comment on column SCT_GSXXZCB.sjjydz
is '实际经营地址';
comment on column SCT_GSXXZCB.dzyx
is '电子邮箱';
comment on column SCT_GSXXZCB.wzwd
is '网址网店';
comment on column SCT_GSXXZCB.cyrs
is '从业人数';
comment on column SCT_GSXXZCB.jyzt
is '经营状态';
comment on column SCT_GSXXZCB.yzbm
is '邮政编码';
comment on column SCT_GSXXZCB.qngzze
is '全年工资总额';
comment on column SCT_GSXXZCB.qnnsze
is '全年纳税总额';
comment on column SCT_GSXXZCB.sfy_gdcz
is '是否有股东出资信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_gqbg
is '是否有股权变更信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_dwtz
is '是否有对外投资信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_dwdb
is '是否有对外担保信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_xzxk
is '是否有行政许可信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_zscq
is '是否有知识产权信息 1是 0否';
comment on column SCT_GSXXZCB.sfy_xzcf
is '是否有行政处罚信息 1是 0否';
alter table SCT_GSXXZCB
        add constraint PK_SCT_GSXXZCB primary key (XYDM, ND);

create table SCT_LRB
(
        xydm         VARCHAR2(100) not null,
        nd           NUMBER not null,
        tbrq         DATE,
        item1_bqfse  NUMBER(16,2),
        item1_sqfse  NUMBER(16,2),
        item2_bqfse  NUMBER(16,2),
        item2_sqfse  NUMBER(16,2),
        item3_bqfse  NUMBER(16,2),
        item3_sqfse  NUMBER(16,2),
        item4_bqfse  NUMBER(16,2),
        item4_sqfse  NUMBER(16,2),
        item5_bqfse  NUMBER(16,2),
        item5_sqfse  NUMBER(16,2),
        item6_bqfse  NUMBER(16,2),
        item6_sqfse  NUMBER(16,2),
        item7_bqfse  NUMBER(16,2),
        item7_sqfse  NUMBER(16,2),
        item8_bqfse  NUMBER(16,2),
        item8_sqfse  NUMBER(16,2),
        item9_bqfse  NUMBER(16,2),
        item9_sqfse  NUMBER(16,2),
        item10_bqfse NUMBER(16,2),
        item10_sqfse NUMBER(16,2),
        item11_bqfse NUMBER(16,2),
        item11_sqfse NUMBER(16,2),
        item12_bqfse NUMBER(16,2),
        item12_sqfse NUMBER(16,2),
        item13_bqfse NUMBER(16,2),
        item13_sqfse NUMBER(16,2),
        item14_bqfse NUMBER(16,2),
        item14_sqfse NUMBER(16,2),
        item15_bqfse NUMBER(16,2),
        item15_sqfse NUMBER(16,2),
        item16_bqfse NUMBER(16,2),
        item16_sqfse NUMBER(16,2),
        item17_bqfse NUMBER(16,2),
        item17_sqfse NUMBER(16,2),
        item18_bqfse NUMBER(16,2),
        item18_sqfse NUMBER(16,2),
        item19_bqfse NUMBER(16,2),
        item19_sqfse NUMBER(16,2),
        item20_bqfse NUMBER(16,2),
        item20_sqfse NUMBER(16,2),
        item21_bqfse NUMBER(16,2),
        item21_sqfse NUMBER(16,2),
        item22_bqfse NUMBER(16,2),
        item22_sqfse NUMBER(16,2),
        item23_bqfse NUMBER(16,2),
        item23_sqfse NUMBER(16,2),
        item24_bqfse NUMBER(16,2),
        item24_sqfse NUMBER(16,2),
        item25_bqfse NUMBER(16,2),
        item25_sqfse NUMBER(16,2),
        item26_bqfse NUMBER(16,2),
        item26_sqfse NUMBER(16,2),
        item27_bqfse NUMBER(16,2),
        item27_sqfse NUMBER(16,2),
        item28_bqfse NUMBER(16,2),
        item28_sqfse NUMBER(16,2),
        item29_bqfse NUMBER(16,2),
        item29_sqfse NUMBER(16,2),
        item30_bqfse NUMBER(16,2),
        item30_sqfse NUMBER(16,2),
        item31_bqfse NUMBER(16,2),
        item31_sqfse NUMBER(16,2),
        item32_bqfse NUMBER(16,2),
        item32_sqfse NUMBER(16,2),
        item33_bqfse NUMBER(16,2),
        item33_sqfse NUMBER(16,2),
        item34_bqfse NUMBER(16,2),
        item34_sqfse NUMBER(16,2),
        item35_bqfse NUMBER(16,2),
        item35_sqfse NUMBER(16,2),
        item36_bqfse NUMBER(16,2),
        item36_sqfse NUMBER(16,2),
        item37_bqfse NUMBER(16,2),
        item37_sqfse NUMBER(16,2),
        item38_bqfse NUMBER(16,2),
        item38_sqfse NUMBER(16,2),
        item39_bqfse NUMBER(16,2),
        item39_sqfse NUMBER(16,2),
        item40_bqfse NUMBER(16,2),
        item40_sqfse NUMBER(16,2),
        item41_bqfse NUMBER(16,2),
        item41_sqfse NUMBER(16,2),
        item42_bqfse NUMBER(16,2),
        item42_sqfse NUMBER(16,2),
        item43_bqfse NUMBER(16,2),
        item43_sqfse NUMBER(16,2),
        item44_bqfse NUMBER(16,2),
        item44_sqfse NUMBER(16,2),
        item45_bqfse NUMBER(16,2),
        item45_sqfse NUMBER(16,2),
        item46_bqfse NUMBER(16,2),
        item46_sqfse NUMBER(16,2),
        item47_bqfse NUMBER(16,2),
        item47_sqfse NUMBER(16,2),
        item48_bqfse NUMBER(16,2),
        item48_sqfse NUMBER(16,2),
        item49_bqfse NUMBER(16,2),
        item49_sqfse NUMBER(16,2),
        item50_bqfse NUMBER(16,2),
        item50_sqfse NUMBER(16,2)
)
;
comment on table SCT_LRB
is '企业自查表 利润表';
comment on column SCT_LRB.xydm
is '信用代码';
comment on column SCT_LRB.nd
is '年度';
comment on column SCT_LRB.tbrq
is '填报日期';
comment on column SCT_LRB.item1_bqfse
is '项目1 本期发生额';
comment on column SCT_LRB.item1_sqfse
is '项目1 上期发生额';
alter table SCT_LRB
        add constraint PK_SCT_LRB primary key (XYDM, ND);

create table SCT_XJLLB
(
        xydm         VARCHAR2(100) not null,
        nd           NUMBER not null,
        tbrq         DATE,
        item1_bqfse  NUMBER(16,2),
        item1_sqfse  NUMBER(16,2),
        item2_bqfse  NUMBER(16,2),
        item2_sqfse  NUMBER(16,2),
        item3_bqfse  NUMBER(16,2),
        item3_sqfse  NUMBER(16,2),
        item4_bqfse  NUMBER(16,2),
        item4_sqfse  NUMBER(16,2),
        item5_bqfse  NUMBER(16,2),
        item5_sqfse  NUMBER(16,2),
        item6_bqfse  NUMBER(16,2),
        item6_sqfse  NUMBER(16,2),
        item7_bqfse  NUMBER(16,2),
        item7_sqfse  NUMBER(16,2),
        item8_bqfse  NUMBER(16,2),
        item8_sqfse  NUMBER(16,2),
        item9_bqfse  NUMBER(16,2),
        item9_sqfse  NUMBER(16,2),
        item10_bqfse NUMBER(16,2),
        item10_sqfse NUMBER(16,2),
        item11_bqfse NUMBER(16,2),
        item11_sqfse NUMBER(16,2),
        item12_bqfse NUMBER(16,2),
        item12_sqfse NUMBER(16,2),
        item13_bqfse NUMBER(16,2),
        item13_sqfse NUMBER(16,2),
        item14_bqfse NUMBER(16,2),
        item14_sqfse NUMBER(16,2),
        item15_bqfse NUMBER(16,2),
        item15_sqfse NUMBER(16,2),
        item16_bqfse NUMBER(16,2),
        item16_sqfse NUMBER(16,2),
        item17_bqfse NUMBER(16,2),
        item17_sqfse NUMBER(16,2),
        item18_bqfse NUMBER(16,2),
        item18_sqfse NUMBER(16,2),
        item19_bqfse NUMBER(16,2),
        item19_sqfse NUMBER(16,2),
        item20_bqfse NUMBER(16,2),
        item20_sqfse NUMBER(16,2),
        item21_bqfse NUMBER(16,2),
        item21_sqfse NUMBER(16,2),
        item22_bqfse NUMBER(16,2),
        item22_sqfse NUMBER(16,2),
        item23_bqfse NUMBER(16,2),
        item23_sqfse NUMBER(16,2),
        item24_bqfse NUMBER(16,2),
        item24_sqfse NUMBER(16,2),
        item25_bqfse NUMBER(16,2),
        item25_sqfse NUMBER(16,2),
        item26_bqfse NUMBER(16,2),
        item26_sqfse NUMBER(16,2),
        item27_bqfse NUMBER(16,2),
        item27_sqfse NUMBER(16,2),
        item28_bqfse NUMBER(16,2),
        item28_sqfse NUMBER(16,2),
        item29_bqfse NUMBER(16,2),
        item29_sqfse NUMBER(16,2),
        item30_bqfse NUMBER(16,2),
        item30_sqfse NUMBER(16,2),
        item31_bqfse NUMBER(16,2),
        item31_sqfse NUMBER(16,2),
        item32_bqfse NUMBER(16,2),
        item32_sqfse NUMBER(16,2),
        item33_bqfse NUMBER(16,2),
        item33_sqfse NUMBER(16,2),
        item34_bqfse NUMBER(16,2),
        item34_sqfse NUMBER(16,2),
        item35_bqfse NUMBER(16,2),
        item35_sqfse NUMBER(16,2),
        item36_bqfse NUMBER(16,2),
        item36_sqfse NUMBER(16,2),
        item37_bqfse NUMBER(16,2),
        item37_sqfse NUMBER(16,2),
        item38_bqfse NUMBER(16,2),
        item38_sqfse NUMBER(16,2)
)
;
comment on table SCT_XJLLB
is '企业自查表 现金流量表';
comment on column SCT_XJLLB.xydm
is '信用代码';
comment on column SCT_XJLLB.nd
is '年度';
comment on column SCT_XJLLB.tbrq
is '填报日期';
comment on column SCT_XJLLB.item1_bqfse
is '项目1 本期发生额';
comment on column SCT_XJLLB.item1_sqfse
is '项目1 上期发生额';
alter table SCT_XJLLB
        add constraint PK_SCT_XJLLB primary key (XYDM, ND);

create table SCT_XZCF
(
        xydm     VARCHAR2(100) not null,
        nd       NUMBER not null,
        tbrq     DATE,
        xh       NUMBER not null,
        cfjdswh  VARCHAR2(100),
        wfxwlx   VARCHAR2(100),
        xzcfnr   VARCHAR2(1000),
        zccfjdjg VARCHAR2(1000),
        cfrq     DATE
)
;
comment on table SCT_XZCF
is '企业自查表 行政处罚信息';
comment on column SCT_XZCF.xydm
is '信用代码';
comment on column SCT_XZCF.nd
is '年度';
comment on column SCT_XZCF.tbrq
is '填报日期';
comment on column SCT_XZCF.xh
is '序号';
comment on column SCT_XZCF.cfjdswh
is '行政处罚决定书文号';
comment on column SCT_XZCF.wfxwlx
is '违法行为类型';
comment on column SCT_XZCF.xzcfnr
is '行政处罚内容';
comment on column SCT_XZCF.zccfjdjg
is '作出行政处罚决定机关名称';
comment on column SCT_XZCF.cfrq
is '作出行政处罚决定日期';
alter table SCT_XZCF
        add constraint PK_SCT_XZCF primary key (XYDM, ND, XH);

create table SCT_XZXK
(
        xydm     VARCHAR2(100) not null,
        nd       NUMBER not null,
        tbrq     DATE,
        xh       NUMBER not null,
        xkwjbh   VARCHAR2(100),
        xkwjmc   VARCHAR2(1000),
        yxq_from DATE,
        yxq_to   DATE,
        xkjg     VARCHAR2(1000),
        djzt     VARCHAR2(100)
)
;
comment on table SCT_XZXK
is '企业自查表 行政许可信息';
comment on column SCT_XZXK.xydm
is '信用代码';
comment on column SCT_XZXK.nd
is '年度';
comment on column SCT_XZXK.tbrq
is '填报日期';
comment on column SCT_XZXK.xh
is '序号';
comment on column SCT_XZXK.xkwjbh
is '许可文件编号';
comment on column SCT_XZXK.xkwjmc
is '许可文件名称';
comment on column SCT_XZXK.yxq_from
is '有效期自';
comment on column SCT_XZXK.yxq_to
is '有效期至';
comment on column SCT_XZXK.xkjg
is '许可机关';
comment on column SCT_XZXK.djzt
is '登记状态';
alter table SCT_XZXK
        add constraint PK_SCT_XZXK primary key (XYDM, ND, XH);

create table SCT_ZCFZB
(
        xydm       VARCHAR2(100) not null,
        nd         NUMBER not null,
        tbrq       DATE,
        item1_qcs  NUMBER(16,2),
        item1_qms  NUMBER(16,2),
        item2_qcs  NUMBER(16,2),
        item2_qms  NUMBER(16,2),
        item3_qcs  NUMBER(16,2),
        item3_qms  NUMBER(16,2),
        item4_qcs  NUMBER(16,2),
        item4_qms  NUMBER(16,2),
        item5_qcs  NUMBER(16,2),
        item5_qms  NUMBER(16,2),
        item6_qcs  NUMBER(16,2),
        item6_qms  NUMBER(16,2),
        item7_qcs  NUMBER(16,2),
        item7_qms  NUMBER(16,2),
        item8_qcs  NUMBER(16,2),
        item8_qms  NUMBER(16,2),
        item9_qcs  NUMBER(16,2),
        item9_qms  NUMBER(16,2),
        item10_qcs NUMBER(16,2),
        item10_qms NUMBER(16,2),
        item11_qcs NUMBER(16,2),
        item11_qms NUMBER(16,2),
        item12_qcs NUMBER(16,2),
        item12_qms NUMBER(16,2),
        item13_qcs NUMBER(16,2),
        item13_qms NUMBER(16,2),
        item14_qcs NUMBER(16,2),
        item14_qms NUMBER(16,2),
        item15_qcs NUMBER(16,2),
        item15_qms NUMBER(16,2),
        item16_qcs NUMBER(16,2),
        item16_qms NUMBER(16,2),
        item17_qcs NUMBER(16,2),
        item17_qms NUMBER(16,2),
        item18_qcs NUMBER(16,2),
        item18_qms NUMBER(16,2),
        item19_qcs NUMBER(16,2),
        item19_qms NUMBER(16,2),
        item20_qcs NUMBER(16,2),
        item20_qms NUMBER(16,2),
        item21_qcs NUMBER(16,2),
        item21_qms NUMBER(16,2),
        item22_qcs NUMBER(16,2),
        item22_qms NUMBER(16,2),
        item23_qcs NUMBER(16,2),
        item23_qms NUMBER(16,2),
        item24_qcs NUMBER(16,2),
        item24_qms NUMBER(16,2),
        item25_qcs NUMBER(16,2),
        item25_qms NUMBER(16,2),
        item26_qcs NUMBER(16,2),
        item26_qms NUMBER(16,2),
        item27_qcs NUMBER(16,2),
        item27_qms NUMBER(16,2),
        item28_qcs NUMBER(16,2),
        item28_qms NUMBER(16,2),
        item29_qcs NUMBER(16,2),
        item29_qms NUMBER(16,2),
        item30_qcs NUMBER(16,2),
        item30_qms NUMBER(16,2),
        item31_qcs NUMBER(16,2),
        item31_qms NUMBER(16,2),
        item32_qcs NUMBER(16,2),
        item32_qms NUMBER(16,2),
        item33_qcs NUMBER(16,2),
        item33_qms NUMBER(16,2),
        item34_qcs NUMBER(16,2),
        item34_qms NUMBER(16,2),
        item35_qcs NUMBER(16,2),
        item35_qms NUMBER(16,2),
        item36_qcs NUMBER(16,2),
        item36_qms NUMBER(16,2),
        item37_qcs NUMBER(16,2),
        item37_qms NUMBER(16,2),
        item38_qcs NUMBER(16,2),
        item38_qms NUMBER(16,2),
        item39_qcs NUMBER(16,2),
        item39_qms NUMBER(16,2),
        item40_qcs NUMBER(16,2),
        item40_qms NUMBER(16,2),
        item41_qcs NUMBER(16,2),
        item41_qms NUMBER(16,2),
        item42_qcs NUMBER(16,2),
        item42_qms NUMBER(16,2),
        item43_qcs NUMBER(16,2),
        item43_qms NUMBER(16,2),
        item44_qcs NUMBER(16,2),
        item44_qms NUMBER(16,2),
        item45_qcs NUMBER(16,2),
        item45_qms NUMBER(16,2),
        item46_qcs NUMBER(16,2),
        item46_qms NUMBER(16,2),
        item47_qcs NUMBER(16,2),
        item47_qms NUMBER(16,2),
        item48_qcs NUMBER(16,2),
        item48_qms NUMBER(16,2),
        item49_qcs NUMBER(16,2),
        item49_qms NUMBER(16,2),
        item50_qcs NUMBER(16,2),
        item50_qms NUMBER(16,2),
        item51_qcs NUMBER(16,2),
        item51_qms NUMBER(16,2),
        item52_qcs NUMBER(16,2),
        item52_qms NUMBER(16,2),
        item53_qcs NUMBER(16,2),
        item53_qms NUMBER(16,2),
        item54_qcs NUMBER(16,2),
        item54_qms NUMBER(16,2),
        item55_qcs NUMBER(16,2),
        item55_qms NUMBER(16,2),
        item56_qcs NUMBER(16,2),
        item56_qms NUMBER(16,2),
        item57_qcs NUMBER(16,2),
        item57_qms NUMBER(16,2),
        item58_qcs NUMBER(16,2),
        item58_qms NUMBER(16,2),
        item59_qcs NUMBER(16,2),
        item59_qms NUMBER(16,2),
        item60_qcs NUMBER(16,2),
        item60_qms NUMBER(16,2),
        item61_qcs NUMBER(16,2),
        item61_qms NUMBER(16,2),
        item62_qcs NUMBER(16,2),
        item62_qms NUMBER(16,2),
        item63_qcs NUMBER(16,2),
        item63_qms NUMBER(16,2),
        item64_qcs NUMBER(16,2),
        item64_qms NUMBER(16,2),
        item65_qcs NUMBER(16,2),
        item65_qms NUMBER(16,2),
        item66_qcs NUMBER(16,2),
        item66_qms NUMBER(16,2),
        item67_qcs NUMBER(16,2),
        item67_qms NUMBER(16,2),
        item68_qcs NUMBER(16,2),
        item68_qms NUMBER(16,2),
        item69_qcs NUMBER(16,2),
        item69_qms NUMBER(16,2),
        item70_qcs NUMBER(16,2),
        item70_qms NUMBER(16,2),
        item71_qcs NUMBER(16,2),
        item71_qms NUMBER(16,2),
        item72_qcs NUMBER(16,2),
        item72_qms NUMBER(16,2),
        item73_qcs NUMBER(16,2),
        item73_qms NUMBER(16,2),
        item74_qcs NUMBER(16,2),
        item74_qms NUMBER(16,2),
        item75_qcs NUMBER(16,2),
        item75_qms NUMBER(16,2),
        item76_qcs NUMBER(16,2),
        item76_qms NUMBER(16,2),
        item77_qcs NUMBER(16,2),
        item77_qms NUMBER(16,2),
        item78_qcs NUMBER(16,2),
        item78_qms NUMBER(16,2),
        item79_qcs NUMBER(16,2),
        item79_qms NUMBER(16,2),
        item80_qcs NUMBER(16,2),
        item80_qms NUMBER(16,2),
        item81_qcs NUMBER(16,2),
        item81_qms NUMBER(16,2),
        item82_qcs NUMBER(16,2),
        item82_qms NUMBER(16,2),
        item83_qcs NUMBER(16,2),
        item83_qms NUMBER(16,2),
        item84_qcs NUMBER(16,2),
        item84_qms NUMBER(16,2),
        item85_qcs NUMBER(16,2),
        item85_qms NUMBER(16,2),
        item86_qcs NUMBER(16,2),
        item86_qms NUMBER(16,2)
)
;
comment on table SCT_ZCFZB
is '企业自查表 资产负债表';
comment on column SCT_ZCFZB.xydm
is '企业信用代码';
comment on column SCT_ZCFZB.nd
is '年度';
comment on column SCT_ZCFZB.tbrq
is '填报日期';
comment on column SCT_ZCFZB.item1_qcs
is '项目1期初数';
comment on column SCT_ZCFZB.item1_qms
is '项目1期末数';
alter table SCT_ZCFZB
        add constraint PK_SCT_ZCFZB primary key (XYDM, ND);

create table SCT_ZSCQ
(
        xydm        VARCHAR2(100) not null,
        nd          NUMBER not null,
        tbrq        DATE,
        xh          NUMBER not null,
        zscqdw_xydm VARCHAR2(100),
        mc          VARCHAR2(100),
        zl          VARCHAR2(100),
        czrmc       VARCHAR2(100),
        zqrmc       VARCHAR2(100),
        zqdjqx      VARCHAR2(100),
        djzt        VARCHAR2(100),
        bhqk        VARCHAR2(100)
)
;
comment on table SCT_ZSCQ
is '企业自查表 知识产权出资信息';
comment on column SCT_ZSCQ.xydm
is '信用代码';
comment on column SCT_ZSCQ.nd
is '年度';
comment on column SCT_ZSCQ.tbrq
is '填报日期';
comment on column SCT_ZSCQ.xh
is '序号';
comment on column SCT_ZSCQ.zscqdw_xydm
is '知识产权单位信用代码';
comment on column SCT_ZSCQ.mc
is '名称';
comment on column SCT_ZSCQ.zl
is '种类';
comment on column SCT_ZSCQ.czrmc
is '出质人名称';
comment on column SCT_ZSCQ.zqrmc
is '质权人名称';
comment on column SCT_ZSCQ.zqdjqx
is '质权登记期限';
comment on column SCT_ZSCQ.djzt
is '登记状态';
comment on column SCT_ZSCQ.bhqk
is '变化情况';
alter table SCT_ZSCQ
        add constraint PK_SCT_ZSCQ primary key (XYDM, ND, XH);

create or replace view gov_nbcc_jh_qy as
        select "XH","JHXH","NBXH",nvl(b.uniscid,a.zch) "ZCH",zch zch_old,"QYMC","FDDBR",a.QYLXDL,"DJJG","GXDW","XCR","LRR","LRSJ","ND","CCWH",null zzxs,WCBJ,XCSJ,b.UNISCID xydm from GOV_NBCC_JH_QY@dbl_hc a,hz_qyhznr@dbl_hc b
        where a.nbxh=b.pripid;
comment on table GOV_NBCC_JH_QY is '年报核查企业名录';
comment on column GOV_NBCC_JH_QY.XH is '序号';
comment on column GOV_NBCC_JH_QY.JHXH is '核查计划序号';
comment on column GOV_NBCC_JH_QY.NBXH is '企业内部序号';
comment on column GOV_NBCC_JH_QY.ZCH is '企业注册号或信用代码';
comment on column GOV_NBCC_JH_QY.QYMC is '企业名称';
comment on column GOV_NBCC_JH_QY.FDDBR is '法人';
comment on column GOV_NBCC_JH_QY.QYLXDL is '企业类型大类';
comment on column GOV_NBCC_JH_QY.DJJG is '登记机关（代码）';
comment on column GOV_NBCC_JH_QY.GXDW is '管辖单位（代码）';
comment on column GOV_NBCC_JH_QY.XCR is '核查人，以,分隔';
comment on column GOV_NBCC_JH_QY.LRR is '列入人';
comment on column GOV_NBCC_JH_QY.LRSJ is '列入时间';
comment on column GOV_NBCC_JH_QY.ND is '年度';
comment on column GOV_NBCC_JH_QY.CCWH is '抽查文号';
comment on column GOV_NBCC_JH_QY.ZZXS is '企业组织形式，如果没有则等于QYLXDL';
comment on column GOV_NBCC_JH_QY.WCBJ is '完成标志（名称）';
comment on column GOV_NBCC_JH_QY.XCSJ is '巡查时间';
comment on column GOV_NBCC_JH_QY.XYDM is '企业信用代码';
comment on column GOV_NBCC_JH_QY.zch_old is '注册号';
create or replace view gov_nbcc_rc_qy as
        select a.pripid NBXH,nvl(uniscid,regno) ZCH,regno zch_old,entname QYMC,lerep FDDBR,QYLXDL,regorg DJJG,(select content from bm_djjg c where c.code=b.regorg) djjg_mc,
               localadm GXDW,(select content from bm_gxdw c where c.code=b.localadm) gxdw_mc,estdate clrq,dom zs,null qyzzxs,
                nvl(a.jdjg,b.regorg) jdjg,(select content from bm_djjg c where c.code=nvl(a.jdjg,b.regorg)) jdjg_mc,lrrq,
                (select content from ztjg_bm_jyycsy c where c.code=a.lrsy and (b.qylxdl=c.qylxdl or c.qylxdl is null) and rownum<=1) lrsy,
                null xcr,sysdate xcsj,to_char(sysdate,'yyyy')-1 nd,b.UNISCID xydm
        from GOV_EXCEPTIONREASON a,hz_qyhznr b
        where a.pripid=b.pripid;
comment on table GOV_NBCC_RC_QY is '经营异常企业名录';
comment on column GOV_NBCC_RC_QY.NBXH is '日常监管企业名录（异常名录）';
comment on column GOV_NBCC_RC_QY.ZCH is '企业注册号或信用代码';
comment on column GOV_NBCC_RC_QY.QYMC is '企业名称';
comment on column GOV_NBCC_RC_QY.FDDBR is '法人';
comment on column GOV_NBCC_RC_QY.QYLXDL is '企业类型大类（代码）';
comment on column GOV_NBCC_RC_QY.DJJG is '企业登记机关（代码）';
comment on column GOV_NBCC_RC_QY.DJJG_MC is '企业登记机关（名称）';
comment on column GOV_NBCC_RC_QY.GXDW is '企业管辖单位（代码）';
comment on column GOV_NBCC_RC_QY.GXDW_MC is '企业管辖单位（名称）';
comment on column GOV_NBCC_RC_QY.CLRQ is '企业成立日期';
comment on column GOV_NBCC_RC_QY.ZS is '企业住所';
comment on column GOV_NBCC_RC_QY.QYZZXS is '企业组织形式（如果没有则同QYLXDL）';
comment on column GOV_NBCC_RC_QY.JDJG is '做出异常处理决定的机关代码';
comment on column GOV_NBCC_RC_QY.JDJG_MC is '做出异常处理决定的机关名称';
comment on column GOV_NBCC_RC_QY.LRRQ is '列入异常的日期';
comment on column GOV_NBCC_RC_QY.LRSY is '列出异常的事由（名称）';
comment on column GOV_NBCC_RC_QY.XCR is '核查人名称，以,分隔';
comment on column GOV_NBCC_RC_QY.XCSJ is '核查时间';
comment on column GOV_NBCC_RC_QY.ND is '核查年度';
comment on column GOV_NBCC_RC_QY.ZCH is '企业信用代码';
comment on column GOV_NBCC_JH_QY.zch_old is '注册号';
--创建JOB
var job number;
begin
  dbms_job.submit(:job,'pkg_import.prc_job_updateXydmFromZch;',sysdate+1,'trunc(sysdate+1)');
  commit;
end;
/
print job;

--经营异常企业修改
create table t_hcrw_nd(hcrw_id varchar2(100),nd integer);
alter table T_JS_BD_GDCZ drop primary key drop index;
alter table T_JS_BD_GDCZ drop column hcrw_id;
alter table T_JS_BD_GDCZ add constraint pk_T_JS_BD_GDCZ primary key(xydm,gd,bgrq,sjly);
alter table T_JS_BD_GQBG drop primary key drop index;
alter table T_JS_BD_GQBG drop column hcrw_id;
alter table T_JS_BD_GQBG add constraint pk_T_JS_BD_GQBG primary key(xydm,gd,bgrq,sjly);
alter table T_JS_BD_XZCF drop primary key drop index;
alter table T_JS_BD_XZCF drop column hcrw_id;
alter table T_JS_BD_XZCF add constraint pk_T_JS_BD_XZCF primary key(XYDM, XZCFJDSWH, SJLY);
alter table T_JS_BD_XZXK drop primary key drop index;
alter table T_JS_BD_XZXK drop column hcrw_id;
alter table T_JS_BD_XZXK add constraint pk_T_JS_BD_XZXK primary key(XYDM, XKWJBH, SJLY);
alter table T_JS_BD_ZSCQ drop primary key drop index;
alter table T_JS_BD_ZSCQ drop column hcrw_id;
alter table T_JS_BD_ZSCQ add constraint pk_T_JS_BD_ZSCQ primary key(XYDM, CZRMC, ZL, SJLY);
alter table T_JS_GDCZ drop primary key drop index;
alter table T_JS_GDCZ drop column hcrw_id;
alter table T_JS_GDCZ add constraint pk_T_JS_GDCZ primary key(XYDM, GD, BGRQ);
alter table T_JS_GQBG drop primary key drop index;
alter table T_JS_GQBG drop column hcrw_id;
alter table T_JS_GQBG add constraint pk_T_JS_GQBG primary key( XYDM, GD, BGRQ);
alter table T_JS_XZCF drop primary key drop index;
alter table T_JS_XZCF drop column hcrw_id;
alter table T_JS_XZCF add constraint pk_T_JS_XZCF primary key(  XYDM, XZCFJDSWH);
alter table T_JS_XZXK drop primary key drop index;
alter table T_JS_XZXK drop column hcrw_id;
alter table T_JS_XZXK add constraint pk_T_JS_XZXK primary key( XYDM, XKWJBH);
alter table T_JS_ZSCQ drop primary key drop index;
alter table T_JS_ZSCQ drop column hcrw_id;
alter table T_JS_ZSCQ add constraint pk_T_JS_ZSCQ primary key( XYDM, CZRMC, ZL);
alter table T_NB drop primary key drop index;
alter table T_NB drop column hcrw_id;
alter table T_NB add constraint pk_T_NB primary key( XYDM, ND);
alter table T_NB_BD drop primary key drop index;
alter table T_NB_BD drop column hcrw_id;
alter table T_NB_BD add constraint pk_T_NB_BD primary key( XYDM, ND,SJLY);
alter table T_NB_BD_DWDB drop primary key drop index;
alter table T_NB_BD_DWDB drop column hcrw_id;
alter table T_NB_BD_DWDB add constraint pk_T_NB_BD_DWDB primary key( ID);
alter table T_NB_BD_DWTZ drop primary key drop index;
alter table T_NB_BD_DWTZ drop column hcrw_id;
alter table T_NB_BD_DWTZ add constraint pk_T_NB_BD_DWTZ primary key( ID);
alter table T_NB_BD_GDCZ drop primary key drop index;
alter table T_NB_BD_GDCZ drop column hcrw_id;
alter table T_NB_BD_GDCZ add constraint pk_T_NB_BD_GDCZ primary key( ID);
alter table T_NB_BD_GQBG drop primary key drop index;
alter table T_NB_BD_GQBG drop column hcrw_id;
alter table T_NB_BD_GQBG add constraint pk_T_NB_BD_GQBG primary key( ID);
alter table T_NB_BD_WD drop primary key drop index;
alter table T_NB_BD_WD drop column hcrw_id;
alter table T_NB_BD_WD add constraint pk_T_NB_BD_WD primary key( ID);
alter table T_NB_BD_XZXK drop primary key drop index;
alter table T_NB_BD_XZXK drop column hcrw_id;
alter table T_NB_BD_XZXK add constraint pk_T_NB_BD_XZXK primary key( ID);
alter table T_NB_DWDB drop primary key drop index;
alter table T_NB_DWDB drop column hcrw_id;
alter table T_NB_DWDB add constraint pk_T_NB_DWDB primary key( ID);
alter table T_NB_DWTZ drop primary key drop index;
alter table T_NB_DWTZ drop column hcrw_id;
alter table T_NB_DWTZ add constraint pk_T_NB_DWTZ primary key( ID);
alter table T_NB_GDCZ drop primary key drop index;
alter table T_NB_GDCZ drop column hcrw_id;
alter table T_NB_GDCZ add constraint pk_T_NB_GDCZ primary key( ID);
alter table T_NB_GQBG drop primary key drop index;
alter table T_NB_GQBG drop column hcrw_id;
alter table T_NB_GQBG add constraint pk_T_NB_GQBG primary key( ID);
alter table T_NB_WD drop primary key drop index;
alter table T_NB_WD drop column hcrw_id;
alter table T_NB_WD add constraint pk_T_NB_WD primary key( ID);
alter table T_NB_XZXK drop primary key drop index;
alter table T_NB_XZXK drop column hcrw_id;
alter table T_NB_XZXK add constraint pk_T_NB_XZXK primary key( ID);

alter table t_hcsxjg modify qygsnr varchar2(4000);
alter table t_hcsxjg modify bznr varchar2(4000);
insert into x_codelist
        select 'year',2010+rownum ,2010+rownum,'0',null,'年度选择' from dual connect by level<=20;
drop index IDX_HCRW_1;
create unique index IDX_HCRW_1 on T_HCRW (hcjh_id, hcdw_xydm, nd);
--create unique index idx_t_sczt_2 on T_SCZT (name);
update t_hcsx set page='js_zscq' where id='87604e472fda4faaa9247d7c8b9b989a';
update t_hcsx set page='js_stockRightChange' where id='9559686ef987488f8df0e064632153f3';
update t_hcsx set page='js_license' where id='3c9015ebd3a942eab8dfc72b1374a473';
update t_hcsx set page='js_punishment' where id='8c253dfa317746b8a4441bb4fe8d9c63';
update t_hcsx set page='js_gudongchuzi' where id='34A194D475854B32E050A8C085050AD8';
