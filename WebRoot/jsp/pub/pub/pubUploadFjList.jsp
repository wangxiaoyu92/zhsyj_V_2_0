<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>
<%
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
    String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));

    int v_gridwidth = 800;
    int v_gridheight = 500;
    String v_gridwidths = StringHelper.showNull2Empty(request.getParameter("gridwidth"));
    String v_gridheights = StringHelper.showNull2Empty(request.getParameter("gridheight"));
    if (v_gridwidths != null && !"".equals(v_gridwidths)) {
        v_gridwidth = Integer.parseInt(v_gridwidths);
    }
    if (v_gridheights != null && !"".equals(v_gridheights)) {
        v_gridheight = Integer.parseInt(v_gridheights);
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>附件列表</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
</head>
<script type="text/javascript">
    var selectTableDataId = '';
    var form;
    var table;
    var layer;
    var mask;
    $(function () {
        initData();
    });
    function initData() {
        layui.use(['form', 'table', 'layer'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            var param = {
                'fjwid': '<%=v_ajdjid%>',
                'fjcsdmlb': '<%=v_dmlb%>',
                'fjcsdlbh': '<%=v_fjcsdlbh%>'
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.render({
                elem: '#roleTable'
                , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , url: '<%=basePath%>pub/pub/queryFjlist'
                , page: true // 展示分页
                , limit: 10 // 每页展示条数
                , limits: [10, 20, 30] // 每页条数选择项
                , request: {
                    pageName: 'page' //页码的参数名称，默认：page
                    , limitName: 'rows' //每页数据量的参数名，默认：limit
                }
                , where: param //设定异步数据接口的额外参数
                , response: {
                    countName: 'total' //数据总数的字段名称，默认：count
                    , dataName: 'rows' //数据列表的字段名称，默认：data
                }
                , cols: [[
                    {field: 'fjcsdmlbmc', title: '附件类别名称', event: 'trclick'}
                    , {field: 'fjcsdmmc', title: '附件名称', event: 'trclick'}
                    , {
                        field: 'fjcsfjbc', title: '是否必传附件'
                        , templet: function (d) {
                            if (d.fjcsfjbc == "1") {
                                return '<span style="color:blue;">是</span>';
                            } else {
                                return '<span style="color:red;">否</span>';
                            }
                        }, event: 'trclick'
                    }
                    , {field: 'ycfjcount', title: '已上传附件数', event: 'trclick'}
                ]]
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            // 监听工具条
            table.on('tool(paramgridfilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'trclick') { // 选中行
                    if (selectTableDataId != data.fjcsdmz) {
                        // 清除所有行的样式
                        $(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $(obj.tr.selector).css("background", "#90E2DA");
                        table.singleData = data;
                        selectTableDataId = data.fjcsdmz;
                    } else { // 再次选中清除样式
                        $(obj.tr.selector).attr("style", "");
                        table.singleData = '';
                        selectTableDataId = '';
                    }
                }
            });
            var $ = layui.$, active = {
                uploadFuJian: function () { // 上传附件
                    if (!table.singleData) {
                        layer.alert('请选择要上传的附件类型！');
                    } else {
                        uploadFuJian(table.singleData.fjcsdmz);
                    }
                }
                , chakanFuJian: function () { // 查看附件
                    if (!table.singleData) {
                        layer.alert('请选择要查看的附件！');
                    } else {
                        chakanFuJian(table.singleData.fjcsdmz, table.singleData.ycfjcount);
                    }
                }
            };
            $('.demoTable .layui-btn').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });

        })
    }

    //上传附件
    function uploadFuJian(v_fjcsdmz) {
        var url = "<%=basePath%>jsp/pub/pub/pubUploadFj.jsp?ajdjid=<%=v_ajdjid%>&dmlb=<%=v_dmlb%>&fjcsdmz="
                + v_fjcsdmz + "&time=" + new Date().getMilliseconds();
//        parent.layer.close(parent.layer.getFrameIndex(window.name));
        parent.sy.modalDialog({
            type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
            , area: ['100%', '100%']
            , title: '上传附件'
            , content: url
            , btn: ['关闭']
            , end: function (index, layero) {
                window.location.reload();
            }
        });
    }

    //查看附件
    function chakanFuJian(v_fjcsdmz, v_ycfjcount) {
        if (v_ycfjcount == 0 || v_ycfjcount == null || v_ycfjcount == "" || v_ycfjcount.length == 0) {
            layer.msg('没有可查看的附件！', {time: 1000});
            return;
        }

        //浏览器版本判断，方便pubUploadFjView.jsp中查看图片查看器进行判断处理，因为改进版查看器只支持IE8以下（不包含IE8）
        var browserNameVersion = checkLowOrEqualsIE8();
        var v_dmlb = '<%=v_dmlb%>';
        var url = "<%=contextPath %>/pub/pub/pubUploadFjViewIndex?fjwid=<%=v_ajdjid%>&fjcsdmz=" + v_fjcsdmz + "&browserNameVersion=" + browserNameVersion + "&dmlb=" + v_dmlb + "&time=" + new Date().getMilliseconds();
        parent.sy.modalDialog({
            type: 2
            , title: '查看附件'
            , area: ['100%', '100%']
            , content: url
            , btn: ['关闭']
        })
    }

    //检测浏览器
    function checkBrowser() {
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
                (s = ua.match(/rv:([\d.]+)\) like gecko/)) ? Sys.ie = s[1] :
                        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
                                (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                                        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                                                (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
        if (Sys.ie) return 'IE@' + Sys.ie;
        if (Sys.firefox) return 'Firefox@' + Sys.firefox;
        if (Sys.chrome)  return 'Chrome@' + Sys.chrome;
        if (Sys.opera)  return 'Opera@' + Sys.opera;
        if (Sys.safari) return 'Safari@' + Sys.safari;
    }

    //检测浏览器是否低于等于8,是返回yes 不是返回no,如果是360浏览器兼容模式，伪造IE,也认为<=8
    function checkLowOrEqualsIE8() {
        var checkVal = checkBrowser();
        if (checkVal.indexOf("IE@") > -1) {//是IE
            //判断是否低于等于8
            var ver = checkVal.substring(checkVal.indexOf('@') + 1, checkVal.length);
            var ver_no_dot = ver.substring(0, ver.indexOf('.'));
            if (ver_no_dot <= 8)
                return 'yes';
            else
                return 'no';
        } else {//其他浏览器
            return 'no';
        }
    }

    var closeWindow = function ($dialog) {
        parent.$("#" + sy.getDialogId()).dialog("close");
    };
</script>
<body>
<div class="layui-fluid">
    <div class="content_wrap" style="width:<%=v_gridwidth%>px;height:<%=v_gridheight%>px;">
        <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
            <div class="layui-btn-group demoTable">
                <ck:permission biz="uploadPubFuJian">
                    <button class="layui-btn" data-type="uploadFuJian" data="btn_uploadFuJian">
                        <img src="<%=basePath%>/images/pub/upload.png" align="absmiddle">上传附件
                    </button>
                </ck:permission>
                <ck:permission biz="chakanPubFuJian">
                    <button class="layui-btn" data-type="chakanFuJian" data="btn_chakanFuJian">
                        <img src="<%=basePath%>/images/pub/view.gif" align="absmiddle">查看附件
                    </button>
                </ck:permission>
            </div>
        </fieldset>
        <table class="layui-hide" overflow-y="scroll" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>
