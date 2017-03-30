package com.kysoft.beans;

/**
 * Created by Guohw on 2017-03-29.
 */
public class Authority {
    private String displayName;
    //这里定义一个权限对应一个url
    private String url;

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Authority(String displayName, String url) {
        this.displayName = displayName;
        this.url = url;
    }

    public Authority() {
    }
}
