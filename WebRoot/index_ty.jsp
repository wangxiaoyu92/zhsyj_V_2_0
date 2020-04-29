<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%	
	String systemcode = StringHelper.showNull2Empty(request.getParameter("systemcode"));
	System.out.print("-----------" + systemcode + "------------");	
%>
<%
	//如果用户已经登录过了，不再登录，直接跳转到主页面【zjf】
	Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
	if(sysuser!=null){
		request.getSession().setAttribute("systemcode",systemcode);
		request.getRequestDispatcher("/jsp/main.jsp").forward(request, response);
	}
%> 
<!DOCTYPE HTML>
<html>
<head>
<title>食品药品综合监管执法平台</title>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link href="<%=contextPath%>/css/login.css" rel="stylesheet" type="text/css" />
<script src="<%=contextPath%>/pages.js/index_ty.js" type="text/javascript" ></script>
<style>
 .div-phone a.send1{height: 26px;text-decoration:none;line-height: 26px;padding:2px;width: 90px;background: #AA8926;font-family: '宋体';color: #fff;font-size: 12px;text-align: center;border-radius:2px;margin-left:2px;-webkit-transition:all 0.2s linear;-moz-transition:all 0.2s linear;-ms-transition:all 0.2s linear;-o-transition:all 0.2s linear;transition:all 0.2s linear;}
 .div-phone a.send1:hover{text-decoration: none;background: #866c1b;-webkit-transition:all 0.2s linear;-moz-transition:all 0.2s linear;-ms-transition:all 0.2s linear;-o-transition:all 0.2s linear;transition:all 0.2s linear;}
 .div-phone a.send0{height: 26px;text-decoration:none;line-height: 26px;padding:2px;width: 90px;background: #A1A1A1;font-family: '宋体';color: #fff;font-size: 12px;text-align: center;border-radius:2px;margin-left:2px;}
 .div-phone a.send0:hover{background: #A1A1A1;font-family: '宋体';color: #fff;font-size: 12px;text-decoration: none;}

</style>
<script>
$(function() {
var url1 = "http://42.236.68.68:8080/syjzhpt/"; 
//  window.location.href = url1;
// window.open(url1);
});
//验证码倒计时
var sends = {
	checked:1,
	send:function(){
// 			var numbers = /^1\d{10}$/;
			var numbers = /^1[3|4|5|7|8]\d{9}$/;
			var val = $('#userName_5').val().replace(/\s+/g,""); //获取输入手机号码
			if( $('.div-phone a').attr('class') == 'send1'){
				if(val=="tygly" || val == "admin"){
				$('#userName_5').val("");
				$('.qxmima').css('display','none');
				$('.mima').css('display','');
				$('#userName_1').val(val);
				$('#checkfrom').removeAttr("onclick").attr("onclick","checkform();");
				}else if(!numbers.test(val) || val.length ==0){
// 					$('.div-phone').append('<span class="error">手机格式错误</span>');
                     $.messager.alert('提示','手机格式错误,请输入正确的手机号码','error');	
					return false;
				}else {
				//发送验证码
				$.post(basePath + '/servlet/PhoneCodeServlet?' + Math.random(),{
				username : $('#userName_5').val()
				},
				function(result) {
				if(result=="" || result==null){
				alert("验证码已经发到手机上，请注意查收");
				}else {
				$.messager.alert('提示','登录失败！'+result,'error');	
				}
			},'json');
			}
			
			}
			if(numbers.test(val)){
				var time = 30;
				//移除错误
// 				$('.div-phone span').remove();
               
				function timeCountDown(){
					if(time==0){//倒计时结束
					//取消倒计时
						clearInterval(timer);
						$('.div-phone a').attr("onclick","sends.send();");
						$('.div-phone a').addClass('send1').removeClass('send0').html("发送验证码");
						sends.checked = 1;
						return true;
					}
					$('.div-phone a').html(time+"S后再次发送");
					time--;
					return false;
					sends.checked = 0;
				}
				 $('.div-phone a').removeAttr("onclick");
				$('.div-phone a').addClass('send0').removeClass('send1');
				timeCountDown();
				//倒计时开始
				var timer = setInterval(timeCountDown,1000);
			}
	}
}


function sendyzm(){
			var numbers = /^1[3|4|5|7|8]\d{9}$/;
			var val = $('#userName_1').val().replace(/\s+/g,""); //获取输入手机号码
				if(val=="tygly" || val == "admin"){
				$('.qxmima').css('display','none');
				$('.mima').css('display','');
				$('#checkfrom').removeProp("onclick").prop("onclick","checkform();");
				}else if(!numbers.test(val) || val.length ==0){
// 					$('.div-phone').append('<span class="error">手机格式错误</span>');
                     $.messager.alert('提示','手机格式错误,请输入正确的手机号码','error');	
					return false;
				}else {
				$('#userName_1').val("");
				$('.qxmima').css('display','');
				$('.mima').css('display','none');
				$('#userName_5').val(val);
				$('#checkfrom').removeAttr("onclick").attr("onclick","checkform1();");
				}
				
				}
</script>
</head>
<body class="LoginBgStyle">
	<div align="center">
		<table width="1087" height="601" border="0" cellpadding="0"	cellspacing="0" >
			<tr>
				<td height="601" class="LoginBgStyle_syjzhpt">
					<div class="maintab02">
						<table width="527" height="221" border="0" cellspacing="0"	cellpadding="0">
							<tr>
								<td height="45" colspan="2">
									<table width="527" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="131" height="45" class="tdbg_1_2"	onclick="switch_tab(1)" id="tab_1"></td>
<%--											<td width="131" height="45" class="tdbg_2_2"	onclick="switch_tab(2)" id="tab_2"></td>--%>
<%--											<td width="131" height="45" class="tdbg_3_2"	onclick="switch_tab(3)" id="tab_3"></td>--%>
<%--											<td width="131" height="45" class="tdbg_4_2"	onclick="switch_tab(4)" id="tab_4"></td>--%>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="176" height="200">&nbsp;</td>
								<td width="351">
									<div id="div_1" style="display:none">
										<input id="systemcode" name="systemcode" value="<%=systemcode%>"  type="hidden"  /> 
										<form id="fm1"  method="post" >
										<table width="300" border="0" cellspacing="2" cellpadding="0">
											<tr class ="div-phone qxmima">
										      	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/user.png);background-repeat:no-repeat;">&nbsp;</td>
										        <td>用户名：</td>
										        <td  style="width:200px;height: 26px;padding-right: 15px">
										        	<input	style="width:100px;" type="text" id="userName_5"  name="userName"   /> 
										        	<a  href="javascript:;" class="send1" onclick="sends.send();">发送验证码</a>
										        </td>
									      	</tr>
									      		<tr style="display: none" class="mima" >
										      	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/user.png);background-repeat:no-repeat;">&nbsp;</td>
										        <td>用户名：</td>
										        <td align="left">
										        	<input	type="text"  id="userName_1" name="userName"  onblur="sendyzm();" value=""  /> 
										        </td>
									      	</tr>
									       	<tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>
									        
									        
									        <tr style="display: none" class="mima">
										    	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/lock.png);background-repeat:no-repeat;">&nbsp;</td>
										      	<td>密 &nbsp;&nbsp;&nbsp;码：</td>
									        	<td align="left">
									          		<input	type="password" id="userPwd_1"  name="userPwd" value=""  />
									        	</td>
									        </tr>
									        								     
									      	<tr class="qxmima" >
                                               <td style="width:7%;background-image:url(<%=contextPath%>/images/login/key.png);background-repeat:no-repeat;">&nbsp;</td> 
										      	<td>验证码：</td>
									        	<td align="left">
									          		<input	type=text id="yzm1" style="width:180px"   name="yzm"  onKeyDown="onEnter()" value=""  />
									          		<input type="hidden" name="yzmId1" id="yzmId1" />
									        	</td>


									        </tr>
									        <tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>								
										</table>
										</form>									
									</div>
									<div id="div_2" style="display:none">
										<form id="fm2"  method="post" >
										<table width="300" border="0" cellspacing="2" cellpadding="0">
											<tr>
										      	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/user.png);background-repeat:no-repeat;">&nbsp;</td>
										        <td>用户名：</td>
										        <td align="left">
										        	<input	type="text"  id="userName_2" name="userName" value=""  /> 
										        </td>
									      	</tr>	
									       	<tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>								     
									      	<tr>
										    	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/lock.png);background-repeat:no-repeat;">&nbsp;</td>
										      	<td>密 &nbsp;&nbsp;&nbsp;码：</td>
									        	<td align="left">
									          		<input	type="password" id="userPwd_2"  name="userPwd" value="" />
									        	</td>
									        </tr>
									        <tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>											
										</table>
										</form>										
									</div>
									<div id="div_3" style="display:none">
										<form id="fm3"  method="post" >
										<table width="300" border="0" cellspacing="2" cellpadding="0">
											<tr>
										      	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/user.png);background-repeat:no-repeat;">&nbsp;</td>
										        <td>用户名：</td>
										        <td align="left">
										        	<input	type="text"  id="userName_3" name="userName" value=""  /> 
										        </td>
									      	</tr>	
									       	<tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>								     
									      	<tr>
										    	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/lock.png);background-repeat:no-repeat;">&nbsp;</td>
										      	<td>密 &nbsp;&nbsp;&nbsp;码：</td>
									        	<td align="left">
									          		<input	type="password" id="userPwd_3"  name="userPwd" value="" />
									        	</td>
									        </tr>
									        <tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>											
										</table>
										</form>										
									</div>
									<div id="div_4"  style="display:block">
										<form id="fm4"  method="post" >
										<table width="300" border="0" cellspacing="2" cellpadding="0">									      					     
									    	<tr>
									      		<td style="width:7%;background-image:url(<%=contextPath%>/images/login/sfz.png);background-repeat:no-repeat;">&nbsp;</td>
									        	<td>身份证：</td>
									        	<td align="left">
									         		<input	type="text"  id="userName_4" name="userName" value="" /> 
									        	</td>
									      	</tr>	
									       	<tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>								     
									      	<tr>
									      		<td style="width:7%;background-image:url(<%=contextPath%>/images/login/lock.png);background-repeat:no-repeat;">&nbsp;</td>
									      		<td>密 &nbsp;&nbsp;码：</td>
									        	<td  align="left">
									          		<input	type="password" id="userPwd_4"  name="userPwd" value="" />
									        	</td>
									        </tr>
									        <tr>
									        	<td colspan="3">&nbsp;</td>
									        </tr>							   
									    </table>
									    </form>
									</div>
									<div>
										<table  class="mima" style="display:none" width="300" border="0" cellspacing="2" cellpadding="0">
											<tr>
									        	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/key.png);background-repeat:no-repeat;">&nbsp;</td>
									        	<td>验证码：</td>
									        	<td  align="left">
									        	    <table align="left">
										        		<tr>
										        			<td>
										        				<input type="text" id="yzm" name="yzm" style="width:65px" onKeyDown="onEnter()" />
										        				<input type="hidden" name="yzmId" id="yzmId" />
										        			</td>
										        			<td>
<%--										        				<a href="javascript:void(0)" onclick="getYzm();" id="yzmBtn"><img src="<%=contextPath%>/images/login/hqyzm.png"/></a>--%>
										        				<img src="<%=contextPath%>/servlet/CodeServlet" id="yzmimg" border="0" onclick="changeImage(this)" style="cursor:pointer" alt="点击刷新验证码"/>
										        			</td>
										        		</tr>
									        	    </table>
									        	</td>
									        </tr>												
										</table>	
									</div>
								</td>
							</tr>
							<tr>
								<td width="176" height="26"></td>
								<td width="351" nowrap="nowrap">
									<table width="351" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="50px">
												<div id="loading-mask" style="display:none;z-index:20000"><img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /></div>
											</td>											
											<td align="left">
												<div id="btn_div">
													<a href="javascript:void(0)" onclick="checkform1();" id="checkfrom" ><img id="dl" title="登录" class="easyui-tooltip" src="<%=contextPath%>/images/login/dl2.png"  alt="登录"/></a>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href="javascript:void(0)" onclick="reset2();"><img id="cz" title="重置" class="easyui-tooltip" src="<%=contextPath%>/images/login/cz2.png"  alt="重置" /></a>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="176" height="26"></td>
								<td width="351" nowrap="nowrap">
									<table width="351" border="0" cellspacing="0"	cellpadding="0">
										<tr>
											<td width="50px">
											</td>											
											<td align="left">
												<div id="btn_div2">
<!-- 													<a href="ocx/cameraOcx.zip" target="_blank">下载浏览器插件</a> -->
<%--													<a href="<%=contextPath%>/common/userreg/go2Register" target="_self" style="color: red" >【新用户注册】</a>--%>
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