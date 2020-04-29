package com.zzhdsoft.siweb.dto.bridge;


import org.apache.commons.lang.StringUtils;

import java.io.Serializable;

public class ApiResult<T> implements Serializable {
    public static final int SUCCESS = 1;
    public static final int ERROR = 0;

    public static final int ERROR_TOKEN = -100;

    private Integer code = ERROR;
    private String message = "";

    private T data;

    public ApiResult() {
    }

    public ApiResult(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public boolean isSuccess(){
        return code == SUCCESS;
    }

    public static <T> ApiResult<T> success() {
        return new ApiResult<T>(SUCCESS, "", null);
    }

    public static <T> ApiResult<T> success(T data) {
        return new ApiResult<T>(SUCCESS, "", data);
    }

    public static <T> ApiResult<T> success(String message, T data) {
        return new ApiResult<T>(SUCCESS, message, data);
    }

    public static <T> ApiResult<T> error() {
        return new ApiResult<T>(ERROR, "", null);
    }

    public static <T> ApiResult<T> error(String message) {
        return new ApiResult<T>(ERROR, message, null);
    }

    public static <T> ApiResult<T> error(int code, String message) {
        return new ApiResult<T>(code, message, null);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        if (StringUtils.isEmpty(message))
            message = "";

        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
