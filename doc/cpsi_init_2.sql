/**
truncate table T_NB_XZXK;
truncate table T_NB_WD;
truncate table T_NB_GQBG;
truncate table T_NB_GDCZ;
truncate table T_NB_DWTZ;
truncate table T_NB_DWDB;
truncate table T_NB_BD_XZXK;
truncate table T_NB_BD_WD;
truncate table T_NB_BD_GQBG;
truncate table T_NB_BD_GDCZ;
truncate table T_NB_BD_DWTZ;
truncate table T_NB_BD_DWDB;
delete from T_NB_BD;
truncate table T_NB;
truncate table t_hcrw;
truncate table T_HCRW_TJ;
truncate table T_HCJH_HCSX;
truncate table T_HCJH;
truncate table T_HCSXJG;
truncate table T_SCZT;
truncate table T_TOKEN;

truncate table T_USER_ORG;
commit;
 */
/**
根据接口表初始化数据库
 */

/**
  初始化组织机构表
  将管辖单位放到登记机构下
 */
declare
  cursor cur_org is
    select * from sys_organization;
begin
  delete from sys_organization;
  insert into sys_organization(id,name,parent_id,type,contacts,phone,brief_name)
    select code id,content name,sjcode2 parent_id,1 type,null contacts,null phone,djjgjc brief_name  from(
      select a.*,case when sjcode='0' and code not in('100000','610000') then '610000' else sjcode end sjcode2
      from bm_djjg a where code not in('100000')
      start with sjcode='0' connect by prior code=sjcode
    ) start with sjcode2='0' connect by prior code=sjcode2;

  for o in cur_org loop
    insert into sys_organization(id,name,parent_id,type,contacts,phone,brief_name)
      select code id,content name,o.id parent_id,1 type,null contacts,null phone,null brief_name from BM_gxdw where code like o.id||'%' and length(code)=8;
  end loop;
end;
/

/**
  初始化核查人员
 */
delete from t_zfry;
insert into t_zfry(code,name,gender,dw_id,dw_name,zw,mobile,mail,zfzh,sfzh,zflx,whcd,zt,GXDW_ID,GXDW_NAME,user_id)
  select user_id,full_name,null gender,djjg dw_id,(select content from bm_djjg b where b.code=a.djjg) dw_name,
    null zw,null mobile,null mail,zfzh,null sfzh,1,null whcd,1,
    gxdwdm GXDW_ID,(select content from bm_gxdw b where b.code=a.gxdwdm) gxdw_name,
    gh user_id
  from xt_user a;
/**
  初始化操作员
 */
delete from sys_user where user_id<>'system';
delete from sys_user_role a where not exists(select 1 from sys_user b where b.user_id=a.user_id);

insert into sys_user(user_id,manager_id,name,email,mobile,password,salt,create_time,manager_name,status,org_id,org_type,weight,org_name,zfry)
  select gh user_id,null manager_id,full_name name,null email,null mobile,lower(pkg_hc.MD5_DIGEST(gh||'000000'||'123qwe!@#QWE')) password,'123qwe!@#QWE' salt,sysdate create_time,
         null manager_name,1 status,djjg org_id,0 org_type,1 weight,(select content from bm_djjg b where b.code=a.djjg) org_name,
         user_name zfry
  from xt_user a where gh is not null and gh not in(select gh from(select gh,count(1) from xt_user where gh is not null group by gh having count(1)>1));
insert into sys_user_role(role_id,user_id)
  select a.id,b.user_id from sys_role a,sys_user b
  where a.name in('超级管理员')
        and b.user_id<>'system';
update sys_user set password=lower(pkg_hc.MD5_DIGEST(user_id||'111111'||salt));
insert into t_user_org values('system','系统管理员','610000','陕西省工商行政管理局');
/**
初始化编码表
**/
delete from x_codelist where name='ztlx';
insert into x_codelist(name,value,literal,edit_flag,style,descn)
  select 'ztlx',code,content,0,null,'企业主体类型' from bm_qydl;
delete from x_codelist where name='jyzt';
insert into x_codelist(name,value,literal,edit_flag,style,descn)
  select 'jyzt',code,content,0,null,'经营状态' from BM_TCKYQK;
delete from x_codelist where name='czxs';
insert into x_codelist(name,value,literal,edit_flag,style,descn)
  select 'czxs',code,content,0,null,'出资形式' from BM_CZXS;
delete from x_codelist where name='wzlx';
insert into x_codelist(name,value,literal,edit_flag,style,descn)
  select 'wzlx',code,content,0,null,'网址类型' from BM_WZLX;
insert into x_codelist(name,value,literal,edit_flag,style,descn)
  select 'qylxdl',code,content,0,null,'企业类型大类' from BM_QYDL;
/**
开发测试过程中可能需要用到的SQL
 */
--查询操作员，条件是此操作员有未核查过的企业
select * from sys_user a where exists(select 1 from t_hcrw b where b.zfry_code1=a.zfry and not exists(select 1 from t_hcsxjg c where c.hcrw_id=b.id));
--查询操作员，条件是此操作员有核查过的企业
select * from sys_user a where exists(select 1 from t_hcrw b where b.zfry_code1=a.zfry and exists(select 1 from t_hcsxjg c where c.hcrw_id=b.id));
--查询可核查的企业
select b.nd ND,b.zch XYDM,b.qymc QYMC, a.zs TXDZ, f.dzyx MAIL, decode(e.sfydwtz,'0','否','是') SFTZGMGQ,
       (select content from BM_TCKYQK g where g.code=a.yyzk) JYZT, decode(e.sfywzwd,'0','否','是') SFYWZWD,
       case when (select count(1) from nnb_dwdb g where g.nd=b.nd and g.nbxh=b.nbxh)>0 then 1 else 0 end  SFYDWDBXX,
       a.cyrs CYRS, c.syzqyhj SYZQYHJ, c.LRZE LRZE, c.zyywsr ZYYWSR, c.jlr JLR, c.nsze NSZE, c.fzze FZZE,f.lxdh lxdh,
       e.COLGRANUM gxbys_jy, e.COLEMPLNUM  gxbys_gg, e.RETSOLNUM tysbs_jy, e.RETEMPLNUM tysbs_gg, e.DISPERNUM cjrs_jy, e.DISEMPLNUM cjrs_gg, e.UNENUM zjys_jy, e.UNEEMPLNUM zjys_gg,
       d.RESPARMSIGN dj_frsfdy, null dj_lxdh, d.RESPARSECSIGN dj_qtzw, d.NUMPARM dj_dyzs, null dj_zcdys, null dj_wzrs, d.BNXZDYRS dj_fzdys, null dj_jjfzs, d.parins dj_sfjlzz, null dj_wjlzzyy,
       c.zcze zcze,f.yzbm YZBM,null yyzsr,null dj_dzzjz,null dj_frdbsfdzzsj
from nnb_jbqk a,gov_nbcc_jh_qy b,nnb_zczk c,nnb_fgdj d,nnb_qtxx e,nnb_txxx f
where a.nbxh=b.nbxh and b.nd=a.nd
      and b.nbxh=c.nbxh and a.nd=c.nd
      and b.nbxh=d.nbxh and a.nd=d.nd
      and b.nbxh=e.nbxh and b.nd=e.nd
      and b.nbxh=f.nbxh and b.nd=f.nd
      and b.nd=2014
      and b.zch in(select hcdw_xydm from t_hcrw);

/***
20160620 修改表结构
 */
alter table cpsi.t_nb add yyzsr number(10,2);
comment on column cpsi.t_nb.yyzsr is '营业总收入';
alter table cpsi.t_nb add dj_dzzjz integer;
alter table cpsi.t_nb add dj_frdbsfdzzsj integer;
comment on column cpsi.t_nb.dj_dzzjz is '党组织建制';
comment on column cpsi.t_nb.dj_frdbsfdzzsj is '法人代表是否为党组织书记';
alter table cpsi.t_nb_dwtz add tzqy_zch varchar2(100);
comment on column cpsi.t_nb_dwtz.tzqy_zch is '被投资企业注册号';

alter table cpsi.t_nb_bd add yyzsr number(10,2);
comment on column cpsi.t_nb_bd.yyzsr is '营业总收入';
alter table cpsi.t_nb_bd add dj_dzzjz integer;
alter table cpsi.t_nb_bd add dj_frdbsfdzzsj integer;
comment on column cpsi.t_nb_bd.dj_dzzjz is '党组织建制';
comment on column cpsi.t_nb_bd.dj_frdbsfdzzsj is '法人代表是否为党组织书记';
alter table cpsi.t_nb_bd_dwtz add tzqy_zch varchar2(100);
comment on column cpsi.t_nb_bd_dwtz.tzqy_zch is '被投资企业注册号';
