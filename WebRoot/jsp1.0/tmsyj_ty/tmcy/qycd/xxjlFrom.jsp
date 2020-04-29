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
    String hcyjxxjlid = StringHelper.showNull2Empty(request.getParameter("hcyjxxjlid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
 %> 
<!DOCTYPE html>
<html>
<head>
<title>菜品信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript"> 
    var xdfs =  <%=SysmanageUtil.getAa10toJsonArray("xdfs")%>;  
    var xdfsinfo;
	//下拉框列表	
	$(function() { 			
	xdfsinfo = $('#xdfs').combobox({
			data : xdfs,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});				
		if ($('#hcyjxxjlid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmcy/cdgl/QueryXxjl', {
				hcyjxxjlid : $('#hcyjxxjlid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
				showUploadFj($('#hcyjxxjlid').val());
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true');
				$('#btnselectcom').hide();
			 }
		}else{
			$('#hid').hide();
		}
	});


	// 保存 
	var submitForm = function($dialog, $grid, $pjq) { 
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/tmcy/cdgl/SaveXxjl',
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


	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
    	$dialog.dialog('destroy');
	}; 
	//选择企业
	function selectcom(){
		var style = "help:no;status:no;scroll:no;dialogWidth:800px;dialogHeight:500px;dialogTop:100px;" +
		"dialogLeft:400px;resizable:no;center:no";    
		var obj = new Object();
		obj.singleSelect="true"; 
	    var v_retStr=window.showModalDialog("<%=basePath%>pub/pub/selectcomIndex?a="+new Date().getMilliseconds(),obj,
	        style);  
	    if (v_retStr!=null && v_retStr.length>0){
	    for (var k=0;k<=v_retStr.length-1;k++){
	      var myrow=v_retStr[k];
	      $("#comid").val(myrow.comid); //公司id 
	    }}      
	}
	//获取上传的图片
	function showUploadFj(hcyjxxjlid){
		if(hcyjxxjlid!='' && hcyjxxjlid!=null){
			$.post(basePath + '/pub/pub/queryFjViewList', {
				'fjwid':hcyjxxjlid
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
</script>  
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" > 
		<input type="hidden" id="hcyjxxjlid" name="hcyjxxjlid" value="<%=hcyjxxjlid%>"/> 
		<input name="comid" id="comid" type="hidden" />  
	       	<sicp3:groupbox title="洗消记录信息">	
	       		<table class="table" style="width: 99%;">
					<!-- <tr>
						<td style="text-align:right;"><nobr>企业id:</nobr></td>
						<td><input name="comid" id="comid"  style="width: 175px; " class="input_readonly" readonly="readonly" class="easyui-validatebox" data-options="required:true"/>
						 <a id="btnselectcom" href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="selectcom()">选择企业 </a></td>
						<td style="text-align:right;"><nobr>餐具名称:</nobr></td>
						<td><input name="cjmc" id="cjmc"   style="width: 175px; "  class="easyui-validatebox" data-options="required:true" /></td>											
					</tr> -->
					<tr id='hid'>	
						<td style="text-align:right;"><nobr>操作员:</nobr></td>
						<td><input name="aae011" id="aae011"   style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input name="aae036" id="aae036"    style="width: 175px; "  /></td>
					</tr> 					
					<tr>
						<td style="text-align:right;"><nobr>消毒开始时间:</nobr></td>
						<td><input name="xdkssj" id="xdkssj"  style="width: 175px; "  class="easyui-validatebox" data-options="required:true" class="Wdate"
					     onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
						</td>								
						<td style="text-align:right;"><nobr>消毒结束时间:</nobr></td>
						<td><input name="xdjssj" id="xdjssj"   style="width: 175px; " class="easyui-validatebox" data-options="required:true" class="Wdate"
					     onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /> </td>						
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>消毒方式:</nobr></td>
						<td><input name="xdfs" id="xdfs"   style="width: 175px; " /></td>
						<td style="text-align:right;"><nobr>温/浓度:</nobr></td>
						<td><input name="wnd" id="wnd" style="width: 175px; " class="easyui-validatebox" data-options="required:false" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>餐具名称:</nobr></td>
						<td  colspan="3"><input name="cjmc" id="cjmc"   style="width: 450px; "  class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					 		
				</table>
	        </sicp3:groupbox>
	         <div id="picbox" style="width:100%;text-align:center;">
			</div>
		</form>
    </div>    
</body>
</html>