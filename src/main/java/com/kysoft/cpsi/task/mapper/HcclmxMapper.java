package com.kysoft.cpsi.task.mapper;

import java.util.List;
import java.util.Map;

import com.kysoft.cpsi.task.entity.Hcclmx;

public interface HcclmxMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	int insert(Hcclmx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	int insertSelective(Hcclmx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	Hcclmx selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	int updateByPrimaryKeySelective(Hcclmx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_HCCLMX
	 * @mbggenerated  Fri May 27 16:40:14 CST 2016
	 */
	int updateByPrimaryKey(Hcclmx record);

	List<Hcclmx> queryForTask(Map<String, Object> paramMap);
}