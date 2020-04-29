<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>采集信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript"> 
$(function(){
 var id=$("#cydjid").val();
 	 if(id==""){
 	   $("#hide").eq(0).hide();
 	 }	
 	 
	   if ($('#cydjid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/jyjc/queryJyjccydj', {
				cydjid : $('#cydjid').val()
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data; 			
					$('form').form('load', mydata); 
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
               }	
				parent.$.messager.progress('close');
			}, 'json');
                 if('<%=op%>' == 'view'){	
				$('from:input').addClass('input_readonly');
				$('from:input').attr('readonly','readonly');
				$('input').attr('disabled','true');
				$('#btnselectcom').hide();
			}
		} 
   })
  

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		var submitForm = function($dialog, $grid, $pjq) {
	 	 $pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url:basePath + '/jyjc/saveJyjccydj',
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条 
				}					
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 	    $("#id").val(result.id);
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$grid.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
		}
	 
	function selectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		style:"help:no;status:no;scroll:no;dialogWidth:800px;dialogHeight:500px;dialogTop:100px;" +
		"dialogLeft:400px;resizable:no;center:no",
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		comjyjcbz : "1"
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		  var myrow=obj[k];
	      $("#bcydwcomid").val(myrow.comid); //公司id 
	      $("#bcydw").val(myrow.comdm); //公司名称        
	      $("#bcydwdz").val(myrow.comdz); //公司地址       
	      $("#bcydwfl").val(myrow.comdalei); //公司分类      
	      $("#tel").val(myrow.comyddh); //公司练习电话    
	 }
	}
	sy.removeWinRet(dialogID);//不可缺少	
	})
	}
	 
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };  
  </script>
</head>
<body> 
	<form id="fm" name="fm" method="post">
	    <input type="hidden" id='cydjid' name='cydjid' value="<%=cydjid%>"/>
	    <input type="hidden" id='bcydwcomid' name='bcydwcomid'/>
	    <input type="hidden" id='scdwcomid' name='scdwcomid'/>
		<sicp3:groupbox title="抽样信息">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:right;"><nobr>被抽样单位:</nobr></td>
					<td><input id="bcydw" name="bcydw" style="width: 200px"
						class="easyui-validatebox" data-options="required:true" /> 
						<a id="btnselectcom" href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-search"
						onclick="selectcom()">选择企业 </a> </td>
					<td style="text-align:right;"><nobr>被抽样单位联系电话:</nobr></td>
					<td><input id="tel" name="tel" style="width: 200px" /></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>被抽样单位地址:</nobr></td>
					<td><input id="bcydwdz" name="bcydwdz" style="width: 200px" /></td>
					<td style="text-align:right;"><nobr>被抽样单位分类:</nobr></td>
					<td><input id="bcydwfl" name="bcydwfl" style="width: 200px" /></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>抽样编号:</nobr></td>
					<td><input id="cybh" name="cybh" style="width: 200px" 
					class="easyui-validatebox" data-options="required:true" /></td>
					<td style="text-align:right;"><nobr>样品名称:</nobr></td>
					<td><input id="ypmc" name="ypmc" style="width: 200px" /></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>样品批号或生产日期:</nobr></td>
					<td><input id="ypbh" name="ypbh" style="width: 200px" /></td>
					<td style="text-align:right;"><nobr>抽样时间:</nobr></td>
					<td><input id="cysj" name="cysj" style="width: 200px" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /></td>
				</tr> 
				<tr>
					<td style="text-align:right;"><nobr>抽样数量:</nobr></td>
					<td><input id="countcy" name="countcy" style="width: 200px"
					class="easyui-validatebox" data-options="required:true"  /></td>
					<td style="text-align:right;"><nobr>生产单位:</nobr></td>
					<td><input id="scdw" name="scdw" style="width: 200px" /></td>
				</tr> 
				<tr>
					
					<td style="text-align:right;"><nobr>抽样经手人:</nobr></td>
					<td><input id="cyjsr" name="cyjsr" style="width: 200px"  /></td>
					<td style="text-align:right;"><nobr>抽样分类:</nobr></td>
					<td><input id="cyfl" name="cyfl" style="width: 200px" /></td>
				</tr> 
				<tr id='hide'>
				    <td style="text-align:right;"><nobr>经办时间:</nobr></td>
					<td><input id="aae036" name="aae036" style="width: 200px"  readonly="readonly" /></td>
					<td style="text-align:right;"><nobr>经办人:</nobr></td>
					<td><input id="aae011" name="aae011" style="width: 200px"  readonly="readonly"/></td>
				</tr> 
			</table>
		</sicp3:groupbox>
	</form>
</body>
</html>