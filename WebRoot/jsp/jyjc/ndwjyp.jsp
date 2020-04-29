<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>通用父子关系表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //定义全局变量父子关系类别
        var b_parentchildlb = "ndwjjcyp";
        //定义全局变量父子关系类别名称
        var b_parentchildlbmc = "你点我检样品";
        var treeObj;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;

        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "parentchildid",
                    pIdKey: "parentid",
                    rootPId: 0
                },
                key: {
                    name: "mc"
                }
            },
            callback: {
                onClick: onClick
            }

        };
        var setting2={
            view: {
                showLine: true
            },
            async: {
                enable: true, //启用异步加载
                url: basePath + '/pub/pub/queryParentchildTree?parentchildlb='
                    + b_parentchildlb + '&parentchildlbmc=' + b_parentchildlbmc,  //调用后台的方法
                dataFilter: ajaxDataFilter,//用于对 Ajax返回数据进行预处理
                autoParam: ["parentchildid"], //向后台传递的参数
                otherParam: {} //额外的参数
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "parentchildid",
                    pIdKey: "parentid",
                    rootPId: 0
                },
                key: {
                    name: "text"
                }
            },
            callback: {
                onClick: onClick2
            }
        };
        var form;
        var element;
        var layer;
        var laydate;
        $(function() {
            refreshZTree();
            layui.use(['form', 'element', 'laydate', 'layer'], function () {
                form = layui.form;
                element = layui.element;
                laydate = layui.laydate;
                layer = layui.layer;
                laydate.render({
                    elem:"#czsj"
                    ,type:"datetime"
                });
                var url = basePath + '/pub/pub/saveParentchild?parentchildlb='
                        + b_parentchildlb + '&parentchildlbmc=' + b_parentchildlbmc;
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                refreshZTree();
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
            });
            intSelectData("sfyx", v_SFYX);
        });
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes =eval(responseData[0]);//获取后台传递的数据
            return zNodes;
        }
        function showMenu() {
            var cityObj = $("#parentname");
            var cityOffset = $("#parentname").offset();
            $("#menuContent").css({
                left: cityOffset.left-254 + "px",
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
        //初始化zTree树
        function refreshZTree(){
            var param={
                parentchildlb:b_parentchildlb,
                parentchildlbmc:b_parentchildlbmc
            };
            //初始化机构树
            $.post(basePath + '/pub/pub/queryParentchildZTree',param, function(result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                    treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    addCate();
                } else {
                    $.messager.alert('提示', result.msg, 'error');
                }
            }, 'json');

        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            $('#fm').form('load',treeNode);//用节点数据填充form
            $("#parentname").val(treeNode.parentname);
            form.render('select');
        }
        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            $("#parentname").val(treeNode.text);
            $("#parentid").val(treeNode.id);
            hideMenu();
        }

    </script>
    <script type="text/javascript">

        function refresh(){
            parent.window.refresh();
        }

        // 新增
        function addCate() {
            $('#fm').form('clear');
//            $('#aaz093').val('');
//             $('#aaa102').val('');
//             $('#aaa103').val('');
//             $('#aaa104').combotree('setValue','');
            $('#sfyx').val('1');
            <%--$('#jcxmid').val('<%=v_jyjcxmid%>');--%>
//            form.render('select');
        }

        // 删除
        function delCate() {
            var parentchildid = $('#parentchildid').val();
            if (parentchildid==null || parentchildid=="") {
                layer.alert('请选择要删除的分类');
                return false;
            }
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/pub/pub/delParentchild', {
                                parentchildid :parentchildid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        refreshZTree();
                                    });
                                    //如果删除本页的最后一条数据时 则查询上一页的数据而不是让他在本页无数据的状态
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
        }


    </script>
</head>
<body>
<div class="layui-layout-body">
    <div class="layui-side" style="width: 250px;">
        <div class="layui-side-scroll" style="width:100%;">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="layui-body" style="margin-left: 55px; width: 79%;">
        <div class="layui-collapse">
            <div class="layui-colla-item" style="width:100%">
                <h2 class="layui-colla-title">分类信息</h2>
                <div class="layui-colla-content layui-show">
                    <form class="layui-form" id="fm">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">通用父子关系表ID:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="parentchildid" name="parentchildid" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>父级分类:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="parentname" name="parentname" lay-verify="required" readonly
                                       autocomplete="off"  class="layui-input layui-bg-gray" onclick="showMenu();">
                                <input type="hidden" id="parentid" name="parentid">
                            </div>
                        </div>
                        <div id="menuContent" class="menuContent"
                             style="display:none;position:absolute;z-index:333;height: 200px;width: 250px;">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>是否有效:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <select id="sfyx" name="sfyx" lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">编号:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="bh" name="bh"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>名称:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="mc" name="mc" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">操作员:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="username" name="username" readonly
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">操作时间:</label>
                            <div class="layui-input-inline" style="width: 750px">
                                <input type="text" id="czsj" name="czsj" disabled
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <ck:permission biz="addSysfunction">
                                    <button class="layui-btn" data-type="addSysfunction" data="btn_addSysfunction"
                                            >新增
                                    </button>
                                </ck:permission>
                                <ck:permission biz="delSysfunction">
                                    <button class="layui-btn layui-btn-danger" type="button"
                                            data="btn_delSysfunction" onclick="delCate()">删除
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

</div>
</body>
</html>