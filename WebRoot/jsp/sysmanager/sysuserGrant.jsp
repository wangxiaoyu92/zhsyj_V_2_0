<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.Sys" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_userid = StringHelper.showNull2Empty(request.getParameter("userid"));
    Sysuser vSysUser=(Sysuser) SysmanageUtil.getSysuser();//获取当前用户
    String v_cur_userkind=vSysUser.getUserkind();
    System.out.println("v_cur_userkind v_cur_userkind "+v_cur_userkind);
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户授权管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var authorizableTableData = []; // 可授权角色列表当前页数据
        var authorizedTableData = []; // 已授权角色列表数据
        var authorizableDlTableData = []; // 可授权大类列表当前页数据 TODO
        var authorizedDlTableData = []; // 已授权大类列表数据
        var userid = '<%=v_userid%>'
        $(function () {
            initData(); // 初始化表格数据
            initUserAaa027GrantZTree(); // 初始化行政区划树
            initUserOrgGrantZTree();// 初始化机构授权树
        });
        function initData() {
            // 获取已授权角色列表数据
           /* $.post(basePath + 'sysmanager/sysuser/querySysuserRole', {userid: $("#userid").val()}, function (result) {
                if (result.code == '0') {
                    authorizedTableData = result.rows;
                }
            }, 'json');*/
          /*  // 获取已授权大类列表数据
            $.post(basePath + 'sysmanager/sysuser/querySysuserAae140', {userid: userid}, function (result) {
                if (result.code == '0') {
                    authorizedDlTableData = result.rows;
                }
            }, 'json');*/
            $.ajax({
                type:'POST',
                url:basePath + 'sysmanager/sysuser/querySysuserRole',
                dataType:'json',
                data:{ userid:$("#userid").val()},
                async:false,
                success:function(result){
                    authorizedTableData = result.rows;
                }
            });
            $.ajax({
                type:'POST',
                url:basePath + 'sysmanager/sysuser/querySysuserAae140',
                dataType:'json',
                data:{ userid:$("#userid").val()},
                async:false,
                success:function(result){
                    authorizedDlTableData = result.rows;
                }
            });
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                // 可授权角色列表
                table.render({
                    elem: '#authorizableTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , height: 358 // 容器高度
                    , url: basePath + '/sysmanager/sysuser/querySysuserNoRole'
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
                        {checkbox: true}
                        , {field: 'roleid', title: '角色ID'}
                        , {field: 'rolename', title: '角色名称'}
                        , {field: 'roledesc', title: '角色描述'}
                    ]]
                   , done: function (res, curr, count) {
                        authorizableTableData = res.rows;
                    }
                });
                // 已授权角色列表
                table.render({
                    elem: '#authorizedTable'
                    , data: authorizedTableData
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , limit: 1000
                    , page: false // 展示分页
                    , height: 358 // 容器高度
                    , cols: [[
                        {checkbox: true}
                        , {field: 'roleid', title: '角色ID'}
                        , {field: 'rolename', title: '角色名称'}
                        , {field: 'roledesc', title: '角色描述'}
                    ]]
                });
                // 可授权企业大类列表
                table.render({
                    elem: '#authorizableDlTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , height: '320;overflow:visible' // 容器高度 设置非隐藏项（暂时）
                    , cellMinWidth: 205
                    , url: basePath + 'sysmanager/sysuser/querySysuserNoAae140',
                    where: {
                        userid: userid
                    }
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
                        {checkbox: true}
                        , {field: 'aae140', title: '大类代码'}
                        , {field: 'aae140name', title: '大类名称'}
                    ]]
                    , done: function (res, curr, count) {
                        authorizableDlTableData = res.rows;
                    }
                });
                // 已授权大类列表
                table.render({
                    elem: '#authorizedDlTable'
                    , data: authorizedDlTableData
                    , limit: 1000
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: false // 展示分页
                    , height: 358 // 容器高度
                    , cellMinWidth: 205
                    , cols: [[
                        {checkbox: true}
                        , {field: 'aae140', title: '大类代码'}
                        , {field: 'aae140name', title: '大类名称'}
                    ]]
                });
            });
        }
        // 选中当前所在页角色数据赋值
        function allRolesGrant() {
            var loadData = authorizedTableData.concat(authorizableTableData); // 要加载的数据
            // 选中数据与已绑定数据比较，已有的不添加
            for (var i = 0; i < authorizableTableData.length; i++) {
                for (var j = 0; j < authorizedTableData.length; j++) {
                    if (authorizableTableData[i].roleid == authorizedTableData[j].roleid) {
                        loadData.remove(authorizableTableData[i]); // 去除重复的数据
                    }
                }
            }
            authorizedTableData = loadData;
            table.reload('authorizedTable', {data: loadData});
        }
        // 选中所选角色数据赋值
        function selectRolesGrant() {
            var checkStatus = table.checkStatus('authorizableTable')
                    , data = checkStatus.data;
            if (data.length == 0) {
                layer.msg('您未选中任何数据！', {icon: 5});
                return;
            }
            var loadData = data.concat(authorizedTableData); // 要加载的数据
            // 选中数据与已绑定数据比较，已有的不添加
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < authorizedTableData.length; j++) {
                    if (data[i].roleid == authorizedTableData[j].roleid) {
                        loadData.remove(data[i]); // 去除重复的数据
                    }
                }
            }
            authorizedTableData = loadData;
            table.reload('authorizedTable', {data: loadData});
        }
        // 选中所选角色数据取消赋值
        function selectRolesUnGrant() {
            var checkStatus = table.checkStatus('authorizedTable')
                    , data = checkStatus.data;
            if (data.length == 0) {
                layer.msg('您未选中任何数据！', {icon: 5});
                return;
            }
            // 去除选中数据
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < authorizedTableData.length; j++) {
                    if (data[i].roleid == authorizedTableData[j].roleid) {
                        authorizedTableData.remove(authorizedTableData[j]);
                    }
                }
            }
            table.reload('authorizedTable', {data: authorizedTableData});
        }
        // 当前页所有角色数据取消赋值
        function allRolesUnGrant() {
            authorizedTableData = [];
            table.reload('authorizedTable', {data: authorizedTableData});
        }
        // 保存角色授权
        function saveSysuserRole() {
            var JsonStr = $.toJSON(authorizedTableData);
            var param = {
                'JsonStr': JsonStr,
                'userid': $("#userid").val()
            };
            $.post(basePath + 'sysmanager/sysuser/saveSysuserRole', param, function (result) {
                if (result.code == '0') {
                    layer.msg('用户角色授权成功!', {time: 500}, function () {
                        table.reload('authorizedTable', {data: authorizedTableData});
                    });
                } else {
                    layer.open({
                        title: "提示",
                        content: "用户角色授权失败：" + result.msg
                    });
                }
            }, 'json');
        }
        // 选中当前所在页大类数据赋值
        function allDlGrant() {
            var loadData = authorizedDlTableData.concat(authorizableDlTableData); // 要加载的数据
            // 选中数据与已绑定数据比较，已有的不添加
            for (var i = 0; i < authorizableDlTableData.length; i++) {
                for (var j = 0; j < authorizedDlTableData.length; j++) {
                    if (authorizableDlTableData[i].aae140 == authorizedDlTableData[j].aae140) {
                        loadData.remove(authorizableDlTableData[i]); // 去除重复的数据
                    }
                }
            }
            authorizedDlTableData = loadData;
            table.reload('authorizedDlTable', {data: loadData});
        }
        // 选中所选大类数据赋值
        function selectDlGrant() {
            var checkStatus = table.checkStatus('authorizableDlTable')
                    , data = checkStatus.data;
            if (data.length == 0) {
                layer.msg('您未选中任何数据！', {icon: 5});
                return;
            }
            var loadData = data.concat(authorizedDlTableData); // 要加载的数据
            // 选中数据与已绑定数据比较，已有的不添加
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < authorizedDlTableData.length; j++) {
                    if (data[i].aae140 == authorizedDlTableData[j].aae140) {
                        loadData.remove(data[i]); // 去除重复的数据
                    }
                }
            }
            authorizedDlTableData = loadData;
            table.reload('authorizedDlTable', {data: loadData});
        }
        // 选中所选大类数据取消赋值
        function selectDlUnGrant() {
            var checkStatus = table.checkStatus('authorizedDlTable')
                    , data = checkStatus.data;
            if (data.length == 0) {
                layer.msg('您未选中任何数据！', {icon: 5});
                return;
            }
            // 去除选中数据
            for (var i = 0; i < data.length; i++) {
                for (var j = 0; j < authorizedDlTableData.length; j++) {
                    if (data[i].aae140 == authorizedDlTableData[j].aae140) {
                        authorizedDlTableData.remove(authorizedDlTableData[j]);
                    }
                }
            }
            table.reload('authorizedDlTable', {data: authorizedDlTableData});
        }
        // 当前页所有大类数据取消赋值
        function allDlUnGrant() {
            authorizedDlTableData = [];
            table.reload('authorizedDlTable', {data: authorizedDlTableData});
        }
        // 保存企业大类授权
        function saveSysuserAae140() {
            var JsonStr = $.toJSON(authorizedDlTableData);
            var param = {
                'JsonStr': JsonStr,
                'userid': $("#userid").val()
            };
            $.post(basePath + 'sysmanager/sysuser/saveSysuserAae140', param, function (result) {
                if (result.code == '0') {
                    layer.msg('用户大类授权成功!', {time: 500}, function () {
                        table.reload('authorizedDlTable', {data: authorizedDlTableData});
                        var param = {
                            userid: userid
                        };
                        table.reload('authorizableDlTable', {
                            url: basePath + 'sysmanager/sysuser/querySysuserNoAae140',
                            param: param
                        });
                    });
                } else {
                    layer.open({
                        title: "提示",
                        content: "用户大类授权失败：" + result.msg
                    });
                }
            }, 'json');
        }
        // 行政区划树配置
        var settingaaa027 = {
            view: {
                showLine: true
            },
            check: {
                enable: true,
                chkboxType: {"Y": "s", "N": "s"}
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "aaa027",
                    pIdKey: "aaa148",
                    rootPId: null
                },
                key: {
                    name: "aaa129"
                }
            },
            callback: {
                onCheck: onCheckaaa027
            }

        };
        // 勾选或不勾选事件	(行政区划树)
        function onCheckaaa027(event, treeId, treeNode) {
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");
            var nodes = treeObj.getCheckedNodes(true);
            var param = "";
            for (var i = 0; i < nodes.length; i++) {
                param = param + "aaa027=" + nodes[i].aaa027 + "&";
            }
            $('#aaa027treeCheckedNodes').val(param);
        }
        // 初始化【统筹区授权】树
        function initUserAaa027GrantZTree() {
            $.ajax({
                url: basePath + 'sysmanager/sysuser/querySysuserAaa027ZTree',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: '',
                dataType: 'json',
                error: function () {
                    layer.open({
                        title: "提示",
                        content: '服务器繁忙，请稍后再试！'
                    });
                },
                success: function (result) {
                    if (result.code == '0') {
                        //准备zTree数据
                        var zNodesaaa027 = eval(result.aaa027Data);
                        $.fn.zTree.init($("#treeDemo_userAaa027Grant"), settingaaa027, zNodesaaa027);
                        initUserAaa027CheckedZTreeNodes();// 初始化行政区划树选中状态
                    } else {
                        layer.open({
                            title: "提示",
                            content: result.msg
                        });
                    }
                }
            });
        }
        // 初始化原来权限节点的选中状态
        function initUserAaa027CheckedZTreeNodes() {
            var userid = $("#userid").val();
            var aaa027treeObj = $.fn.zTree.getZTreeObj("treeDemo_userAaa027Grant");
            aaa027treeObj.checkAllNodes(false);
            $.ajax({
                url: basePath + 'sysmanager/sysuser/querySysuserHaveAaa027Grant',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: 'userid=' + userid,
                dataType: 'json',
                error: function () {
                    layer.open({
                        title: "提示",
                        content: "服务器繁忙，请稍后再试！"
                    });
                },
                success: function (result) {
                    if (null != result && "[]" != result) {
                        $.each(result.rows, function (i, item) { //得到节点，并选中
                            var node = aaa027treeObj.getNodeByParam("aaa027", item.aaa027, null);
                            if (null != node) {
                                aaa027treeObj.checkNode(node, true, false, true);
                            }
                        });
                    }
                }
            });
        }
        // 保存行政区划授权
        function saveSysuserAaa027Grant() {
            var userid = $("#userid").val();
            var param = $('#aaa027treeCheckedNodes').val();
            param = param + "userid=" + userid;
            $.post(basePath + '/sysmanager/sysuser/saveSysuserAaa027Grant', param, function (result) {
                if (result.code == '0') {
                    layer.msg('行政区划授权成功!', {time: 500}, function () {
                    });
                } else {
                    layer.open({
                        title: "提示",
                        content: "行政区划授权失败：" + result.msg
                    });
                }
            }, 'json');
        }
        // 行政机构树配置信息
        var settingUserOrg = {
            view: {
                showLine: true
            },
            check: {
                enable: true,
                chkboxType: {"Y": "s", "N": "s"}
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "orgid",
                    pIdKey: "parent",
                    rootPId: null
                },
                key: {
                    name: "orgname"
                }
            },
            callback: {
                onCheck: onCheckUserOrg
            }
        };
        //勾选或不勾选事件
        function onCheckUserOrg(event, treeId, treeNode) {
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo_userOrgGrant");
            var nodes = treeObj.getCheckedNodes(true);
            var param = "";
            for (var i = 0; i < nodes.length; i++) {
                param = param + "orgid=" + nodes[i].orgid + "&";
            }
            $('#userOrgtreeCheckedNodes').val(param);
        }
        // 初始化【机构授权】树
        function initUserOrgGrantZTree() {
            $.ajax({
                url: basePath + 'sysmanager/sysuser/querySysuserOrgZTree',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: '',
                dataType: 'json',
                error: function () {
                    layer.open({
                        title: "提示",
                        content: "服务器繁忙，请稍后再试！"
                    });
                },
                success: function (result) {
                    if (result.code == '0') {
                        //准备zTree数据
                        var zNodesOrg = eval(result.orgData);
                        $.fn.zTree.init($("#treeDemo_userOrgGrant"), settingUserOrg, zNodesOrg);
                        initUserOrgCheckedZTreeNodes(); // 初始化选中节点
                    } else {
                        layer.open({
                            title: "提示",
                            content: result.msg
                        });
                    }
                }
            });
        }
        // 初始化原来权限节点的选中状态
        function initUserOrgCheckedZTreeNodes() {
            var userid = $("#userid").val();
            var userorgtreeObj = $.fn.zTree.getZTreeObj("treeDemo_userOrgGrant");
            userorgtreeObj.checkAllNodes(false);
            $.ajax({
                url: basePath + 'sysmanager/sysuser/querySysuserHaveOrgGrant',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: 'userid=' + userid,
                dataType: 'json',
                error: function () {
                    layer.open({
                        title: "提示",
                        content: "服务器繁忙，请稍后再试！"
                    });
                },
                success: function (result) {
                    if (null != result && "[]" != result) {
                        $.each(result.rows, function (i, item) { //得到节点，并选中
                            var node = userorgtreeObj.getNodeByParam("orgid", item.orgid, null);
                            if (null != node) {
                                userorgtreeObj.checkNode(node, true, false, true);
                            }
                        });
                    }
                }
            });
        }
        // 保存机构授权
        function saveSysuserOrgGrant() {
            var userid = $("#userid").val();
            var param = $('#userOrgtreeCheckedNodes').val();
            param = param + "userid=" + userid;
            $.post(basePath + '/sysmanager/sysuser/saveSysuserOrgGrant', param, function (result) {
                if (result.code == '0') {
                    layer.msg('机构授权成功!', {time: 500}, function () {
                    });
                } else {
                    layer.open({
                        title: "提示",
                        content: '机构授权失败：' + result.msg
                    });
                }
            }, 'json');
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div class="layui-container">
    <input type="hidden" id="userid" name="userid" value="<%=v_userid%>">

    <div class="layui-tab layui-tab-card" style="width: 100%">
        <ul class="layui-tab-title">
            <li class="layui-this">角色授权</li>
            <%
                if (!"6".equals(v_cur_userkind) && !"7".equals(v_cur_userkind) &&  !"8".equals(v_cur_userkind) &&  !"20".equals(v_cur_userkind) && !"21".equals(v_cur_userkind) && !"30".equals(v_cur_userkind)){
            %>
            <li>企业大类授权</li>
            <li>行政区划授权</li>
            <li>机构授权</li>
            <%}%>
        </ul>
        <div class="layui-tab-content">
            <%-- 角色授权 --%>
            <div class="layui-tab-item layui-show" style="width: auto;height: auto">

                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs5 layui-col-sm5">
                        <div class="grid-demo">
                            <table class="layui-hide" id="authorizableTable"></table>
                        </div>
                    </div>
                    <div class="layui-col-md1 layui-col-xs1 layui-col-sm1">
                        <div class="grid-demo">
                            <div style="margin-left: 20%;margin-top: 50px">
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="allRolesGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe65b;</i>全右
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="selectRolesGrant()"
                                            class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe602;</i>单右
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="selectRolesUnGrant()"
                                            class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe603;</i>单左
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="allRolesUnGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe65a;</i>全左
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md5 layui-col-xs5 layui-col-sm5">
                        <div class="grid-demo">
                            <table class="layui-hide" id="authorizedTable"></table>
                        </div>
                    </div>
                    <div class="layui-form-item" style="margin-left: 70%">
                        <ck:permission biz="saveSysuserRole">
                            <button onclick="saveSysuserRole()" data="btn_saveSysuserRole"
                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe605;</i>保存角色授权
                            </button>
                        </ck:permission>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="closeWindow()">
                            <i class="layui-icon">&#x1006;</i>取消
                        </button>
                    </div>
                </div>
            </div>
                <%
                    if (!"6".equals(v_cur_userkind) && !"7".equals(v_cur_userkind) &&  !"8".equals(v_cur_userkind) &&  !"20".equals(v_cur_userkind) && !"21".equals(v_cur_userkind) && !"30".equals(v_cur_userkind)){
                %>
            <div class="layui-tab-item">
                <%-- 企业大类授权 --%>
                <div class="layui-row">
                    <div class="layui-col-md5 layui-col-xs5 layui-col-sm5">
                        <div class="grid-demo">
                            <table class="layui-hide" id="authorizableDlTable"></table>
                        </div>
                    </div>
                    <div class="layui-col-md1 layui-col-xs1 layui-col-sm1">
                        <div class="grid-demo">
                            <div style="margin-left: 20%;margin-top: 50px">
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="allDlGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe65b;</i>全右
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="selectDlGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe602;</i>单右
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="selectDlUnGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe603;</i>单左
                                    </button>
                                </div>
                                <div class="layui-form-item" style="height: 50px">
                                    <button onclick="allDlUnGrant()" class="layui-btn layui-btn-sm layui-btn-normal">
                                        <i class="layui-icon">&#xe65a;</i>全左
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md5 layui-col-xs5 layui-col-sm5">
                        <div class="grid-demo">
                            <table class="layui-hide" id="authorizedDlTable"></table>
                        </div>
                    </div>

                    <div class="layui-form-item" style="margin-left: 70%">
                        <ck:permission biz="saveSysuserAae140">
                            <button onclick="saveSysuserAae140()" data="btn_saveSysuserAae140"
                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe605;</i>保存大类授权
                            </button>
                        </ck:permission>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="closeWindow()">
                            <i class="layui-icon">&#x1006;</i>取消
                        </button>
                    </div>
                </div>
            </div>
            <div class="layui-tab-item">
                <%-- 行政区划授权--%>
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                        <div class="grid-demo">
                            <div style="overflow: hidden; height:378px;">
                                <ul id="treeDemo_userAaa027Grant" class="ztree"></ul>
                                <input type="hidden" id="aaa027treeCheckedNodes">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item" style="margin-left: 70%">
                        <ck:permission biz="saveSysuserAaa027Grant">
                            <button onclick="saveSysuserAaa027Grant()" data="btn_saveSysuserAaa027Grant"
                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe605;</i>保存行政区划授权
                            </button>
                        </ck:permission>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="closeWindow()">
                            <i class="layui-icon">&#x1006;</i>取消
                        </button>
                    </div>
                </div>
            </div>
            <div class="layui-tab-item">
                <%-- 组织机构授权--%>
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                        <div class="grid-demo">
                            <div style="height:378px;overflow: hidden;">
                                <ul id="treeDemo_userOrgGrant" class="ztree"></ul>
                                <input type="hidden" id="userOrgtreeCheckedNodes">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item" style="margin-left: 70%">
                        <ck:permission biz="saveSysuserOrgGrant">
                            <button onclick="saveSysuserOrgGrant()" data="btn_saveSysuserOrgGrant"
                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe605;</i>保存机构授权
                            </button>
                        </ck:permission>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="closeWindow()">
                            <i class="layui-icon">&#x1006;</i>取消
                        </button>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
</div>
</body>
</html>