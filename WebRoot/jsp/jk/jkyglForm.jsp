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
	String jkid = StringHelper.showNull2Empty(request.getParameter("jkid"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>监控源编辑</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        //下拉框列表
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
                var lock = true;// 锁住表单   这里定义一把锁
                var url;
                if ($('#jkid').val().length > 0) {
                    url = basePath + '/jk/jkgl/updateJky';
                } else {
                    url = basePath + '/jk/jkgl/addJky';
                }
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
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
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#jkid').val().length > 0) {
                    $.post(basePath + '/jk/jkgl/queryJkyDTO', {
                            jkid: $('#jkid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                            } else {
                                layer.alert('提示', '查询失败：' + result.msg);
                            }
                        }, 'json');

                    if ('<%=op%>' == 'view') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                    }


                    //$('#jkqybh').addClass('input_readonly');
                    //$('#jkqybh').attr('readonly','readonly');
                    //$('#jkybh').addClass('input_readonly');
                    //$('#jkybh').attr('readonly','readonly');
                    //$('#camorgid').addClass('input_readonly');
                    //$('#camorgid').attr('readonly','readonly');
                }
            })
        });


        // 保存
        var submitForm = function () {
            $("#saveAjdjBtn").click();

        };


        // 关闭窗口
        var closeWindow = function () {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        function showMenu_aaa027() {
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
            parent.sy.modalDialog({
                title: '监控',
                area: ['300px', '400px'],
                content: url
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                if (typeof(obj.type) != "undefined" && obj.type != null && obj.type == 'ok') {
                    $('#aaa027').val(obj.aaa027);
                    $('#aaa027name').val(obj.aaa027name);
                }
                sy.removeWinRet(dialogID);//不可缺少
            })
        }
	</script>
</head>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form class="layui-form" action="" id="jkyglForm">

			<div class="layui-container">
				<div class="layui-row">
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 100px">监控源ID:</label>

							<div class="layui-input-inline">
								<input type="text" id="jkid" name="jkid" readonly
									   autocomplete="off" class="layui-input layui-bg-gray" value="<%=jkid%>">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 143px">明厨亮灶监控对象id：</label>

							<div class="layui-input-inline">
								<input type="text" id="camorgid" name="camorgid"
									   autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 100px"><font
									class="myred">*</font>监控企业编号:：</label>

							<div class="layui-input-inline">
								<input type="text" id="jkqybh" name="jkqybh"
									   autocomplete="off" class="layui-input" lay-verify="required">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 143px"><font
									class="myred">*</font>监控企业名称:</label>

							<div class="layui-input-inline">
								<input type="text" id="jkqymc" name="jkqymc"
									   autocomplete="off" class="layui-input" lay-verify="required">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 100px"><font
									class="myred">*</font>监控源编号：</label>
							<div class="layui-input-inline">
								<input type="text" id="jkybh" name="jkybh" autocomplete="off"
									   lay-verify="required"
									   class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 143px"><font
									class="myred">*</font>监控源名称：</label>

							<div class="layui-input-inline">
								<input type="text" id="jkymc" name="jkymc" autocomplete="off"
									   lay-verify="required" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 100px">监控类型:</label>

							<div class="layui-input-inline">
								<input type="text" id="jklx" name="jklx"
									   autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 143px">显示顺序:</label>
							<div class="layui-input-inline">
								<input type="text" id="orderno" name="orderno"
									   autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 100px">离线监控视频路径:</label>

							<div class="layui-input-inline">
								<input type="text" id="jksppath" name="jksppath" autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 143px">所属统筹区:</label>

							<div class="layui-input-inline">
								<input type="text" id="aaa027name" name="aaa027name" autocomplete="off"
									   class="layui-input"
									   readonly onclick="showMenu_aaa027();">
								<input name="aaa027" id="aaa027" type="hidden"/>
								<div id="menuContent_aaa027" class="menuContent"
									 style="display:none; position: absolute;">
									<ul id="treeDemo_aaa027" class="ztree"
										style="margin-top:0px;width:150px;height:450px;"></ul>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-form-item" style="display: none">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
							</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
</html>