package com.kysoft.cpsi.audit.mapper;

import com.kysoft.cpsi.audit.entity.Homepage;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

public interface HomepageMapper {

    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	int insert(Homepage record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	int insertSelective(Homepage record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	Homepage selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	int updateByPrimaryKeySelective(Homepage record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_WD
	 * @mbggenerated  Sat Jun 25 10:35:58 CST 2016
	 */
	int updateByPrimaryKey(Homepage record);

	List<Homepage> selectByTaskId(String hcrwId);

    List<Homepage> selectByTaskId2(String hcrwId);
    List<Homepage> selectByTaskId3(String hcrwId);

    @Delete("delete from T_NB_BD_WD where HCRW_ID = #{taskId,jdbcType=VARCHAR}")
	void deleteByTaskId(String hcrwId);

	void insert2(Homepage homepage);

}