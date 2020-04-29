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
        var houseod = '';
        // 菜单树配置
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'animal/queryAnimalZTreeAsync',  //调用后台的方法
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "animalhouseid",
                    pIdKey: "parenthouseid",
                    rootPId: 0
                },
                key: {
                    name: "housename"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        $(function () {
            $('#houseno').blur(function () {
                var houseno = $('#houseno').val();
                if (houseno == null || houseno == '') {
                    return false;
                }
                if (houseno != houseod) {
                    checkUniqueness();
                }
            })
            refreshZTree();
            layui.use(['form', 'element', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                element = layui.element;
                // 保存菜单
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(basePath + 'animal/saveAnimalhouse', formData, function (result) {
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
                    var animalhouseid = $('#animalhouseid').val();
                    if (animalhouseid) {
                        var childnum = $('#childnum').val();
                        var msg;
                        if (childnum >= 1) {
                            msg = "此菜单为上级舍所,如果删除，其所属的子舍所也将被删除，确定要删除此舍所吗？";
                        } else {
                            msg = "确定要删除此舍所吗？";
                        }
                        layer.confirm(msg, function (index) {
                            $.post(basePath + 'animal/delAnimalhouse', {animalhouseid: animalhouseid},
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
                            , content: '没有选择舍所数据，无法删除！'
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
            var zNodes = eval(responseData.animalhouseData);//获取后台传递的数据
            return zNodes;
        }

        function onClick(e, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#parenthouseid").val(nodes[0].parenthouseid);
            $("#animalhouseid").val(nodes[0].animalhouseid);
            $("#parentname").val(nodes[0].parentname);
            $("#childnum").val(nodes[0].childnum);
            $("#housenoold").val(nodes[0].houseno);
            form.render();
        }

        var setting2 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'animal/queryAnimalZTreeAsync',  //调用后台的方法
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "animalhouseid",
                    pIdKey: "parenthouseid",
                    rootPId: 0
                },
                key: {
                    name: "housename"
                }
            },
            callback: {
                onClick: onClick2
            }
        };

        var setting3 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法
                autoParam: ["orgid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilterOrg //用于对 Ajax返回数据进行预处理
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
                onClick: onClick3
            }
        };

        function ajaxDataFilterOrg(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }
        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();
            $("#parenthouseid").val(nodes[0].animalhouseid);
            $("#parentname").val(nodes[0].housename);
            hideMenu();
        }

        //单击节点事件
        function onClick3(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo3");
            var nodes = zTree.getSelectedNodes();
            $("#orgid").val(nodes[0].orgid);
            $("#orgname").val(nodes[0].orgname);
            hideMenu2();
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

        function showOrg() {
            var cityObj = $("#orgname");
            var cityOffset = $("#orgname").offset();
            $("#menuContent2").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown2);
            refreshZTree3();
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function hideMenu2() {
            $("#menuContent2").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent"
                    || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu();
            }
        }
        function onBodyDown2(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent2"
                || $(event.target).parents("#menuContent2").length > 0)) {
                hideMenu();
            }
        }

        function refreshZTree2() { //初始化父菜单下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }

        function refreshZTree3() { //初始化父菜单下拉框
            $.fn.zTree.init($("#treeDemo3"), setting3);
        }

        //新增
        function addSysfunction() {
            $('#fm').form('clear');
        }


        //验证编码唯一性
        function checkUniqueness() {
            houseod = $('#houseno').val();
            var houseno = $('#houseno').val();
            var housenoold = $('#housenoold').val();
            if(housenoold==houseno){
                houseod = houseno;
                $('#houseno').val(houseno);
                $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
            }else {
                if (houseno != null && houseno != "") {
                    $.post(basePath + '/animal/queryAnimalhouseDTO', {
                            houseno: houseno
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                //存在
                                if (mydata != undefined) {
                                    layer.msg("编号重复请重新填写");
                                    $('#houseno').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编号唯一</font>");
                                } else {
                                    houseod = houseno;
                                    $('#houseno').val(houseno);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
                }
            }
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
            <h2 class="layui-colla-title">动物舍所信息</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="fm">
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>舍所编号:</label>

                        <div class="layui-input-inline" style="width: 500px">
                            <input type="text" id="houseno" name="houseno"
                                   class="layui-input" lay-verify="required">
                            <input name="animalhouseid" id="animalhouseid" type="hidden"/>
                            <input name="childnum" id="childnum" type="hidden"/>
                            <input name="housenoold" id="housenoold" type="hidden"/>
                        </div>
                        <div class="layui-input-inline">
                            <font color="red" id="greentext">保证编号唯一</font>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"><span style="color: red;">*</span>舍所名称:</label>

                        <div class="layui-input-inline" style="width: 500px">
                            <input type="text" id="housename" name="housename" autocomplete="off"
                                   lay-verify="required" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">上级舍所:</label>

                        <div class="layui-input-inline" style="width: 500px">
                            <input type="text" id="parentname" name="parentname" onclick="showMenu();"
                                   readonly class="layui-input layui-bg-gray">
                            <input name="parenthouseid" id="parenthouseid" type="hidden"/>
                        </div>
                    </div>
                    <div id="menuContent" class="menuContent"
                         style="display:none;position:fixed;z-index:333;height: 200px;width: 250px;">
                        <ul id="treeDemo2" class="ztree"></ul>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">组织机构:</label>

                        <div class="layui-input-inline" style="width: 500px">
                            <input type="text" id="orgname" name="orgname" onclick="showOrg();"
                                   readonly class="layui-input layui-bg-gray">
                            <input name="orgid" id="orgid" type="hidden"/>
                        </div>
                    </div>
                    <div id="menuContent2" class="menuContent2"
                         style="display:none;position:fixed;z-index:333;height: 200px;width: 250px;">
                        <ul id="treeDemo3" class="ztree"></ul>
                    </div>


                    <div class="layui-form-item">
                        <label class="layui-form-label" >舍所备注:</label>
                        <div class="layui-input-inline" style="width: 500px">
                            <textarea placeholder="请输入内容" class="layui-textarea" id="houseremarks" name="houseremarks"></textarea>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <ck:permission biz="addhouse">
                                <button class="layui-btn" data-type="addSysfunction" data="btn_addSysfunction"
                                        onclick="addAnimalhouse()">新增
                                </button>
                            </ck:permission>
                            <ck:permission biz="delhouse">
                                <button class="layui-btn layui-btn-danger" data-type="delSysfunction"
                                        data="btn_delSysfunction"
                                        lay-submit="" lay-filter="delete">删除
                                </button>
                            </ck:permission>
                            <ck:permission biz="savehouse">
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
