DROP TABLE v_hcrw;
CREATE TABLE v_hcrw (
  HCDW_XYDM  VARCHAR2(32),
  HCDW_NAME  VARCHAR2(200),
  ZFRY_CODE1 VARCHAR2(32),
  ZFRY_CODE2 VARCHAR2(32),
  ZFRY_NAME1 VARCHAR2(20),
  ZFRY_NAME2 VARCHAR2(20),
  HCFL       INTEGER,
  HCJG       VARCHAR2(100),
  JYZT       INTEGER,
  HCJGMC     VARCHAR2(100),
  DJJG       VARCHAR2(100),
  DJJGMC     VARCHAR2(100),
  ZTLX       INTEGER,
  ZZXS       INTEGER,
  QYBM       VARCHAR2(100),
  QYMC       VARCHAR2(100),
  HYFL       INTEGER,
  FR         VARCHAR2(32),
  LXDH       VARCHAR2(20),
  MAIL       VARCHAR2(100),
  JYDZ       VARCHAR2(400),
  LLR        VARCHAR2(32)
);
COMMENT ON TABLE v_hcrw IS '核查任务表';
COMMENT ON COLUMN v_hcrw.HCDW_XYDM IS '被核查单位统一社会信用代码';
COMMENT ON COLUMN v_hcrw.HCDW_NAME IS '被核查单位名称';
COMMENT ON COLUMN v_hcrw.ZFRY_CODE1 IS '执法人员编码1';
COMMENT ON COLUMN v_hcrw.ZFRY_CODE2 IS '执法人员编码2';
COMMENT ON COLUMN v_hcrw.ZFRY_NAME1 IS '执法人员名称';
COMMENT ON COLUMN v_hcrw.ZFRY_NAME2 IS '执法人员名称';
COMMENT ON COLUMN v_hcrw.HCFL IS '核查分类';
COMMENT ON COLUMN v_hcrw.HCJG IS '核查机关代码';
COMMENT ON COLUMN v_hcrw.JYZT IS '经营状态';
COMMENT ON COLUMN v_hcrw.HCJGMC IS '核查机关名称';
COMMENT ON COLUMN v_hcrw.DJJG IS '登记机关';
COMMENT ON COLUMN v_hcrw.DJJGMC IS '登记机关名称';
COMMENT ON COLUMN v_hcrw.ZTLX IS '主体类型';
COMMENT ON COLUMN v_hcrw.ZZXS IS '组织形式';
COMMENT ON COLUMN v_hcrw.QYBM IS '所在区域区域编码';
COMMENT ON COLUMN v_hcrw.QYMC IS '所在区域名称';
COMMENT ON COLUMN v_hcrw.HYFL IS '行业分类';
COMMENT ON COLUMN v_hcrw.FR IS '法人';
COMMENT ON COLUMN v_hcrw.LXDH IS '联系电话';
COMMENT ON COLUMN v_hcrw.MAIL IS '电子邮箱';
COMMENT ON COLUMN v_hcrw.JYDZ IS '经营地址';
COMMENT ON COLUMN v_hcrw.LLR IS '联络人';
DROP TABLE v_nb;
CREATE TABLE V_NB (
  ID        VARCHAR2(32),
  ND        NUMBER,
  XYDM      VARCHAR2(32),
  QYMC      VARCHAR2(300),
  TXDZ      VARCHAR2(300),
  MAIL      VARCHAR2(300),
  SFTZGMGQ  NUMBER,
  JYZT      NUMBER,
  SFYWZWD   NUMBER,
  SFYDWDBXX NUMBER,
  CYRS      NUMBER,
  SYZQYHJ   NUMBER,
  LRZE      NUMBER,
  ZYYWSR    NUMBER,
  JLR       NUMBER,
  NSZE      NUMBER,
  FZZE      NUMBER,
  ZCZE      NUMBER,
  SJLX      INTEGER
);
COMMENT ON TABLE v_nb IS '年报主表';
COMMENT ON COLUMN v_nb.ID IS '计划编号,用于定向核查';
COMMENT ON COLUMN v_nb.ND IS '年度';
COMMENT ON COLUMN v_nb.XYDM IS '统一社会信用代码';
COMMENT ON COLUMN v_nb.QYMC IS '企业名称';
COMMENT ON COLUMN v_nb.TXDZ IS '通信地址';
COMMENT ON COLUMN v_nb.MAIL IS '电子邮箱';
COMMENT ON COLUMN v_nb.SFTZGMGQ IS '是否投资或者购买其他公司股权';
COMMENT ON COLUMN v_nb.JYZT IS '经营状态';
COMMENT ON COLUMN v_nb.SFYWZWD IS '是否有网站或网店';
COMMENT ON COLUMN v_nb.SFYDWDBXX IS '是否有对外担保信息';
COMMENT ON COLUMN v_nb.CYRS IS '从业人数';
COMMENT ON COLUMN v_nb.SYZQYHJ IS '所有者权益合计';
COMMENT ON COLUMN v_nb.LRZE IS '利润总额';
COMMENT ON COLUMN v_nb.ZYYWSR IS '营业总收入中主营业务收入';
COMMENT ON COLUMN v_nb.JLR IS '净利润';
COMMENT ON COLUMN v_nb.NSZE IS '纳税总额';
COMMENT ON COLUMN v_nb.FZZE IS '负债总额';
COMMENT ON COLUMN v_nb.ZCZE IS '资产总额';
COMMENT ON COLUMN v_nb.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_NB_WD;
CREATE TABLE V_NB_WD (
  TYPE NUMBER,
  NAME VARCHAR2(200),
  WZ   VARCHAR2(300),
  ND   NUMBER,
  XYDM VARCHAR2(32),
  SJLX INTEGER
);
COMMENT ON TABLE V_NB_WD IS '年报-网店表';
COMMENT ON COLUMN v_nb_wd.TYPE IS '类型';
COMMENT ON COLUMN v_nb_wd.NAME IS '名称';
COMMENT ON COLUMN v_nb_wd.WZ IS '网址';
COMMENT ON COLUMN v_nb_wd.ND IS '年度';
COMMENT ON COLUMN v_nb_wd.XYDM IS '统一社会信用代码';
COMMENT ON COLUMN v_nb_wd.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_NB_DWTZ;
CREATE TABLE V_NB_DWTZ (
  ND     NUMBER,
  XYDM   VARCHAR2(32),
  TZQYMC VARCHAR2(300),
  SJLX   INTEGER
);
COMMENT ON TABLE V_NB_DWTZ IS '年报-对外投资表';
COMMENT ON COLUMN v_nb_dwtz.ND IS '年度';
COMMENT ON COLUMN v_nb_dwtz.XYDM IS '统一社会信用代码';
COMMENT ON COLUMN v_nb_dwtz.TZQYMC IS '投资设立企业或者购买股权企业名称';
COMMENT ON COLUMN v_nb_dwtz.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_NB_DWDB;
CREATE TABLE V_NB_DWDB (
  ND     NUMBER,
  XYDM   VARCHAR2(32),
  ZQR    VARCHAR2(32),
  ZWR    VARCHAR2(32),
  ZZQZL  NUMBER,
  ZZQSE  NUMBER,
  LXZWQX DATE,
  BZQJ   VARCHAR2(32),
  BZFS   NUMBER,
  BZDBFW VARCHAR2(300),
  SJLX   INTEGER
);
COMMENT ON TABLE V_NB_DWDB IS '年报-担保表';
COMMENT ON COLUMN v_nb_dwdb.ND IS '年度';
COMMENT ON COLUMN v_nb_dwdb.XYDM IS '统一社会信用代码';
COMMENT ON COLUMN v_nb_dwdb.ZQR IS '债权人';
COMMENT ON COLUMN v_nb_dwdb.ZWR IS '债务人';
COMMENT ON COLUMN v_nb_dwdb.ZZQZL IS '主债权种类';
COMMENT ON COLUMN v_nb_dwdb.ZZQSE IS '主债权数额';
COMMENT ON COLUMN v_nb_dwdb.LXZWQX IS '履行债务的期限';
COMMENT ON COLUMN v_nb_dwdb.BZQJ IS '保证的期间';
COMMENT ON COLUMN v_nb_dwdb.BZFS IS '保证的方式';
COMMENT ON COLUMN v_nb_dwdb.BZDBFW IS '保证担保的范围';
COMMENT ON COLUMN v_nb_dwdb.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_NB_GQBG;
CREATE TABLE V_NB_GQBG (
  ND       NUMBER,
  XYDM     VARCHAR2(32),
  GD       VARCHAR2(32),
  BGQ_GQBL NUMBER,
  BGH_GQBL NUMBER,
  BGRQ     DATE,
  SJLX     INTEGER
);
COMMENT ON TABLE V_NB_GQBG IS '年报-股权变更表';
COMMENT ON COLUMN V_NB_GQBG.ND IS '年度';
COMMENT ON COLUMN V_NB_GQBG.XYDM IS '统一社会信用代码';
COMMENT ON COLUMN V_NB_GQBG.GD IS '股东';
COMMENT ON COLUMN V_NB_GQBG.BGQ_GQBL IS '变更前股权比例';
COMMENT ON COLUMN V_NB_GQBG.BGH_GQBL IS '变更后股权比例';
COMMENT ON COLUMN V_NB_GQBG.BGRQ IS '股权变更日期';
COMMENT ON COLUMN V_NB_GQBG.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_JS_ZSCQ;
CREATE TABLE V_JS_ZSCQ (
  XYDM   VARCHAR2(32),
  CZRMC  VARCHAR2(32),
  ZL     NUMBER,
  QYMC   VARCHAR2(300),
  ZQRMC  VARCHAR2(32),
  ZQDJRQ DATE,
  ZT     NUMBER,
  GSSJ   DATE,
  BHQK   VARCHAR2(300),
  SJLX   INTEGER
);
COMMENT ON TABLE V_JS_ZSCQ IS '即时信息-知识产权出质登记表';
COMMENT ON COLUMN V_JS_ZSCQ.XYDM IS '企业信用代码';
COMMENT ON COLUMN V_JS_ZSCQ.CZRMC IS '出质人名称';
COMMENT ON COLUMN V_JS_ZSCQ.ZL IS '种类';
COMMENT ON COLUMN V_JS_ZSCQ.QYMC IS '企业名称';
COMMENT ON COLUMN V_JS_ZSCQ.ZQRMC IS '质权人名称';
COMMENT ON COLUMN V_JS_ZSCQ.ZQDJRQ IS '质权登记期限';
COMMENT ON COLUMN V_JS_ZSCQ.ZT IS '状态';
COMMENT ON COLUMN V_JS_ZSCQ.GSSJ IS '公示时间';
COMMENT ON COLUMN V_JS_ZSCQ.BHQK IS '变化情况';
COMMENT ON COLUMN V_JS_ZSCQ.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_JS_GDCZ;
CREATE TABLE V_JS_GDCZ (
  XYDM   VARCHAR2(32),
  GD     VARCHAR2(32),
  BGRQ   DATE,
  RJE    NUMBER,
  SJE    NUMBER,
  GSSJ   DATE,
  RJCZFS NUMBER,
  RJCZE  NUMBER,
  RJCZRQ DATE,
  SJCZFS NUMBER,
  SJCZE  NUMBER,
  SJCZRQ DATE,
  SJLX   INTEGER
);
COMMENT ON TABLE V_JS_GDCZ IS '即时信息-股东出资表';
COMMENT ON COLUMN V_JS_GDCZ.XYDM IS '企业信用代码';
COMMENT ON COLUMN V_JS_GDCZ.GD IS '股东';
COMMENT ON COLUMN V_JS_GDCZ.BGRQ IS '变更日期';
COMMENT ON COLUMN V_JS_GDCZ.RJE IS '认缴额';
COMMENT ON COLUMN V_JS_GDCZ.SJE IS '实缴额';
COMMENT ON COLUMN V_JS_GDCZ.GSSJ IS '公示时间';
COMMENT ON COLUMN V_JS_GDCZ.RJCZFS IS '认缴出资方式';
COMMENT ON COLUMN V_JS_GDCZ.RJCZE IS '认缴出资额';
COMMENT ON COLUMN V_JS_GDCZ.RJCZRQ IS '认缴出资到期日期';
COMMENT ON COLUMN V_JS_GDCZ.SJCZFS IS '实缴出资方式';
COMMENT ON COLUMN V_JS_GDCZ.SJCZE IS '实缴出资额';
COMMENT ON COLUMN V_JS_GDCZ.SJCZRQ IS '实缴出资日期';
COMMENT ON COLUMN V_JS_GDCZ.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_JS_GQBG;
CREATE TABLE V_JS_GQBG (
  XYDM  VARCHAR2(32),
  GD    VARCHAR2(32),
  BGRQ  DATE,
  BGQBL NUMBER,
  BGHBL NUMBER,
  GSSJ  DATE,
  SJLX  INTEGER
);
COMMENT ON TABLE V_JS_GQBG IS '即时信息-股权变更表';
COMMENT ON COLUMN V_JS_GQBG.XYDM IS '企业信用代码';
COMMENT ON COLUMN V_JS_GQBG.GD IS '股东';
COMMENT ON COLUMN V_JS_GQBG.BGRQ IS '变更日期';
COMMENT ON COLUMN V_JS_GQBG.BGQBL IS '变更前比例';
COMMENT ON COLUMN V_JS_GQBG.BGHBL IS '变更后比例';
COMMENT ON COLUMN V_JS_GQBG.GSSJ IS '公示时间';
COMMENT ON COLUMN V_JS_GQBG.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_JS_XZXK;
CREATE TABLE V_JS_XZXK (
  XYDM   VARCHAR2(32),
  XKWJBH VARCHAR2(32),
  YXQ_KS DATE,
  YXQ_JS DATE,
  XKWJMC VARCHAR2(300),
  XKJG   VARCHAR2(300),
  XKNR   VARCHAR2(300),
  ZT     NUMBER,
  GSSJ   DATE,
  XQ     VARCHAR2(300),
  SJLX   INTEGER
);
COMMENT ON TABLE V_JS_XZXK IS '即时信息-行政许可表';
COMMENT ON COLUMN V_JS_XZXK.XYDM IS '企业信用代码';
COMMENT ON COLUMN V_JS_XZXK.XKWJBH IS '许可文件编号';
COMMENT ON COLUMN V_JS_XZXK.YXQ_KS IS '有效期自';
COMMENT ON COLUMN V_JS_XZXK.YXQ_JS IS '有效期至';
COMMENT ON COLUMN V_JS_XZXK.XKWJMC IS '许可文件名称';
COMMENT ON COLUMN V_JS_XZXK.XKJG IS '许可机关';
COMMENT ON COLUMN V_JS_XZXK.XKNR IS '许可内容';
COMMENT ON COLUMN V_JS_XZXK.ZT IS '状态';
COMMENT ON COLUMN V_JS_XZXK.GSSJ IS '公示时间';
COMMENT ON COLUMN V_JS_XZXK.XQ IS '详情';
COMMENT ON COLUMN V_JS_XZXK.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
DROP TABLE V_JS_XZCF;
CREATE TABLE V_JS_XZCF (
  XYDM      VARCHAR2(32),
  XZCFJDSWH VARCHAR2(32),
  WFLX      NUMBER,
  XZCFNR    VARCHAR2(32),
  CFJG      VARCHAR2(32),
  CFRQ      DATE,
  BZ        VARCHAR2(500),
  GSSJ      DATE,
  SJLX      INTEGER
);
COMMENT ON TABLE V_JS_XZCF IS '即时信息-行政处罚表';
COMMENT ON COLUMN V_JS_XZCF.XYDM IS '企业信用代码';
COMMENT ON COLUMN V_JS_XZCF.XZCFJDSWH IS '行政处罚决定书文号';
COMMENT ON COLUMN V_JS_XZCF.WFLX IS '违法行为类型';
COMMENT ON COLUMN V_JS_XZCF.XZCFNR IS '行政处罚内容';
COMMENT ON COLUMN V_JS_XZCF.CFJG IS '作出行政处罚决定机关名称';
COMMENT ON COLUMN V_JS_XZCF.CFRQ IS '作出行政处罚决定日期';
COMMENT ON COLUMN V_JS_XZCF.BZ IS '备注';
COMMENT ON COLUMN V_JS_XZCF.GSSJ IS '公示时间';
COMMENT ON COLUMN V_JS_XZCF.SJLX IS '数据来源类型,1为公示信息,2为比对信息';
--企业表
CREATE TABLE t_qy
(
  xydm   VARCHAR2(32),
  name   VARCHAR2(200),
  jyzt   INTEGER,
  djjg   VARCHAR2(100),
  djjgmc VARCHAR2(100),
  ztlx   INTEGER,
  zzxs   INTEGER,
  qybm   VARCHAR2(100),
  qymc   VARCHAR2(100),
  hyfl   INTEGER,
  fr     VARCHAR2(32),
  lxdh   VARCHAR2(20),
  mail   VARCHAR2(100),
  jydz   VARCHAR2(400),
  llr    VARCHAR2(32)
);
INSERT INTO t_qy
  SELECT
    sys_guid()                                 xydm,
    '企业名称' || rownum                           name,
    round(uext_random.value(1, 3))             jyzt,
    uext_random.random_numeric_character(10)   djjg,
    '登记机关' || round(uext_random.value(1, 100)) djjgmc,
    round(uext_random.value(1, 3))             ztlx,
    round(uext_random.value(1, 3))             zzxs,
    uext_random.random_numeric_character(10)   qybm,
    '区域名称' || round(uext_random.value(1, 100)),
    round(uext_random.value(1, 3))             hyfl,
    uext_random.random_name                    fr,
    uext_random.random_mobile                  lxdh,
    uext_random.random_email('@163.com')       email,
    uext_random.random_addr                    jydz,
    uext_random.random_name                    llr
  FROM dual
  CONNECT BY level <= 20000;
--执法人员
CREATE TABLE T_RY
(
  code VARCHAR2(32),
  name VARCHAR2(500)
);
INSERT INTO t_ry
  SELECT
    sys_guid()              code,
    uext_random.random_name name
  FROM dual
  CONNECT BY level <= 500;
--生成任务v_hcrw
DECLARE
  CURSOR qy IS
    SELECT *
    FROM t_qy;
  ry        NUMBER;
  hcry_code VARCHAR2(32);
  hcry_name VARCHAR2(500);
  v_hcjg    VARCHAR2(32);
  v_hcjgmc  VARCHAR2(4000);
BEGIN
  FOR o IN qy LOOP
    ry := round(uext_random.value(1, 500));
    SELECT
      code,
      name
    INTO hcry_code, hcry_name
    FROM (SELECT
            a.*,
            rownum rn
          FROM t_ry a)
    WHERE rn = ry;
    ry := round(uext_random.value(1, 14));
    SELECT
      ID,
      name
    INTO v_hcjg, v_hcjgmc
    FROM (SELECT
            a.*,
            rownum rn
          FROM cpsi.sys_organization a)
    WHERE rn = ry;
    INSERT INTO v_hcrw (HCDW_XYDM, HCDW_NAME, ZFRY_CODE1, ZFRY_CODE2, ZFRY_NAME1, ZFRY_NAME2, HCFL, HCJG, JYZT, HCJGMC, DJJG, DJJGMC, ZTLX, ZZXS, QYBM, QYMC, HYFL, FR, LXDH, MAIL, JYDZ, LLR)
    VALUES
      (o.xydm, o.name, hcry_code, NULL, hcry_name, NULL, round(uext_random.value(1, 3)), v_hcjg,
               o.jyzt, v_hcjgmc, o.djjg, o.djjgmc, o.ztlx, o.zzxs, o.qybm, o.qymc, o.hyfl, o.fr,
                                         o.lxdh, o.mail, o.jydz, o.llr);
    ry := round(uext_random.value(1, 500));
    SELECT
      code,
      name
    INTO hcry_code, hcry_name
    FROM (SELECT
            a.*,
            rownum rn
          FROM t_ry a)
    WHERE rn = ry;
    UPDATE v_hcrw
    SET zfry_code2 = hcry_code, zfry_name2 = hcry_name
    WHERE HCDW_XYDM = o.xydm;
  END LOOP;
END;
/
--生成看报V_NB;
INSERT INTO v_nb (ID, ND, XYDM, QYMC, TXDZ, MAIL, SFTZGMGQ, JYZT, SFYWZWD, SFYDWDBXX, CYRS, SYZQYHJ, LRZE, ZYYWSR, JLR, NSZE, FZZE, ZCZE, SJLX)
  SELECT
    sys_guid()                       id,
    2016                             nd,
    xydm,
    name                             qymc,
    jydz                             txdz,
    mail,
    trunc(uext_random.value(0, 2))   SFYWZWD,
    trunc(uext_random.value(0, 2))   jyzt,
    trunc(uext_random.value(0, 2))   SFYWZWD,
    trunc(uext_random.value(0, 2))   SFYDWDBXX,
    trunc(uext_random.value(1, 500)) CYRS,
    trunc(uext_random.value(1, 500)) SYZQYHJ,
    trunc(uext_random.value(1, 500)) LRZE,
    trunc(uext_random.value(1, 500)) ZYYWSR,
    trunc(uext_random.value(1, 500)) JLR,
    trunc(uext_random.value(1, 500)) NSZE,
    trunc(uext_random.value(1, 500)) FZZE,
    trunc(uext_random.value(1, 500)) ZCZE,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成年报-对外担保
INSERT INTO v_nb_dwdb (ND, XYDM, ZQR, ZWR, ZZQZL, ZZQSE, LXZWQX, BZQJ, BZFS, BZDBFW, SJLX)
  SELECT
    2016                                nd,
    xydm,
    uext_random.random_name             ZQR,
    uext_random.random_name             ZWR,
    trunc(uext_random.value(0, 2))      ZZQZL,
    trunc(uext_random.value(200, 1000)) ZZQSE,
    uext_random.random_date_year(2020)  LXZWQX,
    trunc(uext_random.value(200, 1000)) BZQJ,
    trunc(uext_random.value(0, 2))      BZFS,
    uext_random.random_date_year(2020)  BZDBFW,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成年报-对外投资
INSERT INTO v_nb_dwtz (ND, XYDM, TZQYMC, SJLX)
  SELECT
    2016                                                 nd,
    xydm,
    '投资设立企业或者购买股权企业名称' || trunc(uext_random.value(0, 2)) TZQYMC,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成年报-股东出资
INSERT INTO v_nb_gdcz (ND, XYDM, GD, RJCZE, RJCZDQSJ, RJCZFS, SJCZE, SJCZSJ, SJCZFS, SJLX)
  SELECT
    2016                                nd,
    xydm,
    uext_random.random_name             gd,
    trunc(uext_random.value(200, 1000)) rjcze,
    uext_random.random_date_year(2020)  RJCZDQSJ,
    trunc(uext_random.value(0, 2))      RJCZFS,
    trunc(uext_random.value(200, 1000)) SJCZE,
    uext_random.random_date_year(2020)  SJCZSJ,
    trunc(uext_random.value(0, 2))      SJCZFS,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成年报-股权变更
INSERT INTO V_NB_GQBG (ND, XYDM, GD, BGQ_GQBL, BGH_GQBL, BGRQ, SJLX)
  SELECT
    2016                               nd,
    xydm,
    uext_random.random_name            gd,
    trunc(uext_random.value(1, 100))   BGQ_GQBL,
    trunc(uext_random.value(1, 100))   BGH_GQBL,
    uext_random.random_date_year(2016) BGRQ,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成年报-网店
INSERT INTO v_nb_wd (TYPE, NAME, WZ, ND, XYDM, SJLX)
  SELECT
    trunc(uext_random.value(0, 2)) type,
    uext_random.random_chinese(10) name,
    uext_random.string('a', 20)    wz,
    2016                           nd,
    xydm,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成即时-股东出资
INSERT INTO v_js_gdcz (XYDM, GD, BGRQ, RJE, SJE, GSSJ, RJCZFS, RJCZE, RJCZRQ, SJCZFS, SJCZE, SJCZRQ, SJLX)
  SELECT
    xydm,
    uext_random.random_name             gd,
    uext_random.random_date_year(2020)  BGRQ,
    trunc(uext_random.value(200, 1000)) rje,
    trunc(uext_random.value(200, 1000)) SJE,
    NULL                                gssj,
    trunc(uext_random.value(0, 2))      RJCZFS,
    trunc(uext_random.value(200, 1000)) SJCZE,
    uext_random.random_date_year(2020)  RJCZRQ,
    trunc(uext_random.value(0, 2))      RJCZFS,
    trunc(uext_random.value(0, 2))      SJCZFS,
    uext_random.random_date_year(2020)  SJCZRQ,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成即时-股权变更
INSERT INTO V_JS_GQBG (XYDM, GD, BGRQ, BGQBL, BGHBL, GSSJ, SJLX)
  SELECT
    xydm,
    uext_random.random_name            gd,
    uext_random.random_date_year(2016) BGRQ,
    trunc(uext_random.value(1, 100))   BGQBL,
    trunc(uext_random.value(1, 100))   BGHBL,
    NULL                               gssj,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成即时-行政处罚
INSERT INTO V_JS_XZCF (XYDM, XZCFJDSWH, WFLX, XZCFNR, CFJG, CFRQ, BZ, GSSJ, SJLX)
  SELECT
    xydm,
    uext_random.random_numeric_character(16) XZCFJDSWH,
    trunc(uext_random.value(0, 2))           WFLX,
    uext_random.random_chinese(10)           XZCFNR,
    uext_random.random_chinese(10)           CFJG,
    uext_random.random_date_year(2016)       CFRQ,
    uext_random.random_chinese(20)           BZ,
    NULL                                     gssj,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成即时-行政许可
INSERT INTO V_JS_XZXK (XYDM, XKWJBH, YXQ_KS, YXQ_JS, XKWJMC, XKJG, XKNR, ZT, GSSJ, XQ, SJLX)
  SELECT
    xydm,
    uext_random.random_numeric_character(16) XKWJBH,
    uext_random.random_date_year(2016)       YXQ_KS,
    uext_random.random_date_year(2016)       YXQ_JS,
    uext_random.random_chinese(10)           XKWJMC,
    uext_random.random_chinese(10)           XKJG,
    uext_random.random_chinese(10)           XKNR,
    trunc(uext_random.value(0, 2))           zt,
    NULL                                     gssj,
    uext_random.random_chinese(10)           XQ,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
--生成即时-知识产权
INSERT INTO V_JS_ZSCQ (XYDM, CZRMC, ZL, QYMC, ZQRMC, ZQDJRQ, ZT, GSSJ, BHQK, SJLX)
  SELECT
    xydm,
    uext_random.random_chinese(10) CZRMC,
    trunc(uext_random.value(0, 2)) ZL,
    uext_random.random_chinese(10) QYMC,
    uext_random.random_chinese(10) ZQRMC,
    uext_random.random_date(2016)  ZQDJRQ,
    trunc(uext_random.value(0, 2)) zt,
    NULL                           gssj,
    uext_random.random_chinese(10) BHQK,
    sjlx
  FROM (
    SELECT
      a.*,
      b.sjlx
    FROM t_qy a, (SELECT 1 sjlx
                  FROM dual
                  UNION ALL SELECT 2
                            FROM dual) b);
