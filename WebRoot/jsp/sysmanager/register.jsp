<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE HTML>
<html>
<head>
<title>用户注册</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link href="<%=contextPath%>/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	//下拉框列表
	var aac058 = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;				
	var cb_aac058;
	$(function() {
		cb_aac058 = $('#aac058').combobox({
			data: aac058,
			valueField: 'id',
			textField: 'text',
			required: false,
			editable: false,
			panelHeight: 'auto'
		}); 

		//校验表单
		$("#fm").validationEngine({
			//will validate on keyup and blur
			validationEventTriggers : "keyup blur",
			//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
			promptPosition : "centerRight",			 
			//addPromptClass : "formError-noArrow formError-text",
			maxErrorsPerField : 1,
			showOneMessage : true,
			//提示信息是否自动隐藏
			autoHidePrompt:true,
			//是否使用美化过的提示框
			prettySelect : true
		});

		//提交表单
		$('#zc').click(function() {
			var status = $("#fm").validationEngine("validate");
			if (status) { //表单验证通过
				//var formData = $("#fm").serialize();
				//alert($("input[name='yzmId']").val());
				var formData = {
					"aac003": $("#aac003").val(),
					"aac002": $("#aac002").val(),
					"aac154": $("#aac154").val(),
					"passwd": hex_md5($("#passwd").val()),
					"mobile": $("#mobile").val(),
					"yzmId": $("input[name='yzmId']").val(),
					"yzm": $("#yzm").val()
				};
				$("#zc").disabled = true;
				$("#btn_div").hide();
				$("#loading-mask").show();
				$.ajax({
		    		url: "<%=contextPath %>/common/userreg/saveWxsiuser",
		    		type: 'post',
		    		async: true,
		    		cache: false,
		    		timeout: 100000,
		    		data: formData,
		    		dataType: 'json',
		    		error: function() {
		    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info',function(){
		    				$("#zc").disabled = false;
		    				$("#btn_div").show();
		    				$("#loading-mask").hide();
		    			});			
		    		},
		    		success: function(result) {
		    			if (result.code == "0") {
		    				$.messager.alert('提示','注册成功！','info',function(){
		    					location.href = "<%=contextPath%>/syscommonfun/go2Login";
		    				});	
		    			} else {
		    				$.messager.alert('提示','注册失败！' + result.msg,'error',function(){
		    					$("#zc").disabled = false;
		    					$("#btn_div").show();
			    				$("#loading-mask").hide();	
		    				});	
		    			}
		    		}
		    	});	
			}
		});
    	
	});


	//重置
	var reset2 = function() {
		//$('#fm').form('clear');
		//$('#aac058').combobox('setValue','1');
		window.location.href = "<%=contextPath%>/common/userreg/go2Register";		
	};

	//发送验证码
	var b_clicked = false;
	var i_timer;
	var i_cnt = 0;
	var i_reset_sec = 60;
	function getYzm() {
		var aac003 = $("#aac003").val();
		var aac002 = $("#aac002").val();
		var mobile = $("#mobile").val();
		if (aac003 == "") {
			$.messager.alert('提示','请输入姓名!','info',function(){
				$("#aac003").focus();
			});
			return false;
		}
		if (aac002 == "") {
			$.messager.alert('提示','请输入身份证号码!','info',function(){
				$("#aac002").focus();
			});
			return false;
		} 
		if (mobile == "") {
			$.messager.alert('提示','请输入手机号码!','info',function(){
				$("#mobile").focus();
			});
			return false;
		} 
		if (b_clicked) return;
		b_clicked = true;
		i_timer = setInterval("cnt_timer()", 1000);
		$.ajax({
			url: basePath + "/common/userreg/getVerifyCode_Register",
			type: 'post',
			async: true,
			cache: false,
			data: $("#fm").serialize(),
			dataType: 'json',
			error: function() {
				$.messager.alert('提示','服务器繁忙，请稍后再试！','info');
			},
			success: function(result) {
				//alert(result.yzmId);
				$("#yzmId").val(result.yzmId);
			}
		});
	} // 倒计时
	function cnt_timer() {
		var y_id = "#yzmBtn";
		i_cnt = i_cnt + 1;
		$(y_id).html('(' + (i_reset_sec - i_cnt) + ')秒后可重新获取');
		if (i_cnt >= i_reset_sec) {
			clearTimeout(i_timer);
			i_cnt = 0;
			b_clicked = false;
			$(y_id).html('<img src="<%=contextPath%>/images/login/hqyzm.png"/>');
		}
	}
		
</script>
</head>
<body class="Loginbjstyle">
	<div align="center">
		<table width="1087" height="601" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td height="601" class="LoginBgStyle">
					<div class="maintab02">
						<table width="527" height="221" border="0" cellspacing="0"	cellpadding="0">
							<tr>
								<td height="45" colspan="2">
									<table width="527" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="131" height="45" class="tdbg_5_1" id="tab_5"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="176" height="200">&nbsp;</td>
								<td width="351">
									<div id="div_5"  style="display:block">
										<form id="fm"  method="post" >
											<table width="300" border="0" cellspacing="2" cellpadding="0">
												<tr>
										        	<td colspan="2">&nbsp;</td>
										        </tr>									      					     
										    	<tr>
										        	<td align="right"><font color="red">*</font><nobr>姓名：</nobr></td>
										        	<td align="left">
										         		<input	type="text"  name="aac003" id="aac003" maxlength="12" class="text-input validate[required,custom[chinese],minSize[2]]" /> 
										        	</td>
										      	</tr>
										      	<tr><td colspan="2"></td></tr>									     
										    	<tr>
										        	<td align="right"><font color="red">*</font><nobr>证件类型：</nobr></td>
										        	<td align="left">
										         		<input	type="text"  name="aac058" id="aac058"  value="1"  readonly="readonly"/> 
										        	</td>
										      	</tr>
										      	<tr><td colspan="2"></td></tr>									     
										    	<tr>
										        	<td align="right"><font color="red">*</font><nobr>证件号码：</nobr></td>
										        	<td align="left">
										         		<input	type="text"  name="aac002" id="aac002" maxlength="18" class="text-input validate[required,custom[IdCard]]"/> 
										        	</td>
										      	</tr>
										      	<tr><td colspan="2"></td></tr>									     
										    	<tr>
										        	<td align="right"><nobr>社保卡号：</nobr></td>
										        	<td align="left">
										         		<input	type="text"  name="aac154" id="aac154" maxlength="20" /> 
										        	</td>
										      	</tr>
										      	<tr><td colspan="2"></td></tr>									     
										      	<tr>
										      		<td align="right"><font color="red">*</font><nobr>手机号码：</nobr></td>
										        	<td  align="left">
										          		<input	type="text" name="mobile" id="mobile" maxlength="11" class="text-input validate[required,custom[mobile]]"/>
										        	</td>
										        </tr>
										        <tr><td colspan="2"></td></tr>
										        <tr>
										        	<td align="right"><font color="red">*</font><nobr>验证码：</nobr></td>
										        	<td  align="left">
										        	    <table align="left">
											        		<tr>
											        			<td>
											        				<input type="text" name="yzm" id="yzm" style="width:60px" class="text-input validate[required,custom[onlyNumberSp]]"/>
											        				<input type="hidden" name="yzmId" id="yzmId" />
											        			</td>
											        			<td>
											        				<a href="javascript:void(0)" onclick="getYzm();" id="yzmBtn"><img src="<%=contextPath%>/images/login/hqyzm.png"/></a>
											        			</td>
											        		</tr>
										        	    </table>
										        	</td>
										        </tr>
										        <tr><td colspan="2"></td></tr>
										      	<tr>
										      		<td align="right"><font color="red">*</font><nobr>密码：</nobr></td>
										        	<td  align="left">
										          		<input	type="password" name="passwd" id="passwd"  class="text-input validate[required,minSize[6],maxSize[20]]"/>
										        	</td>
										        </tr>
										        <tr><td colspan="2"></td></tr>
										      	<tr>
										      		<td align="right"><font color="red">*</font><nobr>确认密码：</nobr></td>
										        	<td  align="left">
										          		<input	type="password" name="passwd2" id="passwd2"  class="text-input validate[condRequired[passwd],equals[passwd]]"/>
										        	</td>
										        </tr>
										    </table>
										</form>
									</div>
								</td>
							</tr>
							<tr>
								<td width="176" height="26"></td>
								<td width="351" nowrap="nowrap">
									<table width="351" border="0" cellspacing="0"	cellpadding="0">
										<tr>
											<td width="100px">
												<div id="loading-mask" style="display:none;z-index:20000"><img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /></div>
											</td>											
											<td align="left">
												<div id="btn_div">
													<a href="javascript:void(0)"><img id="zc" title="注册" class="easyui-tooltip" src="<%=contextPath%>/images/login/zc.png" width="62" height="26" alt="注册"/></a>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href="javascript:void(0)" onclick="reset2();"><img id="cz" title="重置" class="easyui-tooltip" src="<%=contextPath%>/images/login/cz.png" width="62" height="26" alt="重置" /></a>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>