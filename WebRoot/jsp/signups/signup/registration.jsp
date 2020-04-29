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
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>报名填写信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
    var v_sex = [{"id":"","text":"===请选择==="},{"id":"1","text":"男"},{"id":"2","text":"女"}]; 
    var v_enrollIdcardType= [{"id":"","text":"===请选择==="},{"id":"1","text":"身份证"},{"id":"2","text":"护照"},{"id":"3","text":"其他"}]; 
   
   	$(function() {
   		//考试名称下拉框
   		$("#enrollExamName").combobox({
	    	url : basePath + "signups/signup/examCom",      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto',
	        onLoadSuccess: function (data) {
			if (data) {
   			$('#enrollExamName').combobox('setValue',"===请选择===");
			}
			}
	    });
   		// 性别
		$("#enrollSex").combobox({
	    	data : v_sex,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
	    // 证件类型
		$("#enrollIdcardType").combobox({
	    	data : v_enrollIdcardType,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight:'auto'
	    });
   	});
   	
   	
   	function saveSign(){
   	 var idCard=$("#enrollIdcardNo").val();	//获取输入的证件号码
   	 var v_enrollExamName= $('#enrollExamName').combobox('getValue');	//获取选择考试名称的ID
   	 var v_enrollSex=$('#enrollSex').combobox('getValue');		//获取考生性别
   	 var v_enrollIdcardType=$('#enrollIdcardType').combobox('getValue'); 	//获取证件类型
   	 var v_enrollExamId= $('#enrollExamName').combobox('getText');		//获取考试名称
   	 document.getElementById("enrollExamId").value=v_enrollExamId; 	//给考试名称赋值
     var enrollExamId = $("#enrollExamId").val();
     if(v_enrollSex==""){
     	alert("请选择性别");
     	return v_enrollSex;
     }
     if(v_enrollIdcardType==""){
     	alert("请选择证件类型");
     	return v_enrollIdcardType;
     }
     if(enrollExamId=="===请选择==="){
     	alert("请选择考试名称");
     	return enrollExamId;
     }
     
     
     //判断身份证输入的是否正确
		if (v_enrollIdcardType == "1") {	//判断考生选择的证件类型为身份证
		var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;//身份证的正则表达式
			if (regIdCard.test(idCard)) {
				if (idCard.length == 18) {
					var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
    				var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组					
    				var idCardWiSum = 0; //用来保存前17位各自乖以加权因子后的总和
					for ( var i = 0; i < 17; i++) {
   						  idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];					
   						  }
					var idCardMod = idCardWiSum % 11;//计算出校验码所在数组的位置
					var idCardLast = idCard.substring(17);//得到最后一位身份证号码//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
					if (idCardMod == 2) {
						if (idCardLast == "X"|| idCardLast == "x") {
						} else {
							alert("身份证号码错误！");
							return false;
						}
						} else {//用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
						if (idCardLast == idCardY[idCardMod]) {
							} else {
								alert("身份证号码错误！");
								return false;
										}
									}
								}
							} else {
								alert("身份证格式不正确!");
								return false;
							}
						}
						
				if(v_enrollIdcardType=="2"){
					var re1 = /^[a-zA-Z]{5,17}$/;
        			var re2 = /^[a-zA-Z0-9]{5,17}$/;
        			if(re2.test(idCard)||re1.test(idCard)){
        			}else{
        			alert("护照号码输入错误");
        			return false;
        			}
				}
						
						
   	 var url = basePath + "signups/signup/saveSign";
   	 $.messager.progress();	// 显示进度条
   	  $('#fm').form('submit',{
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
						 window.returnValue="ok";
						 window.close(); 
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
   			 
   	 });
   	}
    </script>

  </head>

<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: auto;" border="false">
			<form id="fm" method="post">
			<input type="hidden" id="regId" name="regId" value="${v_examUserReg.regId}">
			<input type="hidden" id="enrollExamId" name="enrollExamId"">
				<sicp3:groupbox title="报名信息">
					<table class="table" style="width:98%;height: 98%">
						<tr>
							<td style="text-align:right;"><nobr>姓名:</nobr>
							</td>
							<td><input id="enrollName" name="enrollName" style="width: 195px"
								class="easyui-validatebox" class="easyui-validatebox"
								data-options="required:true" />
							</td>
						</tr>
						
						<tr>
						<td style="text-align:right;"><nobr>性别</nobr></td>
						<td><input id="enrollSex" name="enrollSex" style="width: 200px"
						data-options="required:true"/></td>
						</tr>
						
						<tr>
							<td style="text-align:right;"><nobr>单位:</nobr>
							</td>
							<td><input id="enrollUnit" name="enrollUnit" style="width: 195px"
								class="easyui-validatebox" class="easyui-validatebox"
								data-options="required:true" />
							</td>
						</tr>
						
						<tr>
						<td style="text-align:right;"><nobr>证件类型</nobr></td>
						<td><input id="enrollIdcardType" name="enrollIdcardType" style="width: 200px"
						data-options="required:true"/></td>
						</tr>
						
						
						<tr>
							<td style="text-align:right;"><nobr>证件号码:</nobr>
							</td>
							<td><input id="enrollIdcardNo" name="enrollIdcardNo" style="width: 195px"
								class="easyui-validatebox" class="easyui-validatebox"
								data-options="required:true" />
							</td>
						</tr>
						
						<tr>
							<td style="text-align:right;"><nobr>考试名称:</nobr>
							</td>
							<td><input id="enrollExamName" name="enrollExamName" style="width: 200px"
								class="easyui-validatebox" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;"><nobr>备注:</nobr>
							</td>
							<td><input id="enrollRemark" name="enrollRemark" style="width: 195px"
								class="easyui-validatebox" class="easyui-validatebox"/>
							</td>
						</tr>
					</table>
				</sicp3:groupbox>
			</form>
			<br/>
			<div style="text-align:center">
	        	<a href="javascript:void(0)" class="easyui-linkbutton"
					iconCls="icon-save" onclick="saveSign()" id="btnSave">点击报名 </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        </div>
		</div>
	</div>
</body>
</html>
