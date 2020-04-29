<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<% 	
    String hsplyid = StringHelper.showNull2Empty(request.getParameter("hsplyid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>菜品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
    var jccc = <%=SysmanageUtil.getAa10toJsonArray("jccc")%>; 
    var jcccinfo; 
	//下拉框列表	
	$(function() {
	jcccinfo = $('#jccc').combobox({
			data : jccc,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});	 			
		if ($('#hsplyid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmcy/cdgl/QuerySply', {
				hsplyid : $('#hsplyid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);	
					/* console.log(mydata);
					var path = mydata.fjpath;
					if(path){
					$('#fjpath').attr('src',basePath + path);//把src属性更改为'6.jpg';   						
					} */
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
				showUploadFj($('#hsplyid').val());
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true'); 
			 }
		}else{
			$('#hid').hide();
			$('#hid1').hide();
		}
	});


	// 保存 
	var submitForm = function($dialog, $grid, $pjq) { 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/tmcy/cdgl/SaveSply',
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
	        			$grid.datagrid('reload');
	        			$dialog.dialog('destroy');  
	        		}); 	                        	                     
              	} else {
              		$pjq.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}; 
	 //获取上传的图片
	function showUploadFj(hsplyid){
		if(hsplyid!='' && hsplyid!=null){
			$.post(basePath + '/pub/pub/queryFjViewList', {
				'fjwid':hsplyid
			},
			function(result) {
				var mydata = result.data;
				if(mydata!=null){
					var playerHtml = ''; 
					for(var i=0;i<mydata.length;i++){
						var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + mydata[i].fjpath;
						playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl +"')\"><img width=\"160px\" height=\"120px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath +  mydata[i].fjpath + "\"/></a></div>"; 
					}
					$('#picbox').append(playerHtml);
				}else{
					$('#picbox').append("暂未上传图片！");
				}			
			},'json');			
		}
	}  
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	};  
</script>  
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="hsplyid" name="hsplyid" value="<%=hsplyid%>"/>   
		<!-- <input   id="jcyptpwjm" name="jcyptpwjm"/>  -->  
		<input name="comid" id="comid" type="hidden" />
	       	<sicp3:groupbox title="食品留样信息">	
	       		<table class="table" style="width: 99%;"> 
	       		<p> 注：1.留样食品必须保留48小时；</p>
	       		<p>  &nbsp;&nbsp;&nbsp;&nbsp; 2.每餐每样食品必须留足不低于100g； </p>
	       		<p>  &nbsp;&nbsp;&nbsp;&nbsp;  3.留样样品0℃——5℃冷藏保存；</p>
	       			<tr id='hid'>	
						<td style="text-align:right;"><nobr>操作员:</nobr></td>
						<td><input name="aae011" id="aae011"   style="width: 375px; "  /></td>
					</tr>
					<tr id='hid1'>
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input name="aae036" id="aae036"    style="width: 375px; "  /></td>
					</tr> 
					<tr>
						<td style="text-align:right;"><nobr>留样时间:</nobr></td>
						<td><input name="splysj" id="splysj"  style="width: 375px; "  class="easyui-validatebox" data-options="required:true"  class="Wdate"
					     onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>								
					</tr>
						<%-- <td colspan="2" rowspan="4"> 
							<div style="width:270px;">
						    	<img src="<%=contextPath%>/images/default.jpg" name="fjpath" id="fjpath" 
						    		height="140" width="110" />
						   	</div>
						</td> --%>
					<tr>	
						<td style="text-align:right;"><nobr>留样餐次:</nobr></td>
						<td><input name="jccc" id="jccc" style="width: 375px; " class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"/></td>									
					</tr>
					 
					 <tr>	
						<td style="text-align:right;"><nobr>留样人:</nobr></td>
						<td><input name="splyry" id="splyry"   style="width: 375px; " class="easyui-validatebox" data-options="required:true" /></td>						
					</tr> 
					 <tr>	
						<td style="text-align:right;"><nobr>留样品种:</nobr></td>
						<td><textarea name="splypz" id="splypz"   style="width: 375px; "  class="easyui-validatebox" data-options="required:true" ></textarea></td>											
					</tr>
				</table>
	        </sicp3:groupbox> 
	         <div id="picbox" style="width:100%;text-align:center;">
			</div> 
		</form>
    </div>    
</body>
</html>