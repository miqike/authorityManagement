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
  insert into sys_organization(id,name,parent_id,type,contacts,phone)
    select code id,content name,sjcode2 parent_id,1 type,null contacts,null phone  from(
      select a.*,case when sjcode='0' and code not in('100000','610000') then '610000' else sjcode end sjcode2
      from bm_djjg@Dbl_Cpsi a where code not in('100000')
      start with sjcode='0' connect by prior code=sjcode
    ) start with sjcode2='0' connect by prior code=sjcode2;

  for o in cur_org loop
    insert into sys_organization(id,name,parent_id,type,contacts,phone)
      select code id,content name,o.id parent_id,1 type,null contacts,null phone from BM_gxdw@Dbl_Cpsi where code like o.id||'%' and length(code)=8;
  end loop;
end;
/

/**
  初始化核查人员
 */
delete from t_zfry;
insert into t_zfry(code,name,gender,dw_id,dw_name,zw,mobile,mail,zfzh,sfzh,zflx,whcd,zt)
  select user_name,full_name,null gender,djjg dw_id,(select content from bm_djjg@dbl_cpsi b where b.code=a.djjg) dw_name,
                             null zw,null mobile,null mail,zfzh,null sfzh,1,null whcd,1
  from v_xt_user@dbl_cpsi a;
/**
  初始化操作员
 */
delete from sys_user where user_id<>'system';
delete from sys_user_role a where not exists(select 1 from sys_user b where b.user_id=a.user_id);

insert into sys_user(user_id,manager_id,name,email,mobile,password,salt,create_time,manager_name,status,org_id,org_type,weight,org_name,zfry)
  select gh user_id,null manager_id,full_name name,null email,null mobile,lower(MD5_DIGEST(gh||'000000'||'123qwe!@#QWE')) password,'123qwe!@#QWE' salt,sysdate create_time,
         null manager_name,1 status,djjg org_id,0 org_type,1 weight,(select content from bm_djjg@dbl_cpsi b where b.code=a.djjg) org_name,
         user_name zfry
  from v_xt_user@dbl_cpsi a where gh is not null and gh not in('06020','06033','05035');
insert into sys_user_role(role_id,user_id)
  select a.id,b.user_id from sys_role a,sys_user b
  where a.name in('超级管理员')
        and b.user_id<>'system';

/**
开发测试过程中可能需要用到的SQL
 */
--查询操作员，条件是此操作员有未核查过的企业
select * from sys_user a where exists(select 1 from t_hcrw b where b.zfry_code1=a.zfry and not exists(select 1 from t_hcsxjg c where c.hcrw_id=b.id));
--查询操作员，条件是此操作员有核查过的企业
select * from sys_user a where exists(select 1 from t_hcrw b where b.zfry_code1=a.zfry and exists(select 1 from t_hcsxjg c where c.hcrw_id=b.id));
