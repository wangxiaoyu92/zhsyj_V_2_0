<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String id = StringHelper.showNull2Empty(request.getParameter("cydjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测报告</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">

        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var v_jcjyshbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var v_shifoubz = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_szdw = <%=SysmanageUtil.getAa10toJsonArray("SZDW")%>;
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var table;
        var layer;
        var mask;
        var cydjid = '<%=id%>';
        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                //主表
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#hjyjczb'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryHjyjczb_zm'
                    , where: {
                        'cydjid': cydjid,
                        detectiondatatype: 1
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
                        {field: 'hviewjgztmc', width: 180, title: '监管主体名称', event: 'trclick1'}
                        , {field: 'jyjcbgbh', width: 150, title: '检验检测报告编号', event: 'trclick1'}
                        , {field: 'jcorgmc', width: 180, title: '检测机构名称', event: 'trclick1'}
                        , {field: 'jcrymc', width: 150, title: '检测人员名称', event: 'trclick1'}
                        , {
                            field: 'jcjyshbz', width: 100, title: '审核标志见'
                            , templet: function (d) {
                                return formatGridColData(v_jcjyshbz, d.jcjyshbz);
                            }, event: 'trclick1'
                        }
                        , {field: 'jsbgrq', width: 110, title: '收到报告日期', event: 'trclick1'}
                        , {field: 'bgsdrq', width: 110, title: '报告送达日期', event: 'trclick1'}
                        , {field: 'jcksrq', width: 110, title: '检测开始日期', event: 'trclick1'}
                        , {field: 'jcjsrq', width: 110, title: '检测结束日期', event: 'trclick1'}
                        , {
                            field: 'cybgsfla', width: 80, title: '是否立案',
                            templet: function (d) {
                                return formatGridColData(v_shifoubz, d.cybgsfla);
                            }, event: 'trclick1'
                        }
                        , {field: 'ajdjbh', width: 150, title: '案件登记编号', event: 'trclick1'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData1 = '';
                        selectTableDataId1 = '';
                        layer.close(mask);
                    }
                });

                // 主表监听工具条
                table.on('tool(hjyjczb)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick1') { // 选中行
                        if (selectTableDataId1 != data.hjyjczbid) {
                            // 清除所有行的样式
                            $($("#hjyjczb").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#hjyjczb").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.hjyjczbid;
                            myquery(data.hjyjczbid);
                        } else { // 再次选中清除样式
                            $("#hjyjczb").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    }
                });
                //明细表
                table.render({
                    elem: '#hjyjcmxb'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
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
                        {field: 'jcxmmc', width: 150, title: '检测项目名称', event: 'trclick2'}
                        , {field: 'jcz', width: 80, title: '检测值', event: 'trclick2'}
                        , {
                            field: 'szdw', width: 80, title: '数值单位'
                            , templet: function (d) {
                                return formatGridColData(v_szdw, d.szdw);
                            }, event: 'trclick2'
                        }
                        , {
                            field: 'jyjcjl', width: 120, title: '检验检测结论'
                            , templet: function (d) {
                                return formatGridColData(v_jyjcjl, d.jyjcjl);
                            }, event: 'trclick2'
                        }
                        , {field: 'xlbz', width: 200, title: '限量标准,执行标准号', event: 'trclick2'}
                        , {field: 'bzz', width: 80, title: '标准值', event: 'trclick2'}
                        , {field: 'jcff', width: 150, title: '检测方法', event: 'trclick2'}
                        , {field: 'yjqk', width: 100, title: '移交情况', event: 'trclick2'}
                        , {field: 'aae011', width: 110, title: '经办人', event: 'trclick2'}
                        , {field: 'aae036', width: 110, title: '经办时间', event: 'trclick2'}
                    ]]

                });
                // 明细表监听工具条
                table.on('tool(hjyjcmxb)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.hjyjcmxbid) {
                            $($("#hjyjcmxb").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#hjyjcmxb").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            // 清除所有行的样式
                            table.singleData2 = data;
                            selectTableDataId2 = data.hjyjcmxbid;
                        } else { // 再次选中清除样式
                            $("#hjyjcmxb").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    //主表
                    addHjyjczb: function () { // 添加
                        addHjyjczb();
                    }
                    , updateHjyjczb: function () { // 修改
                        if (!table.singleData1) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }
                    , delHjyjczb: function () { // 删除
                        if (!table.singleData1) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }
                    , showHjyjczb: function () { // 查看
                        if (!table.singleData1) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            showHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }
                    //明细表
                    , addHjyjcmxb: function () { // 添加
                        if (!table.singleData1) {
                            layer.alert('请选择主表信息！');
                        } else {
                            addHjyjcmxb(table.singleData1.hjyjczbid);
                        }

                    }
                    , updateHjyjcmxb: function () { // 修改
                        if (!table.singleData2) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateHjyjcmxb(table.singleData1.hjyjczbid, table.singleData2.hjyjcmxbid);
                        }
                    }
                    , delHjyjcmxb: function () { // 删除
                        if (!table.singleData2) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delHjyjcmxb(table.singleData2.hjyjcmxbid);
                        }
                    }
                    , showHjyjcmxb: function () { // 查看
                        if (!table.singleData2) {
                            layer.alert('请选择要查看的信息！');
                        } else {
                            showHjyjcmxb(table.singleData1.hjyjczbid, table.singleData2.hjyjcmxbid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        })

        // 根据主表内容查询详细表内容
        function myquery(pcyzdszmainid, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            if (pcyzdszmainid) {
                var param = {
                    hjyjczbid: pcyzdszmainid
                };
                var url = basePath + '/jyjc/queryHjyjcmxb_zm';
                $.post(url, param, function (result) {
                    if (result.code == '0') {
                        table.reload('hjyjcmxb', {
                            data: result.rows
                            , done: function () {
                                table.singleData2 = '';
                                selectTableDataId2 = '';
                                layer.close(mask);
                            }
                        });
                    }
                }, 'json');
            }
        }

        // 主表新增
        var addHjyjczb = function () {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm?op=add';
            parent.sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , param: {
                    'cydjid': cydjid
                }
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        };

        // 主表编辑
        function updateHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , cydjid: cydjid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        }

        // 主表查看
        function showHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , 'cydjid': cydjid
                    , 'op': 'view'
                }
                , btn: ['关闭']
            });
        }

        // 主表删除
        function delHjyjczb(hjyjczbid) {
            layer.open({
                title: '警告!'
                , icon: '3'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + '/jyjc/delHjyjczb_zm', {
                                hjyjczbid: hjyjczbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData1 = '';
                                    selectTableDataId1 = '';
                                    selectTableDataId2 = '';
                                    var param = {
                                        'cydjid': cydjid,
                                        detectiondatatype: 1
                                    }
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.hjyjczb.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh(param, curent);
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
        //主表子页面返回参数
        function closeModalDialogCallback1(dialogID) {
            var param = {
                'cydjid': cydjid,
                detectiondatatype: 1
            }
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                refresh(param, '');
            }
        }
        // 明细表新增
        function addHjyjcmxb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , cydjid: cydjid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }

        // 明细表编辑
        function updateHjyjcmxb(hjyjczbid, hjyjcmxbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid,
                    hjyjcmxbid: hjyjcmxbid
                    , cydjid: cydjid,
                    op: 'edit'
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }
        // 明细表编辑
        function showHjyjcmxb(hjyjczbid, hjyjcmxbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '查看'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid,
                    hjyjcmxbid: hjyjcmxbid
                    , cydjid: cydjid,
                    op: 'view'
                }
                , btn: ['关闭']
            });
        }

        // 明细表删除
        function delHjyjcmxb(hjyjcmxbid) {
            layer.open({
                title: '警告!'
                , icon: '2'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delHjyjcMxb', {
                                hjyjcmxbid: hjyjcmxbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData2 = '';
                                    selectTableDataId2 = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        if (table.cache.hjyjcmxb.length == 1) {
                                            curent = curent - 1;
                                        }
                                        myquery(selectTableDataId1, curent);
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
        //明细表子页面返回参数
        function closeModalDialogCallback2(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                myquery(selectTableDataId1, curent);
            } else {
                //saveOk 在第一页刷新
                myquery(selectTableDataId1, '');
            }
        }
        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('hjyjczb', {
                url: basePath + '/jyjc/queryHjyjczb_zm'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData1 = '';
                    selectTableDataId1 = '';
                    selectTableDataId2 = '';
                    layer.close(mask);
                }
            });
            table.reload('hjyjcmxb', {data: null});
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">主表</h2>

            <div class="layui-colla-content layui-show">
                <div class="layui-margin-top-15">
                    <div class="layui-btn-group demoTable" id="maintoolbar">
                        <ck:permission biz="addHjyjczbJcbg">
                            <button class="layui-btn" data-type="addHjyjczb" data="btn_addHjyjczb">新增
                            </button>
                        </ck:permission>
                        <ck:permission biz="updateHjyjczb">
                            <button class="layui-btn" data-type="updateHjyjczb" data="btn_updateHjyjczb">编辑
                            </button>
                        </ck:permission>
                        <ck:permission biz="delJcbgHjyjczb">
                            <button class="layui-btn layui-btn-danger" data-type="delHjyjczb" data="btn_delHjyjczb">删除
                            </button>
                        </ck:permission>
                        <ck:permission biz="showHjyjczb">
                            <button class="layui-btn" data-type="showHjyjczb" data="btn_showHjyjczb">查看
                            </button>
                        </ck:permission>
                    </div>
                    <table class="layui-hide" id="hjyjczb" lay-filter="hjyjczb"></table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">明细表</h2>

                <div class="layui-colla-content layui-show">
                    <div class="layui-margin-top-15">
                        <div class="layui-btn-group demoTable" id="toolbar">
                            <ck:permission biz="addHjyjcmxb">
                                <button class="layui-btn" data-type="addHjyjcmxb" data="btn_addHjyjcmxb">新增
                                </button>
                            </ck:permission>
                            <ck:permission biz="updateHjyjcmxb">
                                <button class="layui-btn" data-type="updateHjyjcmxb" data="btn_updateHjyjcmxb">编辑
                                </button>
                            </ck:permission>
                            <ck:permission biz="delHjyjcmxb">
                                <button class="layui-btn layui-btn-danger" data-type="delHjyjcmxb"
                                        data="btn_delHjyjcmxb">删除
                                </button>
                            </ck:permission>
                            <ck:permission biz="showHjyjcmxb">
                                <button class="layui-btn" data-type="showHjyjcmxb" data="btn_showHjyjcmxb">查看
                                </button>
                            </ck:permission>
                        </div>
                        <table class="layui-hide" id="hjyjcmxb" lay-filter="hjyjcmxb"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>