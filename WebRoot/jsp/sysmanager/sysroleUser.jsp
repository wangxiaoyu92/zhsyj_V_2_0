<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String roleid = StringHelper.showNull2Empty(request.getParameter("roleid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>角色绑定用户</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var layer;
        var element;
        var table; //
        var form;
        var roleid = '<%=roleid%>';
        var orgid = "";
        var username = "";
        var userkind_v = "";
        var mask1;
        var mask2;
        // 用户类别
        var cb_userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;

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

        //初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#orgTree"), setting);
        }
        // 数据过滤
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            orgid = treeNode.orgid;
            username = $('#username').val();
            userkind_v = $('#userkind').val();
            querySysroleNoUser();

        }
        //查询角色未绑定的用户
        function querySysroleNoUser() {
            mask1 = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('bindableTable', {
                url: basePath + 'sysmanager/sysrole/querySysroleNoUser'
                ,loading:true
                , where: {
                    'roleid': roleid,
                    'orgid': orgid,
                    'username': username,
                    'userkind': userkind_v
                } //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    layer.close(mask1);
                    querySysroleUser();
                }
            });
        }
        $(function () {
            refreshZTree();
            initData();
        });

        //查询角色已绑定的用户
        function querySysroleUser() {
            mask2 = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('bindedTable', {
                url: basePath + 'sysmanager/sysrole/querySysroleUser'
                ,loading:true
                ,page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    'roleid': roleid,
                    'orgid': orgid,
                    'username': username,
                    'userkind': userkind_v
                } //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    layer.close(mask2);
                }
            });
        }
        function initData() {
            // 初始化下拉框数据
            intSelectData('userkind',cb_userkind);
            layui.use(['layer', 'form', 'table', 'element'], function () {
                layer = layui.layer;
                element = layui.element;
                form = layui.form;
                table = layui.table;
                // 初始化用户表
                table.render({
                    elem: '#bindableTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , height: 300 // 容器高度
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
                        , {field: 'userid', width: 200, title: '用户ID'}
                        , {field: 'username', width: 150, title: '用户名'}
                        , {field: 'description', width: 150, title: '用户描述'}
                        , {
                            field: 'userkind', width: 200, title: '用户类别'
                            , templet: function (d) {
                                return  formatGridColData(cb_userkind,d.userkind);
                            }
                        }
                        , {field: 'orgname', width: 200, title: '所属机构'}
                    ]]

                });
                // 初始化用户角色关系表
                table.render({
                    elem: '#bindedTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , height: 300 // 容器高度
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
                        , {field: 'userid', width: 200, title: '用户ID'}
                        , {field: 'username', width: 150, title: '用户名'}
                        , {field: 'description', width: 150, title: '用户描述'}
                        , {
                            field: 'userkind', width: 200, title: '用户类别'
                            , templet: function (d) {
                                var userkind = d.id;
                                $.each(cb_userkind, function (i, n) {
                                    if (d.userkind == n.id) {
                                        userkind = n.text;
                                        return false; // 结束本次循环
                                    }
                                });
                                return userkind;
                            }
                        }
                        , {field: 'orgname', width: 200, title: '所属机构'}
                    ]]

                });
            });
        }

        // 角色绑定用户(多选)
        function addSysuserRole() {
            var checkStatus = table.checkStatus('bindableTable');
            var data = checkStatus.data;
            if (data.length > 0) {
                var JsonStr = $.toJSON(data);
                var param = {
                    'JsonStr': JsonStr,
                    'roleid': roleid
                };
                $.post(basePath + 'sysmanager/sysrole/addSysuserRole', param, function (result) {
                    if (result.code == '0') {
                        layer.msg('操作成功', {time: 1000}, function () {
                            querySysroleNoUser();
                            querySysroleUser();
                        });
                    } else {
                        layer.open({
                            type: 4,
                            content: "操作失败：" + result.msg //这里content是一个普通的String
                        });
                    }
                }, 'json');
            } else {
                layer.msg('请先选择要绑定的用户！', {icon: 5});
                return;
            }
        }

        // 角色解除绑定用户(多选)
        function delSysuserRole() {
            var checkStatus = table.checkStatus('bindedTable');
            var data = checkStatus.data;
            if (data.length > 0) {
                var JsonStr = $.toJSON(data);
                var param = {
                    'JsonStr': JsonStr,
                    'roleid': roleid
                };
                $.post(basePath + 'sysmanager/sysrole/delSysuserRole', param, function (result) {
                    if (result.code == '0') {
                        layer.msg('操作成功', {time: 1000}, function () {
                            querySysroleNoUser();
                            querySysroleUser();
                        });
                    } else {
                        layer.open({
                            type: 4,
                            content: "操作失败：" + result.msg //这里content是一个普通的String
                        });
                    }
                }, 'json');
            } else {
                layer.msg('请先选择要解绑的用户！', {icon: 5});
                return;
            }
        }
    </script>
</head>
<body class="layui-layout-body">

<div class="layui-side layui-bg-gray" style="width: 251px;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: 140px">
                <form class="layui-form" id="myqueryform">
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名称</label>

                        <div class="layui-input-inline" style="width: 218px">
                            <input type="text" id="username" name="username" placeholder="请输入用户名称"
                                   class="layui-input">
                        </div>
                        <label class="layui-form-label">用户类别</label>

                        <div class="layui-input-inline" style="width: 218px">
                            <select name="userkind" id="userkind"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="layui-margin-top-15">
                <div class="layui-side-scroll" style="width:251px;">
                    <ul id="orgTree" class="ztree" style="height:325px"></ul>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="layui-body" style="margin-left: 55px;">
    <div class="layui-collapse">
        <div class="layui-colla-item" style="width:100%;height:50%;">
            <h6 class="layui-colla-title">角色【未绑定】用户列表</h6>

            <div class="layui-colla-content layui-show">
                <fieldset class="layui-elem-field site-demo-button"
                          style="width: 100%;border: none;padding-top: 8px;">
                    <div>
                        <ck:permission biz="addSysuserRole">
                            <button class="layui-btn layui-btn-xs" data-type="getCheckData"
                                    data="btn_addSysuserRole" onclick="addSysuserRole()">绑定用户
                            </button>
                        </ck:permission>
                    </div>
                </fieldset>
                <table class="layui-hide" id="bindableTable"></table>
            </div>
        </div>
        <div class="layui-colla-item" style="width:100%;height:50%;">
            <h2 class="layui-colla-title">角色【已绑定】用户列表</h2>

            <div class="layui-colla-content layui-show">
                <fieldset class="layui-elem-field site-demo-button"
                          style="width: 100%;border: none;padding-top: 8px;">
                    <div>
                        <ck:permission biz="delSysuserRole">
                            <button class="layui-btn layui-btn-xs" data="btn_delSysuserRole"
                                    data-type="delSysuserRole" onclick="delSysuserRole()">解除绑定
                            </button>
                        </ck:permission>
                    </div>
                </fieldset>
                <table class="layui-hide" id="bindedTable"></table>
            </div>
        </div>
    </div>
</div>
</body>
</html>