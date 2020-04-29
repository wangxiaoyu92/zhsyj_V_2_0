<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
    String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
    String v_nodename = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")), "UTF-8");
    String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
    String v_ajslrbz = StringHelper.showNull2Empty(request.getParameter("ajslrbz"));
    String v_operatetype = StringHelper.showNull2Empty(request.getParameter("operatetype"));
    String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>文书管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var layer; // 弹出层
        var selectTableDataId = '';
        var mask;
        /*var laydate;*/
        $(function () {
            layui.use(['table', 'layer'], function () {
                table = layui.table;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/pub/wsgldy/queryAjwslist'
                    , where: {
                        ajdjid: '<%=v_ajdjid%>'
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
                        {field: 'fjcsdmmc', width: 110, title: '执法文书名称', event: 'trclick'}
                        , {field: 'zfwsdmz', width: 110, title: '执法文书编号', event: 'trclick'}
                        , {field: 'zfwsycfjzs', width: 110, title: '已传附件张数', event: 'trclick'}
                        , {
                            field: 'zfwstzbz', width: 130, title: '执法文书填写标志'
                            , templet: function (d) {
                                if (d.zfwstzbz == "0")
                                    return '<span style=color:red>未填写</span>';
                                else
                                    return '<span style=color:green>已填写</span>';
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'opt', width: 251, title: '操作'
                            , templet: function (d) {
                                var v_OperRet = '<a href="javascript:uploadFuJian(\'' + d.zfwsdmz + '\')" mce_href="#"><img src="<%=basePath%>images/pub/upload.png" align="absmiddle">以附件形式上传</a>&nbsp;';
                                v_OperRet += '<a href="javascript:wenshuguanli(' + "'" + d.zfwsqtbid + "'" + ',\'' + d.zfwsurl + '\',\'' + d.zfwsdmz + '\',\'' + d.fjcsdmmc + '\',\'' + d.fjcszfwstitle + '\',\'' + d.zfwsuserid + '\',\'' + d.ajzfwsid + '\')" mce_href="#"><img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">填写文书</a>&nbsp;';
                                var v_baoqingyiyuebz = d.baoqingyiyuebz;
                                if (v_baoqingyiyuebz == '0' || v_baoqingyiyuebz == "" || v_baoqingyiyuebz == null) {
                                    v_OperRet += '<a href="javascript:baoqing(\'' + d.ajzfwsid + '\',\'' + d.fjcsdmmc + '\')" mce_href="#"><img src="<%=basePath%>images/pub/export_file.png" align="absmiddle">报请</a>&nbsp;';
                                } else {
                                    v_OperRet += '<a href="javascript:yiyue(\'' + d.ajzfwsid + '\',\'' + d.fjcsdmmc + '\')" mce_href="#"><img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">已阅</a>&nbsp;';
                                }
                                return v_OperRet;
                            }, event: 'trclick'
                        }
                        , {field: 'zfwsczyxm', width: 100, title: '操作员', event: 'trclick'}
                        , {field: 'zfwsczsj', width: 150, title: '操作时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(ZfwsFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.ajzfwsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.ajzfwsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    myselectZfws: function () {//添加文书
                        myselectZfws();
                    }
                    , delZfws: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要删除的文书！');
                        } else {
                            delZfws(table.singleData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        });

        function baoqing(v_ajzfwsid, v_fjcsdmmc) {
            var obj = new Object();
            var v_fsxtbz = "执法文书:" + v_fjcsdmmc;
            var url = "<%=basePath%>jsp/pub/pub/baoqing.jsp?time=" + new Date().getMilliseconds();
            parent.sy.modalDialog({
                title: '报请'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    opkind: 1,
                    qtbid: v_ajzfwsid,
                    fsxtbz: encodeURI(encodeURI(v_fsxtbz))
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].mysave();
                }, btn2: function () {
                    window.location.reload();
                }
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (k == null || k == '') {
                    return;
                }
                if (typeof(k.type) != "undefined" && k.type != null) {
                    if (k.type == "ok" || k.type == "") { //传递回的type为ok的时候才刷新页面。
                    }
                }
                sy.removeWinRet(dialogID);
            });
        }

        function yiyue(v_ajzfwsid, v_fjcsdmmc) {
            var obj = new Object();
            var v_fsxtbz = "执法文书:" + v_fjcsdmmc;
            var url = "<%=basePath%>jsp/pub/pub/baoqing.jsp?time=" + new Date().getMilliseconds();
            parent.sy.modalDialog({
                title: '已阅'
                , area: ['800px', '550px']
                , content: url
                , param: {
                    opkind: 1,
                    qtbid: v_ajzfwsid,
                    fsxtbz: encodeURI(encodeURI(v_fsxtbz))
                }
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (k == null || k == '') {
                    return;
                }
                if (typeof(k.type) != "undefined" && k.type != null) {
                    if (k.type == "ok" || k.type == "") { //传递回的type为ok的时候才刷新页面。
                    }
                }
                sy.removeWinRet(dialogID);
            });
        }

        //填写文书
        function wenshuguanli(v_zfwsqtbid, v_zfwsurl, v_zfwsdmz, v_fjcsdmmc, v_fjcszfwstitle, v_zfwsuserid, v_ajzfwsid) {
            var obj = new Object();
            var v_dmlb = "ZFAJZFWS";
            var v_sys_userid = '<%=v_userid%>';
            var v_canbaocun = "1";
            if (v_sys_userid != v_zfwsuserid) {
                v_canbaocun = "0";
            }
            var url = "<%=basePath%>" + v_zfwsurl + "?time=" + new Date().getMilliseconds()+"&operatetype=<%=v_operatetype%>&comid=<%=v_comid%>&resultid=<%=v_ajdjid%>";
            if (sy.IsNull(parent.sy.modalDialog) == '') {
                //创建模态窗口
                sy.modalDialog({
                    area: ['1000px', '550px'],
                    countent: url
                }, function (dialogID) {
                    /*var k = sy.getWinRet(dialogID);*/
                    sy.removeWinRet(dialogID);//不可缺少
                    /*if (k == null || k == '') {
                     return;
                     }
                     if (typeof(k.type) != "undefined" && k.type != null) {
                     if (k.type == "ok" || k.type == "") { //传递回的type为ok的时候才刷新页面。*/
                    mygrid.datagrid('reload');
                    /*    }
                     }*/
                });
            } else {
                parent.sy.modalDialog({
                    title: '文书填写'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        ajdjid: '<%=v_ajdjid%>',
                        zfwsqtbid: v_zfwsqtbid,
                        zfwsdmz: v_zfwsdmz,
                        fjcsdmmc: encodeURI(encodeURI(v_fjcsdmmc)),
                        fjcszfwstitle: v_fjcszfwstitle,
                        canbaocun: v_canbaocun,
                        ajzfwsid: v_ajzfwsid
                    }
                    , btn: ['保存', '关闭']
                    , btn1: function (index, layero) {
                        parent.window[layero.find('iframe')[0]['name']].mysave();
                    }
                        <%--, btn2: function (index, layero) {--%>
<%--//                        parent.layer.close(index);--%>
                        <%--//刷新的时候显示进度条--%>
                            <%--var mask = layer.load(1, {shade: [0.1, '#393D49']});--%>
                            <%--table.reload('table', {--%>
                                <%--url: basePath + '/pub/wsgldy/queryAjwslist',--%>
                                <%--param: {ajdjid: '<%=v_ajdjid%>'}--%>
                                <%--, done: function () {--%>
                                    <%--layer.close(mask);--%>
                                <%--}--%>
                            <%--});--%>
                        <%--&lt;%&ndash;table.reload('table', {&ndash;%&gt;--%>
                        <%--&lt;%&ndash;url: basePath + '/pub/wsgldy/queryAjwslist',&ndash;%&gt;--%>
                        <%--&lt;%&ndash;param: {ajdjid: '<%=v_ajdjid%>'}&ndash;%&gt;--%>
                        <%--&lt;%&ndash;});&ndash;%&gt;--%>
                    <%--}--%>
                }, function () {
                    var mask = layer.load(1, {shade: [0.1, '#393D49']});
                    table.reload('table', {
                        url: basePath + '/pub/wsgldy/queryAjwslist',
                        param: {ajdjid: '<%=v_ajdjid%>'}
                        , done: function () {
                            layer.close(mask);
                        }
                    });
                });
            }
        }

        //从单位信息表中读取
        function myselectZfws() {
            var url = basePath + "/pub/wsgldy/pubWsglAddIndex";
            parent.sy.modalDialog({
                title: '添加文书'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    ajdjid: '<%=v_ajdjid%>'
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);//不可缺少
            var v_fjcsdmz = "";
            if (obj == null || obj == '') {
                return;
            }
            for (var k = 0; k <= obj.length - 1; k++) {
                var myrow = obj[k];
                if (v_fjcsdmz == "") {
                    v_fjcsdmz = myrow.fjcsdmz;
                } else {
                    v_fjcsdmz = v_fjcsdmz + "," + myrow.fjcsdmz;
                }
            }

            if (v_fjcsdmz != "") {
                $.post(basePath + '/pub/wsgldy/saveZfwsadd', {
                            fjcsdmzlist: v_fjcsdmz,
                            ajdjid: '<%=v_ajdjid%>',
                            psbh: '<%=v_psbh%>',
                            nodeid: '<%=v_nodeid%>',
                            nodename: '<%=v_nodename%>'
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('新增文书成功', {time: 1000}, function () {
                                    mask = layer.load(1, {shade: [0.1, '#393D49']});
                                    table.reload('table',
                                            {
                                                url: basePath + '/pub/wsgldy/queryAjwslist',
                                                where: {ajdjid: '<%=v_ajdjid%>'}
                                                , done: function (res, curr, count) {
                                                layer.close(mask);
                                            }
                                            });
                                });
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "处理失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
            }
        }
        // 删除
        function delZfws(data) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项文书么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/pub/wsgldy/delZfws', {
                                ajzfwsid: data.ajzfwsid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 500}, function () {
                                        if (table.cache.table.length == 1) {
                                            curent = curent - 1;
                                        }
                                        mask = layer.load(1, {shade: [0.1, '#393D49']});
                                        table.reload('table', {
                                            url: basePath + '/pub/wsgldy/queryAjwslist',
                                            param: {ajdjid: '<%=v_ajdjid%>'}
                                            , page: {
                                                curr: curent //重新从第 1 页开始
                                            }
                                            , done: function (res, curr, count) {
                                                layer.close(mask);
                                            }
                                        });
                                        table.singleData = '';
                                        selectTableDataId = '';
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

        //上传附件
        function uploadFuJian(v_fjcsdmz) {
            var obj = new Object();
            var v_dmlb = "ZFAJZFWS";
            var url = "<%=basePath%>jsp/pub/pub/pubUploadFj.jsp?time=" + new Date().getMilliseconds();
            parent.sy.modalDialog({
                title: '附件管理'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    ajdjid: '<%=v_ajdjid%>',
                    dmlb: v_dmlb,
                    fjcsdmz: v_fjcsdmz
                }
                , btn: ['关闭']
                , end: function () {
                    window.location.reload();
                }
            });
        }

        //关闭方法
        var closeWindow = function ($dialog) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };
    </script>
</head>
<body>
<div class="layui-fluid">
    <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="myselectZfws">
                <button class="layui-btn" data-type="myselectZfws" data="btn_myselectZfws">选择文书</button>
            </ck:permission>
            <ck:permission biz="delZfws">
                <button class="layui-btn layui-btn-danger" data-type="delZfws" data="btn_delZfws">删除</button>
            </ck:permission>
        </div>
    </fieldset>
    <table class="layui-hide" id="table" lay-filter="ZfwsFilter"></table>
</div>
</body>
</html>