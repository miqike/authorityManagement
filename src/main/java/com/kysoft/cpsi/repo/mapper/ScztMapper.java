package com.kysoft.cpsi.repo.mapper;

import com.kysoft.cpsi.repo.entity.Sczt;

import java.util.List;
import java.util.Map;

public interface ScztMapper {
    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	int deleteByPrimaryKey(String xydm);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	int insert(Sczt record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	int insertSelective(Sczt record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	Sczt selectByPrimaryKey(String xydm);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	int updateByPrimaryKeySelective(Sczt record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_SCZT
	 * @mbg.generated  Wed Sep 21 17:26:36 CST 2016
	 */
	int updateByPrimaryKey(Sczt record);

	List<Sczt> query(Map<String, Object> params);
    
    List<Sczt> queryExt(Map<String, Object> params);

    /*查询被检查单位需要上传的�?查材�?*/
    List<Map<String, Object>> queryHccl(Map<String, Object> params);

    List<Sczt> selectByXydm(Map<String, Object> params);
}