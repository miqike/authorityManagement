package com.kysoft.cpsi.found.mapper;

import com.kysoft.cpsi.found.entity.Gssx;

import java.util.List;
import java.util.Map;

public interface GssxMapper {

    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	int insert(Gssx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	int insertSelective(Gssx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	Gssx selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	int updateByPrimaryKeySelective(Gssx record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_GSSX
	 * @mbggenerated  Mon May 23 18:09:26 CST 2016
	 */
	int updateByPrimaryKey(Gssx record);

	List<Gssx> query(Map<String, Object> params);
}