<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_querykind = StringHelper.showNull2Empty(request.getParameter("querykind"));
    if (null == v_querykind || "".equalsIgnoreCase(v_querykind)) {
        v_querykind = "no";
    }

    //目前是选择企业日常监督管理人员时，传过来已经选择过的人员id列表，以逗号分隔例如2016052614593110739048580,2016052614593110739048599
    String v_useridstr = StringHelper.showNull2Empty(request.getParameter("useridstr"));

%>
<!DOCTYPE html>
<html>
<head>
    <title>选择</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsyncgw?',  //调用后台的方法
                autoParam: ["orgid"], //向后台传递的参数
                otherParam: {"querykind": "<%=v_querykind%>"}, //额外的参数 gu20161210add pubkind='all'取所有的部门
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
        });

        //初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            var param = {'orgid': treeNode.orgid};
            table.reload('table', {
                url: basePath + '/sysmanager/sysuser/querySysuser'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
        }
    </script>
    <script type="text/javascript">
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");

        //下拉框列表
        var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
        var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>;
        //下拉框列表
        var cb_userkind;
        var cb_lockstate;
        var selectTableDataId;
        var table2Data;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#table'
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
                        {type: 'checkbox'}
                        , {field: 'username', width: 100, title: '用户', event: 'trclick'}
                        , {field: 'orgname', width: 100, title: '机构名称', event: 'trclick'}
                        , {field: 'description', width: 150, title: '用户描述', event: 'trclick'}
                        , {
                            field: 'userkind', width: 150, title: '用户类别'
                            , templet: function (d) {
                                return sy.formatGridCode(userkind, d.userkind);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'mobile', width: 120, title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', width: 120, title: '手机号2', event: 'trclick'}
                        , {
                            field: 'lockstate', width: 150, title: '账户锁定状态'
                            , templet: function (d) {
                                if (d.lockstate == "1") {
                                    return '<span style="color:red;">' + sy.formatGridCode(lockstate, d.lockstate) + '</span>';
                                } else {
                                    return sy.formatGridCode(lockstate, d.lockstate);
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'aaa027name', width: 120, title: '统筹区', event: 'trclick'}
                        , {field: 'userid', width: 120, title: '用户ID', event: 'trclick'}
                    ]]
                });
                table.render({
                    elem: '#table2'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    /*,url : basePath + '/sysmanager/sysuser/querySysuser'
                     ,where:{
                     useridstr:'<%=v_useridstr%>',
                     querykind:'1'
                     }*/
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
                        {field: 'username', width: 100, title: '用户', event: 'trclick'}
                        , {field: 'orgname', width: 100, title: '机构名称', event: 'trclick'}
                        , {field: 'description', width: 150, title: '用户描述', event: 'trclick'}
                        , {
                            field: 'userkind', width: 150, title: '用户类别'
                            , templet: function (d) {
                                return sy.formatGridCode(userkind, d.userkind);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'mobile', width: 120, title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', width: 120, title: '手机号2', event: 'trclick'}
                        , {
                            field: 'lockstate', width: 150, title: '账户锁定状态'
                            , templet: function (d) {
                                if (d.lockstate == "1") {
                                    return '<span style="color:red;">' + sy.formatGridCode(lockstate, d.lockstate) + '</span>';
                                } else {
                                    return sy.formatGridCode(lockstate, d.lockstate);
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'aaa027name', width: 120, title: '统筹区', event: 'trclick'}
                        , {field: 'userid', width: 120, title: '用户ID', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(table2Filter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId1 = data.userid) {
                            // 清除所有行的样式
                            $($("#table2").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#table2").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.userid;
                        } else { // 再次选中清除样式
                            $("#table2").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                queryData();
                var $ = layui.$, active = {
                    addToSelectGrid: function () { //获取选中数据
                        var checkStatus = table.checkStatus('table')
                                , data = checkStatus.data;
                        if (data != "") {
                            addToSelectGrid(data);
                        } else {
                            layer.alert("您未选择任何数据");
                        }

                    }
                    , mydeleterow: function () {
                        if (!table.singleData) {
                            layer.alert('您未选择任何数据！');
                        } else {
                            mydeleterow(table.singleData.userid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听查询
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
                //监听重置
                $("#btn_reset").bind("click", function () {
                    reset();
                    return false;
                });
            });
        });///////////////////////////
        function queryData() {
            var url = basePath + '/sysmanager/sysuser/querySysuser'
            var param = {
                useridstr: '<%=v_useridstr%>',
                querykind: '1'
            }
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    table2Data = result.rows;
                    table.reload('table2', {data: table2Data});
                }
            }, 'json');
        }
        function reset() {
            $('#description').val('');
            $('#userjc').val('');
            var param = {
                'description': '',
                'userjc': '',
                'querykind': ''
            };
            table.reload('table', {
                url: basePath + '/sysmanager/sysuser/querySysuser'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
        }
        function query() {
            var param = {
                'description': $('#description').val(),
                'userjc': $('#userjc').val(),
                'querykind': ''
            };
            table.reload('table', {
                url: basePath + '/sysmanager/sysuser/querySysuser'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
        }
        ;
        function queding() {
            if (table2Data != null && table2Data != '') {
                var rows = table2Data;
                sy.setWinRet(rows);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请添加到选择列表！');
            }
            /*     var rows=table2Data;
             sy.setWinRet(rows);
             parent.layer.close(parent.layer.getFrameIndex(window.name));*/
        }
        ;

        function addToSelectGrid(data) {
            var selectData = data;
            var loadData = table2Data.concat(selectData); // 用当前表格数据合并返回的数据
            // 选中数据与已绑定数据比较，已有的不添加
            for (var i = 0; i < selectData.length; i++) {
                for (var j = 0; j < table2Data.length; j++) {
                    if (selectData[i].userid == table2Data[j].userid) {
                        loadData.remove(selectData[i]); // 去除重复的数据
                    }
                }
            }
            table2Data = loadData;
            table.reload('table2', {data: loadData});
        }
        ;

        function mydeleterow(userid) {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要删除该行吗?'
                , btn1: function (index, layero) {
                    var i = table2Data.length;
                    for (var j = 0; j < table2Data.length; j++) {
                        if (userid == table2Data[j].userid) {
                            table2Data.remove(table2Data[j]); // 去除数据
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                    if (table2Data.length < i) {
                        layer.msg('删除成功!', {time: 500}, function () {
                            table.reload('table2', {data: table2Data});
                        })
                    } else {
                        layer.msg('删除失败!', {time: 500});
                    }

                }
            })
        }
        ;
    </script>

</head>
<body>
<div class="layui-layout-body">
    <div class="layui-side layui-bg-gray" style="width: 250px;">
        <div class="layui-side-scroll" style="width:250px;">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="layui-body" style="margin-left: 55px; width: 80%;">
        <div class="lay-row" >
            <div class="layui-col-md12">
                <form class="layui-form" id="myqueryform">
                    <table class="layui_table">
                        <tr>
                            <td>用户汉字描述:</td>
                            <td><input type="text" id="description" name="description" class="layui-input"></td>
                            <td>拼音首字母:</td>
                            <td><input type="text" id="userjc" name="userjc" class="layui-input"></td>
                            <td>
                                <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal" lay-submit="">
                                    <i class="layui-icon">&#xe615;</i>搜索
                                </button>
                                <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn_reset">
                                    <i class="layui-icon">&#xe621;</i>重置
                                </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="lay-row" >
            <div class="layui-col-md12">
                <table class="layui-hide" id="table" lay-filter="UserFilter1"></table>
            </div>
        </div>
        <div class="lay-row" >
            <div class="layui-col-md12">
                <div class="layui-collapse">
                    <div class="layui-colla-item">
                        <h2 class="layui-colla-title">已选择的用户列表</h2>

                        <div class="layui-colla-content layui-show">
                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="addToSelectGrid">
                                    <button class="layui-btn" data-type="addToSelectGrid"
                                            data="btn_addToSelectGrid">增加到选择列表
                                    </button>
                                </ck:permission>
                                <ck:permission biz="mydeleterow">
                                    <button class="layui-btn" data-type="mydeleterow"
                                            data="btn_mydeleterow">删除行
                                    </button>
                                </ck:permission>
                            </div>
                            <table class="layui-hide" id="table2" lay-filter="table2Filter"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>