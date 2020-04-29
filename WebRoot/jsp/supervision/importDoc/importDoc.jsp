<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>doc模板导入</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        var form;
        var layer;
        var lock = true;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var url = basePath + '/supervision/checkinfo/saveImportDoc';
            });
        })


        // 保存检查项目内容信息
        function saveRole() {
            if (!lock) {
                return
            }
            lock = false;
            var url = basePath + '/supervision/checkinfo/saveImportDoc';
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    if (!isValid) {
                        $.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;
                },
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg('保存成功！', {time: 1000}, function () {
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
                            title: "提示",
                            content: "保存失败：" + result.msg //这里content是一个普通的String
                        });
                        lock = true;
                    }
                }
            });
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
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
        //校验文件
        var checkFile = function () {
            var str = $('#file').val();
            if (str == "" || str == null) {
                $.messager.alert('提示', '请选择需要导入的文件!', 'info');
                return false;
            }
            return true;
        }
        function submitForm() {
            $("#saveRoleBtn").click();
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
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
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
<div class="layui-margin-top-15">
    <form id="fm" class="layui-form" enctype="multipart/form-data" method="post">
        <div class="layui-container">
            <div class="layui-row">
                <div class="layui-col-md4 layui-col-xs12 layui-col-sm8 layui-col-md-offset4 layui-col-xs-offset0 layui-col-sm-offset2">
                    <div class="layui-form-item">
                        <label class="layui-form-label">检查表</label>

                        <div class="layui-input-inline">
                            <input type="text" id="itemname" name="itemname" onclick="showMenu();"
                                   class="layui-input">
                            <input name="itemid" id="itemid" type="hidden"/>
                        </div>
                    </div>
                    <div id="menuContent" class="menuContent" style="display:none;">
                        <ul id="treeDemo2" class="ztree"></ul>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">明细附件上传</label>

                        <div class="layui-input-block">
                            <input type="file" id="file" name="file" onchange="checkFile();"/>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">明细上传模板</label>

                        <div class="layui-input-block">
                            <a href="<%=basePath %>jsp/supervision/importDoc/明细上传模板.doc"> 明细上传模板 </a>
                        </div>
                    </div>
                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" onclick="saveRole()"
                                    id="saveRoleBtn">保存
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