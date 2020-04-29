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
    <title>机构管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        var element;
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
            layui.use(['form', 'element', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                element = layui.element;
                // 保存
                form.on('submit(save)', function (data) {
/*                    var v_parent = $("#parent").val();
                    if (v_parent==null || v_parent==""){
                        layer.open({
                            title: '提示'
                            , content: '请' + result.msg
                        });
                    }*/
                    var formData = data.field;
                    $.post(basePath + 'sysmanager/sysorg/saveSysorg', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                refreshZTree();
                                addSysorg();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                // 删除
                form.on('submit(delete)', function (data) {
                    var orgid = $('#orgid').val();
                    if (orgid != null && orgid != '') {
                        var childnum = $('#childnum').val();
                        var msg;
                        if (childnum > 1) {
                            msg = "此机构为父级机构,如果删除，其所属的子机构也将被删除，确定要删除此机构吗？";
                        } else {
                            msg = "确定要删除此机构吗？";
                        }
                        layer.confirm(msg, function (index) {
                            $.post(basePath + 'sysmanager/sysorg/delSysorg', {orgid: orgid},
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
                        layer.open({
                            title: '提示'
                            , content: '没有选择菜单数据，无法删除！'
                        });
                    }
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            });
        });

        //初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        function onClick(e, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#parent").val(nodes[0].parent);
            $("#parentname").val(nodes[0].parentname);
            form.render();
        }
        // 所选父机构下拉树配置
        var setting2 = {
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
                onClick: onClick2
            }
        };

        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();
            $("#parent").val(nodes[0].orgid);
            $("#parentname").val(nodes[0].orgname);
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
            refreshZTree2();
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

        function refreshZTree2() { //初始化父机构下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }

        //新增
        function addSysorg() {
            $('#fm').form('clear');
            $('#orgkind').val('0');
            $('#orderno').val('1');
        }
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side layui-bg-gray" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">机构信息</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="fm">
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构ID</label>

                        <div class="layui-input-block">
                            <input type="text" id="orgid" name="orgid" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构编码</label>

                        <div class="layui-input-block">
                            <input type="text" id="orgcode" name="orgcode" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>机构名称</label>

                        <div class="layui-input-block">
                            <input type="text" id="orgname" name="orgname" autocomplete="off"
                                   lay-verify="required" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构描述</label>

                        <div class="layui-input-block">
                            <input type="text" id="orgdesc" name="orgdesc" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>父机构</label>

                        <div class="layui-input-block">
                            <input type="text" id="parentname" name="parentname" onclick="showMenu();"
                                   lay-verify="required" class="layui-input layui-bg-gray" readonly>
                            <input name="parent" id="parent" type="hidden"/>
                        </div>
                    </div>
                    <div id="menuContent" class="menuContent" style="display:none;position:fixed;z-index:333;">
                        <ul id="treeDemo2" class="ztree" style="height:250px;width: 250px;"></ul>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构地址</label>

                        <div class="layui-input-block">
                            <input type="text" id="address" name="address" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构负责人</label>

                        <div class="layui-input-block">
                            <input type="text" id="principal" name="principal" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">联系人</label>

                        <div class="layui-input-block">
                            <input type="text" id="linkman" name="linkman" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">联系电话</label>

                        <div class="layui-input-block">
                            <input type="text" id="tel" name="tel" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">分组</label>

                        <div class="layui-input-block">
                            <input type="text" id="fz" name="fz" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">子机构个数</label>

                        <div class="layui-input-block">
                            <input type="text" id="childnum" name="childnum" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <input id="shortname" name="shortname" type="hidden" style="width: 200px;"/>
                    <input id="orgkind" name="orgkind" type="hidden" style="width: 200px;" value="0"/>
                    <input id="orderno" name="orderno" type="hidden" style="width: 200px;" value="1"/>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <ck:permission biz="addSysorg">
                                <button class="layui-btn" data-type="addSysorg" data="btn_addSysorg"
                                        onclick="addSysorg()">新增
                                </button>
                            </ck:permission>
                            <ck:permission biz="delSysorg">
                                <button class="layui-btn layui-btn-danger" data-type="delSysorg" data="btn_delSysorg"
                                        lay-submit="" lay-filter="delete">删除
                                </button>
                            </ck:permission>
                            <ck:permission biz="saveSysorg">
                                <button class="layui-btn" data-type="saveSysorg" data="btn_saveSysorg"
                                        lay-submit="" lay-filter="save">保存
                                </button>
                            </ck:permission>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>