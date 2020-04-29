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
    <title>选择法律法规</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>

    <script type="text/javascript">
        var singleSelect = sy.getUrlParam("singleSelect");
        var v_singleSelect = (singleSelect == "true");
        var form;
        var table;
        var layer;

        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'omlaw/queryItemZTreeAsync',  //调用后台的方法
                autoParam: ["itemid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "itemid",
                    pIdKey: "itempid",
                    rootPId: 0
                },
                key: {
                    name: "itemname"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.treeData);//获取后台传递的数据
            if (!responseData) {
                for (var i = 0; i < responseData.length; i++) {
                    //将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
                    array[i] = {
                        id: responseData[i].itemid,
                        name: responseData[i].itemname,
                        isParent: false,
                        itemdesc: itemdesc
                    };
                }
            }
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#itempid").val(nodes[0].itempid);
            $("#itemid").val(nodes[0].itemid);
            $("#parentname").val(nodes[0].itemname);
            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#parentname");
            var cityOffset = $("#parentname").offset();
            $("#menuContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            initItemCombotree();
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent"
                    || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu();
            }
        }

        function initItemCombotree() { // 初始化项目树下拉框
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        var xz;
        var mask;
        var grData;
        $(function () {
            layui.use(['form', 'layer', 'table', 'element'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'omlaw/queryContent'
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
                        {type: 'checkbox'}//复选框
                        , {field: 'contentcode', title: '编号', event: 'trclick'}
                        , {field: 'content', title: '内容', event: 'trclick'}
                        , {field: 'contentsortid', title: '排序号', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        xz = '';
                        grData = '';
                        layer.close(mask);
                    }
                });
                //监听复选框
                table.on('checkbox(gr)', function (obj) {
                    var checkStatus = table.checkStatus('grid');
                    xz = checkStatus.data.length;//获取被选中的个数
                    grData = checkStatus.data;//获取被选中的数据
                });

            })
            //查询
            $('#btn_query').click(function () {
                query();
                grData = [];
                return false; //阻止页面刷新
            });
            //树
            initItemCombotree();
        });

        // 查询
        function query() {
            var itemid = $("#itemid").val();
            var itemname = $("#itemname").val();
            var param = {
                'itemid': itemid,
                'itemname': itemname
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('grid', {
                url: basePath + 'omlaw/queryContent'
                , where: param
                , done: function (res, curr, count) {
                    xz = '';
                    grData = '';
                    layer.close(mask);
                }
            });
        }

        //重置
        //        var reset = function () {
        //            $('#fm').form('clear');
        //            grid.datagrid('load', {});
        //        };

        //选择数据返回
        function getDataInfo() {
            if (xz > 0) {
                var obj = new Object();
                obj.data = grData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择法律法规！');
                grData = [];
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <div class="layui-table">
                    <form id="fm" class="layui-form">
                        <div class="layui-container">
                            <div class="layui-form-item">
                                <div class="layui-row">
                                    <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 layui-col-md-offset2">
                                        <label class="layui-form-label">父项目名称</label>

                                        <div class="layui-input-inline">
                                            <input name="parentname" id="parentname" onclick="showMenu();"
                                                   class="layui-input layui-bg-gray" readonly>
                                            <input type="hidden" name="itempid" id="itempid"/>
                                            <input type="hidden" id="itemid" name="itemid"/>
                                        </div>
                                    </div>
                                    <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
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
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="grid" lay-filter="gr"></table>
    </div>
    <div id="menuContent" class="menuContent" style="display:none; position: absolute;">
        <ul id="treeDemo" class="ztree" style="margin-top:0px;width:auto;height:230px;"></ul>
    </div>
</div>
</body>
</html>