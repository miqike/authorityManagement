package com.kysoft.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Guohw on 2017-04-01.
 */
@WebFilter(filterName = "BbsFilter")
public class BbsFilter implements Filter {
    private FilterConfig config;
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request= (HttpServletRequest) req;
        HttpServletResponse response= (HttpServletResponse) resp;
       MyHttpServletRequest myHttpServletRequest=new MyHttpServletRequest(request);

        request.getRequestDispatcher("bbs.jsp").forward(myHttpServletRequest,  response);
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
        this.config=config;
    }

}
