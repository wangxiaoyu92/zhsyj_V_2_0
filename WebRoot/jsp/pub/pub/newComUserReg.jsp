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
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
</script>
<style type="text/css">
 .txt-bitian{color: red}
</style>
</head>
<body >
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="新企业用户注册">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td style="text-align:right;"><nobr><span class="txt-bitian">*</span>企业名称:</nobr></td>
							<td colspan="3"><input id="commc" name="commc" style="width: 500px" class="easyui-validatebox" data-options="required:true" /></td>
						</tr> 
						<tr>
						    <td style="text-align:right;"><nobr><span class="txt-bitian">*</span>移动电话:</nobr></td>
						    <td><input id="comyddh" name="comyddh" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:'mobile'"/>
						     (注册成功后，该手机号为系统登录账号，默认密码123456)
						    </td>						
						</tr>  
						<tr>
							<td style="text-align:right;"><nobr><span class="txt-bitian">*</span>所属统筹区:</nobr></td>
							<td>
								<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
								   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
								<input name="aaa027" id="aaa027"  type="hidden"/>
								<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
									<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
								</div>							
							</td>
						</tr>						
						<tr>
							<td style="text-align:right;"><nobr>企业地址:</nobr></td>
							<td colspan="3"><input id="comdz" name="comdz" style="width: 700px" class="easyui-validatebox"/></td>	
						</tr>
						<tr>
	                      <td style="text-align:right;"><nobr>地图定位:</nobr></td>
						  <td>
						     经度坐标：<input id="comjdzb" name="comjdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
						     纬度坐标：<input id="comwdzb" name="comwdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
									<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
										iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>					     
						  </td>
						</tr>
						<tr>
	                        <td style="text-align:right;"><nobr>企业分类:</nobr></td>
							<td><input id="comdalei" name="comdalei" style="width: 200px" class="easyui-combobox" data-options="validType:'comboboxNoEmpty'" /></td>					
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>企业法人/业主:</nobr></td>
							<td><input id="comfrhyz" name="comfrhyz" style="width: 200px" class="easyui-validatebox" /></td>						
						</tr>	
						<tr>						
							<td style="text-align:right;"><nobr>法人/业主身份证号:</nobr></td>
							<td><input id="comfrsfzh" name="comfrsfzh" style="width: 200px" class="easyui-validatebox" data-options="validType:'idcard'"/></td>			
						</tr>
						<tr>	
							<td style="text-align:right;"><nobr>企业负责人:</nobr></td>
							<td><input id="comfzr" name="comfzr" style="width: 200px" class="easyui-validatebox"  /></td>						
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>固定电话:</nobr></td>
							<td><input id="comgddh" name="comgddh" style="width: 200px" class="easyui-validatebox" /></td>						
						</tr>						
						<tr>
							<td style="text-align:right;"><nobr>许可证编号:</nobr></td>
							<td><input id="comxkzbh" name="comxkzbh" style="width: 200px" class="easyui-validatebox" /></td>						
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>许可有效期始:</nobr></td>
							<td><input id="comxkyxqq" name="comxkyxqq" style="width: 200px" class="easyui-datebox"/></td>
						</tr>
						<tr>		
							<td style="text-align:right;"><nobr>许可有效期止:</nobr></td>
							<td><input id="comxkyxqz" name="comxkyxqz" style="width: 200px" class="easyui-datebox"/></td>								
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>资质证明:</nobr></td>
							<td><input id="comzzzm" name="comzzzm" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>
						</tr>
						<tr>								
							<td style="text-align:right;"><nobr>资质证明编号:</nobr></td>
							<td><input id="comzzzmbh" name="comzzzmbh" style="width: 200px" class="easyui-validatebox" data-options="required:false"/></td>														
						</tr>																					
																                    
					</table>
				</div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>