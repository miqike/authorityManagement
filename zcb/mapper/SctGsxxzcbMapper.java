package com.kysoft.cpsi.zcb.mapper;

import com.kysoft.cpsi.zcb.entity.SctGsxxzcb;
import com.kysoft.cpsi.zcb.entity.SctGsxxzcbKey;

public interface SctGsxxzcbMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int deleteByPrimaryKey(SctGsxxzcbKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int insert(SctGsxxzcb record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int insertSelective(SctGsxxzcb record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    SctGsxxzcb selectByPrimaryKey(SctGsxxzcbKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int updateByPrimaryKeySelective(SctGsxxzcb record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GSXXZCB
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int updateByPrimaryKey(SctGsxxzcb record);
}