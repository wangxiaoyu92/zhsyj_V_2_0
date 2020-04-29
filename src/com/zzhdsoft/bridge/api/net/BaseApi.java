package com.zzhdsoft.bridge.api.net;

import com.alibaba.fastjson.JSONObject;

import com.zzhdsoft.mvc.GlobalConfig;
import com.zzhdsoft.siweb.dto.bridge.ApiRequestHeader;
import com.zzhdsoft.siweb.dto.bridge.ApiResult;
import com.zzhdsoft.siweb.dto.bridge.AstPageResult;
import okhttp3.Response;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.type.JavaType;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Api基类，实现网络通讯
 */
public class BaseApi {

    /**
     * 对api全路径的一个包装，如：service1.city.get
     * serviceCode=service1
     * apiCode=city.get
     */
    public static class ServiceApiCode {
        public String serviceCode = "";
        public String apiCode = "";

        public ServiceApiCode(String fullCode) {
            if (StringUtils.isEmpty(fullCode))
                return;

            String[] array = fullCode.split("\\.");
            if (array.length <= 2) {
                apiCode = fullCode;
                return;
            }

            if (array.length > 3) {
                return;
            }

            serviceCode = array[0];
            apiCode = array[1] + "." + array[2];
        }
    }

    private static Logger logger = LoggerFactory.getLogger(BaseApi.class);

    /**
     * 获取Json字符串
     *
     * @param params
     * @return
     */
    protected String getJson(HashMap<String, Object> params) {
        String json = JSONObject.toJSONString(params);

        return json;
    }

    /**
     * 根据serviceCode获取对应后台Api服务的url
     * 目前只允许获取authserver的地址
     *
     * @param serviceCode 后端服务代码
     * @return
     */
    protected String getBackServiceApiUrl(String serviceCode) {
        return GlobalConfig.getAppConfig("authUrl");
    }

    /**
     * 获取认证中心API的url
     *
     * @return
     */
    protected String getAuthServerApiUrl() {
        return  GlobalConfig.getAppConfig("authUrl");
    }

    /**
     * 获取当前的时间戳
     *
     * @return
     */
    public String getCurrentTimestamp() {
        return String.valueOf(System.currentTimeMillis());
    }

    protected  ApiRequestHeader getHeader(String code){
        return getHeader(code, "", "");
    }

    protected ApiRequestHeader getHeader(String code, String userId, String token) {
        ApiRequestHeader header = new ApiRequestHeader();

        header.timestamp = getCurrentTimestamp();
        header.code = code;
        header.device = "1";
        header.deviceId = "";

        //获取当前用户的token，未登录时为空
        header.token = token;

        header.uid = userId;

        return header;
    }

    protected <T> ApiResult<T> getEntity(String fullCode, String json, Class<T> clazz) {
        ServiceApiCode serviceApiCode = new ServiceApiCode(fullCode);

        String url = getBackServiceApiUrl(serviceApiCode.serviceCode);
        ApiRequestHeader header = getHeader(serviceApiCode.apiCode);

        return getEntity(url, header, json, clazz);
    }

    /**
     * 如果ApiResult的data是一个非泛型的对象，那么需要使用此方法
     *
     * @param url
     * @param header
     * @param json
     * @param clazz
     * @param <T>
     * @return
     */
    protected <T> ApiResult<T> getEntity(String url, ApiRequestHeader header, String json, Class<T> clazz) {

        logger.debug("------>传给后台数据[" + header.code + "]：" + json);

        try {
            Response response = ApiExecutor.execute(url, header, json);
            return ApiResultParser.parseResponse(response, clazz);
        } catch (java.net.ConnectException cex) {
            String message = "无法连接服务器";
            logger.error(message);
            return ApiResult.error(message);
        } catch (Exception ex) {
            //throw new RuntimeException(ex.getLocalizedMessage());
            logger.error(ex.getLocalizedMessage());
            return ApiResult.error(ex.getLocalizedMessage());
        }
    }

    protected <T> ApiResult<List<T>> getList(String fullCode, Class<T> clazz) {
        ServiceApiCode serviceApiCode = new ServiceApiCode(fullCode);

        String url = getBackServiceApiUrl(serviceApiCode.serviceCode);
        ApiRequestHeader header = getHeader(serviceApiCode.apiCode);

        return getList(url, header, clazz);
    }

    /**
     * 如果ApiResult的data是一个List，那么需要使用此方法
     *
     * @param url
     * @param header
     * @param clazz
     * @param <T>
     * @return
     */
    protected <T> ApiResult<List<T>> getList(String url, ApiRequestHeader header, Class<T> clazz) {
        HashMap<String, Object> params = new HashMap<String, Object>();
        String json = getJson(params);

        return getList(url, header, json, clazz);
    }

    protected <T> ApiResult<List<T>> getList(String fullCode, String json, Class<T> clazz) {
        ServiceApiCode serviceApiCode = new ServiceApiCode(fullCode);

        String url = getBackServiceApiUrl(serviceApiCode.serviceCode);
        ApiRequestHeader header = getHeader(serviceApiCode.apiCode);

        return getList(url, header, json, clazz);
    }

    /**
     * 如果ApiResult的data是一个List，那么需要使用此方法
     *
     * @param url
     * @param header
     * @param json
     * @param clazz
     * @param <T>
     * @return
     */
    protected <T> ApiResult<List<T>> getList(String url, ApiRequestHeader header, String json, Class<T> clazz) {
        logger.debug("------>传给后台数据[" + header.code + "]：" + json);
        JavaType javaType = null;

//        JavaType javaType = JsonMapper.defaultMapper()
//                                      .buildCollectionType(ArrayList.class, clazz);

        try {
            Response response = ApiExecutor.execute(url, header, json);
            return ApiResultParser.parseListResponse(response, javaType);
        } catch (java.net.ConnectException cex) {
            String message = "无法连接服务器";
            logger.error(message);
            return ApiResult.error(message);
        } catch (Exception ex) {
            //throw new RuntimeException(ex.getLocalizedMessage());
            logger.error(ex.getLocalizedMessage());
            return ApiResult.error(ex.getLocalizedMessage());
        }
    }

//    protected <T> ApiResult<AstPageResult<T>> getAstPageResult(String fullCode, String json,
//                                                               TypeReference<AstPageResult<T>> reference) {
//        ServiceApiCode serviceApiCode = new ServiceApiCode(fullCode);
//
//        String url = getBackServiceApiUrl(serviceApiCode.serviceCode);
//        ApiRequestHeader header = getHeader(serviceApiCode.apiCode);
//
//        return getAstPageResult(url, header, json, reference);
//    }

    /**
     * 如果ApiResult的data是一个AstPageResult<T>，那么需要使用此方法
     *
     * @param url
     * @param header
     * @param json
     * @param reference
     * @param <T>
     * @return
     */
//    protected <T> ApiResult<AstPageResult<T>> getAstPageResult(String url, ApiRequestHeader header, String json,
//                                                               TypeReference<AstPageResult<T>> reference) {
//        logger.debug("------>传给后台数据[" + header.code + "]：" + json);
//
//        try {
//            Response response = ApiExecutor.execute(url, header, json);
//            return ApiResultParser.parseAstPageResultResponse(response, reference);
//
//        } catch (java.net.ConnectException cex) {
//            String message = "无法连接服务器";
//            logger.error(message);
//            return ApiResult.error(message);
//        } catch (Exception ex) {
//            //throw new RuntimeException(ex.getLocalizedMessage());
//            logger.error(ex.getLocalizedMessage());
//            return ApiResult.error(ex.getLocalizedMessage());
//        }
//    }
}
