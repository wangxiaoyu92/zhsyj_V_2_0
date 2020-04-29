<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
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
    <title>菜单管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var form;
        var layer;
        var element;
        //下拉框数据
        var cb_type = <%=SysmanageUtil.getAa10toJsonArray("TYPE")%>; // 菜单类别
        var cb_systemcode = <%=SysmanageUtil.getAa10toJsonArray("SYSTEMCODE")%>; // 所属系统
        // 菜单树配置
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'sysmanager/sysfunction/querySysfunctionZTreeAsync',  //调用后台的方法
                autoParam: ["functionid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "functionid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "title"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        $(function () {
            refreshZTree();
            // 初始化下拉框选项数据
            intSelectData('type', cb_type);
            intSelectData('systemcode', cb_systemcode);
            layui.use(['form', 'element', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                element = layui.element;
                // 保存菜单
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(basePath + 'sysmanager/sysfunction/saveSysfunction', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                refreshZTree();
                                addSysfunction();
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
                // 删除菜单
                form.on('submit(delete)', function (data) {
                    var functionid = $('#functionid').val();
                    if (functionid) {
                        var childnum = $('#childnum').val();
                        var msg;
                        if (childnum >= 1) {
                            msg = "此菜单为父级菜单,如果删除，其所属的子菜单也将被删除，确定要删除此菜单吗？";
                        } else {
                            msg = "确定要删除此菜单吗？";
                        }
                        layer.confirm(msg, function (index) {
                            $.post(basePath + 'sysmanager/sysfunction/delSysfunction', {functionid: functionid},
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
            $("#btn_selectIcon").bind("click", function () {
                selectIcon();
                return false;
            });
        });
        function selectIcon() {
            sy.modalDialog({
                title: '选择图标'
                , area: ['100%', '100%']
                , content: basePath + 'jsp/pub/pub/selectIcon.jsp'
            }, function (dialogID) {
                var icon = sy.getWinRet(dialogID);
                icon = icon ? icon : ($("#imageurl").val() ? $("#imageurl").val() : "&#xe658");
                $("#imageurlSpan").html(""); // 首先清空
                $("#imageurlSpan").append("<i class='layui-icon'>" + icon + "</i>");
                $("#imageurl").val(icon);
                sy.removeWinRet(dialogID);
            });
        }
        //初始化zTree树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.menuData);//获取后台传递的数据
            return zNodes;
        }

        function onClick(e, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#parent").val(nodes[0].parent);
            $("#parentname").val(nodes[0].parentname);
            var icon = treeNode.imageurl ? treeNode.imageurl : "&#xe658";
            $("#imageurlSpan").html(""); // 首先清空
            $("#imageurlSpan").append("<i class='layui-icon'>" + icon + "</i>");
            $("#imageurl").val(icon);
            form.render();
        }

        var setting2 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'sysmanager/sysfunction/querySysfunctionZTreeAsync',  //调用后台的方法
                autoParam: ["functionid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "functionid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "title"
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
            $("#parent").val(nodes[0].functionid);
            $("#parentname").val(nodes[0].title);
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

        function refreshZTree2() { //初始化父菜单下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }

        //新增
        function addSysfunction() {
            $('#fm').form('clear');
            $('#orderno').val('1');
            $('#visible').val('1');
        }
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 79%;">
    <div class="layui-collapse">
        <div class="layui-colla-item" style="width:100%">
            <h2 class="layui-colla-title">菜单信息</h2>
            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="fm">
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单编号</label>

                        <div class="layui-input-block">
                            <input type="text" id="functionid" name="functionid" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>菜单类型</label>

                        <div class="layui-input-block">
                            <select id="type" name="type" lay-verify="required"></select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>菜单名称</label>

                        <div class="layui-input-block">
                            <input type="text" id="title" name="title" autocomplete="off"
                                   lay-verify="required" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单路径</label>

                        <div class="layui-input-block">
                            <input type="text" id="location" name="location"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>业务标识(唯一约束)</label>

                        <div class="layui-input-block">
                            <input type="text" id="bizid" name="bizid"
                                   class="layui-input" lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单父节点</label>

                        <div class="layui-input-block">
                            <input type="text" id="parentname" name="parentname" onclick="showMenu();"
                                   readonly class="layui-input layui-bg-gray">
                            <input name="parent" id="parent" type="hidden"/>
                        </div>
                    </div>
                    <div id="menuContent" class="menuContent"
                         style="display:none;position:fixed;z-index:333;height: 200px;width: 250px;">
                        <ul id="treeDemo2" class="ztree"></ul>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                <label class="layui-form-label">菜单图标</label>
                                <div class="layui-input-inline">
                                    <span id="imageurlSpan"></span>
                                    <input type="hidden" id="imageurl" name="imageurl" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                <div class="layui-input-inline">
                                    <button class="layui-btn layui-btn-sm layui-btn-normal"
                                            id="btn_selectIcon">
                                        <i class="layui-icon">&#xe621;</i>选择图标
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单序号（菜单显示顺序）</label>

                        <div class="layui-input-block">
                            <input type="text" id="orderno" name="orderno"
                                   class="layui-input" value="1">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否可见</label>

                        <div class="layui-input-block">
                            <select id="visible" name="visible">
                                <option value="0">隐藏</option>
                                <option value="1">可见</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单打开方式</label>

                        <div class="layui-input-block">
                            <input type="text" id="target" name="target"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单所属系统</label>

                        <div class="layui-input-block">
                            <select id="systemcode" name="systemcode"></select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">子菜单个数</label>

                        <div class="layui-input-block">
                            <input type="text" id="childnum" name="childnum" readonly
                                   class="layui-input layui-bg-gray">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <ck:permission biz="addSysfunction">
                                <button class="layui-btn" data-type="addSysfunction" data="btn_addSysfunction"
                                        onclick="addSysfunction()">新增
                                </button>
                            </ck:permission>
                            <ck:permission biz="delSysfunction">
                                <button class="layui-btn layui-btn-danger" data-type="delSysfunction"
                                        data="btn_delSysfunction"
                                        lay-submit="" lay-filter="delete">删除
                                </button>
                            </ck:permission>
                            <ck:permission biz="saveSysfunction">
                                <button class="layui-btn" data-type="saveSysfunction" data="btn_saveSysfunction"
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
