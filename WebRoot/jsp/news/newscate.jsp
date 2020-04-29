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
    <title>新闻分类管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        // 新闻类别树配置
        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "cateid",
                    pIdKey: "cateparentid",
                    rootPId: 0
                },
                key: {
                    name: "catename"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        $(function () {
            $('#addNewsCate').click(function () {
                addNewsCate();
                return false;
            })
            refreshZTree();
            layui.use(['form', 'element', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                // 保存
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(basePath + '/newscate/saveNewsCate', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                refreshZTree();
                                $('#fm').form('clear');
                            });
                        } else {
                            layer.msg('保存失败' + result.msg);
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                // 删除
                form.on('submit(delete)', function (data) {
                    var cateid = $('#cateid').val();
                    if (cateid) {
                        var cateparentid = $('#cateparentid').val();
                        var msg;
                        if (cateparentid <= 1) {
                            msg = "此菜单为父级菜单,如果删除，其所属的子菜单也将被删除，确定要删除此菜单吗？";
                        } else {
                            msg = "确定要删除此菜单吗？";
                        }
                        layer.confirm(msg, function (index) {
                            $.post(basePath + '/newscate/delNewsCate', {cateid: cateid},
                                    function (result) {
                                        if (result.code == '0') {
                                            layer.msg('删除成功', {time: 1000}, function () {
                                                refreshZTree();
                                                $('#fm').form('clear');
                                            });
                                        } else {
                                            layer.open({
                                                title: '提示'
                                                , content: '删除失败' + result.msg
                                            });
                                        }
                                    }, 'json');
                            layer.close(index);
                        });
                    } else {
                        layer.msg('没有选择菜单数据，无法删除！');
                    }
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            });
        });
        //初始化zTree树
        function refreshZTree() {
            //初始化树
            $.post(basePath + '/newscate/queryNewcateZTree', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                } else {
                    layer.alert(result.msg);
                }
            }, 'json');
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            if (nodes[0].parentTId) {
                var parentNode = nodes[0].getParentNode();
                $("#cateparentid").val(parentNode.cateid);
                $("#cateparentname").val(parentNode.catename);
            } else {
                $("#cateparentid").val('0');
                $("#cateparentname").val('');
            }

        }

        // 新增
        function addNewsCate() {
            $('#fm').form('clear');
        }
        function showCate() {
            var cityObj = $("#cateparentname");
            var cityOffset = $("#cateparentname").offset();
            $("#cateContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            refreshZTree2();
        }
        function onBodyDown(event) {
            if (!(event.target.id == "cateBtn" || event.target.id == "cateContent"
                    || $(event.target).parents("#cateContent").length > 0)) {
                hideMenu();
            }
        }
        function hideMenu() {
            $("#cateContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        var setting2 = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "cateid",
                    pIdKey: "cateparentid",
                    rootPId: 0
                },
                key: {
                    name: "catename"
                }
            },
            callback: {
                onClick: onClick2
            }
        };
        function refreshZTree2() { //初始化父菜单下拉框
            //初始化机构树
            $.post(basePath + '/newscate/queryNewcateZTree', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo2"), setting2, zNodes);
                } else {
                    layer.alert(result.msg);
                }
            }, 'json');
        }
        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();

            $("#cateparentid").val(nodes[0].cateid);
            $("#cateparentname").val(nodes[0].catename);
            hideMenu();
        }
    </script>
</head>

<body class="layui-layout-body">
<div class="layui-side layui-bg-gray" style="width: 250px;">
    <div class="layui-side-scroll" style="width:250px;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
    <div class="layui-collapse">
        <div class="layui-colla-item" style="width:100%;height:50%;">
            <h2 class="layui-colla-title">新闻分类信息</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="fm" name="fm">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">新闻分类ID:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <input type="text" id="cateid" name="cateid" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><span
                                style="color: red;">*</span>新闻分类名称:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <input type="text" id="catename" name="catename" lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><span
                                style="color: red;">*</span>新闻分类简称:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <input type="text" id="catejc" name="catejc" lay-verify="required"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">父级分类:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <input type="text" name="cateparentname" id="cateparentname"
                                   readonly onclick="showCate();" class="layui-input layui-bg-gray">
                            <input name="cateparentid" id="cateparentid" type="hidden"/>
                        </div>
                    </div>
                    <div id="cateContent" class="cateContent" style="display:none;position:fixed;z-index:333;">
                        <ul id="treeDemo2" class="ztree" style="height:250px;width: 250px;"></ul>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">新闻分类级别:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <input type="text" id="catelevel" name="catelevel"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 102px">是否允许添加新闻:</label>

                        <div class="layui-input-inline" style="width: 800px">
                            <select id="catesfyxtjxw" name="catesfyxtjxw" placeholder="请选择">
                                <option value="0">否</option>
                                <option value="1">是</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <ck:permission biz="addNewsCate">
                                <button class="layui-btn" data-type="addNewsCate" data="btn_addNewsCate"
                                        id="addNewsCate">新增
                                </button>
                            </ck:permission>
                            <ck:permission biz="delNewsCate">
                                <button class="layui-btn layui-btn-danger" data-type="delNewsCate"
                                        data="btn_delNewsCate"
                                        lay-submit="" lay-filter="delete">删除
                                </button>
                            </ck:permission>
                            <ck:permission biz="saveNewsCate">
                                <button class="layui-btn" data-type="saveNewsCate" data="btn_saveNewsCate"
                                        lay-submit="" lay-filter="save">保存
                                </button>
                            </ck:permission>
                        </div>
                    </div>
                </form>
                <br/>
            </div>
        </div>
    </div>
</div>
</body>
</html>