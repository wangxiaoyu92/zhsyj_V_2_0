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
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String basetype = StringHelper.showNull2Empty(request.getParameter("basetype"));
    String itemtype = StringHelper.showNull2Empty(request.getParameter("itemtype"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>项目内容</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        var form;
        var layer;
        var op = "<%=op%>";
        $(function () {
            if (op == "edit") {
                $.post(basePath + '/supervision/checkinfo/queryCheckAndType', {
                            basetype: $('#basetype').val(),
                            itemid: $('#itemtype').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                if (mydata != null) {
                                    //加载类别列表
                                    radio(mydata.aaa100);
                                    showcomList(mydata.aaa100, mydata.aaa102);
                                    $('#aaa102').val(mydata.aaa102);
                                    $('#itemname').val(mydata.itemname);
                                    $("#itemid").val($('#itemtype').val());
                                    layui.use('form', function () {
                                        form = layui.form;
                                        form.render();//重新渲染form表单
                                    })
                                }
                            } else {
                                layer.msg('查询失败：' + result.msg);
                            }
                        }, 'json');

            } else {
                //加载类别列表
                showcomList("comdalei", null);
                radio("comdalei");
            }
            layui.use(['form', 'layer'], function () {//保存
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/supervision/checkinfo/saveCheckAndType';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });

                form.on('radio(comdalei)', function (data) {//单选框点击事件
                    var val = data.value
                    showcomList(val, null);
                    radio(val);
                    form.render('select');//重新渲染form表单
                });
            });
        });

        //表单提交
        function submitForm() {
            $("#save").click();
        }

        // 关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        //获取单选框的值
        function radio(aaa100) {
            var radio = $("input[name='comdalei']");
            if ('COMDALEI' == aaa100 || "comdalei" == aaa100) {
                radio.eq(0).attr("checked", true);
                $("#aaa100").val('COMDALEI');
            } else if ('COMXIAOLEI' == aaa100 || "comxiaolei" == aaa100) {
                radio.eq(1).attr("checked", true);
                $("#aaa100").val('COMXIAOLEI');
            } else if ('JCSBJCGM' == aaa100 || 'jcsbjcgm' == aaa100) {
                radio.eq(2).attr("checked", true);
                $("#aaa100").val('JCSBJCGM');
            }
        }

        //获取类别列表
        function showcomList(val, aaa102) {
            var aaa102value;
            var aaa102Options = '';
            if ("COMDALEI" == val || "comdalei" == val) {
                aaa102value =<%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
                aaa102Options = '';
                for (var i = 0; i < aaa102value.length; i++) {
                    if (aaa102 == aaa102value[i].id) {
                        aaa102Options += '<option select value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    } else {
                        aaa102Options += '<option value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    }
                }
                $("#aaa102").html(aaa102Options);
            } else if ("COMXIAOLEI" == val || "comxiaolei" == val) {
                aaa102value =<%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>;
                aaa102Options = '';
                for (var i = 0; i < aaa102value.length; i++) {
                    if (aaa102 == aaa102value[i].id) {
                        aaa102Options += '<option select value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    } else {
                        aaa102Options += '<option value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    }
                }
                $("#aaa102").html(aaa102Options);
            } else if ('JCSBJCGM' == val || 'jcsbjcgm' == val) {
                aaa102value = <%=SysmanageUtil.getAa10toJsonArray("jcsbjcgm")%>;
                aaa102Options = '';
                for (var i = 0; i < aaa102value.length; i++) {
                    if (aaa102 == aaa102value[i].id) {
                        aaa102Options += '<option select value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    } else {
                        aaa102Options += '<option value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                    }
                }
                $("#aaa102").html(aaa102Options);
            }
        }
    </script>
    <script type="text/javascript">
        var setting2 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法
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
            $("#itemid").val(nodes[0].itemid);
            $("#itemname").val(nodes[0].itemname);
            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#itemname");
            var cityOffset = $("#itemname").offset();
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

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
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
    </script>
</head>
<body>

<div>
    <form id="fm" class="layui-form" action="">
        <div class="layui-container">
            <div class="layui-row">
                <input id="op" name="op" style="width: 200px;" hidden="hidden" value='<%=op%>'/>
                <input id="basetype" name="basetype" style="width: 200px;" hidden="hidden" value='<%=basetype%>'/>
                <input id="itemtype" name="itemtype" style="width: 200px;" hidden="hidden" value='<%=itemtype%>'/>
                <input name="filepath" id="filepath" hidden="hidden"/>

                <div class="layui-col-md8 layui-col-xs12 layui-col-sm10 layui-col-md-offset2 layui-col-xs-offset0 layui-col-sm-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">企业类型：</label>

                        <div class="layui-input-inline" style="width: 400px">
                            <input type="radio" name="comdalei" lay-filter="comdalei" value="comdalei" title="企业大类">
                            <input type="radio" name="comdalei" lay-filter="comdalei" value="comxiaolei" title="企业小类">
                            <input type="radio" name="comdalei" lay-filter="comdalei" value="jcsbjcgm" title="聚餐规模">
                            <input type="text" name="aaa100" id="aaa100" hidden="hidden"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><span
                                style="color: red;">*</span>类别：</label>

                        <div class="layui-input-inline" style="width: 300px">
                            <select name="aaa102" id="aaa102" required lay-verify="required"></select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><span
                                style="color: red;">*</span>计划项：</label>

                        <div class="layui-input-inline" style="width: 300px">
                            <input name="itemname" id="itemname" onclick="showMenu();" class="layui-input layui-bg-gray"
                                   required lay-verify="required" readonly>
                            <input name="itemid" id="itemid" type="text" hidden="hidden"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div id="menuContent" class="menuContent" style="display:none;position:fixed;z-index:333;">
                            <ul id="treeDemo2" class="ztree" style="height:250px;width: 250px;"></ul>
                        </div>
                    </div>
                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="save"
                                    id="save">保存
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>