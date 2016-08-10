insert into js_hz_gdcz(ID,READ_FLAG,REGNO,GD,BGRQ,RJE,SJE,GSSJ,RJCZFS,RJCZE,RJCZRQ,SJCZFS,SJCZE,SJCZRQ)
select sys_guid() id,0 read_flag,e.xydm regno, e.name gd,e.czrq bgrq,
        e.cze rje,f.cze sje,e.czrq+20 gssj,e.czfs rjczfs,e.cze rjcze,e.czrq rjczrq,f.czfs sjczfs,f.cze sjcze, f.czrq sjczrq
      from
        (select d.nbxh,d.nd,d.name,d.seq seq,
          (select content from BM_CZXS e where e.code=c.czfs) czfs,c.czrq,c.cze,e.regno xydm
          from nnb_fr d,nnb_frczqk c,hz_qyhznr e
          where d.nbxh=c.nbxh and d.seq=c.seq and d.nd=c.nd and d.nbxh=e.pripid
           -- and c.nbxh=v_nbxh and c.nd=v_nd
            and c.czlx='1') e,
        (select d.nbxh,d.nd,d.name,d.seq seq,
          (select content from BM_CZXS e where e.code=c.czfs) czfs,c.czrq,c.cze,e.regno xydm
          from nnb_fr d,nnb_frczqk c ,hz_qyhznr e
          where d.nbxh=c.nbxh and d.seq=c.seq and d.nd=c.nd and d.nbxh=e.pripid
--            and c.nbxh=v_nbxh and c.nd=2015
            and czlx='2') f
         where e.nbxh=f.nbxh(+) and e.nd=f.nd(+) and e.seq=f.seq(+) and rownum<=100;
insert into JS_HZ_GQBG(REGNO,GD,BGRQ,BGQBL,BGHBL,GSSJ,ID,READ_FLAG)
  select b.regno,a.INV GD, a.ALTDATE BGRQ, a.TRANSAMPR BGHBL, a.TRANSAMOR BGH_GQBL,a.ALTDATE+20 gssj,sys_guid() id,0 read_flag
  from NNB_GQBG a,hz_qyhznr b where a.nbxh=b.pripid and rownum<=200;
insert into JS_HZ_XZCF(ID,READ_FLAG,REGNO,XZCFJDSWH,WFLX,XZCFNR,CFJG,CFRQ,BZ,GSSJ)
  select sys_guid() id,0 read_flag,b.regno,'wh'||rownum XZCFJDSWH, '交警处罚' wflx, '交通违法' XZCFNR, '西安市交通局' CFJG,sysdate-100 cfrq,'备注' bz,sysdate-30 gssj
  from hz_qyhznr b where rownum<=200;
insert into JS_HZ_XZXK(HDRQ,ID,READ_FLAG,REGNO,XKWJBH,YXQ_KS,YXQ_JS,XKWJMC,XKJG,XKNR,ZT,GSSJ,XQ)
  select sysdate-100 HDRQ,sys_guid() id,0 read_flag,b.regno,'wh'||rownum XKWJBH, sysdate-20 YXQ_KS,sysdate+320 YXQ_JS, '许可文件名称'||rownum XKWJMC, '西安市交通局' XKJG,'许可内容'||rownum XKNR,'正常' zt,sysdate-30 gssj,'许可详情'||rownum
  from hz_qyhznr b where rownum<=200;
insert into JS_HZ_ZSCQ(ID,READ_FLAG,REGNO,CZRMC,ZL,QYMC,ZQRMC,ZQDJRQ,ZT,GSSJ,BHQK)
  select sys_guid() id,0 read_flag,b.regno,'出质人名称'||rownum CZRMC,'著作权' ZL,entname qymc,'质权人名称'||rownum ZQRMC,sysdate-200 ZQDJRQ,'正常' zt,sysdate-30 gssj,'变化情况'||rownum BHQK
  from hz_qyhznr b where rownum<=200;
