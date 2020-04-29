<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>单位信息列表中读取</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var selectTableDataId;
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        var v_tabname = sy.getUrlParam("tabname");
        var v_colname = sy.getUrlParam("colname");
        var layer;
        var form;
        var table;
        var mask;
        $(function () {
            layui.use(['layer', 'form', 'table'], function () {
                layer = layui.layer;
                form = layui.form;
                table = layui.table;
                //刷新的时候显示进度条
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#pcyzdszTable',
                    url: basePath + '/pub/pub/queryPcyzdsz'
                    ,where:{
                        tabname:v_tabname,
                        colname:v_colname
                    }
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {
                            field: 'avalue', width: 899, title: '值', event: 'trclick'
                        }
                    ]]
                    ,done:function () {
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.pcyzdszdetailid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.pcyzdszdetailid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $=layui.$,active={
                    quedPcom: function () { // 确定
                        if(!table.singleData){
                            layer.alert('请先选择企业信息！')
                        }else{
                            quedPcom(table.singleData);
                        }

                    }
                    , addPcom: function () { // 新增列表值
                        addPcom();
                    }
                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            })
        });
        function quedPcom(rows) {
            var arr=new Array();
            arr.push(rows)
            sy.setWinRet(arr);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        function addPcom() {
            var url = basePath + "jsp/pub/pub/pcyzdszmain.jsp";
            parent.sy.modalDialog({
                    title: '添加列表值'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        singleSelect: "true",
                        tabname: "",
                        colname: "",
                        time: new Date().getMilliseconds()
                    }
                }
                , function (dialogID) {
                        //刷新的时候显示进度条
                        var mask = layer.load(1, {shade: [0.1, '#393D49']});
                        var param ={ tabname:v_tabname,colname:v_colname};
                        table.reload('pcyzdszTable', {
                            url: basePath + '/pub/pub/queryPcyzdsz'
                            , page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            , where: param //设定异步数据接口的额外参数
                            ,done:function () {
                                layer.close(mask);
                            }
                        });
                });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="quedPcom">
                <button class="layui-btn" data-type="quedPcom" data="btn_quedPcom">确定</button>
            </ck:permission>
            <ck:permission biz="addPcom">
                <button class="layui-btn " data-type="addPcom" data="btn_addPcom">新增列表值</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="pcyzdszTable" lay-filter="tableFilter">
            <input type="hidden" name="pcyzdszdetailid" id="pcyzdszdetailid">
            <input type="hidden" name="aae140" id="aae140">
        </table>
    </div>
</div>

</body>
</html>