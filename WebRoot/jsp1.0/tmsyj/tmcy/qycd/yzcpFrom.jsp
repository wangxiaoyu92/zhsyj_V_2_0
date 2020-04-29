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
    String hyzcpid = StringHelper.showNull2Empty(request.getParameter("hyzcpid"));
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
    var week;
	//下拉框列表	
	$(function() { //alert(new Date('2017/03/22').getDay()) 
	week = $('#cpxq').combobox({ 
			data : [{id:'',text:'==请选择=='},
			 		{id:'0',text:'星期日'},
					{id:'1',text:'星期一'},
					{id:'2',text:'星期二'},
					{id:'3',text:'星期三'},
					{id:'4',text:'星期四'},
					{id:'5',text:'星期五'},
					{id:'6',text:'星期六'}],
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});		 
	jcccinfo = $('#jccc').combobox({ 
			data : jccc,
			valueField : 'id',
			textField : 'text',
			required : true,
			editable :false,
			panelHeight :180
		});		 
		if ($('#hyzcpid').val().length > 0) { 
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/tmcy/cdgl/QueryYzcp', {
				hyzcpid : $('#hyzcpid').val()
			}, 
			function(result) {
				if (result.code=='0') { 
					var mydata = result.rows[0];					
					$('form').form('load', mydata);							
				} else {
					parent.$.messager.alert('提示','查询失败：'+result.msg,'error');
                }	
				parent.$.messager.progress('close');
				showUploadFj($('#hyzcpid').val());
			}, 'json');
			 if ('<%=op%>' == 'show'){ 
			 	$('from:input').addClass('input_readonly');
			 	$('from:input').attr('readonly','readonly');
			 	$('input').attr('disabled','true'); 
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
			url: basePath + '/tmcy/cdgl/SaveYzcp',
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
	function getWeek(){
		var week=$("#cprq").val();
		var num = new Date(week).getDay();
		$("#cpxq").combobox("select", num);
	} 
	//获取上传的图片
	function showUploadFj(hyzcpid){
		if(hyzcpid!='' && hyzcpid!=null){
			$.post(basePath + '/pub/pub/queryFjViewList', {
				'fjwid':hyzcpid
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
		<input type="hidden" id="hyzcpid" name="hyzcpid" value="<%=hyzcpid%>"/>  
		<input name="comid" id="comid" type="hidden" /> 
	       	<sicp3:groupbox title="菜谱信息">	
	       		<table class="table" style="width: 99%;"> 		
					<tr>	
						<td style="text-align:right;"><nobr>菜谱名称:</nobr></td>
						<td><input name="cpmc" id="cpmc"   style="width: 175px; "  class="easyui-validatebox" data-options="required:true" /></td>											
						<td style="text-align:right;"><nobr>就餐餐次:</nobr></td>
						<td><input name="jccc" id="jccc" style="width: 175px; " class="easyui-validatebox" data-options="required:false" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>菜谱日期:</nobr></td>
						<td><input name="cprq" id="cprq"  style="width: 175px; "  onchange="getWeek()"  class="easyui-validatebox" data-options="required:true"  class="Wdate"
					     onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>								
						<td style="text-align:right;"><nobr>菜谱星期:</nobr></td>
						<td><input name="cpxq" id="cpxq" style="width: 175px;" 
						class="easyui-validatebox" data-options="required:false"/> 
						</td>						
					</tr> 			
					<tr id='hid'>	
						<td style="text-align:right;"><nobr>操作员:</nobr></td>
						<td><input name="aae011" id="aae011"   style="width: 175px; "  /></td>
						<td style="text-align:right;"><nobr>操作时间:</nobr></td>
						<td><input name="aae036" id="aae036"    style="width: 175px; "  /></td>
					</tr> 				
				</table>
	        </sicp3:groupbox>
	         <div id="picbox" style="width:100%;text-align:center;">
			 </div>
		</form>
    </div>    
</body>
</html>