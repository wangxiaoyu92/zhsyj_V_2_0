<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig, com.zzhdsoft.utils.SysmanageUtil"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE HTML >
<html>
<head>
<title>审核报名人员</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
	var v_sex = [{"id":"","text":"===请选择==="},{"id":"1","text":"男"},{"id":"2","text":"女"}]; 
    var v_enrollIdcardType= [{"id":"","text":"===请选择==="},{"id":"1","text":"身份证"},{"id":"2","text":"护照"},{"id":"3","text":"其他"}]; 
    var v_state = [{"id":"","text":"===请选择==="},{"id":"1","text":"未审核"},{"id":"2","text":"审核中"},{"id":"3","text":"审核通过"},{"id":"4","text":"审核未通过"},{"id":"5","text":"已缴费"}]; 
    
    $(function() {
    grid = $('#grid').datagrid({
    toolbar: '#toolbar',
    url : basePath + 'signups/signup/queryCoursewareInfos',
	striped : true, // 奇偶行使用不同背景色
	singleSelect : true,// True只允许选中一行
	checkOnSelect : false, // 当用户仅在点击该复选框的时候才会呗选中或取消
	selectOnCheck : false,			
	pagination : true,// 底部显示分页栏
	pageSize : 10,
	pageList : [ 10, 20, 30 ],
	rownumbers : true,// 是否显示行号
	fitColumns : false,// 列自适应宽度			
	idField: 'enrollId', //该列是一个唯一列
	sortOrder: 'desc',	 
	 columns : [ [
	 {
	  			title: '报名ID',
				field: 'enrollId',
				width : '100',
				hidden : true
	 },{
	 			title: '注册ID',
				field: 'regId',
				width : '100',
				hidden : true
	 },{
	 			title: '考生名称',
				field: 'enrollName',
				width : '100',
				hidden : false
	 },
	 {
	 			title: '性别',
				field: 'enrollSex',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_sex, value);
				}
	 },
	 {
	 			title: '考生单位',
				field: 'enrollUnit',
				width : '100',
				hidden : false
	 },{
	 			title: '考生证件类型',
				field: 'enrollIdcardType',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_enrollIdcardType, value);
				}
	 },{
	 			title: '考试证件号码',
				field: 'enrollIdcardNo',
				width : '180',
				hidden : false
	 },{
	 			title: '所报考考试ID',
				field: 'enrollExamId',
				width : '180',
				hidden : true
	 },{
	 			title: '所报考考试名称',
				field: 'enrollExamName',
				width : '180',
				hidden : false
	 },{
	 			title: '申请状态',
				field: 'enrollState',
				width: '100',
				hidden: false,
				formatter:function(value, row){
					return sy.formatGridCode(v_state, value);
				}
	 },{
	 			title: '备注',
				field: 'enrollRemark',
				width : '100',
				hidden : false
	 },{
	 			title: '报名时间',
				field: 'enrollTime',
				width : '130',
				hidden : false
	 }
	 ]]   
    });
    });
    
    //点击查看报名的详细信息
    function showSignup(){
    	var row = $('#grid').datagrid('getSelected');
    	if (row) {
    	var obj = new Object();
    	var url = basePath + "signups/signup/detailedManagerIndex?enrollId=" + row.enrollId;

			var dialog = parent.sy.modalDialog({
				title : '报名信息',
				width : 750,
				height : 560,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少
				if(obj != null && obj == "ok"){
					grid.datagrid('reload');
				}
			});
    	}else{
			$.messager.alert('提示', '请先选择查看的信息', 'info');
		}	
    
    }
    
    function saveAdopt(){
   	    var row = $('#grid').datagrid('getSelected');
		var v_state="3";
		var v_url = basePath + "signups/signup/uodateSign?v_state="+v_state+"&enrollId=" + row.enrollId;
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url : v_url,
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
			 		$.messager.alert('提示','审核通过成功！','info',function(){
						 window.returnValue = "ok";
						// window.close(); 
						grid.datagrid('reload');
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','审核通过失败：'+result.msg,'error');
                }
	        }    
		});
	}
	
	 function closeNoAdopt(){
   	    var row = $('#grid').datagrid('getSelected');
		var v_state="4";
		var v_url = basePath + "signups/signup/uodateSign?v_state="+v_state+"&enrollId=" + row.enrollId;
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url : v_url,
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
			 		$.messager.alert('提示','审核不通过成功！','info',function(){
						 window.returnValue = "ok";
						// window.close(); 
						grid.datagrid('reload');
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','审核不通过失败：'+result.msg,'error');
                }
	        }    
		});
	}
    
    </script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: hidden;" border="false">
					<form id="fm" method="post">
			<sicp3:groupbox title="课件列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_showCourseWare" iconCls="ext-icon-report_magnify"
								plain="true" onclick="showSignup()">查看</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_addCourseware" iconCls="icon-add" plain="true"
								onclick="saveAdopt()">审核通过</a>
							</td>
							<td><div class="datagrid-btn-separator"></div></td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_editCoursewareInfo" iconCls="icon-edit" plain="true"
								onclick="closeNoAdopt()">审核不通过</a>
							</td>
						</tr>
					</table>
				</div>
				<div id="grid"></div>
			</sicp3:groupbox>
			</form>
		</div>
	</div>
</body>
</html>
