package com.zzhdsoft.utils.bridge;


import okhttp3.*;
import org.apache.commons.lang.StringUtils;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.TimeUnit;


/**
 * OkHttp功能类
 * 低级封装，异步操作没有封装到UI线程，如果调用的话，需要自己同步到UI线程
 * onResponse回调的参数是response，一般情况下，比如我们希望获得返回的字符串，可以通过response.body().string()获取；
 * 如果希望获得返回的二进制字节数组，则调用response.body().bytes()；
 * 如果你想拿到返回的inputStream，则调用response.body().byteStream()
 * 获取JSON
 * Gson gson = new Gson();
 * MyClass obj = gson.fromJson(response.body().charStream(), MyClass.class);
 */
public class OkHttpUtils {
    // 默认的标签
    public static final String TAG = OkHttpUtils.class.getSimpleName();

    // 默认的超时时间 TODO:修改测试的超时时间
    private static final int DEFAULT_CONNECT_TIMEOUT = 15;
    private static final int DEFAULT_WRITE_TIMEOUT = 15;
    private static final int DEFAULT_READ_TIMEOUT = 300;

    public static final MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json; charset=utf-8");
    public static final MediaType MEDIA_TYPE_MARKDOWN = MediaType.parse("text/x-markdown; charset=utf-8");
    public static final MediaType MEDIA_TYPE_PLAIN = MediaType.parse("text/plain;charset=utf-8");
    public static final MediaType MEDIA_TYPE_PNG = MediaType.parse("image/png");

    private volatile static OkHttpUtils mInstance = new OkHttpUtils();

    private OkHttpClient client;

    private OkHttpUtils() {
        initOkClient();
    }

    /**
     * 对OKClient进行初始化
     */
    private void initOkClient() {
        client = new OkHttpClient.Builder()
                .connectTimeout(DEFAULT_CONNECT_TIMEOUT, TimeUnit.SECONDS)
                .writeTimeout(DEFAULT_WRITE_TIMEOUT, TimeUnit.SECONDS)
                .readTimeout(DEFAULT_READ_TIMEOUT, TimeUnit.SECONDS)
                .build();
    }

    public static OkHttpUtils getInstance() {
        if (null == mInstance) {
            synchronized (OkHttpUtils.class) {
                if (null == mInstance) {
                    mInstance = new OkHttpUtils();
                }
            }
        }

        return mInstance;
    }

    public OkHttpClient getClient() {
        if (client == null) {
            synchronized (OkHttpUtils.class) {
                if (client == null) {
                    initOkClient();
                }
            }
        }

        return client;
    }

    /**
     * 返回一个默认Client的Copy
     * 可以再对此Client对象进行各种设置，不影响原来的Client
     * 比如：单独设置读超时时间为500毫秒
     * .readTimeout(500, TimeUnit.MILLISECONDS)
     *
     * @return
     */
    public OkHttpClient getCopyClient() {
        OkHttpClient copy = client.newBuilder()
                                  .build();

        return copy;
    }

    /**
     * GET
     *
     * @param url
     * @param tag
     * @return
     * @throws IOException
     */
    public static Response get(String url, String tag) throws IOException {
        Request request = new Request.Builder()
                .url(url)
                .tag(tag)
                .build();

        Response response = getInstance().getClient()
                                         .newCall(request)
                                         .execute();
        if (!response.isSuccessful())
            throw new IOException("Unexpected code " + response);

        return response;
    }

    public static Response get(String url) throws IOException {
        return get(url, TAG);
    }

    /**
     * GET，异步，返回的非UI线程
     *
     * @param url
     * @param tag
     * @param callback
     */
    public static void get(String url, String tag, Callback callback) {
        Request request = new Request.Builder()
                .url(url)
                .tag(tag)
                .build();

        getInstance().getClient()
                     .newCall(request)
                     .enqueue(callback);
    }

    /**
     * GET，异步，返回的非UI线程
     *
     * @param url
     * @param callback
     */
    public static void get(String url, Callback callback) {
        get(url, TAG, callback);
    }

    /**
     * Post方式提交Json
     *
     * @param url
     * @param tag
     * @param json
     * @return
     * @throws IOException
     */
    public static Response postJson(String url, String tag, String json) throws IOException {
        RequestBody body = RequestBody.create(MEDIA_TYPE_JSON, json);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .tag(tag)
                .build();

        Response response = getInstance().getClient()
                                         .newCall(request)
                                         .execute();
        if (!response.isSuccessful())
            throw new IOException("Unexpected code " + response);

        return response;
    }

    public static Response postJson(String url, String json) throws IOException {
        return postJson(url, TAG, json);
    }

    /**
     * Post方式提交Json，异步，返回的非UI线程
     *
     * @param url
     * @param tag
     * @param json
     * @param callback
     */
    public static void postJson(String url, String tag, String json, Callback callback) {
        RequestBody body = RequestBody.create(MEDIA_TYPE_JSON, json);
        Request request = new Request.Builder()
                .url(url)
                .post(body)
                .tag(tag)
                .build();

        getInstance().getClient()
                     .newCall(request)
                     .enqueue(callback);
    }

    public static void postJson(String url, String json, Callback callback) {
        postJson(url, TAG, json, callback);
    }

    /**
     * Post方式提交表单
     * //        RequestBody formBody = new FormBody.Builder
     * //                .add("search", "Jurassic Park")
     * //                .build();
     *
     * @param url
     * @param tag
     * @param formBody
     * @throws Exception
     */
    public static Response postFormBody(String url, String tag, RequestBody formBody) throws IOException {

        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .tag(tag)
                .build();

        Response response = getInstance().getClient()
                                         .newCall(request)
                                         .execute();
        if (!response.isSuccessful())
            throw new IOException("Unexpected code " + response);

        return response;
    }

    public static Response postFormBody(String url, RequestBody formBody) throws IOException {
        return postFormBody(url, TAG, formBody);
    }

    /**
     * Post方式提交表单，异步，返回的非UI线程
     *
     * @param url
     * @param tag
     * @param formBody
     * @param callback
     */
    public static void postFormBody(String url, String tag, RequestBody formBody, Callback callback) {
        Request request = new Request.Builder()
                .url(url)
                .post(formBody)
                .tag(tag)
                .build();

        getInstance().getClient()
                     .newCall(request)
                     .enqueue(callback);
    }

    public static void postFormBody(String url, RequestBody formBody, Callback callback) {
        postFormBody(url, TAG, formBody, callback);
    }

    /**
     * Post方式提交String
     *
     * @param url
     * @param tag
     * @param postBody
     * @return
     * @throws IOException
     */
    public static Response postString(String url, String tag, String postBody) throws IOException {
        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(MEDIA_TYPE_PLAIN, postBody))
                .tag(tag)
                .build();

        Response response = getInstance().getClient()
                                         .newCall(request)
                                         .execute();
        if (!response.isSuccessful())
            throw new IOException("Unexpected code " + response);

        return response;
    }

    public static Response postString(String url, String postBody) throws IOException {
        return postString(url, TAG, postBody);
    }

    /**
     * Post方式提交String，异步，返回的非UI线程
     *
     * @param url
     * @param tag
     * @param postBody
     * @param callback
     */
    public static void postString(String url, String tag, String postBody, Callback callback) {
        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(MEDIA_TYPE_PLAIN, postBody))
                .tag(tag)
                .build();

        getInstance().getClient()
                     .newCall(request)
                     .enqueue(callback);
    }

    public static void postString(String url, String postBody, Callback callback) {
        postString(url, TAG, postBody, callback);
    }

    /**
     * Post方式提交文件
     *
     * @param url
     * @param tag
     * @param file
     * @return
     * @throws IOException
     */
    public static Response postFile(String url, String tag, File file) throws IOException {
        //File file = new File("README.md");
        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(MEDIA_TYPE_MARKDOWN, file))
                .tag(tag)
                .build();

        Response response = getInstance().getClient()
                                         .newCall(request)
                                         .execute();
        if (!response.isSuccessful())
            throw new IOException("Unexpected code " + response);

        return response;
    }

    public static Response postFile(String url, File file) throws IOException {
        return postFile(url, TAG, file);
    }

    /**
     * Post方式提交文件，异步，返回的非UI线程
     *
     * @param url
     * @param tag
     * @param file
     * @param callback
     */
    public static void postFile(String url, String tag, File file, Callback callback) {
        //File file = new File("README.md");
        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(MEDIA_TYPE_MARKDOWN, file))
                .tag(tag)
                .build();

        getInstance().getClient()
                     .newCall(request)
                     .enqueue(callback);
    }

    public static void postFile(String url, File file, Callback callback) {
        postFile(url, TAG, file, callback);
    }

    /**
     * 取消指定TAG的请求
     *
     * @param tag
     */
    public static void cancleRequest(String tag) {
        okhttp3.Dispatcher dispatcher = getInstance().getClient()
                                                     .dispatcher();
        List<Call> runningCalls = dispatcher.runningCalls();
        List<Call> queuedCalls = dispatcher.queuedCalls();

        for (Call call : runningCalls) {
            String callTag = call.request()
                                 .tag()
                                 .toString();
            if (StringUtils.equals(tag, callTag)) {
                cancelCall(call);
            }
        }

        for (Call call : queuedCalls) {
            String callTag = call.request()
                                 .tag()
                                 .toString();
            if (StringUtils.equals(tag, callTag)) {
                cancelCall(call);
            }
        }
    }

    private static void cancelCall(Call call) {
        if (call.isCanceled())
            return;

        if (call.isExecuted())
            return;

        try {
            call.cancel();
        } catch (Exception ex) {

        }
    }

    /**
     * 取消所有的请求
     */
    public static void cancelAll() {
        getInstance().getClient()
                     .dispatcher()
                     .cancelAll();
    }
}
