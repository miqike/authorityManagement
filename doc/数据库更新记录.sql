--20160902
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
