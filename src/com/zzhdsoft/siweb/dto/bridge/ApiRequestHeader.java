package com.zzhdsoft.siweb.dto.bridge;

import org.apache.commons.lang.StringUtils;

/**
 * 请求Header
 */
public class ApiRequestHeader {
    public static String HEADER1 = "X-AST-Key";
    public static String HEADER2 = "X-AST-Sign";

    public static final String HEADER_TOKEN = "token";
    public static final String HEADER_DEVICE = "device";
    public static final String HEADER_DEVICEID = "deviceId";
    public static final String HEADER_ID = "uid";
    public static final String HEADER_CODE = "code";

    /**
     * 请求的时间戳
     */
    public String timestamp;

    /**
     * 令牌
     */
    public String token;

    /**
     * 设备类型[1 PC 2 安卓 3 iOS 4 微信]
     */
    public String device;

    public String getDeviceDesc() {
        if(StringUtils.isEmpty(device))
            return "";
        int deviceInt = Integer.parseInt(device);
        String result;
        switch (deviceInt) {
            case 1:
                result = "PC";
                break;
            case 2:
                result = "安卓";
                break;
            case 3:
                result = "iOS";
                break;
            case 4:
                result = "微信";
                break;
            default:
                result = device;
        }

        return result;
    }

    /**
     * 设备唯一编码
     */
    public String deviceId;

    /**
     * 用户唯一标识（id）
     */
    public String uid;

    /**
     * 后台服务代码
     */
    public String code;

    /**
     * 是否是有效的header，用于检查header内容，不放入request.header中
     */
    public boolean isValidHeader;

}
