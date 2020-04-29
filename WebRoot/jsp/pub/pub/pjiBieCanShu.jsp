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
    String v_aaa100 = StringHelper.showNull2Empty(request.getParameter("aaa100"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>中标分类设置</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var treeObj;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;

        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "aaa102",
                    pIdKey: "aaa104",
                    rootPId: 0
                },
                key: {
                    name: "aaa103"
                }
            },
            callback: {
                onClick: onClick
            }

        };
        var setting2 = {
            view: {
                showLine: true
            },
            async: {
                enable: true, //启用异步加载
                url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=<%=v_aaa100%>',  //调用后台的方法
                dataFilter: ajaxDataFilter,//用于对 Ajax返回数据进行预处理
                autoParam: ["aaa102"], //向后台传递的参数
                otherParam: {}, //额外的参数
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "aaa102",
                    pIdKey: "aaa104",
                    rootPId: 0
                },
                key: {
                    name: "text"
                }
            },
            callback: {
                onClick: onClick2
            }
        }
        var form;
        var element;
        var layer;
        var table;
        $(function () {
            refreshZTree();
            layui.use(['form', 'table', 'element', 'laydate', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                element = layui.element;
                layer = layui.layer;
                var url = basePath + '/pub/pub/saveJiBieCanShu';
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
            })
            intSelectData("aaa105", v_SFYX);
        });

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes =eval(responseData);//获取后台传递的数据
            return zNodes;
        }
        function onClick2(event, treeId, treeNode) {
            $("#parentname").val(treeNode.text);
            $("#aaa104").val(treeNode.id);
//            $("#jcxmparentid").val(treeNode.jcxmparentid);
            hideMenu();
        }
        //初始化zTree树
        function refreshZTree() {
            //初始化机构树
            $.post(basePath + '/pub/pub/queryJiBieCanShuZTree?aaa100=<%=v_aaa100%>', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                    treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    addCate();
                    //treeObj.expandAll(true);
                    //addNewsCate();//
                } else {
                    layer.alert('提示:'+result.msg);
                }
            }, 'json');
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            if(treeNode.parentname==undefined){
                $("#parentname").val("");
            }
            form.render('select');
        }

    </script>
    <script type="text/javascript">
        var cbt_parent;

        function refresh() {
            parent.window.refresh();
        }

        // 新增
        function addCate() {
            $('#fm').form('clear');
            /* 		$('#aaz093').val('');
                    $('#aaa102').val('');
                    $('#aaa103').val('');
                    $('#aaa104').combotree('setValue',''); */
            $('#aaa105').val("1");
            $('#aaa100').val('<%=v_aaa100%>');
//            form.render('select');
        }

        // 删除
        function delCate() {
            var v_aaz093 = $('#aaz093').val();
            if (v_aaz093 == null || v_aaz093 == "") {
                layer.alert('请选择要删除的分类');
                return false;
            }
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '您确定要删除该分类吗？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/pub/pub/delJiBieCanShu', {
                            aaz093: v_aaz093,
                            aaa100: '<%=v_aaa100%>'
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
                        <input type="hidden" id="aaa101" name="aaa101">
                        <input type="hidden" id="aaz094" name="aaz094">
                        <input type="hidden" id="aaa106" name="aaa106">
                        <input type="hidden" id="aaa107" name="aaa107">
                        <input type="hidden" id="aae011" name="aae011">
                        <input type="hidden" id="aae036" name="aae036">
                        <input type="hidden" id="aaa100" name="aaa100" value="<%=v_aaa100%>">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">级别参数表id:</label>
                            <div class="layui-input-inline" style="width: 790px">
                                <input type="text" id="aaz093" name="aaz093" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>级别参数编码:</label>
                            <div class="layui-input-inline" style="width: 790px">
                                <input type="text" id="aaa102" name="aaa102" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>级别参数名称:</label>
                            <div class="layui-input-inline" style="width: 790px">
                                <input type="text" id="aaa103" name="aaa103" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width:100px;"><font
                                    class="myred">*</font>父级分类:</label>
                            <div class="layui-input-inline" style="width: 790px">
                                <input type="text" id="parentname" name="parentname" lay-verify="required"
                                       autocomplete="off"  class="layui-input" onclick="showMenu();">
                                <input type="hidden" id="aaa104" name="aaa104">
                            </div>
                        </div>
                        <div id="menuContent" class="menuContent"
                             style="display:none;position:absolute;z-index:333;height: 200px;width: 250px;">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">是否启用:</label>
                            <div class="layui-input-inline" style="width: 790px">
                                <select id="aaa105" name="aaa105"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <ck:permission biz="addSysfunction">
                                    <button class="layui-btn" type="button" data-type="addSysfunction" data="btn_addSysfunction" onclick="addCate()"
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