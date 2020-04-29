package com.zzhdsoft.bridge.api.net;

import com.zzhdsoft.siweb.dto.bridge.ApiRequestHeader;
import com.zzhdsoft.siweb.dto.bridge.ApiResult;
import okhttp3.Response;
import org.nutz.ioc.loader.annotation.IocBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import java.util.HashMap;

/**
 * 通用Api，直接返回ApiResult<Object>，不解析data
 */
@IocBean
public class CommonApi extends BaseApi {
    private static Logger logger = LoggerFactory.getLogger(CommonApi.class);

    /**
     * 调用后台api，不传任何参数
     *
     * @param fullCode 后台api全名称，如：service1.city.add
     * @return
     */
    public ApiResult<Object> execute(String fullCode) {
        HashMap<String, Object> params = new HashMap<String, Object>();
        String json = getJson(params);

        return execute(fullCode, json);
    }

    /**
     * 调用后台api，传入参数
     *
     * @param fullCode 后台api全名称，如：service1.city.add
     * @param params   参数map
     * @return
     */
    public ApiResult<Object> execute(String fullCode, HashMap<String, Object> params) {
        String json = getJson(params);

        return execute(fullCode, json);
    }

    /**
     * 调用后台api，传入json字符串
     *
     * @param fullCode 后台api全名称，如：service1.city.add
     * @param json     传给后台的json
     * @return
     */
    public ApiResult<Object> execute(String fullCode, String json) {

        ServiceApiCode serviceApiCode = new ServiceApiCode(fullCode);

        ApiRequestHeader header = getHeader(serviceApiCode.apiCode);
        String url = getBackServiceApiUrl(serviceApiCode.serviceCode);

        logger.debug("------>传给后台数据[" + header.code + "]：" + json);

        try {
            Response response = ApiExecutor.execute(url, header, json);
            return ApiResultParser.parseStringResponse(response);
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


}
