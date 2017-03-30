package com.kysoft.Daos;

import com.kysoft.beans.Authority;
import com.kysoft.beans.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Guohw on 2017-03-29.
 */
public class UserDao {
    private static List<Authority> authorities;
    private static Map<String,User> users;
    static{
        authorities=new ArrayList<Authority>();
        authorities.add(new Authority("lesson1","/lesson1.jsp"));
        authorities.add(new Authority("lesson2","/lesson2.jsp"));
        authorities.add(new Authority("lesson3","/lesson3.jsp"));
        authorities.add(new Authority("lesson4","/lesson4.jsp"));
        authorities.add(new Authority("lesson5","/lesson5.jsp"));
        users=new HashMap<String, User>();
       User userA= new User("AA");
       userA.setAuthorities(authorities.subList(0,2));
       User userB= new User("BB");
       userB.setAuthorities(authorities.subList(2,5));
        users.put(userA.getUserName(),userA);
        users.put(userB.getUserName(),userB);
    }
    //查看某个用户的权限
    public List<Authority> getAuthorityByUser(String userName){
       User user= users.get(userName);
        return user.getAuthorities();
    }
    //修改某个用户的权限
    public void updateAuthority(String userName,List<Authority> authorities1){
       User user= users.get(userName);
       user.setAuthorities(authorities1);
    }
    public User getUserByUserName(String userName){
        return users.get(userName);
    }
    public List<Authority> getAuthorities(){
        return authorities;
    }
}
