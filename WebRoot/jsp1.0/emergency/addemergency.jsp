<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>添加预案信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;	
	var sfyx = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
	
	$(function() {
		$('#cateid').combobox({
	    	data:newscate,      
	        valueField:'id',   
	        textField:'text',
	        required:true,
	        editable:false,
	        panelHeight:'auto' 
	    });
		$('#sfyx').combobox({
	    	data:sfyx,      
	        valueField:'id',   
	        textField:'text',
	        required:true,
	        editable:false,
	        panelHeight:'auto',
            onLoadSuccess: function () {
	            var val = $(this).combobox("getData");
	            $(this).combobox("select", val[0].id);
	        }    
	    });
		$('#newsispicture').combobox({
	    	data:[{"id":0,"text":"否"},{"id":1,"text":"是"}],      
	        valueField:'id',   
	        textField:'text',
	        required:true,
	        editable:false,
	        panelHeight:'auto',
            onLoadSuccess: function () {
	            var val = $(this).combobox("getData");
	            $(this).combobox("select", val[0].id);
	        }  
	    });
		
	});

	
	// 保存
	function saveYaxx() {
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: basePath + '/news/saveNews',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!isValid){
					$.messager.progress('close');
					return false;
				}else{
					var newsispicture = $("#newsispicture").combobox('getValue');
					if(newsispicture == '1'){
						/*
						var filepath = $("#filepath").val();
						if(filepath == ''){
							$.messager.progress('close');	
							$.messager.alert('提示','请选择一个新闻图片！','info'); 
							return false;
						}else{
							//检测上传文件的类型
							if(!(/(?:jpg|gif|png|jpeg)$/i.test(filepath))) {
								$.messager.progress('close');	
								$.messager.alert('提示','只允许上传jpg|gif|png|jpeg格式的图片！','info',function(){
									$("#filepath").val();
									return false;
								}); 				
							}
						}*/
 					}
					//getData() 获取编辑器的内容 
					var newscontent = CKEDITOR.instances.newscontent.getData();
				    if(newscontent.length == 0){
				    	$.messager.progress('close');
				   		$.messager.alert('提示','请输入新闻内容！','info'); 
				   	    return false;
				    }
				}
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		$.messager.progress('close');
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			closeAndRefreshWindow();
	        		}); 	                        	                     
              	} else {
              		$.messager.progress('close');
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	}


	//关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();      
		s.type = "ok";
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close"); 
		/* window.returnValue = s;   
		window.close();    */ 
	} 
	  
	//关闭窗口  
	function closeWindow(){
         parent.$("#"+sy.getDialogId()).dialog("close");
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow:auto;" border="false">
        	<form id="fm" method="post" >	
        		<sicp3:groupbox title="编辑预案信息">
	        		<table class="table" style="width: 99%;">	        		    
						<tr>
							<td style="text-align:right;"><nobr>预案编号：</nobr></td>
							<td><input id="newsid" name="newsid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>						
							<td style="text-align:right;"><nobr>添加时间：</nobr></td>
							<td><input id="newstjsj" name="newstjsj" style="width: 200px;" readonly="readonly" class="input_readonly"  /></td>
						</tr> 
						<tr>						
							<td style="text-align:right;"><nobr>预案分类：</nobr></td>
							<td><input id="cateid" name="cateid" style="width: 200px;" /></td>			
							<td style="text-align:right;"><nobr>预案来源：</nobr></td>
							<td><input id="newsfrom" name="newsfrom" style="width: 200px;" /></td>
						</tr> 
						<tr>		
							<td style="text-align:right;"><nobr>是否有效：</nobr></td>
							<td><input id="sfyx" name="sfyx" style="width: 200px;"   /></td>
							<td style="text-align:right;"><nobr>是否图片预案：</nobr></td>
							<td><input id="newsispicture" name="newsispicture" style="width: 200px;"  onchange="switchShowHide();"/></td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>预案标题：</nobr></td>
							<td><input id="newstitle" name="newstitle" style="width: 260px;" class="easyui-validatebox" data-options="required:true" /></td>						
						</tr>
						<tr>		
							<td style="text-align:right;"><nobr>预案内容：</nobr></td>
							<td colspan="3">
								<div height="100px" style="overflow: auto;">
						        	<textarea class="ckeditor" id="newscontent" name="newscontent" cols="20" rows="100"></textarea>
								</div>
							</td>
						</tr>
					</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveYaxx"
					iconCls="icon-save" onclick="saveYaxx()" id="btnSave">保存 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-undo" onclick="closeWindow()" id="btnUndo">取消</a>
	        </div>
		</div>
	</div>
	
</body>
</html>