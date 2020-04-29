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

<!DOCTYPE html>
<html>
<head>
<title>检查计划信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
 // 执法计划类别
	var planchecktype = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
	var cb_planchecktype; // 执法计划类别
$(function() {
// 执法计划类别
		cb_planchecktype = $('#planchecktype').combobox({
			data:planchecktype,
			valueField:'id',
			textField:'text',
			required:true,//必填项目
			edittable:false,
			panelHeight:'auto'
		});
		//查询企业类别
		gettypes("COMDALEI");
		// 企业大类
// 		var sq = eval(cb_comdalei2);
// 		var str ="";
// 		for(var i=0;i<cb_comdalei2.length;i++){
// 		alert(sq[i].id);
// 		alert(sq[i].text);
// $("#plantypeareas").append("<input type='checkbox' name=plantypearea  id='plantypearea"+sq[i].id+"' value='"+sq[i].id+"'> "+sq[i].text+"</input>");
// 		}
		
});

//范围切换(str 为范围标识如按类别COMXIAOLEI)
function selectplantype(str){
$('#plantypeareas').empty();
 gettypes(str);
}



//获取企业类别列表
 function gettypes(str){
$.post(basePath + 'supervision/getqiyeType', {
				type : str
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
					for(var i=0;i<mydata.length;i++){
					$("#plantypeareas").append("<input type='checkbox' style='width:20px'  name='plantypearea'  id='"+mydata[i].id+"' value='"+mydata[i].id+"'> "+mydata[i].name+"</input>");
					if(i%4==0 && i!=0){//整除
					$("#plantypeareas").append("<br/>");
					}
								}
					}
				} 
			}, 'json');
			return true;
				}


	// 保存企业信息 
	var savePlan = function($dialog, $grid, $pjq) {
		var url = basePath + 'supervision/savePlan';
		//提交一个有效并且避免重复提交的表单
		$pjq.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){ 
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				if(!$("input[type='checkbox']").is(':checked')){
				alert("请选择执行范围");
				isValid=false;
				}
				if($("input[name='planstdate']").val()==null || $("input[name='planstdate']").val()==""){
				alert("请选择执行时间");
				isValid=false;
				} 
				if($("input[name='planeddate']").val()==null || $("input[name='planeddate']").val()==""){
				alert("请选择执行时间");
				isValid=false;
				}
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

	// 加载窗口
	var messageWindow = function(val){
	if(val=="close"){
	parent.$.messager.progress('close');
	}else if(val="open"){
		parent.$.messager.progress({
				text : '数据加载中....'
			});
	}
	};
	
	//验证编码唯一性
	function checkUniqueness(){
	var plancode = $('#plancode').val().toUpperCase();
	if(plancode!=null && plancode!=""){
	$.post(basePath + 'supervision/checkCode', {
				plancode : plancode
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.total;
					//存在
					if(mydata>0){
					alert("编号重复请重新填写");
					$('#plancode').val("");
					$('#greentext').remove();
					}else{
					$('#plancode').val(plancode);
					$('#greentext').remove();
					$('#checkButton').before("<font color='green' id='greentext'>此编号可以使用   </font>");
					}
				} 
			}, 'json');
	}
	}
	
</script>
</head>

<body >
	<form id="fm" method="post">
	<div  style="width: 99%;" >
	<sicp3:groupbox title="计划信息" >	
	<input type="hidden" name="planid" id="planid" >
        		<table class="table"  style="width: 99%;" >
                       <tr>
						<td style="text-align:right;"><nobr>执法计划:</nobr></td>
						<td><input id="planchecktype" name="planchecktype"   class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"  />
						<input id="plantitle" name="plantitle" style="width: 260px" class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					 <tr>
						<td style="text-align:right;"><nobr>编号:</nobr></td>
						<td>
						<!-- 方法待定 -->
						<input onblur="checkUniqueness();" id="plancode" name="plancode" style="width: 260px" class="easyui-validatebox" data-options="required:true" />
						<input  type="button"  onclick="checkUniqueness();" value="验证" /><font color="red" id="checkButton">保证编码唯一</font>
						</td>
					</tr>
					 <tr>
						<td style="text-align:right;"><nobr>执法时间：</nobr></td>
						<td>
					<input type="text" id="planstdate" name="planstdate"    onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'planeddate\')}',readOnly:true})" class="Wdate"   readonly="readonly" data-options="required:true"/> 
						&nbsp;-&nbsp; <input type="text" id="planeddate" name="planeddate"    onFocus="WdatePicker({minDate:'#F{$dp.$D(\'planstdate\')}',readOnly:true})" class="Wdate"  readonly="readonly" data-options="required:true"/> 
						</td>
						</tr>
						<tr><td style="text-align:right;"><nobr>执法范围：</nobr></td>
					<td >
					<input  type="radio"  name="plantype" id="plantype1" value="1" checked="checked" onclick="selectplantype('COMXIAOLEI')" />按类别
<!-- 					<input  type="radio"  name="plantype" id="plantype2" value="2"  onclick="selectplantype('qy')" />按区域 -->
<!-- 					<input  type="radio"  name="plantype" id="plantype3" value="3"  onclick="selectplantype('tddx')"  />按特定对象 -->
					</td>
						</tr>
						
					<tr>
					<td></td>
					<td id="plantypeareas">
					</td>
					</tr>
					
					<tr>
					<td style="text-align:right;"><nobr>内容：</nobr></td>
					<td >
                    <textarea rows="" cols="" style="width: 600px;height: 100px" name="plancontent" ></textarea>					
					</td>
					</tr>
					
					<tr>
					<td style="text-align:right;"><nobr>备注：</nobr></td>
					<td >
                    <textarea rows="" cols="" style="width: 600px;height: 100px" name="planremark" ></textarea>					
					</td>
					</tr>
				</table>
	        </sicp3:groupbox>
	        </div>
	   </form>
</body>
</html>