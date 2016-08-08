package com.kysoft.cpsi.repo.mapper;

import java.util.List;

import com.kysoft.cpsi.repo.entity.Material;

public interface MaterialMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    int insert(Material record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    int insertSelective(Material record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    Material selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    int updateByPrimaryKeySelective(Material record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table T_MATERIAL
     *
     * @mbggenerated Mon Aug 08 09:14:15 CST 2016
     */
    int updateByPrimaryKey(Material record);

	List<Material> selectCandidateByHcsxId(String hcsxId);

	List<Material> selectAll();
}