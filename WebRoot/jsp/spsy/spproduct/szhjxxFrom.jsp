<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次号
	String cppcpch = StringHelper.showNull2Empty(request.getParameter("cppcpch"));
%>
<!DOCTYPE html>
<html>
<head>
<title>添加产品生长环境信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);
// 保存
function submitAir() {
	var url = basePath + 'environment/envAirInfo/addEnvAirInfo';
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#fm').form('submit',{
		url: url,
		onSubmit: function(){ 
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
			if(!isValid){
				$.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
			}					
			return isValid;
        },
        success: function(result){
        	$.messager.progress('close');// 隐藏进度条  
        	result = $.parseJSON(result);  
		 	if (result.code=='0'){
		 		$.messager.alert('提示','保存成功！','info',function(){
					 sy.setWinRet(s);
        		});
             	} else {
             		$.messager.alert('提示','保存失败：'+result.msg,'error');
               }
        }    
	});
}
// 保存
function submitWalter() {

	var url = basePath + 'environment/envWalterInfo/addEnvWalterInfo';
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#fm1').form('submit',{
		url: url,
		onSubmit: function(){
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			if(!isValid){
				$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			}
			return isValid;
		},
		success: function(result){
			$.messager.progress('close');// 隐藏进度条
			result = $.parseJSON(result);
			if (result.code=='0'){
				$.messager.alert('提示','保存成功！','info',function(){
					sy.setWinRet(s);
				});
			} else {
				$.messager.alert('提示','保存失败：'+result.msg,'error');
			}
		}
	});
}
// 保存
function submitSoil() {

	var url = basePath + 'environment/envSoilInfo/addEnvSoilInfo';
	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#fm2').form('submit',{
		url: url,
		onSubmit: function(){
			var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
			if(!isValid){
				$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
			}
			return isValid;
		},
		success: function(result){
			$.messager.progress('close');// 隐藏进度条
			result = $.parseJSON(result);
			if (result.code=='0'){
				$.messager.alert('提示','保存成功！','info',function(){
					sy.setWinRet(s);
				});
			} else {
				$.messager.alert('提示','保存失败：'+result.msg,'error');
			}
		}
	});
}

// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
}

</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: scroll;" border="false">
		<div id="tabs" class="easyui-tabs" fit="false">
			<div title="大气基本信息" style="overflow:hidden;">
				<form id="fm" method="post" >
					<input name="proid" type="hidden" value="<%=proid%>"/>
					<input name="cppcpch" type="hidden" value="<%=cppcpch%>"/>
					<sicp3:groupbox title="大气基本信息">
						<table class="table" style="width: 99%;">
							<tr>
								<td style="text-align:right;"><nobr>总悬浮颗粒物:</nobr></td>
								<td><input id="airtsp" name="airtsp" style="width: 200px"/></td>
								<td style="text-align:right;"><nobr>总碳氢化合物:</nobr></td>
								<td><input id="airthc" name="airthc" style="width: 200px"></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>总氧化剂:</nobr></td>
								<td><input id="airto" name="airto" style="width: 200px"/></td>
								<td style="text-align:right;"><nobr>氮氧化物:</nobr></td>
								<td><input id="airoxynitride" name="airoxynitride" style="width: 200px" /></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>二氧化硫:</nobr></td>
								<td><input id="airso2" name="airso2" style="width: 200px" /></td>
								<td style="text-align:right;"><nobr>一氧化碳:</nobr></td>
								<td><input id="airco" name="airco" style="width: 200px" /></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>降尘:</nobr></td>
								<td><input id="airdustfall" name="airdustfall" style="width: 200px" /></td>
							</tr>
						</table>
					</sicp3:groupbox>
					<div align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-save" onclick="submitAir()"> 保存大气信息 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-back" onclick="closeWindow()"> 关闭窗口 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
			<div title="水基本信息" style="overflow:hidden;">
				<form id="fm1" method="post" >
					<input name="proid" type="hidden" value="<%=proid%>"/>
					<input name="cppcpch" type="hidden" value="<%=cppcpch%>"/>
					<sicp3:groupbox title="水基本信息">
						<table class="table" style="width: 99%;">
							<tr>
								<td style="text-align:right;"><nobr>PH:</nobr></td>
								<td><input id="walterph" name="walterph" style="width: 200px"/></td>
								<td style="text-align:right;"><nobr>溶氧:</nobr></td>
								<td><input id="waltero2" name="waltero2" style="width: 200px"></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>温度:</nobr></td>
								<td><input id="waltertemp" name="waltertemp" style="width: 200px" /></td>
								<td style="text-align:right;"><nobr>浊度:</nobr></td>
								<td><input id="walterturbidity" name="walterturbidity" style="width: 200px" /></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>电导率:</nobr></td>
								<td><input id="walterele" name="walterele" style="width: 200px" /></td>
							</tr>
						</table>
					</sicp3:groupbox>
					<div align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-save" onclick="submitWalter()"> 保存水信息 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-back" onclick="closeWindow()"> 关闭窗口 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
			<div title="土壤基本信息" style="overflow:hidden;">
				<form id="fm2" method="post" >
					<input name="proid" type="hidden" value="<%=proid%>"/>
					<input name="cppcpch" type="hidden" value="<%=cppcpch%>"/>
					<sicp3:groupbox title="土壤基本信息">
						<table class="table" style="width: 99%;">
							<tr>
								<td style="text-align:right;"><nobr>土壤温度:</nobr></td>
								<td><input id="soiltemperature" name="soiltemperature" style="width: 200px"/></td>
								<td style="text-align:right;"><nobr>土壤盐分:</nobr></td>
								<td><input id="soilsalinity" name="soilsalinity" style="width: 200px"></td>
							</tr>
							<tr>
								<td style="text-align:right;"><nobr>土壤水分:</nobr></td>
								<td><input id="soilmoisture" name="soilmoisture" style="width: 200px"/></td>
							</tr>
						</table>
					</sicp3:groupbox>
					<div align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-save" onclick="submitSoil()"> 保存土壤信息 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton"
						   iconCls="icon-back" onclick="closeWindow()"> 关闭窗口 </a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>