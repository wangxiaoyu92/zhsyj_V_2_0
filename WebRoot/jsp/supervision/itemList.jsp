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
	<title>检查项目管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">
        var v_mycomfenleiztree;
        var v_itemtree;
        var form;
        var layer;
        var element;
        //下拉框数据
        var itemtypeData = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
        var planmobankindData = <%=SysmanageUtil.getAa10toJsonArray("PLANMOBANKIND")%>;
        var setting = {
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
                onClick: onClick,
                beforeAsync: beforeAsync,
                onAsyncError: onAsyncError,
                onAsyncSuccess: onAsyncSuccess
            }
        };

        //gu20180325
        var settingComfeilei = {
            view: {
                showLine: true
            },
            check: {
                enable: true,
                chkboxType: {"Y": "s", "N": "s"}
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "aaa102",
                    pIdKey: "aaa104",
                    rootPId: null
                },
                key: {
                    name: "aaa103"
                }
            },
            callback: {
                onCheck: ''
            }

        };


        $(function () {
            layui.use(['form', 'element', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                element = layui.element;

                form.on('submit(delete)', function (data) {
                    var msg = "是否确认删除";
                    var itemid = $('#itemid').val();
                    if (itemid) {
                        layer.confirm(msg, function (index) {
                            $.post(basePath + '/supervision/checkinfo/delCheckGroup', {itemid: itemid},
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
                        layer.msg('没有选择机构数据，无法删除！');
                    }
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(basePath + '/supervision/checkinfo/saveCheckGroup', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功！');
                            //刷新左侧的树
                            refreshZTree();
                            addItem();
                        }
                        else {
                            layer.msg('保存失败！' + result.msg);
                        }
                    })
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })

                $(document).on('click', '#btnsaveComfenlei', function () {
                    savecomfenlei();
                });

            })
            ;
            refreshZTree();
            //初始化下拉框选项数据
            intSelectData('itemtype', itemtypeData);
            intSelectData('planmobankind', planmobankindData);
            initUserComfeileiZTree();
            //gu20180325
        })
        ;

        // 初始化【统筹区授权】树
        function initUserComfeileiZTree(){
            $.ajax({
                url: basePath + '/pub/pub/queryComfeileiZTree',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: '',
                dataType: 'json',
                error: function() {
                    $.messager.alert('提示','服务器繁忙，请稍后再试！','info');
                },
                success: function(result) {
                    if (result.code == '0') {
                        //准备zTree数据
                        var zNodesComfeilei = eval(result.comfeileiData);
                        v_mycomfenleiztree=$.fn.zTree.init($("#treeDemo_comfeilei"), settingComfeilei, zNodesComfeilei);
                        //initUserAaa027CheckedZTreeNodes();
                        myinitchecked();
                    } else {
                        $.messager.alert('提示', result.msg, 'error');
                    }
                }
            });
        }

        //初始化下拉框选项数据
        function initSelectData() {
            var typeOptions = '';
            for (var i = 0; i < itemtypeData.length; i++) {
                typeOptions += '<option value=\'' + itemtypeData[i].id + '\' >' + itemtypeData[i].text + '</option>';
            }
            $("#itemtype").append(typeOptions);
        }

        //初始化检查项目树
        function refreshZTree(){
            v_itemtree=$.fn.zTree.init($("#treeDemo"), setting);
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

        //根据返回值确定是否允许进行异步加载
        function beforeAsync(treeId, treeNode) {
            //
        }
        function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
            //
        }
        function onAsyncSuccess(event, treeId, treeNode, msg) {
            //
        }

        function onClick(e, treeId, treeNode) {
            $('#fm').form('load', treeNode);
            form.render();
            //gu20180325
            if (treeNode.level == 2) {
                document.getElementById("div_comfenlei").style.display = "";
                //myinitchecked(treeNode.plantypearea);
                myinitchecked2(treeNode.itemid);
            } else {
                document.getElementById("div_comfenlei").style.display = "none";
            }
        }
        ;

        function myinitchecked2(prm_itemid) {
            $.ajax({
                url: basePath + '/supervision/checkinfo/queryCheckAndType',
                type: 'post',
                async: true,
                cache: false,
                timeout: 100000,
                data: {itemid: prm_itemid},
                dataType: 'json',
                error: function () {
                    layer.msg('服务器繁忙，请稍后再试！');
                },
                success: function (result) {
                    if (result.code == '0') {
                        //准备zTree数据
                        var mydata = result.rows;
                        v_mycomfenleiztree.checkAllNodes(false);
                        for (var i = 0; i < mydata.length; i++) {

                            var node = v_mycomfenleiztree.getNodeByParam("aaa102", mydata[i].aaa102, null);
                            if (null != node) {
                                v_mycomfenleiztree.checkNode(node, true, false, true);
                            }
                        }
                    } else {
                        layer.msg(result.msg);
                    }
                }
            });
        }
        ;

        function myinitchecked(prm_comfenleicodes) {
            var mycomfenleicodearr = new Array();

            if (prm_comfenleicodes != null) {
                mycomfenleicodearr = prm_comfenleicodes.split(",");
            }
            v_mycomfenleiztree.checkAllNodes(false);
            for (var i = 0; i < mycomfenleicodearr.length; i++) {
                var node = v_mycomfenleiztree.getNodeByParam("aaa102", mycomfenleicodearr[i], null);
                if (null != node) {
                    v_mycomfenleiztree.checkNode(node, true, false, true);
                }
            }
        }
        ;

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

        //新增
        var addItem = function () {
            $('#fm').form('clear');
        };

        //gu20180325保存选择的企业分类
        var savecomfenlei = function () {
            var mycheckedNodes = v_mycomfenleiztree.getCheckedNodes(true);
            var v_comdaleicode = "";
            for (var i = 0; i < mycheckedNodes.length; i++) {
                if (v_comdaleicode == "") {
                    v_comdaleicode = mycheckedNodes[i].aaa102;
                } else {
                    v_comdaleicode += ',' + mycheckedNodes[i].aaa102;
                }
            }
            ;
            var v_itemid = $("#itemid").val();
            $.post(basePath + 'supervision/checkinfo/saveItemidComfenlei', {
                    itemid: v_itemid,
                    plantypearea: v_comdaleicode
                },
                function (result) {
                    if (result.code == '0') {
                        //v_oldplantypearea=v_plantypearea;//gu20180325
//                    var itemtreenode = v_itemtree.getNodeByParam("itemid", v_itemid, null);
//                    v_itemtree.setEditable(true);
//                    itemtreenode.plantypearea=v_comdaleicode;
//                    v_itemtree.setEditable(false);

                        layer.msg('保存企业分类成功', {time: 1000}, function () {
                        });
                    } else {
                        layer.open({
                            title: '提示'
                            , content: '保存企业分类失败' + result.msg
                        });
                    }
                }, 'json');
        };

	</script>
</head>
<body class="layui-layout-body">
<div class="layui-side layui-bg-gray" style="width: 250px;">
	<div class="layui-side-scroll" style="width:250px;">
		<ul id="treeDemo" class="ztree" ></ul>
	</div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
	<table width="100%">
		<tr>
			<td width="50%">
				<div class="layui-collapse">
					<div class="layui-colla-item" style="width:100%;height:50%;">
						<h2 class="layui-colla-title">检查项目信息</h2>
						<div class="layui-colla-content layui-show">
							<form class="layui-form" id="fm">
								<div class="layui-form-item">
									<label class="layui-form-label">项目ID</label>
									<div class="layui-input-block">
										<input type="text" id="itemid" name="itemid" readonly
											   class="layui-input layui-bg-gray">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">项目类别</label>
									<div class="layui-input-block">
										<select id="itemtype" name="itemtype" lay-verify="required"></select>
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">项目名称</label>
									<div class="layui-input-block">
										<input type="text" id="itemname" name="itemname" autocomplete="off"
											   required lay-verify="required" class="layui-input">
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
										<input type="text" id="parentname" name="parentname" onclick="showMenu();"
											   class="layui-input">
										<input name="itempid" id="itempid" type="hidden"/>
									</div>
								</div>
								<div id="menuContent" class="menuContent" style="display:none;">
									<ul id="treeDemo2" class="ztree"></ul>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">备注</label>
									<div class="layui-input-block">
										<input type="text" id="itemremark" name="itemremark" autocomplete="off"
											   class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">排序号</label>
									<div class="layui-input-block">
										<input type="text" id="itemsortid" name="itemsortid" autocomplete="off"
											   class="layui-input">
									</div>
								</div>
								<div class="layui-form-item">
									<label class="layui-form-label">项目类别</label>
									<div class="layui-input-block">
										<select id="planmobankind" name="planmobankind" ></select>
									</div>
								</div>
								<div class="layui-form-item">
									<div class="layui-input-block">
										<ck:permission biz="addItem" >
											<button class="layui-btn" data-type="addItem" data="btn_addItem"
													onclick="addItem()">新增</button>
										</ck:permission>
										<ck:permission biz="delItem" >
											<button class="layui-btn layui-btn-danger" data-type="delItem" data="btn_delItem"
													lay-submit="" lay-filter="delete">删除</button>
										</ck:permission>
										<ck:permission biz="saveItem" >
											<button class="layui-btn" data-type="saveItem" data="btn_saveItem"
													lay-submit="" lay-filter="save">保存</button>
										</ck:permission>
									</div>
								</div>
							</form>
						</div>

					</div>
				</div>
			</td>

			<td style="margin-left: 50px;margin-right: 10px;">
				<div id="div_comfenlei" style="display: none">
					<table style="width: 100%;height: 100%;">
						<tr>
							<td>
								<p style="text-align: center">请选择检查项目对应的企业分类</p>
								<ul id="treeDemo_comfeilei" class="ztree" style="width: 97%;height: 510px;"></ul>
							</td>
						</tr>
						<tr>
							<td style="text-align: center">
								<br/>
								<button class="layui-btn" id="btnsaveComfenlei" data="btn_saveComfenlei">保存企业分类</button>
							</td>
						</tr>
					</table>
				</div>

			</td>
		</tr>
	</table>

</div>
</div>
</body>
</html>