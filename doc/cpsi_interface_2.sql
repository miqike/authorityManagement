drop table gov_nbcc_jh_qy;
create table gov_nbcc_jh_qy(
  XH varchar2(100),
  JHXH varchar2(100),
  NBXH varchar2(100),
  ZCH varchar2(100),
  QYMC varchar2(100),
  FDDBR varchar2(100),
  QYLXDL varchar2(100),
  DJJG varchar2(100),
  GXDW varchar2(100),
  XCR varchar2(100),
  XCSJ varchar2(100),
  WCBJ varchar2(100),
  ND varchar2(100)
);
comment on table gov_nbcc_jh_qy is '抽查企业名单';
comment on column gov_nbcc_jh_qy.XH is '序号';
comment on column gov_nbcc_jh_qy.JHXH is '计划序号';
comment on column gov_nbcc_jh_qy.NBXH is '内部序号';
comment on column gov_nbcc_jh_qy.ZCH is '注册号';
comment on column gov_nbcc_jh_qy.QYMC is '企业名称';
comment on column gov_nbcc_jh_qy.FDDBR is '负责人';
comment on column gov_nbcc_jh_qy.QYLXDL is '企业类型大类';
comment on column gov_nbcc_jh_qy.DJJG is '登记机关';
comment on column gov_nbcc_jh_qy.GXDW is '管辖单位';
comment on column gov_nbcc_jh_qy.XCR is '检查人';
comment on column gov_nbcc_jh_qy.XCSJ is '巡查时间';
comment on column gov_nbcc_jh_qy.WCBJ is '序号';
comment on column gov_nbcc_jh_qy.ND is '年度';

drop table bm_djjg;
create table bm_djjg(
  code varchar2(100),
  content varchar2(100),
  djjgjc varchar2(100),
  sjcode varchar2(100)
);
comment on table bm_djjg is '登记机关';
comment on column bm_djjg.code is '单位编码';
comment on column bm_djjg.content is '单位名称';
comment on column bm_djjg.djjgjc is '登记机关简称';
comment on column bm_djjg.sjcode is '上级单位编码';

drop table bm_gxdw;
create table bm_gxdw(
  code varchar2(100),
  content varchar2(100)
);
comment on table bm_gxdw is '管辖单位';
comment on column bm_gxdw.code is '管辖单位编码';
comment on column bm_gxdw.content is '管辖单位名称';

drop table bm_hy;
create table bm_hy(
  code varchar2(100),content varchar2(100),ml varchar2(100)
);
comment on table bm_hy is '行业';
comment on column bm_hy.code is '行业编码';
comment on column bm_hy.content is '行业名称';
comment on column bm_hy.ml is '';

drop table v_ajgs;
create table v_ajgs(
  AJBH varchar2(100),
  CZRY varchar2(100),
  CZSJ varchar2(100),
  TYPE varchar2(100),
  SHZT varchar2(100),
  SHYJ varchar2(100),
  YJMS varchar2(100),
  NBXH varchar2(100),
  YJMSCS varchar2(100),
  YJMSFS varchar2(100),
  PENDECNO varchar2(100),
  ILLEGACTTYPE varchar2(1000),
  PENTYPE varchar2(100),
  PENAM varchar2(100),
  FORFAM varchar2(100),
  PENAUTH varchar2(100),
  PENDECISSDATE varchar2(100),
  UNITNAME varchar2(100),
  REGNO varchar2(100),
  LEREP varchar2(100),
  XZCFNR varchar2(4000),
  CSTUYJ varchar2(100),
  TUBZ varchar2(100),
  AJZT varchar2(100),
  UPTIME varchar2(100),
  UPNAME varchar2(100),
  OTHERPROVINCE varchar2(100),
  ENTDOMINATION varchar2(100),
  DSRID varchar2(100),
  GSBH varchar2(100)
);
comment on table v_ajgs is '即时_行政处罚';
comment on column V_AJGS.AJBH is '案件编号';
comment on column V_AJGS.CZRY is '';
comment on column V_AJGS.CZSJ is '';
comment on column V_AJGS.TYPE is '';
comment on column V_AJGS.SHZT is '';
comment on column V_AJGS.SHYJ is '';
comment on column V_AJGS.YJMS is '';
comment on column V_AJGS.NBXH is '内部序号';
comment on column V_AJGS.YJMSCS is '';
comment on column V_AJGS.YJMSFS is '';
comment on column V_AJGS.PENDECNO is '处罚单编号';
comment on column V_AJGS.ILLEGACTTYPE is '处罚原因  ';
comment on column V_AJGS.PENTYPE is '';
comment on column V_AJGS.PENAM is '';
comment on column V_AJGS.FORFAM is '';
comment on column V_AJGS.PENAUTH is '';
comment on column V_AJGS.PENDECISSDATE is '';
comment on column V_AJGS.UNITNAME is '';
comment on column V_AJGS.REGNO is '';
comment on column V_AJGS.LEREP is '';
comment on column V_AJGS.XZCFNR is '行政处罚内容';
comment on column V_AJGS.CSTUYJ is '';
comment on column V_AJGS.TUBZ is '';
comment on column V_AJGS.AJZT is '';
comment on column V_AJGS.UPTIME is '';
comment on column V_AJGS.UPNAME is '';
comment on column V_AJGS.OTHERPROVINCE is '';
comment on column V_AJGS.ENTDOMINATION is '';
comment on column V_AJGS.DSRID is '';
comment on column V_AJGS.GSBH is '';

drop table v_qy_bgnrdb;
create table v_qy_bgnrdb(
  BFXH varchar2(100),
  XH varchar2(100),
  SEQ varchar2(100),
  NBXH varchar2(100),
  ALT varchar2(100),
  ALTBE varchar2(1000),
  ALTAF varchar2(1000),
  BGCS varchar2(100),
  HZRQ varchar2(100),
  WZGF varchar2(100),
  NZGF varchar2(100),
  BGNRS varchar2(1000),
  BGHNRS varchar2(1000),
  ALTDATE varchar2(100)
);
comment on table v_qy_bgnrdb is '即时_企业_股权变更';
comment on column V_QY_BGNRDB.BFXH is '';
comment on column V_QY_BGNRDB.XH is '';
comment on column V_QY_BGNRDB.SEQ is '';
comment on column V_QY_BGNRDB.NBXH is '';
comment on column V_QY_BGNRDB.ALT is '';
comment on column V_QY_BGNRDB.ALTBE is '';
comment on column V_QY_BGNRDB.ALTAF is '';
comment on column V_QY_BGNRDB.BGCS is '';
comment on column V_QY_BGNRDB.HZRQ is '';
comment on column V_QY_BGNRDB.WZGF is '';
comment on column V_QY_BGNRDB.NZGF is '';
comment on column V_QY_BGNRDB.BGNRS is '';
comment on column V_QY_BGNRDB.BGHNRS is '';
comment on column V_QY_BGNRDB.ALTDATE is '';

drop table v_qy_qycfxx;
create table v_qy_qycfxx(
  XH varchar2(100),
  NBXH varchar2(100),
  PENTYPE varchar2(100),
  PENAM varchar2(100),
  PENDECNO varchar2(1000),
  WFNR varchar2(100),
  PENDECISSDATE varchar2(100),
  CFSFLX varchar2(100),
  PENAUTH varchar2(100),
  ZXQK varchar2(100),
  LYDQ varchar2(100),
  LRRQ varchar2(100),
  CJFS varchar2(100),
  SHDW varchar2(100),
  SHR varchar2(100),
  SHRQ varchar2(100),
  QYMC varchar2(100),
  WFLX varchar2(100),
  SFSX varchar2(100),
  WFZLMS varchar2(100),
  WFZLXL varchar2(100),
  WFZLXLMS varchar2(100),
  ILLEGACTTYPE varchar2(100),
  SFGS varchar2(100),
  FORFAM varchar2(100),
  BZ varchar2(100)
);
comment on table v_qy_qycfxx is '即时_企业公示_处罚信息';
comment on column V_QY_QYCFXX.XH is '';
comment on column V_QY_QYCFXX.NBXH is '内部序号';
comment on column V_QY_QYCFXX.PENTYPE is '';
comment on column V_QY_QYCFXX.PENAM is '';
comment on column V_QY_QYCFXX.PENDECNO is '处罚单编号';
comment on column V_QY_QYCFXX.WFNR is '';
comment on column V_QY_QYCFXX.PENDECISSDATE is '处罚日期';
comment on column V_QY_QYCFXX.CFSFLX is '';
comment on column V_QY_QYCFXX.PENAUTH is '';
comment on column V_QY_QYCFXX.ZXQK is '';
comment on column V_QY_QYCFXX.LYDQ is '';
comment on column V_QY_QYCFXX.LRRQ is '录入日期';
comment on column V_QY_QYCFXX.CJFS is '';
comment on column V_QY_QYCFXX.SHDW is '';
comment on column V_QY_QYCFXX.SHR is '';
comment on column V_QY_QYCFXX.SHRQ is '';
comment on column V_QY_QYCFXX.QYMC is '企业名称';
comment on column V_QY_QYCFXX.WFLX is '';
comment on column V_QY_QYCFXX.SFSX is '';
comment on column V_QY_QYCFXX.WFZLMS is '';
comment on column V_QY_QYCFXX.WFZLXL is '';
comment on column V_QY_QYCFXX.WFZLXLMS is '';
comment on column V_QY_QYCFXX.ILLEGACTTYPE is '违法类型';
comment on column V_QY_QYCFXX.SFGS is '';
comment on column V_QY_QYCFXX.FORFAM is '';
comment on column V_QY_QYCFXX.BZ is '';

drop table gov_nbcc_jh;
create table gov_nbcc_jh(
  JHXH varchar2(100),
  ND varchar2(100),
  DJJG varchar2(100),
  JHLX varchar2(100),
  JHMC varchar2(100),
  KSSJ varchar2(100),
  JSSJ varchar2(100),
  JHNR varchar2(100),
  JHZT varchar2(100),
  JSBJ varchar2(100),
  CCQYS varchar2(100),
  WWC varchar2(100),
  YWC varchar2(100),
  ZC varchar2(100),
  YC varchar2(100),
  CREATOR varchar2(100),
  CREATETIME varchar2(100),
  QYLXDL varchar2(100),
  HY varchar2(100),
  CLRQQ varchar2(100),
  CLRQZ varchar2(100),
  CCZT varchar2(100),
  CCDJJG varchar2(100),
  CCDJJG_KC varchar2(100),
  CCWH varchar2(100),
  CCBL varchar2(100),
  QYLX varchar2(100),
  CLRQJD varchar2(100),
  SFNB varchar2(100),
  NBND varchar2(100)
);
comment on table GOV_NBCC_JH is '计划任务';
comment on column GOV_NBCC_JH.JHXH is '计划序号';
comment on column GOV_NBCC_JH.ND is '计划年度';
comment on column GOV_NBCC_JH.DJJG is '登记机关';
comment on column GOV_NBCC_JH.JHLX is '计划类型';
comment on column GOV_NBCC_JH.JHMC is '计划名称';
comment on column GOV_NBCC_JH.KSSJ is '开始时间';
comment on column GOV_NBCC_JH.JSSJ is '结束时间';
comment on column GOV_NBCC_JH.JHNR is '计划内容';
comment on column GOV_NBCC_JH.JHZT is '计划状态';
comment on column GOV_NBCC_JH.JSBJ is '';
comment on column GOV_NBCC_JH.CCQYS is '抽查企业数';
comment on column GOV_NBCC_JH.WWC is '未完成';
comment on column GOV_NBCC_JH.YWC is '应完成';
comment on column GOV_NBCC_JH.ZC is '';
comment on column GOV_NBCC_JH.YC is '';
comment on column GOV_NBCC_JH.CREATOR is '';
comment on column GOV_NBCC_JH.CREATETIME is '计划生成时间';
comment on column GOV_NBCC_JH.QYLXDL is '企业类型大类';
comment on column GOV_NBCC_JH.HY is '行业';
comment on column GOV_NBCC_JH.CLRQQ is '成立起始日';
comment on column GOV_NBCC_JH.CLRQZ is '成立终止日';
comment on column GOV_NBCC_JH.CCZT is '抽查状态';
comment on column GOV_NBCC_JH.CCDJJG is '抽查登记机关';
comment on column GOV_NBCC_JH.CCDJJG_KC is '';
comment on column GOV_NBCC_JH.CCWH is '抽查文号';
comment on column GOV_NBCC_JH.CCBL is '';
comment on column GOV_NBCC_JH.QYLX is '企业类型';
comment on column GOV_NBCC_JH.CLRQJD is '处理日期节点';
comment on column GOV_NBCC_JH.SFNB is '';
comment on column GOV_NBCC_JH.NBND is '年报年度';

drop table v_nnb_fgdj;
create table v_nnb_fgdj(
  NBXH varchar2(100),
  ND varchar2(100),
  XH varchar2(100),
  PARINS varchar2(100),
  DZZZJFS varchar2(100),
  NUMPARM varchar2(100),
  BNZJBZ varchar2(100),
  RESPARMSIGN varchar2(100),
  RESPARSECSIGN varchar2(100),
  CJSJ varchar2(100),
  ZJSJ varchar2(100),
  QYLX varchar2(100),
  DJZDYBZ varchar2(100),
  BNXZDYRS varchar2(100)
);
comment on table V_NNB_FGDJ is '年报_非公党建';
comment on column V_NNB_FGDJ.NBXH is '内部序号';
comment on column V_NNB_FGDJ.ND is '年度';
comment on column V_NNB_FGDJ.XH is '';
comment on column V_NNB_FGDJ.PARINS is '';
comment on column V_NNB_FGDJ.DZZZJFS is '';
comment on column V_NNB_FGDJ.NUMPARM is '党员人数';
comment on column V_NNB_FGDJ.BNZJBZ is '';
comment on column V_NNB_FGDJ.RESPARMSIGN is '';
comment on column V_NNB_FGDJ.RESPARSECSIGN is '';
comment on column V_NNB_FGDJ.CJSJ is '';
comment on column V_NNB_FGDJ.ZJSJ is '组建时间';
comment on column V_NNB_FGDJ.QYLX is '';
comment on column V_NNB_FGDJ.DJZDYBZ is '';
comment on column V_NNB_FGDJ.BNXZDYRS is '';

drop table v_nnb_fqczqk;
create table v_nnb_fqczqk(
  NBXH varchar2(100),
  ND varchar2(100),
  SEQ varchar2(100),
  CZQS varchar2(100),
  QXJZ varchar2(100),
  YCZE varchar2(100),
  SJCZE varchar2(100),
  SJCZSJ varchar2(100),
  YCZEMY varchar2(100),
  WFYCZEMY varchar2(100),
  SJCZEMY varchar2(100),
  WFSJCZEMY varchar2(100)
);
comment on table V_NNB_FQCZQK is '年报_股东出资情况';
comment on column V_NNB_FQCZQK.NBXH is '内部序号';
comment on column V_NNB_FQCZQK.ND is '年度';
comment on column V_NNB_FQCZQK.SEQ is '';
comment on column V_NNB_FQCZQK.CZQS is '出资起始时间';
comment on column V_NNB_FQCZQK.QXJZ is '出资结束时间';
comment on column V_NNB_FQCZQK.YCZE is '应出资额';
comment on column V_NNB_FQCZQK.SJCZE is '实际出资额';
comment on column V_NNB_FQCZQK.SJCZSJ is '实际出资时间';
comment on column V_NNB_FQCZQK.YCZEMY is '应出资金额';
comment on column V_NNB_FQCZQK.WFYCZEMY is '';
comment on column V_NNB_FQCZQK.SJCZEMY is '实际出资额';
comment on column V_NNB_FQCZQK.WFSJCZEMY is '';

drop table v_nnb_gqbg;
create table v_nnb_gqbg(
  NBXH varchar2(100),
  ND varchar2(100),
  XH varchar2(100),
  INV varchar2(100),
  ALTDATE varchar2(100),
  TRANSAMPR varchar2(100),
  TRANSAMOR varchar2(100)
);
comment on table V_NNB_GQBG is '年报_股权变更';
comment on column V_NNB_GQBG.NBXH is '内部序号';
comment on column V_NNB_GQBG.ND is '年度';
comment on column V_NNB_GQBG.XH is '';
comment on column V_NNB_GQBG.INV is '股东名称';
comment on column V_NNB_GQBG.ALTDATE is '变更时间';
comment on column V_NNB_GQBG.TRANSAMPR is '变更前股权比例';
comment on column V_NNB_GQBG.TRANSAMOR is '变更后股权比例';

drop table v_nnb_jbqk;
create table v_nnb_jbqk(
  FQR VARCHAR2 (4000),
  YYZK VARCHAR2 (100),
  ZYYWXM VARCHAR2 (4000),
  BZSM VARCHAR2 (4000),
  ZCXS VARCHAR2 (100),
  YWFW VARCHAR2 (4000),
  REGNO VARCHAR2 (100),
  LSQY VARCHAR2 (100),
  NBXH VARCHAR2 (100),
  ND VARCHAR2 (100),
  ZS VARCHAR2 (4000),
  FDDBR VARCHAR2 (100),
  YQMC VARCHAR2 (1000),
  YYQX_QS VARCHAR2 (100),
  YYQX_JZ VARCHAR2 (100),
  ZCZJ VARCHAR2 (100),
  QYLX VARCHAR2 (100),
  JYFS_JYFW VARCHAR2 (4000),
  JYCS VARCHAR2 (100),
  SSZB VARCHAR2 (100),
  JYFW VARCHAR2 (4000),
  JYFS VARCHAR2 (100),
  CYRS VARCHAR2 (100),
  CZFS VARCHAR2 (100),
  QZXK VARCHAR2 (100),
  YBJY VARCHAR2 (100),
  JYLB VARCHAR2 (100),
  SSHY VARCHAR2 (100),
  CLRQ VARCHAR2 (100),
  BELONG_EPNAME VARCHAR2 (100),
  BELONG_EPZCH VARCHAR2 (100),
  BELONG_EPZS VARCHAR2 (100),
  JYFWDJXKZ VARCHAR2 (4000),
  JYFWDJXKZNR VARCHAR2 (4000),
  JYFWQZXKXM VARCHAR2 (4000),
  JYFWQZXKXMNR VARCHAR2 (4000),
  JYFWYBDJXM VARCHAR2 (4000),
  JYFWYBDJXMNR VARCHAR2 (4000),
  GDXMSFBG VARCHAR2 (100),
  GDAQJCZE VARCHAR2 (100),
  ZCSFXG VARCHAR2 (100),
  ZCSFBA VARCHAR2 (100),
  ZCSJQK VARCHAR2 (4000),
  DSSFBD VARCHAR2 (100),
  DSSFBA VARCHAR2 (100),
  DSSJQK VARCHAR2 (4000),
  JSSFBD VARCHAR2 (100),
  JSSFBA VARCHAR2 (100),
  JSSJQK VARCHAR2 (4000),
  JLSFBD VARCHAR2 (100),
  JLSFBA VARCHAR2 (100),
  JLSJQK VARCHAR2 (4000),
  SFYFGS VARCHAR2 (100),
  FGSSFBD VARCHAR2 (100),
  FGSSFBA VARCHAR2 (100),
  FGSSJQK VARCHAR2 (4000),
  SFQS VARCHAR2 (100),
  QSZSFBD VARCHAR2 (100),
  QSZSFBA VARCHAR2 (100),
  QSZSJQK VARCHAR2 (4000),
  JYXMQZXZXK VARCHAR2 (100),
  QZXZXKSFYX VARCHAR2 (100),
  GDSFBD VARCHAR2 (100),
  GDSFBA VARCHAR2 (100),
  GDSJQK VARCHAR2 (4000),
  DSJSSFBG VARCHAR2 (100),
  DSJSSFBA VARCHAR2 (100),
  DSJSSJQK VARCHAR2 (4000),
  ZGBMSFBG VARCHAR2 (100),
  ZGBMSFBA VARCHAR2 (100),
  ZGBMSJQK VARCHAR2 (4000),
  TZZEMY VARCHAR2 (100),
  ZCZBMY VARCHAR2 (100),
  ZFRJMY VARCHAR2 (100),
  WFRJMY VARCHAR2 (100),
  SSZBMY VARCHAR2 (100),
  ZFSJMY VARCHAR2 (100),
  WFSJMY VARCHAR2 (100),
  WQSFCX VARCHAR2 (100),
  WQCXQX VARCHAR2 (100),
  ZXSWHHRSFBD VARCHAR2 (100),
  ZXSWHHRSFBA VARCHAR2 (100),
  HHRSFBD VARCHAR2 (100),
  HHRSFBA VARCHAR2 (100),
  HHRCZSFBD VARCHAR2 (100),
  HHRCZSFBA VARCHAR2 (100),
  GBDQ VARCHAR2 (100)
);
comment on table V_NNB_JBQK is '年报_基本情况';
comment on column V_NNB_JBQK.FQR is '';
comment on column V_NNB_JBQK.YYZK is '';
comment on column V_NNB_JBQK.ZYYWXM is '';
comment on column V_NNB_JBQK.BZSM is '';
comment on column V_NNB_JBQK.ZCXS is '';
comment on column V_NNB_JBQK.YWFW is '';
comment on column V_NNB_JBQK.REGNO is '';
comment on column V_NNB_JBQK.LSQY is '';
comment on column V_NNB_JBQK.NBXH is '内部序号';
comment on column V_NNB_JBQK.ND is '年报年度';
comment on column V_NNB_JBQK.ZS is '地址';
comment on column V_NNB_JBQK.FDDBR is '负责人';
comment on column V_NNB_JBQK.YQMC is '企业名称';
comment on column V_NNB_JBQK.YYQX_QS is '营业期限_起始';
comment on column V_NNB_JBQK.YYQX_JZ is '营业期限_终止';
comment on column V_NNB_JBQK.ZCZJ is '注册资金';
comment on column V_NNB_JBQK.QYLX is '企业类型';
comment on column V_NNB_JBQK.JYFS_JYFW is '';
comment on column V_NNB_JBQK.JYCS is '';
comment on column V_NNB_JBQK.SSZB is '';
comment on column V_NNB_JBQK.JYFW is '经营范围';
comment on column V_NNB_JBQK.JYFS is '';
comment on column V_NNB_JBQK.CYRS is '';
comment on column V_NNB_JBQK.CZFS is '';
comment on column V_NNB_JBQK.QZXK is '';
comment on column V_NNB_JBQK.YBJY is '';
comment on column V_NNB_JBQK.JYLB is '';
comment on column V_NNB_JBQK.SSHY is '';
comment on column V_NNB_JBQK.CLRQ is '';
comment on column V_NNB_JBQK.BELONG_EPNAME is '';
comment on column V_NNB_JBQK.BELONG_EPZCH is '';
comment on column V_NNB_JBQK.BELONG_EPZS is '';
comment on column V_NNB_JBQK.JYFWDJXKZ is '';
comment on column V_NNB_JBQK.JYFWDJXKZNR is '';
comment on column V_NNB_JBQK.JYFWQZXKXM is '';
comment on column V_NNB_JBQK.JYFWQZXKXMNR is '';
comment on column V_NNB_JBQK.JYFWYBDJXM is '';
comment on column V_NNB_JBQK.JYFWYBDJXMNR is '';
comment on column V_NNB_JBQK.GDXMSFBG is '';
comment on column V_NNB_JBQK.GDAQJCZE is '';
comment on column V_NNB_JBQK.ZCSFXG is '';
comment on column V_NNB_JBQK.ZCSFBA is '';
comment on column V_NNB_JBQK.ZCSJQK is '';
comment on column V_NNB_JBQK.DSSFBD is '';
comment on column V_NNB_JBQK.DSSFBA is '';
comment on column V_NNB_JBQK.DSSJQK is '';
comment on column V_NNB_JBQK.JSSFBD is '';
comment on column V_NNB_JBQK.JSSFBA is '';
comment on column V_NNB_JBQK.JSSJQK is '';
comment on column V_NNB_JBQK.JLSFBD is '';
comment on column V_NNB_JBQK.JLSFBA is '';
comment on column V_NNB_JBQK.JLSJQK is '';
comment on column V_NNB_JBQK.SFYFGS is '';
comment on column V_NNB_JBQK.FGSSFBD is '';
comment on column V_NNB_JBQK.FGSSFBA is '';
comment on column V_NNB_JBQK.FGSSJQK is '';
comment on column V_NNB_JBQK.SFQS is '';
comment on column V_NNB_JBQK.QSZSFBD is '';
comment on column V_NNB_JBQK.QSZSFBA is '';
comment on column V_NNB_JBQK.QSZSJQK is '';
comment on column V_NNB_JBQK.JYXMQZXZXK is '';
comment on column V_NNB_JBQK.QZXZXKSFYX is '';
comment on column V_NNB_JBQK.GDSFBD is '';
comment on column V_NNB_JBQK.GDSFBA is '';
comment on column V_NNB_JBQK.GDSJQK is '';
comment on column V_NNB_JBQK.DSJSSFBG is '';
comment on column V_NNB_JBQK.DSJSSFBA is '';
comment on column V_NNB_JBQK.DSJSSJQK is '';
comment on column V_NNB_JBQK.ZGBMSFBG is '';
comment on column V_NNB_JBQK.ZGBMSFBA is '';
comment on column V_NNB_JBQK.ZGBMSJQK is '';
comment on column V_NNB_JBQK.TZZEMY is '';
comment on column V_NNB_JBQK.ZCZBMY is '';
comment on column V_NNB_JBQK.ZFRJMY is '';
comment on column V_NNB_JBQK.WFRJMY is '';
comment on column V_NNB_JBQK.SSZBMY is '';
comment on column V_NNB_JBQK.ZFSJMY is '';
comment on column V_NNB_JBQK.WFSJMY is '';
comment on column V_NNB_JBQK.WQSFCX is '';
comment on column V_NNB_JBQK.WQCXQX is '';
comment on column V_NNB_JBQK.ZXSWHHRSFBD is '';
comment on column V_NNB_JBQK.ZXSWHHRSFBA is '';
comment on column V_NNB_JBQK.HHRSFBD is '';
comment on column V_NNB_JBQK.HHRSFBA is '';
comment on column V_NNB_JBQK.HHRCZSFBD is '';
comment on column V_NNB_JBQK.HHRCZSFBA is '';
comment on column V_NNB_JBQK.GBDQ is '';

drop table v_nnb_jyqk;
create table v_nnb_jyqk(
  NBXH VARCHAR2 (100),
  ND VARCHAR2 (100),
  YYE VARCHAR2 (100),
  FWYYSL VARCHAR2 (100),
  GNXSE VARCHAR2 (100),
  FWYYE VARCHAR2 (100),
  NSZE VARCHAR2 (100),
  GS VARCHAR2 (100),
  LRZE VARCHAR2 (100),
  SHLR VARCHAR2 (100),
  ZCZE VARCHAR2 (100),
  CQTZ VARCHAR2 (100),
  FZZE VARCHAR2 (100),
  CQFZ VARCHAR2 (100),
  YWJYQ VARCHAR2 (100),
  SZJWTZ VARCHAR2 (100),
  JCKDL VARCHAR2 (100),
  JCKZY VARCHAR2 (100),
  DNTZ VARCHAR2 (100),
  DWTZ VARCHAR2 (100),
  YZJGMC VARCHAR2 (100),
  YYZK VARCHAR2 (100),
  TCKYRQ VARCHAR2 (100),
  KSJFZCSCDYY VARCHAR2 (1000),
  SFCBJYGL VARCHAR2 (100),
  CBBQYDCBQYMC VARCHAR2 (100),
  QJCZYY VARCHAR2 (100),
  GYZCCZE VARCHAR2 (100),
  KS VARCHAR2 (100)
);
comment on table V_NNB_JYQK is '年报_经营情况';
comment on column V_NNB_JYQK.NBXH is '内部序号';
comment on column V_NNB_JYQK.ND is '年度';
comment on column V_NNB_JYQK.YYE is '营业额';
comment on column V_NNB_JYQK.FWYYSL is '';
comment on column V_NNB_JYQK.GNXSE is '主营业务营业额';
comment on column V_NNB_JYQK.FWYYE is '';
comment on column V_NNB_JYQK.NSZE is '纳税总额';
comment on column V_NNB_JYQK.GS is '个税';
comment on column V_NNB_JYQK.LRZE is '利润总额';
comment on column V_NNB_JYQK.SHLR is '税后利润';
comment on column V_NNB_JYQK.ZCZE is '资产总额';
comment on column V_NNB_JYQK.CQTZ is '产权投资';
comment on column V_NNB_JYQK.FZZE is '负债总额';
comment on column V_NNB_JYQK.CQFZ is '';
comment on column V_NNB_JYQK.YWJYQ is '';
comment on column V_NNB_JYQK.SZJWTZ is '';
comment on column V_NNB_JYQK.JCKDL is '';
comment on column V_NNB_JYQK.JCKZY is '';
comment on column V_NNB_JYQK.DNTZ is '';
comment on column V_NNB_JYQK.DWTZ is '';
comment on column V_NNB_JYQK.YZJGMC is '验资机构名称';
comment on column V_NNB_JYQK.YYZK is '';
comment on column V_NNB_JYQK.TCKYRQ is '';
comment on column V_NNB_JYQK.KSJFZCSCDYY is '';
comment on column V_NNB_JYQK.SFCBJYGL is '';
comment on column V_NNB_JYQK.CBBQYDCBQYMC is '';
comment on column V_NNB_JYQK.QJCZYY is '';
comment on column V_NNB_JYQK.GYZCCZE is '';
comment on column V_NNB_JYQK.KS is '';

drop table v_nnb_wzxx;
create table v_nnb_wzxx(
  NBXH VARCHAR2 (100),
  ND VARCHAR2 (100),
  SEQ VARCHAR2 (100),
  WEBSITNAME VARCHAR2 (100),
  DOMAIN VARCHAR2 (100),
  WEBTYPE VARCHAR2 (100),
  SFWSLZ VARCHAR2 (100)
);
comment on table v_nnb_wzxx is '年报_网址网店';
comment on column V_NNB_WZXX.NBXH is '内部序号';
comment on column V_NNB_WZXX.ND is '年报年度';
comment on column V_NNB_WZXX.SEQ is '';
comment on column V_NNB_WZXX.WEBSITNAME is '网址名称';
comment on column V_NNB_WZXX.DOMAIN is '网址';
comment on column V_NNB_WZXX.WEBTYPE is '网站类型';
comment on column V_NNB_WZXX.SFWSLZ is '';

drop table bm_qylx;
create table bm_qylx(
  code VARCHAR2 (100),content VARCHAR2 (100),qylxdl VARCHAR2 (100)
);
comment on table bm_qylx is '企业类型';
comment on column bm_qylx.code is '编码';
comment on column bm_qylx.content is '企业类型';
comment on column bm_qylx.qylxdl is '企业类型大类';

drop table v_xt_user;
create table v_xt_user(
  user_name VARCHAR2 (100),full_name VARCHAR2 (100),gh VARCHAR2 (100),gxdwdm VARCHAR2 (100),djjg VARCHAR2 (100),zfzh VARCHAR2 (100)
);
comment on table v_xt_user is '执法人员名单';
comment on column v_xt_user.user_name is '用户代码';
comment on column v_xt_user.full_name is '姓名';
comment on column v_xt_user.gh is '工号';
comment on column v_xt_user.gxdwdm is '管辖单位代码';
comment on column v_xt_user.djjg is '登记机关';
comment on column v_xt_user.zfzh is '执法证号';

/**
导入数据之后，生成测试数据
 */
delete from v_nnb_jbqk where nd='2016';
insert into v_nnb_jbqk(QSZSJQK,JYXMQZXZXK,QZXZXKSFYX,GDSFBD,GDSFBA,GDSJQK,DSJSSFBG,DSJSSFBA,DSJSSJQK,ZGBMSFBG,ZGBMSFBA,ZGBMSJQK,
                       TZZEMY,ZCZBMY,ZFRJMY,WFRJMY,SSZBMY,ZFSJMY,WFSJMY,WQSFCX,WQCXQX,ZXSWHHRSFBD,ZXSWHHRSFBA,HHRSFBD,HHRSFBA,HHRCZSFBD,HHRCZSFBA,GBDQ,
                       FQR,YYZK,ZYYWXM,BZSM,ZCXS,YWFW,REGNO,LSQY,NBXH,ND,ZS,FDDBR,YQMC,YYQX_QS,YYQX_JZ,ZCZJ,QYLX,JYFS_JYFW,JYCS,SSZB,JYFW,JYFS,CYRS,CZFS,
                       QZXK,YBJY,JYLB,SSHY,CLRQ,BELONG_EPNAME,BELONG_EPZCH,BELONG_EPZS,JYFWDJXKZ,JYFWDJXKZNR,JYFWQZXKXM,JYFWQZXKXMNR,JYFWYBDJXM,
                       JYFWYBDJXMNR,GDXMSFBG,GDAQJCZE,ZCSFXG,ZCSFBA,ZCSJQK,DSSFBD,DSSFBA,DSSJQK,JSSFBD,JSSFBA,JSSJQK,JLSFBD,JLSFBA,JLSJQK,SFYFGS,FGSSFBD,
                       FGSSFBA,FGSSJQK,SFQS,QSZSFBD,QSZSFBA)
  select uext_random.random_chinese(10) QSZSJQK,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end JYXMQZXZXK,uext_random.random_chinese(10) QZXZXKSFYX,uext_random.random_chinese(10) GDSFBD,
         uext_random.random_chinese(10) GDSFBA,uext_random.random_chinese(10) GDSJQK,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSJSSFBG,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSJSSFBA,
         uext_random.random_chinese(10) DSJSSJQK,uext_random.random_chinese(10) ZGBMSFBG,uext_random.random_chinese(10) ZGBMSFBA,uext_random.random_chinese(10) ZGBMSJQK,
         uext_random.value(1000,10000) TZZEMY,uext_random.value(1000,10000) ZCZBMY,uext_random.value(1000,10000) ZFRJMY,uext_random.value(1000,10000) WFRJMY,
         uext_random.value(1000,10000) SSZBMY,uext_random.value(1000,10000) ZFSJMY,uext_random.value(1000,10000) WFSJMY,uext_random.random_chinese(10) WQSFCX,
         uext_random.random_chinese(10) WQCXQX,uext_random.random_chinese(10) ZXSWHHRSFBD,uext_random.random_chinese(10) ZXSWHHRSFBA,uext_random.random_chinese(10) HHRSFBD,
         uext_random.random_chinese(10) HHRSFBA,uext_random.random_chinese(10) HHRCZSFBD,uext_random.random_chinese(10) HHRCZSFBA,uext_random.random_chinese(10) GBDQ,
         uext_random.random_chinese(10) FQR,trunc(uext_random.value(0, 2)) YYZK,uext_random.random_chinese(10) ZYYWXM,uext_random.random_chinese(10) BZSM,
         uext_random.random_chinese(10) ZCXS,uext_random.random_chinese(10) YWFW,uext_random.random_chinese(10) REGNO,uext_random.random_chinese(10) LSQY,
         nbxh NBXH,nd ND,uext_random.random_addr ZS,uext_random.random_name FDDBR,
         uext_random.random_chinese(10) YQMC,uext_random.random_chinese(10) YYQX_QS,to_char(uext_random.random_date(345),'yyyy/mm/dd') YYQX_JZ,uext_random.value(1000,10000) ZCZJ,
         uext_random.random_chinese(10) QYLX,uext_random.random_chinese(10) JYFS_JYFW,uext_random.random_chinese(10) JYCS,uext_random.random_chinese(10) SSZB,
         uext_random.random_chinese(10) JYFW,uext_random.random_chinese(10) JYFS,trunc(uext_random.value(1,100)) CYRS,uext_random.random_chinese(10) CZFS,
         uext_random.random_chinese(10) QZXK,uext_random.random_chinese(10) YBJY,uext_random.random_chinese(10) JYLB,uext_random.value(1000,10000) SSHY,
         to_char(uext_random.random_date(345),'yyyy/mm/dd') CLRQ,uext_random.random_chinese(10) BELONG_EPNAME,uext_random.random_numeric_character(15) BELONG_EPZCH,uext_random.random_addr BELONG_EPZS,
         uext_random.random_chinese(10) JYFWDJXKZ,uext_random.random_chinese(10) JYFWDJXKZNR,uext_random.random_chinese(10) JYFWQZXKXM,uext_random.random_chinese(10) JYFWQZXKXMNR,
         uext_random.random_chinese(10) JYFWYBDJXM,uext_random.random_chinese(10) JYFWYBDJXMNR,uext_random.random_chinese(10) GDXMSFBG,uext_random.random_chinese(10) GDAQJCZE,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end ZCSFXG,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end ZCSFBA,uext_random.random_chinese(10) ZCSJQK,uext_random.random_chinese(10) DSSFBD,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSSFBA,uext_random.random_chinese(10) DSSJQK,uext_random.random_chinese(10) JSSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end JSSFBA,
         uext_random.random_chinese(10) JSSJQK,uext_random.random_chinese(10) JLSFBD,uext_random.random_chinese(10) JLSFBA,uext_random.random_chinese(10) JLSJQK,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFYFGS,uext_random.random_chinese(10) FGSSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end FGSSFBA,uext_random.random_chinese(10) FGSSJQK,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFQS,uext_random.random_chinese(10) QSZSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end QSZSFBA
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_jbqk  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from v_nnb_jbqk_bd where nd='2016';
insert into v_nnb_jbqk_bd(QSZSJQK,JYXMQZXZXK,QZXZXKSFYX,GDSFBD,GDSFBA,GDSJQK,DSJSSFBG,DSJSSFBA,DSJSSJQK,ZGBMSFBG,ZGBMSFBA,ZGBMSJQK,
                       TZZEMY,ZCZBMY,ZFRJMY,WFRJMY,SSZBMY,ZFSJMY,WFSJMY,WQSFCX,WQCXQX,ZXSWHHRSFBD,ZXSWHHRSFBA,HHRSFBD,HHRSFBA,HHRCZSFBD,HHRCZSFBA,GBDQ,
                       FQR,YYZK,ZYYWXM,BZSM,ZCXS,YWFW,REGNO,LSQY,NBXH,ND,ZS,FDDBR,YQMC,YYQX_QS,YYQX_JZ,ZCZJ,QYLX,JYFS_JYFW,JYCS,SSZB,JYFW,JYFS,CYRS,CZFS,
                       QZXK,YBJY,JYLB,SSHY,CLRQ,BELONG_EPNAME,BELONG_EPZCH,BELONG_EPZS,JYFWDJXKZ,JYFWDJXKZNR,JYFWQZXKXM,JYFWQZXKXMNR,JYFWYBDJXM,
                       JYFWYBDJXMNR,GDXMSFBG,GDAQJCZE,ZCSFXG,ZCSFBA,ZCSJQK,DSSFBD,DSSFBA,DSSJQK,JSSFBD,JSSFBA,JSSJQK,JLSFBD,JLSFBA,JLSJQK,SFYFGS,FGSSFBD,
                       FGSSFBA,FGSSJQK,SFQS,QSZSFBD,QSZSFBA)
  select uext_random.random_chinese(10) QSZSJQK,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end JYXMQZXZXK,uext_random.random_chinese(10) QZXZXKSFYX,uext_random.random_chinese(10) GDSFBD,
         uext_random.random_chinese(10) GDSFBA,uext_random.random_chinese(10) GDSJQK,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSJSSFBG,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSJSSFBA,
         uext_random.random_chinese(10) DSJSSJQK,uext_random.random_chinese(10) ZGBMSFBG,uext_random.random_chinese(10) ZGBMSFBA,uext_random.random_chinese(10) ZGBMSJQK,
         uext_random.value(1000,10000) TZZEMY,uext_random.value(1000,10000) ZCZBMY,uext_random.value(1000,10000) ZFRJMY,uext_random.value(1000,10000) WFRJMY,
         uext_random.value(1000,10000) SSZBMY,uext_random.value(1000,10000) ZFSJMY,uext_random.value(1000,10000) WFSJMY,uext_random.random_chinese(10) WQSFCX,
         uext_random.random_chinese(10) WQCXQX,uext_random.random_chinese(10) ZXSWHHRSFBD,uext_random.random_chinese(10) ZXSWHHRSFBA,uext_random.random_chinese(10) HHRSFBD,
         uext_random.random_chinese(10) HHRSFBA,uext_random.random_chinese(10) HHRCZSFBD,uext_random.random_chinese(10) HHRCZSFBA,uext_random.random_chinese(10) GBDQ,
         uext_random.random_chinese(10) FQR,trunc(uext_random.value(0, 2)) YYZK,uext_random.random_chinese(10) ZYYWXM,uext_random.random_chinese(10) BZSM,
         uext_random.random_chinese(10) ZCXS,uext_random.random_chinese(10) YWFW,uext_random.random_chinese(10) REGNO,uext_random.random_chinese(10) LSQY,
         nbxh NBXH,nd ND,uext_random.random_addr ZS,uext_random.random_name FDDBR,
         uext_random.random_chinese(10) YQMC,uext_random.random_chinese(10) YYQX_QS,to_char(uext_random.random_date(345),'yyyy/mm/dd') YYQX_JZ,uext_random.value(1000,10000) ZCZJ,
         uext_random.random_chinese(10) QYLX,uext_random.random_chinese(10) JYFS_JYFW,uext_random.random_chinese(10) JYCS,uext_random.random_chinese(10) SSZB,
         uext_random.random_chinese(10) JYFW,uext_random.random_chinese(10) JYFS,trunc(uext_random.value(1,100)) CYRS,uext_random.random_chinese(10) CZFS,
         uext_random.random_chinese(10) QZXK,uext_random.random_chinese(10) YBJY,uext_random.random_chinese(10) JYLB,uext_random.value(1000,10000) SSHY,
         to_char(uext_random.random_date(345),'yyyy/mm/dd') CLRQ,uext_random.random_chinese(10) BELONG_EPNAME,uext_random.random_numeric_character(15) BELONG_EPZCH,uext_random.random_addr BELONG_EPZS,
         uext_random.random_chinese(10) JYFWDJXKZ,uext_random.random_chinese(10) JYFWDJXKZNR,uext_random.random_chinese(10) JYFWQZXKXM,uext_random.random_chinese(10) JYFWQZXKXMNR,
         uext_random.random_chinese(10) JYFWYBDJXM,uext_random.random_chinese(10) JYFWYBDJXMNR,uext_random.random_chinese(10) GDXMSFBG,uext_random.random_chinese(10) GDAQJCZE,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end ZCSFXG,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end ZCSFBA,uext_random.random_chinese(10) ZCSJQK,uext_random.random_chinese(10) DSSFBD,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end DSSFBA,uext_random.random_chinese(10) DSSJQK,uext_random.random_chinese(10) JSSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end JSSFBA,
         uext_random.random_chinese(10) JSSJQK,uext_random.random_chinese(10) JLSFBD,uext_random.random_chinese(10) JLSFBA,uext_random.random_chinese(10) JLSJQK,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFYFGS,uext_random.random_chinese(10) FGSSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end FGSSFBA,uext_random.random_chinese(10) FGSSJQK,
         case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFQS,uext_random.random_chinese(10) QSZSFBD,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end QSZSFBA
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_jbqk_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

delete from v_nnb_jyqk where nd='2016';
insert into v_nnb_jyqk(KS,NBXH,ND,YYE,FWYYSL,GNXSE,FWYYE,NSZE,GS,LRZE,SHLR,ZCZE,CQTZ,FZZE,CQFZ,YWJYQ,SZJWTZ,JCKDL,JCKZY,DNTZ,
                       DWTZ,YZJGMC,YYZK,TCKYRQ,KSJFZCSCDYY,SFCBJYGL,CBBQYDCBQYMC,QJCZYY,GYZCCZE)
  select uext_random.value(100,10000) KS,nbxh NBXH,nd nd,uext_random.value(100,10000) YYE,
         uext_random.value(100,10000) FWYYSL,uext_random.value(100,10000) GNXSE,uext_random.value(100,10000) FWYYE,uext_random.value(100,10000) NSZE,
         uext_random.value(100,10000) GS,uext_random.value(100,10000) LRZE,uext_random.value(100,10000) SHLR,uext_random.value(100,10000) ZCZE,
         uext_random.value(100,10000) CQTZ,uext_random.value(100,10000) FZZE,uext_random.value(100,10000) CQFZ,trunc(uext_random.value(0,2)) YWJYQ,
         uext_random.value(100,10000) SZJWTZ,uext_random.value(100,10000) JCKDL,uext_random.value(100,10000) JCKZY,uext_random.value(100,10000) DNTZ,
         uext_random.value(100,10000) DWTZ,uext_random.random_chinese(10) YZJGMC,trunc(uext_random.value(0,2)) YYZK,to_char(uext_random.random_date(345),'yyyy-mm-dd') TCKYRQ,
         uext_random.random_chinese(10) KSJFZCSCDYY,trunc(uext_random.value(0,2)) SFCBJYGL,uext_random.value(100,10000) CBBQYDCBQYMC,uext_random.value(100,10000) QJCZYY,
         uext_random.value(100,10000) GYZCCZE
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_jyqk  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from v_nnb_jyqk_bd where nd='2016';
insert into v_nnb_jyqk_bd(KS,NBXH,ND,YYE,FWYYSL,GNXSE,FWYYE,NSZE,GS,LRZE,SHLR,ZCZE,CQTZ,FZZE,CQFZ,YWJYQ,SZJWTZ,JCKDL,JCKZY,DNTZ,
                       DWTZ,YZJGMC,YYZK,TCKYRQ,KSJFZCSCDYY,SFCBJYGL,CBBQYDCBQYMC,QJCZYY,GYZCCZE)
  select uext_random.value(100,10000) KS,nbxh NBXH,nd nd,uext_random.value(100,10000) YYE,
         uext_random.value(100,10000) FWYYSL,uext_random.value(100,10000) GNXSE,uext_random.value(100,10000) FWYYE,uext_random.value(100,10000) NSZE,
         uext_random.value(100,10000) GS,uext_random.value(100,10000) LRZE,uext_random.value(100,10000) SHLR,uext_random.value(100,10000) ZCZE,
         uext_random.value(100,10000) CQTZ,uext_random.value(100,10000) FZZE,uext_random.value(100,10000) CQFZ,trunc(uext_random.value(0,2)) YWJYQ,
         uext_random.value(100,10000) SZJWTZ,uext_random.value(100,10000) JCKDL,uext_random.value(100,10000) JCKZY,uext_random.value(100,10000) DNTZ,
         uext_random.value(100,10000) DWTZ,uext_random.random_chinese(10) YZJGMC,trunc(uext_random.value(0,2)) YYZK,to_char(uext_random.random_date(345),'yyyy-mm-dd') TCKYRQ,
         uext_random.random_chinese(10) KSJFZCSCDYY,trunc(uext_random.value(0,2)) SFCBJYGL,uext_random.value(100,10000) CBBQYDCBQYMC,uext_random.value(100,10000) QJCZYY,
         uext_random.value(100,10000) GYZCCZE
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_jyqk_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

delete from v_nnb_fgdj where nd='2016';
insert into v_nnb_fgdj(NBXH,ND,XH,PARINS,DZZZJFS,NUMPARM,BNZJBZ,RESPARMSIGN,RESPARSECSIGN,CJSJ,ZJSJ,QYLX,DJZDYBZ,BNXZDYRS)
  select nbxh NBXH,nd nd,uext_random.value(1,10) XH,uext_random.value(1,10) PARINS,uext_random.value(1,10) DZZZJFS,uext_random.value(1,10) NUMPARM,
         uext_random.value(1,10) BNZJBZ,uext_random.value(1,10) RESPARMSIGN,uext_random.value(1,10) RESPARSECSIGN,uext_random.value(1,10) CJSJ,
         to_char(uext_random.random_date(345),'yyyy-mm-dd') ZJSJ,uext_random.value(1,10) QYLX,uext_random.value(1,10) DJZDYBZ,uext_random.value(1,10) BNXZDYRS
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_fgdj  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from v_nnb_fgdj_bd where nd='2016';
insert into v_nnb_fgdj_bd(NBXH,ND,XH,PARINS,DZZZJFS,NUMPARM,BNZJBZ,RESPARMSIGN,RESPARSECSIGN,CJSJ,ZJSJ,QYLX,DJZDYBZ,BNXZDYRS)
  select nbxh NBXH,nd nd,uext_random.value(1,10) XH,uext_random.value(1,10) PARINS,uext_random.value(1,10) DZZZJFS,uext_random.value(1,10) NUMPARM,
         uext_random.value(1,10) BNZJBZ,uext_random.value(1,10) RESPARMSIGN,uext_random.value(1,10) RESPARSECSIGN,uext_random.value(1,10) CJSJ,
         to_char(uext_random.random_date(345),'yyyy-mm-dd') ZJSJ,uext_random.value(1,10) QYLX,uext_random.value(1,10) DJZDYBZ,uext_random.value(1,10) BNXZDYRS
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_fgdj_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

delete from v_nnb_fqczqk where nd='2016';
insert into v_nnb_fqczqk(NBXH,ND,SEQ,CZQS,QXJZ,YCZE,SJCZE,SJCZSJ,YCZEMY,WFYCZEMY,SJCZEMY,WFSJCZEMY)
  select nbxh NBXH,nd nd,rownum SEQ,to_char(uext_random.random_date(345),'yyyy-mm-dd') CZQS,to_char(uext_random.random_date(345),'yyyy-mm-dd') QXJZ,
         uext_random.value(1,10) YCZE,uext_random.value(1,10) SJCZE,to_char(uext_random.random_date(345),'yyyy-mm-dd')  SJCZSJ,uext_random.value(1,10) YCZEMY,
         uext_random.value(1,10) WFYCZEMY,uext_random.value(1,10) SJCZEMY,uext_random.value(1,10) WFSJCZEMY
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_fqczqk  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from v_nnb_fqczqk_bd where nd='2016';
insert into v_nnb_fqczqk_bd(NBXH,ND,SEQ,CZQS,QXJZ,YCZE,SJCZE,SJCZSJ,YCZEMY,WFYCZEMY,SJCZEMY,WFSJCZEMY)
  select nbxh NBXH,nd nd,rownum SEQ,to_char(uext_random.random_date(345),'yyyy-mm-dd') CZQS,to_char(uext_random.random_date(345),'yyyy-mm-dd') QXJZ,
         uext_random.value(1,10) YCZE,uext_random.value(1,10) SJCZE,to_char(uext_random.random_date(345),'yyyy-mm-dd')  SJCZSJ,uext_random.value(1,10) YCZEMY,
         uext_random.value(1,10) WFYCZEMY,uext_random.value(1,10) SJCZEMY,uext_random.value(1,10) WFSJCZEMY
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_fqczqk_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

delete from V_NNB_GQBG where nd='2016';
insert into V_NNB_GQBG(NBXH,ND,XH,INV,ALTDATE,TRANSAMPR,TRANSAMOR)
  select nbxh NBXH,nd nd,rownum XH,uext_random.random_name INV,to_char(uext_random.random_date(345),'yyyy-mm-dd')  ALTDATE,
         uext_random.value(1,10) TRANSAMPR,uext_random.value(1,10) TRANSAMOR
  from gov_nbcc_jh_qy a where not exists(select 1 from V_NNB_GQBG  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from V_NNB_GQBG_bd where nd='2016';
insert into V_NNB_GQBG_bd(NBXH,ND,XH,INV,ALTDATE,TRANSAMPR,TRANSAMOR)
  select nbxh NBXH,nd nd,rownum XH,uext_random.random_name INV,to_char(uext_random.random_date(345),'yyyy-mm-dd')  ALTDATE,
         uext_random.value(1,10) TRANSAMPR,uext_random.value(1,10) TRANSAMOR
  from gov_nbcc_jh_qy a where not exists(select 1 from V_NNB_GQBG_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

delete from v_nnb_wzxx where nd='2016';
insert into v_nnb_wzxx(NBXH,ND,SEQ,WEBSITNAME,DOMAIN,WEBTYPE,SFWSLZ)
  select nbxh NBXH,nd nd,rownum SEQ,uext_random.random_chinese(10) WEBSITNAME,'http://'||uext_random.string('x',10)||'.com' DOMAIN,
         trunc(uext_random.value(1,10))*10 WEBTYPE,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFWSLZ
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_wzxx  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';
delete from v_nnb_wzxx_bd where nd='2016';
insert into v_nnb_wzxx_bd(NBXH,ND,SEQ,WEBSITNAME,DOMAIN,WEBTYPE,SFWSLZ)
  select nbxh NBXH,nd nd,rownum SEQ,uext_random.random_chinese(10) WEBSITNAME,'http://'||uext_random.string('x',10)||'.com' DOMAIN,
         trunc(uext_random.value(1,10))*10 WEBTYPE,case trunc(uext_random.value(0,2)) when 0 then 'N' else 'Y' end SFWSLZ
  from gov_nbcc_jh_qy a where not exists(select 1 from v_nnb_wzxx_bd  b where b.nbxh=a.nbxh and b.ND=a.nd) and nd='2016';

/**
----问题
1、任务表问题中XCR人员分隔规则需要明确，如果不能确定，只能进行模糊查询。另外能否给出代码，如果按照名称进行匹配会有重名问题。
     任务表问题中XCR字段有610300000000486
     XCR字段与xt_user表中数据对应不上如何处理
2、三个人如何处理
3、管辖单位编码有6、9、10位的
      610100001	城东工商所
      610502002	临渭分局机关
      612428004	牛头店工商所
      610524	西寨街道
      612428005	上竹工商所
      612428006	曙坪工商所
      612428007	华坪工商所
      610526	韦林街道、果园街道
      6127220301	大柳塔管区
      612631011	办公室
      612631010	12315申诉举报中心
      610525	迪村街道
      610527	韦林街道
4、工号重复
    06020	2
    06033	2
    05035	2
5、任务接口表gov_nbcc_jh_qy中增加创建时间字段，根据创建时间进行增量数据获取
6、登记机关中SJCODE字段不正确，目前是进行判断，如果SJCODE=0则付值610000
7、数据完整性不够
8、非公党建数据重复
      6103000000001592	2013	2
      6103010000008353	2013	2
      6127010000001330	2013	2
      612700100002919	2013	2
      6105020000001090	2013	2
      6127262310395	2013	2
      6127322310017	2013	2
      6123006000000074	2013	2
      610403100002257	2013	2
      6100002070429	2013	2
      6104810000007776	2013	2
      610200300001929	2013	2
      6123012700198	2013	2
      610481100000935	2013	2
      6104240000004639	2013	2
      610403100002057	2013	2
      610000200008465	2013	2
      6100002009128	2013	2
      6100000000003302	2013	2
      6100000000070363	2013	2
      610400200000077	2013	2
      6127240000011628	2013	2
      610000100151317	2013	2
      612632100000181	2013	2
      610000100163853	2013	2
      6100000000036335	2013	2
      6126240000030577	2013	2
      6126262300063	2013	2
      610400100027371	2013	2
      6125221200419	2013	2
      610300100008783	2013	2
      6105212010008	2013	2
      6126010000049236	2013	2
      6104031800129	2013	2
      6100000000040276	2013	2
      6100000000070281	2013	2
      610300100004217	2013	2
      6103012060200	2013	2
      612600100006115	2013	2
      6123252100496	2013	2

 */
