package com.util;

import java.io.Serializable;

/**
 * @Auther: luominjie
 * @Date: 2019/4/24 15:07
 * @Description:
 */
public class JsonResult implements Serializable {

    /**
     *请求是否成功
     */
    private boolean status;
    /**
     *请求提示信息
     */
    private String msg;
    /**
     * 请求结果数据
     */
    private Object obj;

    public JsonResult() {
        super();
    }

    public JsonResult(boolean status, String msg, Object obj) {
        this.status = status;
        this.msg = msg;
        this.obj = obj;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }
}
