package com.kysoft.filter;

import com.kysoft.beans.Authority;
import com.kysoft.beans.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Guohw on 2017-03-30.
 */
@WebFilter(filterName = "authorityFilter")
public class AuthorityFilter implements Filter {
    FilterConfig config;
    List<String> noCheckUrls;
    String path;

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        path = request.getServletPath();
        if (noCheckUrls.contains(path)) {
            chain.doFilter(req, resp);
            return;
        }

        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            List<Authority> authorities = user.getAuthorities();
            for (Authority a : authorities) {
                if (path.equals(a.getUrl())) {
                    chain.doFilter(req, resp);
                    return;
                }
            }
            request.setAttribute("message","您没有访问"+path+"的权限");
            request.getRequestDispatcher("list.jsp").forward(request,response);
            return;
        }
    }
    public void init(FilterConfig config) throws ServletException {
        this.config=config;
        noCheckUrls= Arrays.asList(config.getInitParameter("noCheckUrls").split(","));
    }

}
