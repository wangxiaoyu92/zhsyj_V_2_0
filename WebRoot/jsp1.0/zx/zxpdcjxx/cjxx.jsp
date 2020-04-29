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
	String cjid = StringHelper.showNull2Empty(request.getParameter("cjid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>采集信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">

var comdm;
var commc;
var data ;
var xmcsbm;
var xmcsmc;
var pjq;
    $(function  (){
		   //项目代码
		   $.ajax({
			url:basePath +"/zx/zxpdcjxx/xmcs?cssyzt=1",
			 dataType:"json",
			success: function(result ){ 
				data= result.rows; 
				$('#xmcsdm').combobox({
				         data : data,      
				         valueField : "xmcsbm",   
				         textField  : "xmcsmc" ,
				         required : false,
					     editable : false,
					     panelHeight : 'auto', 
				         onSelect:function(){  
				        	 var xm=$('#xmcsdm').combobox('getValue'); 
				        	$.ajax({url:basePath +"/zx/zxpdcjxx/xmcs?cssyzt=1&xmcsbm="+xm,
							 dataType:"json",
							success: function(result ){ 
				        	 $('#cjdf').val(result.data.xmcsfz);
							}})
				        	 //var xmcsbm=$('#xmcsdm').combobox('getValue'); 
				        	// alert(xmcsbm);
				        	 //$('#cjdf').val(data[xmcsbm-100000].xmcsfz);
			                }
				    });   
			},
			error:function(){
				parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
			}
		   }) 
  })   
     	 
		$(function (){ 
	   if ($('#cjid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/zx/zxpdcjxx/xmcsbox', {
				cjid : $('#cjid').val()
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
				$('textarea').attr('disabled','true');
				$('#ss').show();
			}
		} 
   })
  
  
	// 保存 信息 
	  
	/*var submitForm = function($dialog, $ddd, $pjq){ 
		  var comdm=$('#comdm').combobox('getValue'); 
		  var cjid=$('#cjid').val()
		  var xmcsdm=$('#xmcsdm').combobox('getValue');
		  var czyxm=$('#czyxm').val();
		  var beizhu=$('#beizhu').val();
	 		$pjq.messager.progress();	// 显示进度条
	 	$.ajax({
	 		url:basePath + '/zx/zxpdcjxx/cjxx',
			type:"post",
			data:{"comdm":comdm,"cjid":cjid,"xmcsdm":xmcsdm,"czyxm":czyxm,"beizhu":beizhu},
			dataType:"json",
			success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条  
	        	//result = $.parseJSON(result); 
	        	alert(result.code)
			 	if (result.code=='0'){
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$ddd.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                } 
			},
			error:function(){alert("系统有错误")}
		}) 
	}*/
	/*	var url;
		if($('#cjid').val().length > 0){
			url =basePath + '/zx/zxpdcjxx/cjxx';
		}else{
			url =basePath + '/zx/zxpdcjxx/cjxx';
		}*/
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		var submitForm = function($dialog, $ddd, $pjq) {
	 	 $pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url:basePath + '/zx/zxpdcjxx/cjxx',
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
			 		$pjq.messager.alert('提示','保存成功！','info',function(){
	        			$ddd.datagrid('load');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
		}
	 
	function selectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex?a="+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				singleSelect : true
			},
			width : 800,
			height : 600,
			url : url
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj!=null && obj.length>0){
				for (var k=0;k<=obj.length-1;k++){
					var myrow=obj[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comid").val(myrow.comid); //公司代码
				}
			}
		});
	}
	 
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };
	  
  </script>
</head>
<body> 
	<form id="fm" name="fm" method="post">
		<sicp3:groupbox title="信息采集">
			<table class="table" style="width: 99%;">
				<tr style="display:none">
					<td style="text-align:right;"><nobr>采集ID:</nobr></td>
					<td><input id="cjid" name="cjid" style="width: 200px"
						class="input_readonly" readonly="readonly" value="<%=cjid%>"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>企业ID:</nobr></td>
					<td><input id="comid" name="comid" style="width: 200px"
						class="easyui-validatebox" data-options="required:true" /> <% if(!"view".equalsIgnoreCase(op)){%>
						<a id="btnselectcom" href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-search"
						onclick="selectcom()">选择企业 </a> <%} %>
					<td style="text-align:right;"><nobr>企业名称:</nobr></td>
					<td><input id="commc" name="commc" style="width: 200px" /></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>评定项目代码:</nobr></td>
					<td><input id="xmcsdm" name="xmcsdm" style="width: 200px"
						class="easyui-validatebox"
						data-options="validType:'comboboxNoEmpty'" /></td>
					<td style="text-align:right;"><nobr>得分:</nobr></td>
					<td><input id="cjdf" name="cjdf" style="width: 200px" /></td>
				</tr>
				<tr id="ss" style="display:none">
					<td style="text-align:right;"><nobr>操作员姓名:</nobr></td>
					<td><input id="czyxm" name="czyxm" style="width: 200px" /></td>
					<td style="text-align:right;"><nobr>年度:</nobr></td>
					<td><input id="niandu" name="niandu" style="width: 200px"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr>备注:</nobr></td>
					<td colspan="3"><textarea id="beizhu" name="beizhu"
							style="width: 630px"></textarea></td>
				</tr>
			</table>
		</sicp3:groupbox>
	</form>
</body>
</html>