/**
  初始化组织机构表
  将管辖单位放到登记机构下
 */
delete from sys_organization;

insert into sys_organization (id,name,parent_id,type,contacts,phone,brief_name)
select code id,content name,case when code='500' and sjcode is null then '0' else sjcode end parent_id,1 type ,null contacts,null phone,jc brief_name from (
select code,content,null jc,cast(sjcode as varchar2(100)) sjcode from bm_gxdw where code not in(select code from bm_djjg)
union all
select code,content,djjgjc jc,cast(sjcode as varchar2(100)) sjcode from bm_djjg
);

/**
  初始化核查人员 xt_user.user_name字段有重复 xt_user.gh字段有重复
 */
delete from t_zfry;
declare
  cursor xtuser IS
     select * from xt_user;
  v_cnt number;
  v_djjgmc varchar2(1000);
  v_gxdwmc varchar2(1000);
BEGIN
  for o in xtuser LOOP
    select count(1) into v_cnt from t_zfry where code=o.user_name;
    if(v_cnt=0) THEN
      insert into t_zfry(code,name,gender,dw_id,dw_name,zw,mobile,mail,zfzh,sfzh,zflx,whcd,zt,GXDW_ID,GXDW_NAME,user_id)
        values(o.user_name,o.full_name,null,
                           o.djjg,(select content from bm_djjg b where b.code=case when o.djjg is null then '500' else o.djjg end),
                           null,null,null,o.zfzh,null,1,null,1,
               o.gxdwdm,(select content from bm_gxdw b where b.code=case when o.gxdwdm is null then '500' else o.gxdwdm end),o.gh);
    ELSE
      update t_zfry set name=o.full_name,dw_id=o.djjg,dw_name=(select content from bm_djjg b where b.code=case when o.djjg is null then '500' else o.djjg end),
        GXDW_ID=o.gxdwdm,GXDW_NAME=(select content from bm_gxdw b where b.code=case when o.gxdwdm is null then '500' else o.gxdwdm end),
      user_id=o.gh where code=o.user_name;
    END IF;
  END LOOP;
END;
/

/**
  初始化操作员
 */
delete from sys_user where user_id<>'system';
delete from sys_user_role a where not exists(select 1 from sys_user b where b.user_id=a.user_id);

declare
  v_cnt number;
  v_cnt2 number;
begin
  for o in(select * from xt_user where gh is not null) loop
    select count(1) into v_cnt from sys_user where user_id=o.gh;
    if(v_cnt=0) then
      insert into sys_user(user_id,manager_id,name,email,mobile,password,salt,create_time,manager_name,status,org_id,org_type,weight,org_name,zfry,ext1)
      values(o.gh,null,o.full_name ,null,null,lower(pkg_hc.MD5_DIGEST(o.user_name||'000000'||'123qwe!@#QWE')),'123qwe!@#QWE',sysdate,
                  null,1,case when o.djjg is null then '500' else o.djjg end,0,1,(select content from bm_djjg b where b.code=case when o.djjg is null then '500' else o.djjg end) ,
             o.user_name,2);
      select count(1) into v_cnt2 from t_user_org where user_id=o.gh and org_id=case when o.djjg is null then '500' else o.djjg end;
      if(v_cnt2=0) then
        insert into t_user_org(user_id,user_name,org_id,org_name)
        values(o.gh,o.full_name,case when o.djjg is null then '500' else o.djjg end,(select content from bm_djjg b where b.code=case when o.djjg is null then '500' else o.djjg end));
      end if;
    else
      select count(1) into v_cnt2 from t_user_org where user_id=o.gh and org_id=case when o.djjg is null then '500' else o.djjg end;
      if(v_cnt2=0) then
        insert into t_user_org(user_id,user_name,org_id,org_name)
        values(o.gh,o.full_name,case when o.djjg is null then '500' else o.djjg end,(select content from bm_djjg b where b.code=case when o.djjg is null then '500' else o.djjg end));
      end if;
    end if;
  end loop;
end;
/

insert into sys_user_role(role_id,user_id)
  select a.id,b.user_id from sys_role a,sys_user b
  where a.id in(319)
        and b.user_id<>'system' and user_id not in(select user_id  from sys_user_role);
update sys_user set password=lower(pkg_hc.MD5_DIGEST(user_id||'111111'||salt));
insert into t_user_org values('system','系统管理员','500','重庆市工商行政管理局');