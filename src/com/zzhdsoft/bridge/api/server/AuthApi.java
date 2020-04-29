package com.zzhdsoft.bridge.api.server;

import com.zzhdsoft.bridge.api.net.BaseApi;
import com.zzhdsoft.siweb.dto.bridge.ApiRequestHeader;
import com.zzhdsoft.siweb.dto.bridge.ApiResult;
import org.nutz.ioc.loader.annotation.IocBean;

import java.util.HashMap;

/**
 * 通过authserver来验证token
 */
@IocBean
public class AuthApi extends BaseApi {

    /**
     * 校验token
     *
     * @return
     */
    public ApiResult<Object> checkToken(String userId, String token) {
        String url = getAuthServerApiUrl();
        ApiRequestHeader header = getHeader("auth.checkToken", userId, token);

        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("userid", userId);
        params.put("token", token);
        String json = getJson(params);

        return getEntity(url, header, json, Object.class);
    }

}
