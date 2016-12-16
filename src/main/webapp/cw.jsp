<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="net.sf.husky.utils.HttpClientUtils" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.apache.commons.collections.map.HashedMap" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%
        String id=request.getParameter("id");
        String ticket=request.getParameter("ticket");
        Map<String,Object> params = new HashedMap();
        params.put("vid",id);
        params.put("ticket",ticket);
//        String validateResult= HttpClientUtils.httpGet("http://192.168.5.180:9080/casserver/ssoAuth/validUserInfo", params, null);
//        JSONObject jsonObject=JSONObject.parseObject(validateResult);

//        String userInfo=(String)((JSONObject)jsonObject.get("data")).get("userInfo");
//        String userId=userInfo.substring(1,userInfo.length()).replace("$",",").split(",")[0];//可能只适用于重庆
        String userId="";
    %>
    <script>
        eval("var userId = '" + '<%= userId %>'+"'");
        var param = "lieKysoft://" +userId +",";
        location.replace(param);
    </script>
</head>
<body>
用户验证出现错误!
</body>
</html>
