package com.websupport.util;

/**
 * Created by Administrator on 2014/8/25.
 */
public class AjaxObject {
    private boolean status;
    private String msg;
    private Object data;

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
