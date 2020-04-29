<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
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
	
	//用户名+密码+验证码登录开关
	String yzmSwitch = "1";
	String qryzmSwitch = StringHelper.showNull2Empty(SysmanageUtil.getAa01("QRYZMSWITCH").getAaa005());
	if(!"".equals(qryzmSwitch)){
		yzmSwitch = qryzmSwitch;
	}
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
<title>安盛科技食品药品安全溯源平台</title>
<jsp:include page="${contextPath}/inc_nr.jsp"></jsp:include>
<link href="<%=contextPath%>/css/login.css" rel="stylesheet" type="text/css" />
<script src="<%=contextPath%>/pages.js/index.js" type="text/javascript" ></script>
<script type="text/javascript">
	var yzmSwitch = '<%=yzmSwitch%>';
	//alert(yzmSwitch);
</script>
</head>
<body class="LoginBgStyle">
	<div align="center">
		<table width="1087" height="601" border="0" cellpadding="0"	cellspacing="0">
			<tr>
				<td height="601" class="LoginBgStyle_asfoodsafe">
					<div class="maintab02">
						<table width="527" height="221" border="0" cellspacing="0"	cellpadding="0">
							<tr>
								<td height="45" colspan="2">
									<table width="527" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="131" height="45" class="tdbg_1_2" onclick="switch_tab(1)" id="tab_1"></td>
											<td width="131" height="45" class="tdbg_2_2" onclick="switch_tab(2)" id="tab_2"></td>
											<td width="131" height="45" ></td>
											<td width="131" height="45" ></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="176" height="200">&nbsp;</td>
								<td width="351">
									<div id="div_1" style="display:none">
										<input id="systemcode" name="systemcode" value="<%=systemcode%>"  type="hidden"  /> 
										<br><br>
										<form id="fm1"  method="post" >
											<table width="300" border="0" cellspacing="2" cellpadding="0">
												<tr>
											      	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/user.png);background-repeat:no-repeat;">&nbsp;</td>
											        <td>用户名：</td>
											        <td align="left">
											        	<input	type="text"  id="userName_1" name="userName" value=""  /> 
											        </td>
										      	</tr>	
										       	<tr>
										        	<td colspan="3">&nbsp;</td>
										        </tr>								     
										      	<tr>
											    	<td style="width:7%;background-image:url(<%=contextPath%>/images/login/lock.png);background-repeat:no-repeat;">&nbsp;</td>
											      	<td>密 &nbsp;&nbsp;&nbsp;码：</td>
										        	<td align="left">
										          		<input	type="password" id="userPwd_1"  name="userPwd" value=""  />
										        	</td>
										        </tr>
										        <tr>
										        	<td colspan="3">&nbsp;</td>
										        </tr>								
											</table>
											<table width="300" border="0" cellspacing="2" cellpadding="0">
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
	<!-- 										        				<a href="javascript:void(0)" onclick="getYzm();" id="yzmBtn"><img src="<%=contextPath%>/images/login/hqyzm.png"/></a> -->
											        				<img src="<%=contextPath%>/servlet/CodeServlet" id="yzmimg" border="0" onclick="changeImage(this)" style="cursor:pointer" alt="点击刷新验证码"/>
											        			</td>
											        		</tr>
										        	    </table>
										        	</td>
										        </tr>												
											</table>
											<br><br>
											<table width="351" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td width="50px">
														<div id="loading-mask" style="display:none;z-index:20000"><img src="<%=contextPath%>/images/frame/loading.gif" align="absmiddle" /></div>
													</td>											
													<td align="left">
														<div id="btn_div">
															<a id="adl" href="javascript:void(0)" onclick="checkform();"><img id="dl" title="登录" class="easyui-tooltip" src="<%=contextPath%>/images/login/dl2.png"  alt="登录"/></a>
																&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															<a id="acz" href="javascript:void(0)" onclick="reset2();"><img id="cz" title="重置" class="easyui-tooltip" src="<%=contextPath%>/images/login/cz2.png"  alt="重置" /></a>
														</div>
													</td>
												</tr>
											</table>	
										</form>									
									</div>
									<div id="div_2" style="display:none; margin-top: 30px; margin-left: 10px;">
										<form id="fm2"  method="post" >
											<div id="loginByQrcode" style="z-index:1000;" >
												<img id="qrcodeImg" src="<%=contextPath%>/servlet/QRCodeServlet" border="0" onclick="changeQrcode(this)" style="width: 200px; height: 200px;cursor:pointer" alt="点击刷新验证码">
												<br>
												<span id="stateText" style="margin-top: 20px;margin-left: 20px">二维码有效时长一分钟</span>【<span id="timeText">60</span>秒】
											</div>
										</form>										
									</div>																		
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