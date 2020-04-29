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
    String usercomid = StringHelper.showNull2Empty(request.getParameter("usercomid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>选择人员</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync?',  //调用后台的方法
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
            if ('comusersel' == '<%=v_querykind%>') {
                var param = {
                    'orgid': treeNode.orgid,
                    'querykind': '<%=v_querykind%>',
                    //gu0180604 'userkind': '7',
                    'usercomid': '<%=usercomid%>'
                };
            }else{
                var param = {'orgid': treeNode.orgid, 'querykind': '<%=v_querykind%>', 'usercomid': '<%=usercomid%>'};
            }
            initData(param);
        }
    </script>
    <script type="text/javascript">
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        //下拉框列表
        var userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>;
        var lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>;
        var cb_userkind;//用户类型下拉列表
        var cb_lockstate;//账户锁定状态下拉列表
        var form;
        var layer;
        var table;
        var mygrData = [];
        var xz;
        var mask;


        $(function () {
            layui.use(['form', 'layer', 'table', 'element'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                var element = layui.element;
                var param = {'querykind': '<%=v_querykind%>','usercomid': '<%=usercomid%>'};
                initData(param);

                if ('comusersel' != '<%=v_querykind%>') {
                    intSelectData('userkind', userkind);
                }
                intSelectData('lockstate', lockstate);
                form.render();
            })
            $("#btn_query").click(function () {//查询
                query();
                return false; //阻止页面刷新
            })
            $("#btn_queding").click(function () {//查询
                queding();
                return false; //阻止页面刷新
            })
            $("#btn_refresh").click(function () {//查询
                refresh();
                return false; //阻止页面刷新
            })
        })

        function initData(param) {
            var url = basePath + '/sysmanager/sysuser/querySysuser';
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.render({
                title: '任务列表'
                , elem: '#grid'
                , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , url: url
                , where: param
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
                   // , {field: 'orgid', width: 200, title: '机构ID'}
                    , {field: 'description', width: 200, title: '用户描述'}
                    , {field: 'username', width: 100, title: '用户名称'}
                    , {field: 'orgname', width: 200, title: '所属机构'}
                    , {
                        field: 'userkind', width: 120, title: '用户类别'
                        , templet: function (d) {
                            return formatGridColData(userkind, d.userkind);
                        }
                    }
                    , {field: 'mobile2', width: 120, title: '手机号2'}
                    , {field: 'mobile', width: 120, title: '手机号'}

                    , {
                        field: 'lockstate', width: 120, title: '账户锁定状态'
                        , templet: function (d) {
                            return formatGridColData(lockstate, d.lockstate);
                        }
                    }
                    , {field: 'aaa027name', width: 80, title: '统筹区'}
                    , {field: 'userid', width: 200, title: '用户ID'}
                ]]
                , done: function (res, curr, count) {
                    xz = '';
                    mygrData = '';
                    layer.close(mask);
                }
            });
            //监听复选框
            table.on('checkbox(gr)', function (obj) {
                var checkStatus = table.checkStatus('grid');
                xz = checkStatus.data.length;//获取被选中的个数
                mygrData = checkStatus.data;//获取被选中的数据
            });
        }
        //用户类型下拉列表
        function userkindList() {

            for (var i = 0; i < userkind.length; i++) {
                cb_userkind += '<option value=\'' + userkind[i].id + '\' >' + userkind[i].text + '</option>';
            }
            $("#userkind").html(cb_userkind);
            form.render('select');
        }
        //账户锁定状态下拉列表
        function lockstateList() {

            for (var i = 0; i < lockstate.length; i++) {
                cb_lockstate += '<option value=\'' + lockstate[i].id + '\' >' + lockstate[i].text + '</option>';
            }
            $("#lockstate").html(cb_lockstate);
            form.render('select');
        }
        //查询
        function query() {
            if ('comusersel' == '<%=v_querykind%>') {
                var param = {
                    'username': $('#username').val(),
                    'userkind': '7',
                    'lockstate': $('#lockstate').val(),
                    'querykind': '<%=v_querykind%>',
                    'usercomid': '<%=usercomid%>'
                };
            }else{
                var param = {
                    'username': $('#username').val(),
                    'userkind': $('#userkind').val(),
                    'lockstate': $('#lockstate').val(),
                    'querykind': '<%=v_querykind%>'
                };
            }
            mygrData = [];
            initData(param);
        }
        //重置
        function refresh() {
            $('#username').val('');
            $('#userkind').val('');
            $('#lockstate').val('');
            form.render();
            if ('comusersel' == '<%=v_querykind%>') {
                var param = {
                    'username': $('#username').val(),
                    'userkind': '7',
                    'lockstate': $('#lockstate').val(),
                    'querykind': '<%=v_querykind%>',
                    'usercomid': '<%=usercomid%>'
                };
            }else{
                var param = {
                    'username': $('#username').val(),
                    'userkind': $('#userkind').val(),
                    'lockstate': $('#lockstate').val(),
                    'querykind': '<%=v_querykind%>'
                };
            }

            mygrData = [];
            initData(param);
        }
        //确定
        function queding() {
            if (xz > 0) {
                if ('comusersel' == '<%=v_querykind%>') {
                    if (xz == 1) {
                        var obj = new Object();
                        obj.data = mygrData;
                        obj.type = "ok";
                        var rows = mygrData;
                        sy.setWinRet(obj);
                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                    } else {
                        layer.alert('不允许选择多个人员！');
                        mygrData = [];
                    }
                } else {
                    var obj = new Object();
                    obj.data = mygrData;
                    obj.type = "ok";
                    var rows = mygrData;
                    sy.setWinRet(obj);
                    parent.layer.close(parent.layer.getFrameIndex(window.name));
//                parent.$("#"+sy.getDialogId()).dialog("close");
                }
            } else {
                layer.alert('请选择人员！');
                mygrData = [];
            }
        }

    </script>

</head>
<body class="layui-layout-body">
<%if(!"comusersel".equals(v_querykind)){%>
<div class="layui-side layui-bg-gray" style="width: 250px;">
    <div class="layui-side-scroll" style="width:250px;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
<%}else{%>
    <div class="layui-table">
<%}%>
    <div class="layui-collapse">
        <div class="layui-colla-item" style="width:100%;height:auto;">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form">
                    <div class="layui-fluid">
                        <div class="layui-row">
                            <%if(!"comusersel".equals(v_querykind)){%>
                            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="username" id="username"
                                               class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户类别</label>

                                    <div class="layui-input-inline">
                                        <select type="text" name="userkind" id="userkind"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">账户锁定状态</label>

                                    <div class="layui-input-inline">
                                        <select type="text" name="lockstate" id="lockstate"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button id="btn_refresh"
                                                class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe621;</i>重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <%}else{%>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="username" id="username"
                                               class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">账户锁定状态</label>

                                    <div class="layui-input-inline">
                                        <select type="text" name="lockstate" id="lockstate"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button id="btn_refresh"
                                                class="layui-btn layui-btn-sm layui-btn-normal">
                                            <i class="layui-icon">&#xe621;</i>重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="grid" lay-filter="gr"></table>
    </div>
</div>
</body>
</html>