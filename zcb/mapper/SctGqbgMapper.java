package com.kysoft.cpsi.zcb.mapper;

import com.kysoft.cpsi.zcb.entity.SctGqbg;
import com.kysoft.cpsi.zcb.entity.SctGqbgKey;

public interface SctGqbgMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int deleteByPrimaryKey(SctGqbgKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int insert(SctGqbg record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int insertSelective(SctGqbg record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    SctGqbg selectByPrimaryKey(SctGqbgKey key);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int updateByPrimaryKeySelective(SctGqbg record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table SCT_GQBG
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    int updateByPrimaryKey(SctGqbg record);
}