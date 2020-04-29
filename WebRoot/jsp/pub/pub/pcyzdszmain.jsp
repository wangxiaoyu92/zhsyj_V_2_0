<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
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
    <title>常用字段设置</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);

        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var table;
        var layer;
        var mask;
        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                //主表
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#gridmain'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/pub/pub/queryPcyzdszmain'
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
                        {field: 'tabname', width: 300, title: '表名称', event: 'trclick1'}
                        , {field: 'colname', width: 200, title: '列名称', event: 'trclick1'}
                        , {field: 'tabnamedesc', width: 200, title: '表描述', event: 'trclick1'}
                        , {field: 'colnamedesc', width: 200, title: '列描述', event: 'trclick1'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData1 = '';
                        selectTableDataId1 = '';
                        layer.close(mask);
                    }
                });

                // 主表监听工具条
                table.on('tool(gridmain)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick1') { // 选中行
                        if (selectTableDataId1 != data.pcyzdszmainid) {
                            // 清除所有行的样式
                            $($("#gridmain").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#gridmain").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.pcyzdszmainid;
                            myquery(data.pcyzdszmainid);
                        } else { // 再次选中清除样式
                            $("#gridmain").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    }
                });
                //明细表
                table.render({
                    elem: '#griddetail'
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
                        {
                            field: 'aae140', width: 150, title: '大类', event: 'trclick2'
                            , templet: function (d) {
                            return formatGridColData(v_aae140, d.aae140);
//                            for (var i = 0; i < v_aae140.length; i++) {
//                                if (d.aae140 == v_aae140[i].id) {
//                                    return v_aae140[i].text;
//                                }
//                            }
                        }
                        }
                        , {field: 'avalue', width: 200, title: '值', event: 'trclick2'}
                    ]]

                });
                // 明细表监听工具条
                table.on('tool(griddetail)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.pcyzdszdetailid) {
                            $($("#griddetail").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#griddetail").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            // 清除所有行的样式
                            table.singleData2 = data;
                            selectTableDataId2 = data.pcyzdszdetailid;
                        } else { // 再次选中清除样式
                            $("#griddetail").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    //主表
                    addMain: function () { // 添加
                        addMain();
                    }
                    , updateMain: function () { // 修改
                        if (!table.singleData1) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateMain(table.singleData1.pcyzdszmainid);
                        }
                    }
                    , delMain: function () { // 删除
                        if (!table.singleData1) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delMain(table.singleData1.pcyzdszmainid);
                        }
                    }
                    //明细表
                    , addDetail: function () { // 添加
                        if (!table.singleData1) {
                            layer.alert('请选择主表信息！');
                        } else {
                            addDetail(table.singleData1.pcyzdszmainid);
                        }

                    }
                    , updateDetail: function () { // 修改
                        if (!table.singleData2) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateDetail(table.singleData2.pcyzdszdetailid);
                        }
                    }
                    , delDetail: function () { // 删除
                        if (!table.singleData2) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delDetail(table.singleData2.pcyzdszdetailid);
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
                    pcyzdszmainid: pcyzdszmainid
                };
                var url = basePath + '/pub/pub/queryPcyzdszdetail';
                $.post(url, param, function (result) {
                    if (result.code == '0') {
                        table.reload('griddetail', {
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
        var addMain = function () {
            var url = '<%=basePath%>pub/pub/pcyzdszMainAddIndex';
            sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        };

        // 主表编辑
        function updateMain(pcyzdszmainid) {
            var url = '<%=basePath%>pub/pub/pcyzdszMainAddIndex';
            sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    pcyzdszmainid: pcyzdszmainid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        }

        // 主表删除
        function delMain(pcyzdszmainid) {
            layer.open({
                title: '警告!'
                , icon: '3'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + '/pub/pub/delPcyzdszMain', {
                            pcyzdszmainid: pcyzdszmainid
                        },
                        function (result) {
                            if (result.code == '0') {
                                //保证不会重复删除
                                table.singleData1 = '';
                                selectTableDataId1 = '';
                                selectTableDataId2 = '';
                                //本页的值
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.gridmain.length == 1) {
                                        curent = curent - 1;
                                    }
                                    refresh('', curent);
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
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                refresh('', '');
            }
        }
        // 明细表新增
        function addDetail(pcyzdszmainid) {
            var url = '<%=basePath%>pub/pub/pcyzdszAddIndex';
            sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    pcyzdszmainid: pcyzdszmainid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }

        // 明细表编辑
        function updateDetail(pcyzdszdetailid) {
            var url = '<%=basePath%>pub/pub/pcyzdszAddIndex';
            sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    pcyzdszdetailid: pcyzdszdetailid,
                    op: 'edit'
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }

        // 明细表删除
        function delDetail(pcyzdszdetailid) {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + '/pub/pub/delPcyzdsz', {
                            pcyzdszdetailid: pcyzdszdetailid
                        },
                        function (result) {
                            if (result.code == '0') {
                                table.singleData2 = '';
                                selectTableDataId2 = '';
                                //本页的值
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    if (table.cache.griddetail.length == 1) {
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
            table.reload('gridmain', {
                url: basePath + '/pub/pub/queryPcyzdszmain'
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
            table.reload('griddetail', {data: null});
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
                        <ck:permission biz="addMain">
                            <button class="layui-btn" data-type="addMain" data="btn_addMain">增加
                            </button>
                        </ck:permission>
                        <ck:permission biz="updateMain">
                            <button class="layui-btn" data-type="updateMain" data="btn_updateMain">修改
                            </button>
                        </ck:permission>
                        <ck:permission biz="delMain">
                            <button class="layui-btn layui-btn-danger" data-type="delMain" data="btn_delMain">删除
                            </button>
                        </ck:permission>
                    </div>
                    <table class="layui-hide" id="gridmain" lay-filter="gridmain"></table>
                </div>
            </div>
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">明细表</h2>
                <div class="layui-colla-content layui-show">
                    <div class="layui-margin-top-15">
                        <div class="layui-btn-group demoTable" id="toolbar">
                            <ck:permission biz="addCyzdszDetail">
                                <button class="layui-btn" data-type="addDetail" data="btn_addDetail">增加
                                </button>
                            </ck:permission>
                            <ck:permission biz="updateDetail">
                                <button class="layui-btn" data-type="updateDetail" data="btn_updateDetail">修改
                                </button>
                            </ck:permission>
                            <ck:permission biz="delDetail">
                                <button class="layui-btn layui-btn-danger" data-type="delDetail" data="btn_delDetail">删除
                                </button>
                            </ck:permission>
                        </div>
                        <table class="layui-hide" id="griddetail" lay-filter="griddetail"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>