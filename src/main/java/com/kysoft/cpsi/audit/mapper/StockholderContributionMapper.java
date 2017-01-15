package com.kysoft.cpsi.audit.mapper;

import com.kysoft.cpsi.audit.entity.StockholderContribution;
import org.apache.ibatis.annotations.Delete;

import java.util.List;

public interface StockholderContributionMapper {

    /**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	int deleteByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	int insert(StockholderContribution record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	int insertSelective(StockholderContribution record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	StockholderContribution selectByPrimaryKey(String id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	int updateByPrimaryKeySelective(StockholderContribution record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table T_NB_GDCZ
	 * @mbg.generated  Mon Jan 09 11:26:18 CST 2017
	 */
	int updateByPrimaryKey(StockholderContribution record);

	List<StockholderContribution> selectByTaskId(String hcrwId);

    List<StockholderContribution> selectByTaskId2(String hcrwId);
    List<StockholderContribution> selectByTaskId3(String hcrwId);

    
	@Delete("delete from T_NB_BD_GDCZ where  (xydm,nd) in(select a.hcdw_xydm,b.nd from t_hcrw a,t_hcrw_nd b where a.id=b.hcrw_id and a.id=#{hcrwId}) and sjly=2")
	void deleteByTaskId2(String taskId);

	void insert2(StockholderContribution stockholderContribution);

}