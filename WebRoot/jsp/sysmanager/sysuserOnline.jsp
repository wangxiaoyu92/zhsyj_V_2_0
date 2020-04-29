<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>在线用户统计</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var orgid = "";
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var mask;
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法
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
            initTable();
        });

        //初始化【机构】树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            //stopRydw();
            orgid = treeNode.orgid;
            //startRydw();
            getSysuserLocation2();
        }
        function initTable() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#userOnlineTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
//				,url : basePath + 'sysmanager/sysuser/querySysuser'
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
                        {field: 'userid', title: '用户ID'}
                        , {field: 'username', title: '用户名称'}
                        , {field: 'description', title: '用户描述'}
                        , {field: 'mobile', title: '手机号'}
                        , {field: 'mobile2', title: '手机号2'}
                        , {field: 'dwsj', title: '定位时间'}
                        , {field: 'address', title: '定位地址'}
                    ]]
                });
            });
            $('#rydw').on('click', startRydw);
        }

        //启动人员定位
        var timerRydw;
        var startRydw = function () {
            //发送定位信息
            getAllSysuserLocation();
            timerRydw = setInterval('getSysuserLocation()', 6000);
            $("#rydw").linkbutton({
                text: "<span style='font-size: 14px;'><i class='layui-icon'>&#xe6ed;</i>停止人员定位</span>"
            });
            $('#rydw').off('click', startRydw);
            $('#rydw').on('click', stopRydw);
        };
        //停止人员定位
        var stopRydw = function () {
            clearInterval(timerRydw);
            $("#rydw").linkbutton({
                text: "<span style='font-size: 14px;'><i class='layui-icon'>&#xe6ed;</i>开启人员定位</span>"
            });
            $('#rydw').off('click', stopRydw);
            $('#rydw').on('click', startRydw);

            orgid = "";
            //$('#online').val(0);
            //grid.datagrid('loadData',{"total":0,"rows":[]});
        };

        //发布指令获取当前人员的位置
        var getAllSysuserLocation = function () {
            $.post(basePath + '/common/sjb/sendPushMsgAll', 'json');
        };

        //统计【监管员】实时分布情况
        function getSysuserLocation() {
            orgid = "";
            var param = {
                'orgid': orgid
            };
            table.reload('userOnlineTable', {
                url: basePath + 'common/sjb/getSysuserLocation'
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    $('#online').val(count);

                }
            });
        }

        //统计【监管员】实时分布情况
        var getSysuserLocation2 = function () {
            var param = {
                'orgid': orgid
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('userOnlineTable', {
                url: basePath + 'common/sjb/getSysuserLocation'
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
        };

        // 刷新
        function refresh() {
            parent.window.refresh();
        }

    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side layui-bg-black" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">统计</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <div class="layui-fluid">
                    <div class="layui-row">
                        <div class="layui-col-md8 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label">当前定位人数：</label>

                                <div class="layui-input-inline">
                                    <input class="layui-input" id="online" name="online"/>
                                </div>
                                <label class="layui-form-label" style=" text-align:left;"> <font
                                        color="red">人</font></label>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <div class="layui-input-inline">
                                    <button class="layui-btn layui-btn-normal" id="rydw">
                                        <i class="layui-icon"></i>开启人员定位
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="userOnlineTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>