<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_procomid=request.getParameter("procomid");
	String v_proid=request.getParameter("proid");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>添加范围外企业产品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();
s.type="ok";//设为空不刷新父页面
sy.setWinRet(s);

//保质期单位
var v_bzqdwmc = <%=SysmanageUtil.getAa10toJsonArray("BZQDWMC")%>;

//关闭并刷新父窗口
function closeWindow(){      
	parent.$("#"+sy.getDialogId()).dialog("close");     
} 

$(function(){
	//检验表单
	$("#myform").validationEngine({
		validationEventTriggers:"keyup blur", //will validate on keyup and blur
		promptPosition:"centerRight",//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
		prettySelect:true//,是否使用美化过的select
	});

	//自动加载日期单位
	$('#cate').combobox({
		data : v_bzqdwmc,
		valueField : 'id',
		textField : 'text',
		required : false,
		editable : false,
		panelHeight : 'auto',
		onSelect:function(record){
			$("#probzqdwmc").val(record.text);
		}
	});
	 
	if ($('#proid').val().length > 0) {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$.post(basePath + 'spsy/productout/queryQproductoutDTO', {
			comoutid : $('#comoutid').val(),
			proid : $('#proid').val()
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

	}
		
});

var submitForm = function() {
		var status=$("#myform").validationEngine("validate");
		if(status){//表单验证通过
			var url = basePath + 'spsy/productout/productoutAddSave';
		
			//下面的例子演示了如何提交一个有效并且避免重复提交的表单
			$.messager.progress();	// 显示进度条
			$('#myform').form('submit',{
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
							 closeWindow();
		        		}); 	                        	                     
		          	} else {
		          		$.messager.alert('提示','保存失败：'+result.msg,'error');
		            }
		        }    
			});
		}
	};
	
</script>
</head>
  
<body>
	<h3 style="text-align:center">添加外部产品</h3>
	<div class="content_wrap" >
		<form id="myform" method="post">
			<input type="hidden" value="<%=v_procomid%>" id="procomid" name="procomid" />
			<input type="hidden" value="<%=v_proid%>" id="proid" name="proid" />
			<table width="100%" class="table" valign="top" align="center" border="1" >
				<tr>
         			<td class="title" width="20%" style="text-align: right;">产品名称</td>
         			<td align="left">
         				<input type="text" id="proname" name="proname" style="width:200px;"
							   class="validate[required] input-text" />
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">商品条码</td>
         			<td align="left">
         				<input type="text" id="prosptm" name="prosptm" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
			    <tr>
         			<td class="title" style="text-align: right;">规格</td>
         			<td align="left">
         				<input type="text" id="progg" name="progg" style="width:200px;" class="input-text"/>
                       	如180g
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">生产厂家</td>
         			<td align="left">
         				<input type="text" id="prosccj" name="prosccj" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">品名</td>
         			<td align="left">
         				<input type="text" id="propm" name="propm" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">保质期</td>
         			<td align="left">
         				<input type="text" id="probzq" name="probzq" style="width:200px;"
							   class="validate[required] input-text"/>
         				<select id="cate" class="easyui-combobox "  name="probzqdwcode" style="width:100px;"></select>
         				<input type="hidden" id="probzqdwmc" name="probzqdwmc" />
         			</td>
    			</tr>
    
			    <tr>
         			<td class="title" style="text-align: right;">产地/基地名称</td>
         			<td align="left">
         				<input type="text" id="procdjd" name="procdjd" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">配料信息</td>
         			<td align="left">
         				<input type="text" id="proplxx" name="proplxx" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">包装规格</td>
         			<td align="left">
    	     			<input type="text" id="probzgg" name="probzgg" style="width:200px;" class="input-text"/>
                       	如1*12袋
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">厂家地址</td>
         			<td align="left">
         				<input type="text" id="procjdz" name="procjdz" style="width:200px;" class="input-text"/>
         			</td>
    			</tr>
    			<tr>
         			<td class="title" style="text-align: right;">厂家电话</td>
         			<td align="left">
         				<input type="text" id="procjdh" name="procjdh" style="width:200px;"
							   class="easyui-validatebox" validtype="phoneAndMobile"/>
			        </td>
    			</tr>
 		</table>
        <p style="text-align:center">
        <a href="#" id="saveBtn" class="easyui-linkbutton" onclick="submitForm()" >保存数据</a>
        &nbsp;&nbsp;
        <a href="#" onClick="closeWindow()" class="easyui-linkbutton">关闭返回</a>
        </p>
	</form>
</div>
</body>
</html>