package com.zzhdsoft.mvc.bridge;



import com.alibaba.fastjson.JSONObject;
import com.zzhdsoft.bridge.AstServiceException;
import com.zzhdsoft.bridge.api.server.AuthApi;
import com.zzhdsoft.mvc.GlobalConfig;
import com.zzhdsoft.siweb.dto.bridge.ApiRequestHeader;
import com.zzhdsoft.siweb.dto.bridge.ApiResult;
import org.apache.commons.lang.StringUtils;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Mirror;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.HashMap;

/**
 * 服务统一入口
 */
@At("/api")
@IocBean
public class ApiModule {

    private final static Logger logger = LoggerFactory.getLogger(ApiModule.class);

    @Inject
    private AuthApi authApi;

    /**
     * 不检查令牌的api
     */
    private HashMap<String, String> nonCheckApiMap = new HashMap();


    /**
     * 不检查令牌的api+method
     */
    private HashMap<String, String> nonCheckApi2Map = new HashMap();

    /**
     * 不需要检查令牌的api和接口，放入map
     * key=api，整个api都不需要检查
     * key=api.method，这个方法不需要检查
     */
    @PostConstruct
    public void init() {
        logger.debug("初始化令牌过滤map");
        //nonCheckApiMap.put("auth", "auth");
        nonCheckApi2Map.put("auth.login", "auth.login");
    }

    /**
     * 对外暴露的接口，可以任意命名url
     *
     * @param str
     * @param request
     * @return
     */
    @At("/")
    @Ok("json")
    public ApiResult index(@Param("str") String str, HttpServletRequest request) {

        try {
            ApiRequestHeader header = parseHeader(request);

            logger.debug("╔════════════════════════════════════════════════════════════════════════════════════════");
            logger.debug("║ " + header.code + " 请求");
            logger.debug("╟────────────────────────────────────────────────────────────────────────────────────────");
            logger.debug("║ uid：" + header.uid);
            logger.debug("║ token：" + header.token);
            logger.debug("║ device：" + header.getDeviceDesc());
            logger.debug("║ deviceId：" + header.deviceId);
            logger.debug("╟────────────────────────────────────────────────────────────────────────────────────────");
            logger.debug("║ " + str);
            logger.debug("╚════════════════════════════════════════════════════════════════════════════════════════");

            if (!isValidHeader(header)) {
                return ApiResult.error("无效的Header！");
            }

            ApiResult result = processByReflect(str, header);

            logger.debug("╔════════════════════════════════════════════════════════════════════════════════════════");
            logger.debug("║ -->" + header.code + " 返回");
            logger.debug("╟────────────────────────────────────────────────────────────────────────────────────────");
            logger.debug("║ uid：" + header.uid);
            logger.debug("║ token：" + header.token);
            logger.debug("║ device：" + header.getDeviceDesc());
            logger.debug("║ deviceId：" + header.deviceId);
            logger.debug("╟────────────────────────────────────────────────────────────────────────────────────────");
            logger.debug("║ " + JSONObject.toJSON(result));
            logger.debug("╚════════════════════════════════════════════════════════════════════════════════════════");

            return result;
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage(), ex);
            return ApiResult.error(ex.getLocalizedMessage());
        }
    }

    /**
     * 通过反射进行业务分发
     *
     * @param json
     * @param header
     * @return
     */
    private ApiResult processByReflect(String json, ApiRequestHeader header) {

        String[] array = header.code.split("\\.");

        if (array.length < 2)
            return ApiResult.error("服务代码错误！");

        String api = array[0];
        String apiName = api + "Api";
        //apiName = StringUtils.capitalize(apiName);

        String methodName = array[1];

        //0.check token
        if (!isValidToken(header, api, methodName)) {
            return ApiResult.error(ApiResult.ERROR_TOKEN, "业务[" + header.code + "]令牌错误！");
        }

        //1.get service
        Object object;
        Class clazz;
        try {

            object = Mvcs.ctx().getDefaultIoc().get(null,api);
            System.out.println(object.getClass().getName());
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage(), ex);
            return ApiResult.error("业务[" + api + "]不存在！");
        }
//        try {
////           Class clazz2 = Class.forName(object.getClass().getName());
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
        //2.get method
        Mirror mirror = Mirror.me(object);
        try {
            object = mirror.born();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage(), ex);
            return ApiResult.error("业务[" + header.code + "]不存在！");
        }

        //3.invoke method
        ApiResult result = null;
        try {
            result = (ApiResult) mirror.invoke(object,methodName,json,header);
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            logger.error(msg, ex);

            if (ex instanceof AstServiceException) {
                result = ApiResult.error(msg);
            } else {
                //TODO:正式部署，把后面的异常信息移除
                result = ApiResult.error("业务[" + header.code + "]执行异常！" + msg);
            }
        }

        return result;
    }

    /**
     * 解析Header
     *
     * @param request
     * @return
     */
    private ApiRequestHeader parseHeader(HttpServletRequest request) {
        ApiRequestHeader header = new ApiRequestHeader();
        header.token = request.getHeader(ApiRequestHeader.HEADER_TOKEN);
        header.device = request.getHeader(ApiRequestHeader.HEADER_DEVICE);
        header.deviceId = request.getHeader(ApiRequestHeader.HEADER_DEVICEID);
        header.uid = request.getHeader(ApiRequestHeader.HEADER_ID);
        header.code = request.getHeader(ApiRequestHeader.HEADER_CODE);

        return header;
    }

    /**
     * 是否是有效的header
     *
     * @param header
     * @return
     */
    private boolean isValidHeader(ApiRequestHeader header) {
        if (StringUtils.isEmpty(header.device) || StringUtils.isEmpty(header.code)) {
            return false;
        }

        return true;
    }

    /**
     * 是否是有效的token
     * 登录才能访问的接口，需要检查token
     *
     * @param header
     * @param api
     * @param methodName
     * @return
     */
    private boolean isValidToken(ApiRequestHeader header, String api, String methodName) {
        //如果是不需要检查的接口，返回true
        if (nonCheckApiMap.containsKey(api)) {
            logger.debug("===>检查Token：api[{}]在过滤列表中，不需要检查", api);
            return true;
        }

        if (nonCheckApi2Map.containsKey(api + "." + methodName)) {
            logger.debug("===>检查Token：api[{}.{}]在过滤列表中，不需要检查", api, methodName);
            return true;
        }

        if (StringUtils.isEmpty(header.device)
                || StringUtils.isEmpty(header.code)
                || StringUtils.isEmpty(header.token)) {

            logger.debug("===>检查Token：失败！空");
            return false;
        }

        String userid = header.uid;
        String deviceType = header.device;
        String token = header.token;

        //1 PC 2 安卓 3 IOS 4 微信
        boolean isCheck = checkToken(userid, token, deviceType);

        logger.debug("===>检查Token：{}", isCheck);

        return isCheck;
    }

    private boolean checkToken(String userid, String token, String deviceType){

        if(GlobalConfig.getAppConfig("checkTokenFromServer") == null){
            return checkTokenFromLocal(userid, token, deviceType);
        }

        if(GlobalConfig.getAppConfig("checkTokenFromServer").equals("true")){
            return  checkTokenFromServer(userid, token, deviceType);
        }

        return checkTokenFromLocal(userid, token, deviceType);
    }

    private boolean checkTokenFromServer(String userid, String token, String deviceType) {
        ApiResult apiResult = authApi.checkToken(userid, token);

        return apiResult.isSuccess();
    }

    private boolean checkTokenFromLocal(String userid, String token, String deviceType) {
//        SysLoginstatus entity = loginStatusService.get(userid);
//
//        if (entity == null) {
//            logger.debug("===>检查Token：失败！无对应登录数据");
//            return false;
//        }

        //1 PC 2 安卓 3 IOS 4 微信
        boolean isCheck = false;
//        if (StringUtils.equals(deviceType, "1")) {
//            isCheck = StringUtils.equals(token, entity.getPctoken());
//        } else {
//            isCheck = StringUtils.equals(token, entity.getToken());
//        }
//
        return isCheck;
    }
}
