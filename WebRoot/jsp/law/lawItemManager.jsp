<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>法律法规项目管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">

        // 项目大类（四品一械）
        var itemtypeData = <%=SysmanageUtil.getAa10toJsonArray("aae140")%>;
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

    $(function () {

        refreshZTree();
        intSelectData('itemtype',itemtypeData);
        layui.use(['form','element'], function () {
            form = layui.form;
            layer = layui.layer;
            var element = layui.element;
            // 保存
            form.on('submit(save)', function(data){
                var formData = data.field;
                $.post( basePath + 'omlaw/saveLawGroup', formData, function (result) {
                    result = $.parseJSON(result);
                    if (result.code=='0'){
                        layer.msg('保存成功', {time:500},function(){
                            refreshZTree();
                            addItem();
                        });
                    } else {
                        layer.open({
                            title: '提示'
                            ,content: '保存失败' + result.msg
                        });
                    }
                });
                return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
            });
            form.on('submit(delete)',function(data){
                var itemid = $('#itemid').val();
                if (itemid != null && itemid != ''){
                    var childnum = $('#childnum').val();
                    var msg;
                    if (childnum > 1) {
                        msg = "此机构为父级项目,如果删除，其所属的子项目也将被删除，确定要删除此项目吗？";
                    } else {
                        msg = "确定要删除此项目吗？";
                    }
                    layer.confirm(msg, function(index){
                        $.post(basePath + 'omlaw/delLawGroup', {itemid: itemid},
                                function(result){
                                    if (result.code=='0'){
                                        layer.msg('删除成功', {time:500},function(){
                                            refreshZTree();
                                            addItem();
                                        });
                                    } else {
                                        layer.open({
                                            title: '提示'
                                            ,content: '删除失败' + result.msg
                                        });
                                    }
                                }, 'json');
                        layer.close(index);
                    });
                }else{
                    layer.open({
                        title: '提示'
                        ,content: '没有选择机构数据，无法删除！'
                    });
                }
                return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。*/
            });
        });
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
        form.render();
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
        function refresh() {
            parent.window.refresh();
        }

        //新增
        var addItem = function () {
            $('#fm').form('clear');
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
            <div class="layui-colla-item" style="width:100%;height:50%;">
                <h2 class="layui-colla-title">法律法规项目信息</h2>
                <div class="layui-colla-content layui-show">
                    <form class="layui-form" id="fm" name="fm">
                        <div class="layui-form-item">
                            <label class="layui-form-label">项目ID</label>

                            <div class="layui-input-block">
                                <input type="text" id="itemid" name="itemid" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><font class="myred">*</font>项目类别</label>

                            <div class="layui-input-block">
                                <select id="itemtype" name="itemtype"
                                        lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">项目名称</label>

                            <div class="layui-input-block">
                                <input type="text" id="itemname" name="itemname" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">项目描述</label>

                            <div class="layui-input-block">
                                <input type="text" id="itemdesc" name="itemdesc"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">父项目ID</label>

                            <div class="layui-input-block">
                                <input type="text" name="parentname" id="parentname" readonly
                                       class="layui-input layui-bg-gray" onclick="showMenu();">
                                <input name="itempid" id="itempid" type="hidden" class="layui-input"/>
                            </div>
                        </div>
                        <div id="menuContent" class="menuContent" style="display:none; position:fixed;z-index:333;height: 200px">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">备注</label>

                            <div class="layui-input-block">
                                <input type="text" id="itemremark" name="itemremark"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">排序号</label>

                            <div class="layui-input-block">
                                <input type="text" id="itemsortid" name="itemsortid"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <ck:permission biz="addLawItem" >
                                    <button class="layui-btn" data-type="addItem" data="btn_addItem"
                                            onclick="addItem()">新增</button>
                                </ck:permission>
                                <ck:permission biz="delLawGroup" >
                                    <button class="layui-btn layui-btn-danger" data-type="delItem" data="btn_delItem"
                                            lay-submit="" lay-filter="delete">删除</button>
                                </ck:permission>
                                <ck:permission biz="saveFlfgxmgl" >
                                    <button class="layui-btn" data-type="saveItem" data="btn_saveItem"
                                            lay-submit="" lay-filter="save">保存</button>
                                </ck:permission>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>