<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String yewuprocessid = StringHelper.showNull2Empty(request.getParameter("yewuprocessid"));
%>
<!DOCTYPE html>
<html>
<head>
<title>业务工作流绑定编辑</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var sfqygzl = <%=SysmanageUtil.getAa10toJsonArray("SFQYGZL")%>;
	var cb_sfqygzl;
	
	$(function() {
		cb_sfqygzl = $('#sfqygzl').combobox({
	    	data : sfqygzl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });

		$('#psbh').combogrid({
			url: basePath + '/workflow/queryWfprocess', 
			panelWidth : 500,
			panelHeight : 300,
			idField : 'psbh',
			textField : 'psmc',
			mode : 'remote',
			delay : 500,
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
			sortName : 'psbh',
			sortOrder : 'asc',
			columns : [ [ {
				width : '200',
				title : '流程编号',
				field : 'psbh',
				hidden : false,
				sortable : true
			},{
				width : '300',
				title : '流程名称',
				field : 'psmc',
				hidden : false
			}  ] ]
		});  
						
		if ($('#yewuprocessid').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(basePath + '/workflow/queryWfyewuProcessDTO', {
				yewuprocessid : $('#yewuprocessid').val()
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
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');							
			}
		}
	});

	
	// 保存 
	var submitForm = function($dialog, $grid, $pjq) {
		var url;
		if($('#yewuprocessid').val().length > 0){
			url = basePath + '/workflow/updateWfyewuProcess';
		}else{
			url = basePath + '/workflow/addWfyewuProcess';
		}

		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
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
	        			$grid.datagrid('load');
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
	
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="overflow: true;" border="false">
		<form id="fm" method="post" >    
	       	<sicp3:groupbox title="业务工作流绑定信息">	
	       		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>业务工作流绑定ID:</nobr></td>
						<td><input name="yewuprocessid" id="yewuprocessid"  style="width: 300px; " class="input_readonly" readonly="readonly" value="<%=yewuprocessid%>"/></td>															
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>业务名称:</nobr></td>
						<td><input name="yewumc" id="yewumc"   style="width: 300px; " class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>业务名称拼音码:</nobr></td>
						<td><input name="yewumcpym" id="yewumcpym"   style="width: 300px; "  class="easyui-validatebox" data-options="required:true" /></td>						
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>是否启用工作流:</nobr></td>
						<td><input name="sfqygzl" id="sfqygzl"  value="1" style="width: 300px; " class="easyui-validatebox"  data-options="validType:'comboboxNoEmpty'" /></td>
					</tr>
					<tr>	
						<td style="text-align:right;"><nobr>绑定的工作流:</nobr></td>
						<td><input name="psbh" id="psbh"  style="width: 300px; " /></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 300px; " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
							</div>							
						</td>
					</tr>																													
				</table>
	        </sicp3:groupbox>
		</form>
    </div>    
</body>
</html>