package com.kysoft.servlets;

/**
 * Created by Guohw on 2017-03-29.
 */

import com.kysoft.Daos.UserDao;
import com.kysoft.beans.Authority;
import com.kysoft.beans.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/userServlet")
public class UserServlet extends HttpServlet {
    UserDao userDao=new UserDao();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String methodName= req.getParameter("method");
        Method[] methods = null;
        Method currentMethod=null;
        try {
             methods=getClass().getDeclaredMethods();
             for(Method m:methods){
                if(m.getName().equals(methodName)){
                  m.invoke(this,req,resp);
                   return;
                }
             }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void getUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String userName= req.getParameter("userName");
       User user=userDao.getUserByUserName(userName);
        req.setAttribute("u",user);
        req.getRequestDispatcher("manageAuthority.jsp").forward(req,resp);
    }
    public void updateAuthority(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username =req.getParameter("user");
        String authorityDisplayName[]=req.getParameterValues("authority");
        List<Authority> newAuthorities=new ArrayList<Authority>();
        for(Authority a:userDao.getAuthorities()){
          for(String displayName:authorityDisplayName){
              if(a.getDisplayName().equals(displayName))
                  newAuthorities.add(a);
          }
        }
        userDao.updateAuthority(username,newAuthorities);
        resp.sendRedirect("authorityManage.jsp");

    }
    public void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username=req.getParameter("user");
        User user=userDao.getUserByUserName(username);
        req.getSession().setAttribute("currentUser",user);
        req.getRequestDispatcher("list.jsp").forward(req,resp);
    }
    public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().invalidate();
        resp.sendRedirect("login.jsp");
    }
}
