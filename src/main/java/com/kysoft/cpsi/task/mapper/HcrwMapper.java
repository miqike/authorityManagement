package com.kysoft.cpsi.task.mapper;

import java.util.List;
import java.util.Map;

import com.kysoft.cpsi.task.entity.Hcrw;

import net.sf.husky.security.entity.User;

public interface HcrwMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	int insert(Hcrw record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	int insertSelective(Hcrw record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	Hcrw selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	int updateByPrimaryKeySelective(Hcrw record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCRW
	 * @mbggenerated  Wed May 25 15:53:08 CST 2016
	 */
	int updateByPrimaryKey(Hcrw record);

	//根据核查单位查询任务列表--3101
	List<Hcrw> queryForOrg(Map<String, Object> param);
	
	//根据核查人员查询任务列表--5101
	List<Hcrw> queryForAuditor(Map<String, Object> param);

	List<Hcrw> queryForPlan(Map<String, Object> param);
}