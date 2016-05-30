--创建DB LINK
DROP DATABASE LINK DBL_CPSI;
CREATE DATABASE LINK DBL_CPSI CONNECT TO CPSI_INTERFACE IDENTIFIED BY CPSI_INTERFACE USING '(DESCRIPTION=
    (CONNECT_DATA=(SERVICE_NAME=orcl))
	(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.5.133)(PORT=1521)))';
--创建同义词
CREATE OR REPLACE SYNONYM V_HCRW
FOR V_HCRW@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_JS_GDCZ
FOR V_JS_GDCZ@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_JS_GQBG
FOR V_JS_GQBG@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_JS_XZCF
FOR V_JS_XZCF@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_JS_XZXK
FOR V_JS_XZXK@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_JS_ZSCQ
FOR V_JS_ZSCQ@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB
FOR V_NB@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB_DWDB
FOR V_NB_DWDB@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB_DWTZ
FOR V_NB_DWTZ@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB_GDCZ
FOR V_NB_GDCZ@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB_GQBG
FOR V_NB_GQBG@DBL_CPSI;
CREATE OR REPLACE SYNONYM V_NB_WD
FOR V_NB_WD@DBL_CPSI;
--通过DBLINK导入核查任务数据
CREATE OR REPLACE PROCEDURE prc_importDblink(p_hcjhId IN VARCHAR2 DEFAULT NULL) IS
  v_hcjhId VARCHAR2(100);
  v_id     NUMBER;
  v_jhmc   VARCHAR2(200);
  v_cnt    NUMBER;
  BEGIN
    IF (p_hcjhId IS NULL)
    THEN
      v_hcjhId := sys_guid();
    ELSE
      v_hcjhId := p_hcjhId;
    END IF;
    SELECT nvl(max(to_number(id)), 1)
    INTO v_id
    FROM t_hcrw;
    SELECT jhmc
    INTO v_jhmc
    FROM t_hcjh
    WHERE ID = v_hcjhid;
    SELECT count(1)
    INTO v_cnt
    FROM v_hcrw;
    INSERT INTO t_hcrw (ID, HCJH_ID, HCDW_XYDM, HCDW_NAME, ZFRY_CODE1, ZFRY_CODE2, RWZT, HCFL, HCJG, HCJIEGUO, JYZT, HCJGGSQK, RLR, RLRQ, SJWCRQ, ZFRY_NAME1, ZFRY_NAME2,
                        HCJGMC, DJJGMC, DJJG, ZTLX, ZZXS, QYBM, QYMC, RLRMC, JHWCRQ, ND, JHMC, JHXDRQ, JHYQWCSJ)
      SELECT
        v_id + rownum            ID,
        v_hcjhId                 HCJH_ID,
        HCDW_XYDM,
        HCDW_NAME,
        ZFRY_CODE1,
        ZFRY_CODE2,
        NULL                     RWZT,
        HCFL,
        HCJG,
        NULL                     HCJIEGUO,
        JYZT,
        NULL                     HCJGGSQK,
        NULL                     RLR,
        NULL                     RLRQ,
        NULL                     SJWCRQ,
        ZFRY_NAME1,
        ZFRY_NAME2,
        HCJGMC,
        DJJGMC,
        DJJG,
        ZTLX,
        ZZXS,
        QYBM,
        QYMC,
        NULL                     RLRMC,
        NULL                     JHWCRQ,
        to_char(sysdate, 'yyyy') ND,
        v_jhmc                   JHMC,
        NULL                     JHXDRQ,
        NULL                     JHYQWCSJ
      FROM v_hcrw;

    UPDATE t_hcjh
    SET hcrwsl = v_cnt, ypfsl = 0, yrlsl = 0, wrlsl = 0
    WHERE id = v_hcjhid;

    MERGE INTO t_sczt
    USING (SELECT *
           FROM v_hcrw) hcrw
    ON (hcrw.hcdw_xydm = t_sczt.xydm)
    WHEN MATCHED THEN
    UPDATE SET name=hcrw.hcdw_name
    WHEN NOT MATCHED THEN
    INSERT (XYDM, NAME, ZTLX, HYFL, ZZXS, JYZT, FR, LXDH, MAIL, DJJG, JYDZ, LLR, QYBM, QYMC)
    VALUES (hcrw.hcdw_xydm, hcrw.hcdw_name, hcrw.ztlx, hcrw.hyfl, hcrw.zzxs, hcrw.jyzt, hcrw.fr, hcrw.lxdh, hcrw.mail, hcrw.djjg, hcrw.jydz, hcrw.llr, hcrw.qybm, hcrw.qymc);

  END prc_importDblink;
/
--通过DBLINK导入核查数据，主要是年报类数据
CREATE OR REPLACE PROCEDURE prc_import_hc(p_HCRWID IN VARCHAR2) IS
  v_xydm  VARCHAR2(400);
  v_nb_gs t_nb%ROWTYPE;
  v_nb_bd t_nb_bd%ROWTYPE;
  CURSOR cur_hcsx IS
    SELECT *
    FROM t_hcsxjg
    WHERE hcrw_id = p_HCRWID;
  BEGIN
    SELECT HCDW_XYDM
    INTO v_xydm
    FROM t_hcrw
    WHERE ID = p_hcrwid;

    INSERT INTO t_nb (ND, XYDM, QYMC, TXDZ, MAIL, SFTZGMGQ, JYZT, SFYWZWD, SFYDWDBXX, CYRS, SYZQYHJ, LRZE, ZYYWSR, JLR, NSZE, FZZE, HCRW_ID,
                      gxbys_jy, gxbys_gg, tysbs_jy, tysbs_gg, cjrs_jy, cjrs_gg, zjys_jy, zjys_gg, dj_frsfdy, dj_lxdh, dj_qtzw, dj_dyzs, dj_zcdys, dj_wzrs, dj_fzdys, dj_jjfzs, dj_sfjlzz, dj_wjlzzyy)
      SELECT
        ND,
        XYDM,
        QYMC,
        TXDZ,
        MAIL,
        SFTZGMGQ,
        JYZT,
        SFYWZWD,
        SFYDWDBXX,
        CYRS,
        SYZQYHJ,
        LRZE,
        ZYYWSR,
        JLR,
        NSZE,
        FZZE,
        p_HCRWID HCRW_ID,
        gxbys_jy,
        gxbys_gg,
        tysbs_jy,
        tysbs_gg,
        cjrs_jy,
        cjrs_gg,
        zjys_jy,
        zjys_gg,
        dj_frsfdy,
        dj_lxdh,
        dj_qtzw,
        dj_dyzs,
        dj_zcdys,
        dj_wzrs,
        dj_fzdys,
        dj_jjfzs,
        dj_sfjlzz,
        dj_wjlzzyy
      FROM v_nb
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_bd (ND, XYDM, QYMC, TXDZ, MAIL, SFTZGMGQ, JYZT, SFYWZWD, SFYDWDBXX, CYRS, SYZQYHJ, LRZE, ZYYWSR, JLR, NSZE, FZZE, HCRW_ID,
                         gxbys_jy, gxbys_gg, tysbs_jy, tysbs_gg, cjrs_jy, cjrs_gg, zjys_jy, zjys_gg, dj_frsfdy, dj_lxdh, dj_qtzw, dj_dyzs, dj_zcdys, dj_wzrs, dj_fzdys, dj_jjfzs, dj_sfjlzz, dj_wjlzzyy)
      SELECT
        ND,
        XYDM,
        QYMC,
        TXDZ,
        MAIL,
        SFTZGMGQ,
        JYZT,
        SFYWZWD,
        SFYDWDBXX,
        CYRS,
        SYZQYHJ,
        LRZE,
        ZYYWSR,
        JLR,
        NSZE,
        FZZE,
        p_HCRWID HCRW_ID,
        gxbys_jy,
        gxbys_gg,
        tysbs_jy,
        tysbs_gg,
        cjrs_jy,
        cjrs_gg,
        zjys_jy,
        zjys_gg,
        dj_frsfdy,
        dj_lxdh,
        dj_qtzw,
        dj_dyzs,
        dj_zcdys,
        dj_wzrs,
        dj_fzdys,
        dj_jjfzs,
        dj_sfjlzz,
        dj_wjlzzyy
      FROM v_nb
      WHERE XYDM = v_xydm AND sjlx = 2;

    INSERT INTO t_nb_dwdb (id, ND, XYDM, ZQR, ZWR, ZZQZL, ZZQSE, LXZWQX, BZQJ, BZFS, BZDBFW)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        ZQR,
        ZWR,
        ZZQZL,
        ZZQSE,
        LXZWQX,
        BZQJ,
        BZFS,
        BZDBFW
      FROM v_nb_dwdb
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_bd_dwdb (id, ND, XYDM, ZQR, ZWR, ZZQZL, ZZQSE, LXZWQX, BZQJ, BZFS, BZDBFW)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        ZQR,
        ZWR,
        ZZQZL,
        ZZQSE,
        LXZWQX,
        BZQJ,
        BZFS,
        BZDBFW
      FROM v_nb_dwdb
      WHERE XYDM = v_xydm AND sjlx = 2;

    INSERT INTO t_nb_dwtz (id, ND, XYDM, TZQYMC)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        TZQYMC
      FROM v_nb_dwtz
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_bd_dwtz (id, ND, XYDM, TZQYMC)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        TZQYMC
      FROM v_nb_dwtz
      WHERE XYDM = v_xydm AND sjlx = 2;

    INSERT INTO t_nb_gdcz (id, ND, XYDM, GD, RJCZE, RJCZDQSJ, RJCZFS, SJCZE, SJCZSJ, SJCZFS)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        GD,
        RJCZE,
        RJCZDQSJ,
        RJCZFS,
        SJCZE,
        SJCZSJ,
        SJCZFS
      FROM v_nb_gdcz
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_bd_gdcz (id, ND, XYDM, GD, RJCZE, RJCZDQSJ, RJCZFS, SJCZE, SJCZSJ, SJCZFS)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        GD,
        RJCZE,
        RJCZDQSJ,
        RJCZFS,
        SJCZE,
        SJCZSJ,
        SJCZFS
      FROM v_nb_gdcz
      WHERE XYDM = v_xydm AND sjlx = 2;

    INSERT INTO t_nb_GQBG (id, ND, XYDM, GD, BGQ_GQBL, BGH_GQBL, BGRQ)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        GD,
        BGQ_GQBL,
        BGH_GQBL,
        BGRQ
      FROM v_nb_GQBG
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_bd_GQBG (id, ND, XYDM, GD, BGQ_GQBL, BGH_GQBL, BGRQ)
      SELECT
        sys_guid() id,
        ND,
        XYDM,
        GD,
        BGQ_GQBL,
        BGH_GQBL,
        BGRQ
      FROM v_nb_GQBG
      WHERE XYDM = v_xydm AND sjlx = 2;

    INSERT INTO t_nb_wd (id, TYPE, NAME, WZ, ND, XYDM)
      SELECT
        sys_guid() id,
        TYPE,
        NAME,
        WZ,
        ND,
        XYDM
      FROM v_nb_wd
      WHERE XYDM = v_xydm AND sjlx = 1;
    INSERT INTO t_nb_wd (id, TYPE, NAME, WZ, ND, XYDM)
      SELECT
        sys_guid() id,
        TYPE,
        NAME,
        WZ,
        ND,
        XYDM
      FROM v_nb_wd
      WHERE XYDM = v_xydm AND sjlx = 2;

    --根据导入的年报数据，更新HCSXJG表中每个核查事项的内容
    SELECT *
    INTO v_nb_gs
    FROM t_nb
    WHERE hcrw_id = p_HCRWID;
    SELECT *
    INTO v_nb_bd
    FROM t_nb_bd
    WHERE xydm = v_nb_gs.xydm;
    FOR o IN cur_hcsx LOOP
      CASE o.hcsx_id
        WHEN '10a5cbafa03044239b8bedafb301d0a8'
        THEN --通信地址
          UPDATE t_hcsxjg
          SET qygsnr = v_nb_gs.txdz, BZNR = v_nb_bd.txdz
          WHERE hcrw_id = p_HCRWID AND hcsx_id = '10a5cbafa03044239b8bedafb301d0a8';
        WHEN '1d7e3138a58a4709bb3a328fb767a82e'
        THEN --mail
          UPDATE t_hcsxjg
          SET qygsnr = v_nb_gs.mail, BZNR = v_nb_bd.mail
          WHERE hcrw_id = p_HCRWID AND hcsx_id = '1d7e3138a58a4709bb3a328fb767a82e';
        WHEN 'c47e67dcd4b9445bb962efa7f262149c'
        THEN --联系电话
          UPDATE t_hcsxjg
          SET qygsnr = v_nb_gs.lxdh, BZNR = v_nb_bd.lxdh
          WHERE hcrw_id = p_HCRWID AND hcsx_id = 'c47e67dcd4b9445bb962efa7f262149c';
        WHEN 'cf8c476dad384a078f2278ac24f702f3'
        THEN --企业网站网店的名称和网址
          NULL;
        WHEN '08f630ac1b3947d2ab91e572c3f75e01'
        THEN --存续状态 经营状态
          UPDATE t_hcsxjg
          SET qygsnr = v_nb_gs.jyzt, BZNR = v_nb_bd.jyzt
          WHERE hcrw_id = p_HCRWID AND hcsx_id = '08f630ac1b3947d2ab91e572c3f75e01';
        WHEN '8588a435261e485eb72f0d986082bfdb'
        THEN --邮政编码
          UPDATE t_hcsxjg
          SET qygsnr = v_nb_gs.yzbm, BZNR = v_nb_bd.yzbm
          WHERE hcrw_id = p_HCRWID AND hcsx_id = '8588a435261e485eb72f0d986082bfdb';
      ELSE
        NULL;
      END CASE;
    END LOOP;

  END prc_import_hc;
/
--测试DBLINK数据
CREATE OR REPLACE PROCEDURE prc_testDblink(p_rws OUT NUMBER, p_rys OUT NUMBER) IS
  v_rws NUMBER;
  v_rys NUMBER;
  BEGIN
    SELECT
      a.rws,
      b.rys1 + c.rys2
    INTO v_rws, v_rys
    FROM
      (SELECT count(DISTINCT hcdw_xydm) rws
       FROM v_hcrw) a,
      (SELECT count(DISTINCT zfry_code1) rys1
       FROM v_hcrw) b,
      (SELECT count(DISTINCT zfry_code2) rys2
       FROM v_hcrw
       WHERE zfry_code2 NOT IN (SELECT zfry_code1
                                FROM v_hcrw)) c;
    p_rws := v_rws;
    p_rys := v_rys;
  END prc_testDblink;
/
