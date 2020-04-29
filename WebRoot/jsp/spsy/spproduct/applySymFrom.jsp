<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String v_cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>申请溯源码</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "ok";   // 设为刷新父页面
sy.setWinRet(s);

	// 保存 
	var submitForm = function() {
		
		var v_symksh = $("#symksh").val(); // 溯源码开始号
		var v_symjsh = $("#symjsh").val(); // 溯源码结束号
		if (v_symksh > v_symjsh) {
			alert("请输入合理的开始号与结束号！");
			return;
		}
		var url = basePath + '/spsy/spproduct/applySym';

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#applysymfm').form('submit',{
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
			 		$.messager.alert('提示','申请成功！','info',function(){
						 sy.setWinRet(s);
						 closeWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','申请失败：'+result.msg,'error');
                }
	        }    
		});
	};

// 关闭窗口
function closeWindow(){
   	parent.$("#"+sy.getDialogId()).dialog("close");
};

</script>
</head>
<body>
	<form id="applysymfm" name="applysymfm" method="post">
	  <input id="cppcid" name="cppcid" type="hidden" value="<%=v_cppcid%>"/>
       		<table class="table" style="width: 450px;">
       		   <tr>
       		     <td width="29%"></td>
       		     <td width="69%"></td>
       		   </tr>
				<tr>
					<td style="text-align:right;"><nobr>溯源码开始号:</nobr></td>
					<td><input id="symksh" name="symksh" style="width: 200px;" class="easyui-validatebox" 
					data-options="required:true" validType="number"/></td>						
				</tr>
				<tr>						
					<td style="text-align:right;"><nobr>溯源码结束号:</nobr></td>
					<td><input name="symjsh" id="symjsh" class="easyui-validatebox"
					data-options="required:true" style="width: 200px;" validType="number"/></td>
				</tr>
				<tr>	
					<td style="text-align:right;"><nobr>申请人:</nobr></td>
					<td><input id="symsqr" name="symsqr" style="width: 200px" class="easyui-validatebox" 
					data-options="required:true"/></td>
				</tr>
				<tr>
				  <td colspan="2" style="height: 50px;" >
				    <div align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-save" onclick="submitForm();"> 确定 </a>	
							&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton"
							iconCls="icon-back" onclick="closeWindow()"> 取消 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
					</div>														     
				  </td>
				</tr>									
			</table>
   </form>
</body>
</html>