<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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
    <title>角色管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var selectTableDataId = '';
        var mask;
        // 机构数配置
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法
                autoParam: ["orgid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "orgid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "orgname"
                }
            },
            callback: {
                onClick: onClick
            }
        };
        $(function () {
            refreshZTree();
            initData();
        });

        // 初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + 'sysmanager/sysrole/querySysrole'
                , page: true
                , where: {'orgid': treeNode.orgid} //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysrole/querySysrole'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'roleid', title: '角色ID', event: 'trclick'}
                        , {field: 'roledesc', title: '角色描述', event: 'trclick'}
                        , {field: 'rolename', title: '角色名称', event: 'trclick'}
                        , {
                            field: 'sysroleflag', title: '系统角色标志'
                            , templet: function (d) {
                                if (d.sysroleflag == "1") {
                                    return '<span style="color:red;">系统角色</span>';
                                } else {
                                    return '非系统角色';
                                }
                            }
                            , event: 'trclick'
                        }
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.roleid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.roleid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {


                    addSysrole: function () { // 添加
                        addSysrole();
                    }
                    , updateSysrole: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的角色！');
                        } else {
                            updateSysrole(table.singleData.roleid);
                        }
                    }
                    , delSysrole: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的角色！');
                        } else {
                            delSysrole(table.singleData.roleid);
                        }
                    }
                    , bindMenu: function () { // 绑定菜单
                        if (!table.singleData) {
                            layer.alert('请选择要操作的角色！');
                        } else {
                            bindMenu(table.singleData.roleid);
                        }
                    }
                    , bindUser: function () { // 绑定用户
                        if (!table.singleData) {
                            layer.alert('请选择要操作的角色！');
                        } else {
                            bindUser(table.singleData.roleid);
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
        }
        // 搜索
        function query() {
            var rolename = $('#rolename').val();
            var roledesc = $('#roledesc').val();
            var sysroleflag = $('#sysroletype').val();
            var param = {
                'rolename': rolename,
                'roledesc': roledesc,
                'sysroleflag': sysroleflag
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + 'sysmanager/sysrole/querySysrole'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }
        // 重置
        function reload(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('roleTable', {
                url: basePath + 'sysmanager/sysrole/querySysrole'
                , page: {
                    curr: curr
                }
                , where: param
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            refreshZTree();
        }

        // 新增
        function addSysrole() {
            sy.modalDialog({
                title: '添加角色'
                , content: basePath + 'sysmanager/sysrole/sysroleFormIndex'
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                reload('', curent);
            } else {
                //saveOk 在第一页刷新
                reload('', '');
            }
        }

        // 修改
        function updateSysrole(roleid) {
            if (roleid == '0' || roleid == '1' || roleid == '2' || roleid == '3' || roleid == '4') {
                layer.msg('该角色是系统预置标准角色，不可修改！', {icon: 5});
                return;
            }
            sy.modalDialog({
                title: '修改'
                , content: basePath + 'sysmanager/sysrole/sysroleFormIndex'
                , param: {roleid: roleid, op: 'edit'}
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 删除
        function delSysrole(roleid) {
            if (roleid == '0' || roleid == '1' || roleid == '2' || roleid == '3' || roleid == '4') {
                layer.msg('该角色是系统预置标准角色，不可修改！', {icon: 5});
                return;
            }
            layer.open({
                title: '警告'
                , icon: 3
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'sysmanager/sysrole/delSysrole', {
                                roleid: roleid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.roleTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        reload('', curent);
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

        // 角色绑定菜单权限
        function bindMenu(roleid) {
            sy.modalDialog({
                title: '角色授权'
                , content: basePath + 'sysmanager/sysrole/sysroleGrantIndex'
                , param: {roleid: roleid}
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveSysroleGrant();
                }
            });
        }

        // 角色绑定用户
        function bindUser(roleid) {
            sy.modalDialog({
                title: '绑定用户'
                , content: basePath + 'sysmanager/sysrole/sysroleUserIndex'
                , param: {roleid: roleid}
                , area: ['100%', '100%']
            });
        }
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="padding-left: 55px; width: 83%;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-fluid">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">角色名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="rolename" name="rolename"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">角色描述</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="roledesc" name="roledesc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">角色类型</label>

                                    <div class="layui-input-inline">
                                        <select name="sysroletype" id="sysroletype">
                                            <option value="">===请选择===</option>
                                            <option value="0">非系统角色</option>
                                            <option value="1">系统角色</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <ck:permission biz="querySysrole">
                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                    lay-submit="" data="btn_querySysrole">
                                                <i class="layui-icon">&#xe615;</i>搜索
                                            </button>
                                        </ck:permission>
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
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addSysrole">
                <button class="layui-btn" data-type="addSysrole" data="btn_addSysrole">
                    增加
                </button>
            </ck:permission>
            <ck:permission biz="updateSysrole">
                <button class="layui-btn" data-type="updateSysrole"
                        data="btn_updateSysrole">修改
                </button>
            </ck:permission>
            <ck:permission biz="delSysrole">
                <button class="layui-btn layui-btn-danger" data-type="delSysrole"
                        data="btn_delSysrole">删除
                </button>
            </ck:permission>
            <ck:permission biz="bindUser">
                <button class="layui-btn" data-type="bindUser" data="btn_bindUser">
                    绑定用户
                </button>
            </ck:permission>
            <ck:permission biz="bindMenu">
                <button class="layui-btn" data-type="bindMenu" data="btn_bindMenu">
                    绑定菜单
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="roleTable" lay-filter="tableFilter" style="width: auto"></table>
    </div>
</div>
</body>
</html>