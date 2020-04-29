<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="java.net.URLDecoder,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    String v_zfwsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("zfwsdmmc")), "UTF-8");
    v_zfwsdmmc = v_zfwsdmmc + " --模板列表";

    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();

%>
<!DOCTYPE html>
<html>
<head>
    <title>模板提取</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var selectTableDataId = "";
        var table;
        var mask;
        var element;
        var layer;
        $(function () {
            layui.use(['layer', 'form', 'table', 'element'], function () {
                layer = layui.layer;
                form = layui.form;
                table = layui.table;
                element = layui.element;
                table.render({
                    elem: '#mobanTable'
                    , url: basePath + '/pub/wsgldy/queryZfwsmobanlist'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    ,where:{
                        zfwsdmz: '<%=v_zfwsdmz%>'
                    }
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'aaa146', width: 200, title: '添加地区', event: 'trclick'},
                        {field: 'zfwsmbmc', width: 200, title: '执法文书模板名称', event: 'trclick'}
                        , {field: 'zfwsmbczy', width: 180, title: '操作员', event: 'trclick'}
                        , {field: 'zfwsmbczsj', width: 180, title: '操作时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                table.on('tool(tableFilter)',function (obj) {
                    var data=obj.data;
                    if(obj.event=='trclick'){
                        if (selectTableDataId != data.zfwsmbid) {

                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            var v_sysuserid='<%=v_userid%>';
                            if (data.userid!=null && !data.userid=="" && v_sysuserid==data.userid){
                                $("#delete").show();
                            }else{
                                $("#delete").hide();
                            }
                            selectTableDataId = data.zfwsmbid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                })
                var $=layui.$,active={
                    quedingPcom:function () {
                        if(!table.singleData){
                            layer.alert('请先选择模板信息')
                        }else{
                            queding();
                        }
                    },
                    delPcom:function () {
                        if(!table.singleData){
                            layer.alert('请选择要删除的文书模板');
                        }else{
                            delPcom(selectTableDataId);
                        }
                    }
                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });

        });
        function queding() {
            var obj=new Object();
            obj.data=table.singleData;
            obj.type='ok';
            sy.setWinRet(obj);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        function delPcom(zfwsmbid) {
            layer.open({
                title: '警告'
                ,icon:'3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath+'/pub/wsgldy/wsgldyDel', {
                            zfwsmbid: zfwsmbid
                        },
                        function (result) {
                            if (result.code == '0') {
                                //保证不会重复删除
                                table.singleData = '';
                                selectTableDataId = '';
                                //本页的值
                                var curent=$(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000},function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if(table.cache.mobanTable.length==1 ){
                                        curent=curent-1;
                                    }
                                    var mask = layer.load(1, {shade: [0.1, '#393D49']});
                                    table.reload('mobanTable', {
                                        url: basePath + '/pub/wsgldy/queryZfwsmobanlist'
                                        , page: {
                                            curr: curent //重新从第 1 页开始
                                        }
                                        , where: {
                                            zfwsdmz: '<%=v_zfwsdmz%>'
                                        } //设定异步数据接口的额外参数
                                        , done: function () {
                                            layer.close(mask);
                                        }
                                    })
                                });
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="quedingPcom">
                <button class="layui-btn" data-type="quedingPcom" data="btn_quedingPcom">确定选择</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" id="delete" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="mobanTable" lay-filter="tableFilter">
            <input type="hidden" name="zfwsmbid" id="zfwsmbid">
            <input type="hidden" name="ajdjid" id="ajdjid">
            <input type="hidden" name="zfwsdmz" id="zfwsdmz">
            <input type="hidden" name="zfwsqtbid" id="zfwsqtbid">
            <input type="hidden" name="userid" id="userid">
        </table>
    </div>
</div>
</body>
</html>