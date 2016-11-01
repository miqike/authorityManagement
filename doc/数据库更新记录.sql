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

--20161013 陕西更新
        alter table t_hcrw add zcb_result varchar2(4000);
        --pkg_hc 915
        --  v_hcsx_sm||(select zcb_result from t_hcrw where id=p_HCRWID)
--20161018 陕西更新
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
--20101021 陕西更新
        --pkg_hc prc_getHcsxjg
        --20161026
        --pkg_import 89  /*i_hcrw.ND*/v_jhnd-1
        --pkg_import 323 select a.nd-1 into v_nd from t_hcjh a,t_hcrw b where a.id=b.hcjh_id and b.id=p_HCRWID;--日常监管计划的任务年度直接取计划年度减1
        -- Create/Recreate indexes
        create unique index idx_t_hcjh_1 on T_HCJH (jhmc);
--20161031
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
