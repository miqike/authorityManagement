package com.kysoft.filters;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * Created by Guohw on 2017-04-01.
 */
public class MyHttpServletRequest extends HttpServletRequestWrapper {
    public MyHttpServletRequest(HttpServletRequest request) {
        super(request);
    }

    @Override
    public String getParameter(String name) {
        String content=super.getParameter(name);
        String contentNew=null;
        if(content.contains("fuck")){
            contentNew=content.replaceAll("fuck","****");
        }else{
            contentNew=content;
        }
        return contentNew;
    }
}
