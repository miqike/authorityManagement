package com.kysoft.cpsi.zcb.entity;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class SctDwtz extends SctDwtzKey {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SCT_DWTZ.TBRQ
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
	@JSONField(format="yyyy-mm-dd")
    private Date tbrq;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SCT_DWTZ.SLQYMC
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    private String slqymc;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column SCT_DWTZ.SLQYXYDM
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    private String slqyxydm;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SCT_DWTZ.TBRQ
     *
     * @return the value of SCT_DWTZ.TBRQ
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public Date getTbrq() {
        return tbrq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SCT_DWTZ.TBRQ
     *
     * @param tbrq the value for SCT_DWTZ.TBRQ
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public void setTbrq(Date tbrq) {
        this.tbrq = tbrq;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SCT_DWTZ.SLQYMC
     *
     * @return the value of SCT_DWTZ.SLQYMC
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public String getSlqymc() {
        return slqymc;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SCT_DWTZ.SLQYMC
     *
     * @param slqymc the value for SCT_DWTZ.SLQYMC
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public void setSlqymc(String slqymc) {
        this.slqymc = slqymc;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column SCT_DWTZ.SLQYXYDM
     *
     * @return the value of SCT_DWTZ.SLQYXYDM
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public String getSlqyxydm() {
        return slqyxydm;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column SCT_DWTZ.SLQYXYDM
     *
     * @param slqyxydm the value for SCT_DWTZ.SLQYXYDM
     *
     * @mbg.generated Tue Jan 03 14:17:25 CST 2017
     */
    public void setSlqyxydm(String slqyxydm) {
        this.slqyxydm = slqyxydm;
    }
}