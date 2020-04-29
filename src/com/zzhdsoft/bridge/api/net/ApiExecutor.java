package com.zzhdsoft.bridge.api.net;

import com.zzhdsoft.siweb.dto.bridge.ApiRequestHeader;
import com.zzhdsoft.utils.bridge.OkHttpUtils;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import java.io.IOException;

/**
 * API通讯类
 */
public class ApiExecutor {

    /**
     * 创建Request
     *
     * @param url
     * @param header
     * @param json
     * @return
     */
    public static Request buildRequest(String url, ApiRequestHeader header, String json) {

        return new Request.Builder()
                .url(url)
                .header(ApiRequestHeader.HEADER_CODE, header.code)
                .header(ApiRequestHeader.HEADER_TOKEN, header.token)
                .header(ApiRequestHeader.HEADER_ID, header.uid)
                .header(ApiRequestHeader.HEADER_DEVICE, header.device)
                .header(ApiRequestHeader.HEADER_DEVICEID, header.deviceId)
                .post(RequestBody.create(OkHttpUtils.MEDIA_TYPE_JSON, json))
                .build();
    }

    /**
     * 执行通讯
     *
     * @param url
     * @param header
     * @param json
     * @return
     * @throws IOException
     */
    public static Response execute(String url, ApiRequestHeader header, String json) throws IOException {
        final Request request = ApiExecutor.buildRequest(url, header, json);

        Response response = OkHttpUtils.getInstance()
                                       .getClient()
                                       .newCall(request)
                                       .execute();

        return response;
    }
}
