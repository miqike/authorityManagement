package com.kysoft.cpsi.repo.mapper;

import java.util.List;
import java.util.Map;

import com.kysoft.cpsi.repo.entity.AuditItemComment;

public interface AuditItemCommentMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	int insert(AuditItemComment record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	int insertSelective(AuditItemComment record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	AuditItemComment selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	int updateByPrimaryKeySelective(AuditItemComment record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCSX_SM
	 * @mbggenerated  Mon Jun 13 16:49:16 CST 2016
	 */
	int updateByPrimaryKey(AuditItemComment record);

	List<AuditItemComment> selectByHcsxId(String hcsxId);
	
	List<AuditItemComment> queryForAuditItem(Map<String, Object> param);

}