<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
    String animalfenceid = StringHelper.showNull2Empty(request.getParameter("animalfenceid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>动物栅栏信息管理</title>

    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<style type="text/css">
		body{
			overflow: scroll;
		}
	</style>
    <style type="text/css">
        /**treeselect*/
        .layui-form-select .layui-tree {
            display: none;
            position: absolute;
            left: 0;
            top: 42px;
            padding: 5px 0;
            z-index: 999;
            min-width: 100%;
            border: 1px solid #d2d2d2;
            max-height: 300px;
            overflow-y: auto;
            background-color: #fff;
            border-radius: 2px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .12);
            box-sizing: border-box;
        }

        .layui-form-selected .layui-tree {
            display: block;
        }
    </style>
	<script type="text/javascript">
        var index;
        var form;
        var layer;
        var laydate;
        var fenceod = '';
        $(function () {
            $('#fenceno').blur(function () {
                var fenceno = $('#fenceno').val();
                if (fenceno == null || fenceno == '') {
                    return false;
                }
                if (fenceno != fenceod) {
                    checkUniqueness();
                }
            })
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                var lock=true;
                form.on('submit(saveNews)', function (data) {
                    var formData=data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + '/animal/saveAnimalfence', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock=true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });


            });
            if ('<%=op%>' == 'view') {
                $('form:input').addClass('input_readonly');
                $('form:input').attr('readonly', 'readonly');
                $('#fenceremarks').attr('readonly', 'readonly');
                $('input').attr('disabled', 'true');
            }
            var id = $("#animalfenceid").val();
            if (id != "" && id != null) {
                $.ajax({
                    type:'POST',
                    url:basePath + '/animal/queryAnimalfenceDTO',
                    dataType:'json',
                    data:{animalfenceid:$('#animalfenceid').val()},
                    async:false,
                    success:function(result){
                        var mydata = result.data;
                        $('form').form('load', mydata);
                        $("#parentname").val(mydata.housename);
                        $("#fencenoold").val(mydata.fenceno);
                        form.render();
                    }
                });

            }



        });


        // 保存
        function saveFun() {
            $("#saveNewsBtn").click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
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

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.animalhouseData);//获取后台传递的数据
            return zNodes;
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

        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();
            $("#houseid").val(nodes[0].animalhouseid);
            $("#houseno").val(nodes[0].houseno);
            $("#parentname").val(nodes[0].housename);
            hideMenu();
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

        //验证编码唯一性
        function checkUniqueness() {
            fenceod = $('#fenceno').val();
            var fenceno = $('#fenceno').val();
            var fencenoold = $('#fencenoold').val();
            if(fencenoold==fenceno){
                fenceod = fenceno;
                $('#fenceno').val(fenceno);
                $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
            }else {
                if (fenceno != null && fenceno != "") {
                    $.post(basePath + '/animal/queryAnimalfenceDTO', {
                            fenceno: fenceno
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                //存在
                                if (mydata != undefined) {
                                    layer.msg("编号重复请重新填写");
                                    $('#fenceno').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编号唯一</font>");
                                } else {
                                    fenceod = fenceno;
                                    $('#fenceno').val(fenceno);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
                }
            }
        }



	</script>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="animalfenceid" name="animalfenceid" type="hidden" value="<%=animalfenceid%>"/>
            <div class="layui-form-item" >
                <label class="layui-form-label" ><font class="myred">*</font>栅栏编号:</label>

                <div class="layui-input-inline" style="width: 400px">
                    <input type="text" id="fenceno" name="fenceno"
                           autocomplete="off" class="layui-input" lay-verify="required">
                    <input id="fencenoold" name="fencenoold" type="hidden"/>
                </div>
                <div class="layui-input-inline">
                    <font color="red" id="greentext">保证编号唯一</font>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" ><font class="myred">*</font>栅栏名称:</label>

                <div class="layui-input-inline" style="width: 400px">
                    <input type="text" id="fencename" name="fencename"
                           autocomplete="off" class="layui-input" lay-verify="required">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label"><font class="myred">*</font>动物舍所:</label>

                <div class="layui-input-inline" style="width: 400px">
                    <input type="text" id="parentname" name="parentname" onclick="showMenu();"
                           readonly class="layui-input layui-bg-gray" lay-verify="required">
                    <input name="houseno" id="houseno" type="hidden"/>
                    <input name="houseid" id="houseid" type="hidden"/>
                </div>
            </div>
            <div id="menuContent" class="menuContent"
                 style="display:none;position:fixed;z-index:333;height: 200px;width: 250px;">
                <ul id="treeDemo2" class="ztree"></ul>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" >栅栏备注:</label>
                <div class="layui-input-inline" style="width: 400px">
                    <textarea placeholder="请输入内容" class="layui-textarea" id="fenceremarks" name="fenceremarks"></textarea>
                </div>
            </div>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="saveNews"
                            id="saveNewsBtn">保存
                    </button>
                </div>
            </div>
        </form>
    </div>

</div>

</body>
</html>