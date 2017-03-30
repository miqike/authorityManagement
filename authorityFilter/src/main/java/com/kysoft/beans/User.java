package com.kysoft.beans;

import java.util.List;

/**
 * Created by Guohw on 2017-03-29.
 */
public class User {
    private String userName;
    List<Authority> authorities;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<Authority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<Authority> authorities) {
        this.authorities = authorities;
    }

    public User(String userName) {
        this.userName = userName;
    }

    public User() {
    }
}
