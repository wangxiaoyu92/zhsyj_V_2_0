<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
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
    Sysuser sysuser = SysmanageUtil.getSysuser();
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String v_cur_userkind = sysuser.getUserkind();
    if ("30".equals(v_cur_userkind)) {//网上送检人员
        op = "view";
    }
    //useparent 调用dialog是否前面加parent 1加0或空不加
    String useparent = StringHelper.showNull2Empty(request.getParameter("useparent"));
    if (useparent == null || "".equals(useparent)) {
        useparent = "0";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测数据录入</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var v_b_useparent = "<%=useparent%>";
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        var v_jcjyshbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var table;
        var layer;
        var mask;
        var form;
        var cydjid = '<%=id%>';
        $(function () {
            layui.use(['table', 'layer', 'form', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                form = layui.form;
                var element = layui.element;
                //主表
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                intSelectData("jcjylb", v_jcjylb);
                intSelectData("jcjyshbz", v_jcjyshbz);
                form.render();
                table.render({
                    elem: '#hjyjczb'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryHjyjczb_zm'
                    , where: {
                        cydjid: cydjid,
                        detectiondatatype: 2
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
                        {field: 'hviewjgztmc', width: 200, title: '监管主体名称', event: 'trclick1'}
                        , {field: 'jyjcbgbh', width: 200, title: '检验检测报告编号', event: 'trclick1'}
                        , {field: 'jcypmc', width: 200, title: '商品名称', event: 'trclick1'}
                        , {
                            field: 'jcjylb', width: 200, title: '检测检验类别',
                            templet: function (d) {
                                return sy.formatGridCode(v_jcjylb, d.jcjylb);
                            }, event: 'trclick1'
                        }
                        , {field: 'jcorgmc', width: 200, title: '检测机构名称', event: 'trclick1'}
                        , {field: 'jcrymc', width: 200, title: '检测人员名称', event: 'trclick1'}
                        , {field: 'fjjg', width: 200, title: '复检结果', event: 'trclick1'}
                        , {
                            field: 'jcjyshbz', width: 200, title: '审核标志',
                            templet: function (d) {
                                return sy.formatGridCode(v_jcjyshbz, d.jcjyshbz);
                            }, event: 'trclick1'
                        }
                        , {field: 'sbxh', width: 200, title: '设备型号', event: 'trclick1'}
                        , {field: 'aae011', width: 200, title: '操作员', event: 'trclick1'}
                        , {field: 'aae036', width: 200, title: '操作时间', event: 'trclick1'}
                        , {fixed: 'right', width: 180, align: 'center', toolbar: '#barDemo'}
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
//                            myquery(data.hjyjczbid);
                        } else { // 再次选中清除样式
                            $("#hjyjczb").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    } else if (obj.event === 'edit') {
                        updateHjyjczb(data.hjyjczbid);
                    } else if (obj.event === 'del') {
                        delHjyjczb(data.hjyjczbid);
                    } else if (obj.event === 'show') {
                        showHjyjczb(data.hjyjczbid);
                    }
                });
                var $ = layui.$, active = {
                    //主表
                    addHjyjczb: function () { // 添加
                        addHjyjczb();
                    }
                    , shHjyjczb: function () { // 审核
                        if (!table.singleData1) {
                            layer.alert('请选择要审核的信息！');
                        } else {
                            shHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }, hjyjczbFjsc: function () { // 附件上传
                        if (!table.singleData1) {
                            layer.alert('请选择要上传附件的信息！');
                        } else {
                            hjyjczbFjsc(table.singleData1.jcypid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            });
        });

        //检测图片上传
        function hjyjczbFjsc(jcypid) {
            sy.modalDialogLayui({
                title: '附件上传'
                , area: ['100%', '100%']
                , content: "<%=basePath%>pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjtype=9&fjwid=" + jcypid
                , btn: ['关闭']
            });
        }

        //查询
        function query() {
            var hviewjgztmc = $('#hviewjgztmc').val();
            var jcypmc = $('#jcypmc').val();
            var param = {
                'cydjid': cydjid,
                'hviewjgztmc': hviewjgztmc,
                'jcypmc': jcypmc,
                detectiondatatype: 2
            };
            refresh(param, '');
        }

        // 主表新增
        var addHjyjczb = function () {
            var url = '<%=basePath%>jyjc/jcsjlrForm?op=add';
            if (v_b_useparent == "1") {
                parent.sy.modalDialog({
                    title: '添加'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        'cydjid': cydjid
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            } else {
                sy.modalDialog({
                    title: '添加'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        'cydjid': cydjid
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            }

        };

        // 主表编辑
        function updateHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/jcsjlrForm';
            if (v_b_useparent == "1") {
                parent.sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            } else {
                sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            }
        }
        // 审核
        function shHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/jcsjlrForm';
            if (v_b_useparent == "1") {
                parent.sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                        , 'op': 'sh'
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            } else {
                sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                        , 'op': 'sh'
                    }
                    , btn: ['关闭']
                }, closeModalDialogCallback1);
            }

        }
        // 主表查看
        function showHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/jcsjlrForm';
            if (v_b_useparent == "1") {
                parent.sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                        , 'op': 'view'
                    }
                    , btn: ['关闭']
                });
            } else {
                sy.modalDialog({
                    title: '编辑'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        hjyjczbid: hjyjczbid,
                        'cydjid': cydjid
                        , 'op': 'view'
                    }
                    , btn: ['关闭']
                });
            }
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
                                hjyjczbid: hjyjczbid,
                                'cydjid': cydjid,
                                detectiondatatype: 2
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData1 = '';
                                    selectTableDataId1 = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.hjyjczb.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var param = {
                                            detectiondatatype: 2,
                                            'cydjid': cydjid
                                        };
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
                detectiondatatype: 2,
                'cydjid': cydjid
            };
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
                    layer.close(mask);
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">监管主体名称:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="hviewjgztmc" name="hviewjgztmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">商品名称：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcypmc" name="jcypmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_reset">
                                            <i class="layui-icon">&#xe621;</i>重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="layui-colla-item">
            <div class="layui-margin-top-15">
                <div class="layui-btn-group demoTable" id="maintoolbar">
                    <ck:permission biz="addHjyjczb">
                        <button class="layui-btn" data-type="addHjyjczb" data="btn_addHjyjczb">新增
                        </button>
                    </ck:permission>
                    <ck:permission biz="shHjyjczb">
                        <button class="layui-btn" data-type="shHjyjczb" data="btn_showHjyjczb">审核
                        </button>
                    </ck:permission>
                    <ck:permission biz="hjyjczbFjsc">
                        <button class="layui-btn" data-type="hjyjczbFjsc" data="btn_hjyjczbFjsc">检测图片上传
                        </button>
                    </ck:permission>
                </div>
                <table class="layui-hide" id="hjyjczb" lay-filter="hjyjczb"></table>
                <script type="text/html" id="barDemo">
                    <%if (!"view".equals(op)) {%>
                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                    <%}%>
                    <a class="layui-btn layui-btn-xs" lay-event="show">查看</a>
                </script>
            </div>
        </div>
    </div>
</div>
</body>
</html>