package com.kysoft.cpsi.audit.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.kysoft.cpsi.audit.service.AuditService;
import net.sf.husky.exception.BaseException;
import net.sf.husky.web.controller.BaseController;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

@RestController
@RequestMapping("/eai")
public class IntegrateController extends BaseController {

	@Resource
	AuditService auditService;
	
    @RequestMapping(value = "", method = RequestMethod.POST)
    public String importData(@RequestBody String eaiData) throws UnsupportedEncodingException {
        String result = null;
    	try {
        	String _eaiData = StringUtils.substring(eaiData, 0, eaiData.length() - 1);
        	System.out.println("----------------------");
        	System.out.println(URLDecoder.decode(_eaiData, "utf-8"));
        	System.out.println("----------------------");
        	JSONObject jsonData = (JSONObject) JSON.parse(URLDecoder.decode(_eaiData, "utf-8"));
        	auditService.importData(jsonData);
            result = "数据接收成功";
        } catch (BaseException e) {
            //e.printStackTrace();
            result = "数据接收失败: " + e.getMessage();
        }
        return result;
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
    	String eaiData = "%7B%0A%09jhbh%3A%09%27key%27%2C%0A%09nd%3A%092010%2C%0A%09xydm%3A%09%27%27%2C%0A%09qymc%3A%09%27key%27%2C%0A%09syzqyhj%3A%09126289223.960000%2C%0A%09lrze%3A%09-1645108.430000%2C%0A%09yyzsr%3A%09113022006.660000%2C%0A%09zyywsr%3A%09107588461.960000%2C%0A%09jlr%3A%09-1645108.430000%2C%0A%09nsze%3A%090%2C%0A%09fzze%3A%0919561910.140000%2C%0A%09zcze%3A%09145851134.100000%2C%0A%09txdz%3A%09%27%E4%B8%AD%E5%85%B3%E6%9D%91%27%2C%0A%09yzbm%3A%09%270%27%2C%0A%09lxdh%3A%09%27132233221145%27%2C%0A%09dzyx%3A%09%277700266%40qq.com%27%2C%0A%09cyrs%3A%09%2710000%27%2C%0A%09jyzt%3A%09%270%27%2C%0A%09fzr%3A%09%27%E5%A4%A7%E6%B5%B7%27%2C%0A%09gdcz%3A%09%5B%7B%0A%09%09%09%27gd%27%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-03%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742470%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-08%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742475%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-10%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742477%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-15%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742482%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-06%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742473%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-02%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742469%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-11%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742478%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-12%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742479%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-01%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742468%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-09%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742476%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-14%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742481%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-13%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742480%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-07%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742474%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-04%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742471%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%2C+%7B%0A%09%09%09gd%3A%09%27%E4%BF%84%E7%BD%97%E6%96%AF-05%27%2C%0A%09%09%09sjcze%3A%09822%2C%0A%09%09%09sjczsj%3A%09%2742472%27%2C%0A%09%09%09sjczfs%3A%09%27%E7%8E%B0%E9%87%91%27%0A%09%09%7D%5D%0A%7D=";
    	String _eaiData = StringUtils.substring(eaiData, 0, eaiData.length() - 1);
    	JSONObject obj = (JSONObject) JSON.parse(URLDecoder.decode(_eaiData, "utf-8"));
    }
}
