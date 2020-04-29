package com.zzhdsoft.bridge.api.net;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.zzhdsoft.siweb.dto.bridge.ApiResult;
import com.zzhdsoft.siweb.dto.bridge.AstPageResult;
import com.zzhdsoft.utils.bridge.JsonUtils;
import okhttp3.Response;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.type.JavaType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

/**
 * 解析Json数据到ApiResult
 */
public class ApiResultParser {

    private static Logger logger = LoggerFactory.getLogger(ApiResultParser.class);

    public static  <T> ApiResult<T> parseResponse(Response response, Class<T> clazz) throws IOException {
        String json = response.body()
                              .string();

        logger.debug("<-----------后台返回数据：" + json);

        if (StringUtils.isEmpty(json)) {
            return ApiResult.error("服务器返回数据为空");
        }

        JSONObject jsonObject = JSONObject.parseObject(json);

        Integer code = JsonUtils.getInt(jsonObject, "code", 0);
        String message = JsonUtils.getString(jsonObject, "message", "");

        ApiResult<T> result = new ApiResult<T>();
        result.setCode(code);
        result.setMessage(message);

        //后台发生错误
        if (code != 1) {
            if (code == -100)
                processTokenError();
            return result;
        }

        JSONObject dataObject = JsonUtils.getJSONObject(jsonObject, "data", null);
        if (dataObject == null)
            return result;

        String data = dataObject.toString();
        if (StringUtils.isEmpty(data)) {
            return result;
        }

        T t = JSONObject.parseObject(data,clazz);

        result.setData(t);

        return result;
    }


    public static ApiResult<Object> parseStringResponse(Response response) throws IOException {
        String json = response.body()
                              .string();

        logger.debug("<-----------后台返回数据：" + json);

        if (StringUtils.isEmpty(json)) {
            return ApiResult.error("服务器返回数据为空");
        }

        TypeReference<ApiResult<Object>> typeReference = new TypeReference<ApiResult<Object>>() {
        };

        ApiResult<Object> result = JSONObject.parseObject(json, typeReference);

        if (result.getCode() != 1) {
            if (result.getCode() == -100)
                processTokenError();
            return result;
        }

        return result;
    }


    public static  <T> ApiResult<List<T>> parseListResponse(Response response, JavaType javaType) throws IOException {
        String json = response.body()
                              .string();

        logger.debug("<-----------后台返回数据：" + json);

        if (StringUtils.isEmpty(json)) {
            return ApiResult.error("服务器返回数据为空");
        }

        JSONObject jsonObject = JSONObject.parseObject(json);

        Integer code = JsonUtils.getInt(jsonObject, "code", 0);
        String message = JsonUtils.getString(jsonObject, "message", "");

        ApiResult<List<T>> result = new ApiResult<List<T>>();
        result.setCode(code);
        result.setMessage(message);

        //后台发生错误
        if (code != 1) {
            if (code == -100)
                processTokenError();
            return result;
        }

        JSONArray dataObject = JsonUtils.getJSONArray(jsonObject, "data", null);
        if (dataObject == null)
            return result;

        String data = dataObject.toString();
        if (StringUtils.isEmpty(data)) {
            return result;
        }

        List<T> list = JSONObject.parseObject(data,List.class);

        result.setData(list);

        return result;
    }

    public static  <T> ApiResult<AstPageResult<T>> parseAstPageResultResponse(Response response,
                                                                              TypeReference<AstPageResult<T>> reference) throws IOException {
        String json = response.body()
                              .string();

        logger.debug("<-----------后台返回数据：" + json);

        if (StringUtils.isEmpty(json)) {
            return ApiResult.error("服务器返回数据为空");
        }

        JSONObject jsonObject = JSONObject.parseObject(json);

        Integer code = JsonUtils.getInt(jsonObject, "code", 0);
        String message = JsonUtils.getString(jsonObject, "message", "");

        ApiResult<AstPageResult<T>> result = new ApiResult<AstPageResult<T>>();
        result.setCode(code);
        result.setMessage(message);

        //后台发生错误
        if (code != 1) {
            if (code == -100)
                processTokenError();
            return result;
        }

        //parse data
        JSONObject dataObject = JsonUtils.getJSONObject(jsonObject, "data", null);
        if (dataObject == null)
            return result;

        String data = dataObject.toString();
        if (StringUtils.isEmpty(data)) {
            return result;
        }

//        AstPageResult<T> pageResult = JsonMapper.defaultMapper()
//                                                .getMapper()
//                                                .readValue(data, reference);

        AstPageResult<T> pageResult = JSONObject.parseObject(data,AstPageResult.class);
        result.setData(pageResult);

        return result;
    }


    /**
     * 后台token错误
     */
    protected static void processTokenError() {

    }
}
