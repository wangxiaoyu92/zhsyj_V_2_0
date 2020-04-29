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
    <title>法律法规内容管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var isParent;//是否是父类
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
        $(function () {
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});

                table.render({
                    elem: '#table'
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
                        {field: 'contentcode', width: 150, title: '编号', event: 'trclick'}
                        , {field: 'content', width: 600, title: '内容', event: 'trclick'}
                        , {field: 'contentsortid', width: 100, title: '排序号', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(ContentFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.contentid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.contentid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addContent: function () { // 添加
                        if (isParent) {
                            layer.alert('请选择左侧项目树叶子节点！');
                        } else {
                            addContent();
                        }
                    }
                    , editContent: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的法律法规内容信息！');
                        } else {
                            editContent(table.singleData.contentid);
                        }
                    }
                    , delContent: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请先选择要删除的法律法规内容信息！');
                        } else {
                            delContent(table.singleData.contentid);
                        }
                    }
                    , viewContent: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的法律法规内容信息！');
                        } else {
                            viewContent(table.singleData.contentid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            //监听提交
            $("#btn_query").click(function () {
                query();
                return false;
            })
            refreshZTree();
        });

        //初始化检查项目树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

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

        function onClick(e, treeId, treeNode) {
            $('#fm').form('load', treeNode);
            var itemid = $("#itemid").val();
            isParent = treeNode.isParent;
//		var childnum = $("#childnum").val();
            //不是父类的时候 执行查询
            if (!isParent) {
                var param = {
                    'itemid': itemid
                };
                refresh(param, '');
            }
        }
    </script>
    <script type="text/javascript">
        var setting2 = {
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
                onClick: onClick2
            }
        };

        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();
            $("#itempid").val(nodes[0].itemid);
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
            queryItemCombotree();
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

        function queryItemCombotree() { //初始化项目树下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }
    </script>
    <script type="text/javascript">
        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + 'omlaw/queryContent'
                , page: {
                    curr: curr
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }

        // 查询
        function query() {
            var itemid = $("#itemid").val();
            var itemname = $("#itemname").val();
            var childnum = $("#childnum").val();
            if (itemid == null || itemid == '' || itemname == null || itemname == '' || childnum == null || childnum > 0) {
                layer.open({
                    title: '提示'
                    , content: '请选择左侧项目树叶子节点！'
                });
                return;
            }
            var param = {
                'itemid': itemid
            };
            refresh(param, '');
        }

        // 新增项目内容
        var addContent = function () {
            var itemid = $("#itemid").val();
            sy.modalDialog({
                title: '新增法律法规内容'
                , area: ['100%', '100%']
                , content: basePath + 'omlaw/contentForm?op=add&itemid=' + itemid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveContent();
                }
            }, closeModalDialogCallback);
        };
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var itemid = $("#itemid").val();
                var param = {
                    'itemid': itemid
                };
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                //saveOk 在第一页刷新
                var itemid = $("#itemid").val();
                var param = {
                    'itemid': itemid
                };
                refresh(param, '');
            }
        }
        //编辑项目内容
        var editContent = function (contentid) {
            var itemid = $("#itemid").val();
            sy.modalDialog({
                title: '编辑法律法规内容'
                , area: ['100%', '100%']
                , content: basePath + 'omlaw/contentForm?op=edit&contentid='
                + contentid + '&itemid=' + itemid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveContent();
                }
            }, closeModalDialogCallback);
        };


        //删除项目内容
        var delContent = function (contentid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'omlaw/delContent', {
                                contentid: contentid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.table.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var itemid = $("#itemid").val();
                                        var param = {
                                            'itemid': itemid
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
        };

        //查看法律法规条款
        var viewContent = function (contentid) {
            sy.modalDialog({
                title: '查看法律法规内容'
                , area: ['100%', '100%']
                , content: basePath + 'omlaw/contentForm?op=view&contentid=' + contentid
                , btn: ['关闭']
            });
        };
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
        <div class="layui-collapse">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">法律法规内容信息</h2>

                <div class="layui-colla-content layui-show">
                    <form class="layui-form" id="fm" name="fm" style="height: auto">
                        <div class="layui-fluid">
                            <div class="layui-row">
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">项目名称:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="itemname" name="itemname" disabled
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">父项目名称:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" name="parentname" id="parentname" readonly disabled
                                                   class="layui-input layui-bg-gray" onclick="showMenu();">
                                            <input name="itempid" id="itempid" type="hidden" class="layui-input"/>
                                            <input name="itemid" id="itemid" type="hidden" class="layui-input"
                                                   readonly/>
                                            <input name="childnum" id="childnum" type="hidden" class="layui-input"
                                                   readonly/>
                                        </div>
                                        <div id="menuContent" class="layui-side layui-bg-gray"
                                             style="display:none; position:fixed;z-index:333;height: 200px;width: auto">
                                            <ul id="treeDemo2" class="ztree"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md2 layui-col-xs12 layui-col-sm6 layui-col-md-offset5 layui-col-sm-offset3">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"></label>

                                        <div class="layui-input-inline">
                                            <button id="btn_query"
                                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                                <i class="layui-icon">&#xe615;</i>查询
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
        </div>
        <div class="layui-margin-top-15">
            <div class="layui-btn-group demoTable">
                <ck:permission biz="addLawContent">
                    <button class="layui-btn" data-type="addContent" data="btn_addContent" >增加</button>
                </ck:permission>
                <ck:permission biz="editFlfgnr">
                    <button class="layui-btn" data-type="editContent" data="btn_editContent">编辑</button>
                </ck:permission>
                <ck:permission biz="delCheckAndType">
                    <button class="layui-btn layui-btn-danger" data-type="delContent" data="btn_delContent">删除</button>
                </ck:permission>
                <ck:permission biz="viewContent">
                    <button class="layui-btn " data-type="viewContent" data="btn_viewContent">查看</button>
                </ck:permission>
            </div>
            <table class="layui-hide" id="table" lay-filter="ContentFilter"></table>
        </div>
    </div>
</div>
</body>
</html>