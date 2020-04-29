<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<%
String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));  //计划id
String v_op = StringHelper.showNull2Empty(request.getParameter("op"));  //计划id
 %>
<!DOCTYPE html>
<html>
<head>
<title>修改计划信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
// 企业大类
	var planchecktype = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
	var cb_planchecktype; // 执法计划类别
$(function() {
// 执法计划类别
		cb_planchecktype = $('#planchecktype').combobox({
			data:planchecktype,
			valueField:'id',
			textField:'text',
			required:false,
			edittable:false,
			panelHeight:'auto'
		});
		//input赋值
		if ($('#planid').val().length > 0) {
		var plantypearea = '${obj.data.plantypearea }';
			// 企业大类
		            gettypes("COMDALEI",plantypearea);
			if('<%=v_op%>' == 'view'){	
			$('#item2').css('display','none');
			$('#selectItems').css('display','none');
				$('form :input').addClass('input_readonly');
				$('form :input').attr('readonly','readonly');				
				$('.Wdate').attr('disabled',true);	
				cb_planchecktype.combobox('disable',true);		
				$('#item5').css('display','');
				$('#item4').css('display','none');
				//执行项数据
				viewyouyi();
			}else {
			 getitemsByplan();
			}
			
		}
		
		
});

//获取企业类别列表
 function gettypes(str,oldvalue){
$.post(basePath + 'supervision/getqiyeType', {
				type : str
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
					//原来的数值
					var oldplantypearea = oldvalue;
					for(var i=0;i<mydata.length;i++){
// 					alert(mydata[i].id);
// 					alert(oldplantypearea);
//                  alert(oldplantypearea.indexOf(mydata[i].id));
                    //是否含有
                    if(oldplantypearea!=null ){
                    if(oldplantypearea.indexOf(mydata[i].id)>=0){
                    	$("#plantypeareas").append("<input type='checkbox' checked='checked' name=plantypearea  id='"+mydata[i].id+"' value='"+mydata[i].id+"'> "+mydata[i].name+"</input>");
					}else {
						$("#plantypeareas").append("<input type='checkbox' name=plantypearea  id='"+mydata[i].id+"' value='"+mydata[i].id+"'> "+mydata[i].name+"</input>");
						}
						}else {
							$("#plantypeareas").append("<input type='checkbox' name=plantypearea  id='"+mydata[i].id+"' value='"+mydata[i].id+"'> "+mydata[i].name+"</input>");
						}
						if(i%4==0 && i!=0){//整除
					$("#plantypeareas").append("<br/>");
					}
							}
							
					}
				} 
			}, 'json');
				}



	// 保存企业信息 
	var savePlan = function($dialog, $grid, $pjq) {
		var url = basePath + 'supervision/updatePlan';
		//提交一个有效并且避免重复提交的表单
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

 //有数值显示(查询出父类名称)
	     function viewyouyi(){
	     var planid= "<%=v_planid%>";
$.post(basePath + 'supervision/getPlansAndpidnameByid', {
				planid : planid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
					$('#item5').append("<tr><td>执法项</td><td>编号</td></tr>");
					for(var f=0;f<mydata.length;f++){
				$('#item5').append("<tr class='item_4' id='"+mydata[f].contentid+"' ><td><input type='hidden'  name='items' value='"+mydata[f].contentid+"&"+mydata[f].itemid+"'  />"+mydata[f].contentcode+"."+mydata[f].content+"<font color='blue'>["+mydata[f].itemname+"]<font color='red'>["+mydata[f].itempidname+"]</font></td><td>"+mydata[f].contentid+"</td></tr>");
			}
					}else {
					
					}
				} 
			}, 'json');
				}

</script>

<script type="text/javascript">
var str2="<tr><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>";
var str3="<tr class='title' id='item3'> </tr>";
var allitems;
var olditems;
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
//获取计划信息关联的执行项
 function getitemsByplan (){
var planid= "<%=v_planid%>";
messageWindow("open");
$.post(basePath + 'supervision/getPlansByid', {
				planid : planid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
					//获得一类
					olditems=mydata;
					queryOnePlanDTO(mydata);
 					}else {
					//获得一类
					queryOnePlanDTO("");
					//获得二类
					queryTwoPlanDTO("");
					}
					messageWindow("close");
				} 
			}, 'json');
			}
			
		//查询项对象	
	function getitemsByid (str){
$.post(basePath + 'supervision/getitemsByid', {
				itemid : str[0].itempid
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					$("#oneType").val(mydata.itempid);
					queryTwoPlanDTO(str);
				} 
			}, 'json');
			}
//获得一级分类
function queryOnePlanDTO(str){
$.post(basePath + 'supervision/queryOnePlanDTO', {
				itempid : '0000000000000000000000000'
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					$('#oneType').append("<option   value=''>--请选择--</option>");
					for(var i =0;i<mydata.length;i++){
					$('#oneType').append("<option   value='"+mydata[i].itemid+"'>"+mydata[i].itemname+"</option>");
					}
					//有数值
					if(str!=null&&str!=""){
					getitemsByid(str);
					}			
				} 
			}, 'json');
			}
//二级类别			
function queryTwoPlanDTO(str){
var checkValue=$("#oneType").val(); 
//  var checktext=$("#oneType  option:selected").text();
// alert(checkValue);
if(checkValue=="" || checkValue==null){
$('#twoType').empty();
$('#twoTypeselect').css('display','none');
//隐藏
var oldvalue=$('#selecttext').val();
if(oldvalue!=null&&oldvalue!=""){
$('.'+oldvalue).css('display','none');
}
// $('#item2').empty();
// $('#item4').empty();
// var str1="<tr ><td style='text-align: center;'><input type='checkbox' id='allitems' name='' value=''onclick=\"allyouyi()\"   />选择</td><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>"
// $('#item2').append(str1);
// $('#item4').append(str2).append(str3);

allitems="";
}else{
$('#oneitempid').val(checkValue);
$('#twoTypeselect').css('display','');
//隐藏
var oldvalue=$('#selecttext').val();
if(oldvalue!=null&&oldvalue!=""){
$('.'+oldvalue).css('display','none');
}
// $('#item2').empty();
// $('#item4').empty();
// var str1="<tr ><td style='text-align: center;'><input type='checkbox' id='allitems'  name='' value='' onclick=\"allyouyi()\"  />选择</td><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>"
// $('#item2').append(str1);
// $('#item4').append(str2).append(str3);
$.post(basePath + 'supervision/queryOnePlanDTO', {
				itempid : checkValue
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					if(mydata.length>0){
					$('#twoType').empty();
					$('#twoType').append("<option   value=''>--请选择--</option>");
					for(var i =0;i<mydata.length;i++){
					$('#twoType').append("<option   value='"+mydata[i].itemid+"'>"+mydata[i].itemname+"</option>");
					}
					//有数值
					if(str!=null&&str!=""){
					$("#twoType").val(str[0].itempid); 
					queryThreePlanDTO(str);
					}
					}else{
					$('#twoType').empty();
					$('#twoTypeselect').css('display','none');
					}
				} 
			}, 'json');
			
}
}
//三级类别
function queryThreePlanDTO(str){
var checkValue=$("#twoType").val(); 
var oldvalue=$('#selecttext').val();
// alert(checkValue);
// $('#itme2').empty();
if(checkValue=="" || checkValue==null){
$('#item2').empty();
$('#item4').empty();
var str1="<tr ><td><input type='checkbox' id='allitems'  name='' value='' onclick=\"allyouyi()\"  />选择</td><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>"
$('#item2').append(str1);
$('#item4').append(str2).append(str3);

allitems="";
}else{
$('#twoitempid').val(checkValue);
$.post(basePath + 'supervision/queryThreePlanDTO', {
				itempid : checkValue,
				page : 5
			}, 
			function(result) {
				if (result.code=='0') {
					var mydata = result.data;
					var mytotal = result.total;
					if(mydata.length>0){
					allitems=mydata;
					if(oldvalue!=null&&oldvalue!=""){
					$('.'+oldvalue).css('display','none');
					$('.'+checkValue).css('display','');
					}
					for(var i =0;i<mydata.length;i++){
					$('#item2').append("<tr  class='"+mydata[i].itempid+"' ><td  width=15%><input type='checkbox' onclick=\"youyi('"+mydata[i].contentid+"','"+mydata[i].content+"','"+mydata[i].itemid+"','"+mydata[i].itemname+"')\" name='itmes1' id='"+mydata[i].contentid+"a' value='"+mydata[i].contentid+"&"+mydata[i].itemid+"'  /></td><td>"+mydata[i].content+"<font color='red'>["+mydata[i].itemname+"]</font></td><td>"+mydata[i].contentid+"</td></tr>");
					}
					//有数值
					if(olditems!=null&&olditems!=""){
					for(var d=0;d<olditems.length;d++){
					if($('#'+olditems[d].contentid+"a").prop("checked")){
					
					}else{
					//右面没有相应id是否存在，说明用户取消了就不选中
					if($('#'+olditems[d].contentid).length>0){
					$('#'+olditems[d].contentid+"a").prop("checked",true);
					}
					}
					}
					}
					}else{
                    $('#item2').empty();
					}	
					//有数值
					if(str!=null&&str!=""){
					for(var f=0;f<str.length;f++){
					$('#'+str[f].contentid+"a").prop("checked",true);
					}
					//右侧数据
					edityouyi(str);
					
					
					}		
				} 
			}, 'json');
			
			 $('#selecttext').val(checkValue);
}
}
	 //有数值显示
	     function edityouyi(str){
	      if(str!=null&&str!=""){
			for(var f=0;f<str.length;f++){
				$('#item4').append("<tr class='item_4' id='"+str[f].contentid+"' ><td><input type='hidden'  name='items' value='"+str[f].contentid+"&"+str[f].itemid+"'  />"+str[f].content+"<font color='red'>["+str[f].itemname+"]</font></td><td>"+str[f].contentid+"</td></tr>");
			}
				}
				}
	//往右增加	
		function youyi(contentid,content,itemid,itemname){
		if($('#'+contentid+"a").prop("checked")){
		//往右增加
			$('#item3').before("<tr class='item_3' id='"+contentid+"' ><td><input type='hidden'  name='items' value='"+contentid+"&"+itemid+"'  />"+content+"<font color='red'>["+itemname+"]</font></td><td>"+contentid+"</td></tr>");
		}else{
		$('#'+contentid).remove();
		}
		}
	//全部右移
	function allyouyi(){
	if($('#allitems').prop("checked")){
	//全部选中
	for(var i =0 ;i<allitems.length;i++){
	if($('#'+allitems[i].contentid+"a").prop("checked")){
	
		}else{
	$('#'+allitems[i].contentid+"a").prop("checked",true);
		$('#item3').after("<tr class='item_3' id='"+allitems[i].contentid+"' ><td><input type='hidden'  name='items' value='"+allitems[i].contentid+"&"+allitems[i].itemid+"'  />"+allitems[i].content+"<font color='red'>["+allitems[i].itemname+"]</font></td><td>"+allitems[i].contentid+"</td></tr>");
	
	}
	}
	}else{
	//全部取消
	for(var i =0 ;i<allitems.length;i++){
	$('#'+allitems[i].contentid+"a").prop("checked",false);
	$('#'+allitems[i].contentid).remove();
	}
	}
	
	
	
// 	if($('#'+contentid+"a").prop("checked")){
		//往右增加
// 			$('#item3').before("<tr class='item_3' id='"+contentid+"' ><td><input type='hidden'  name='items' value='"+contentid+"&"+itemid+"'  />"+content+"<font color='red'>["+itemname+"]</font></td><td>"+contentid+"</td></tr>");
// 		}else{
// 		$('#'+contentid).remove();
// 		}
	}	
	
		
function emptyText (onevalue,twovalue){
	if(onevalue=="" || onevalue==null){
	
	}else if(twovalue=="" || twovalue==null){
	}
	};

// 保存执行项信息 
	var savePlan = function($dialog, $grid, $pjq) {
		var url = basePath + 'supervision/updatePlan';
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
	
	
</script>
</head>

<body >
	<form id="fm" method="post">
	<div  style="width: 99%;" >
	<sicp3:groupbox title="计划信息">	
	<input type="hidden" name="planid" id="planid" value="<%=v_planid %>" >
	
        		<table class="table"  style="width: 99%;" >
                       <tr>
						<td style="text-align:right;"><nobr>执法计划:</nobr></td>
						<td><input id="planchecktype" name="planchecktype" value="${obj.data.planchecktype }"  class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'"   />
						<input id="plantitle" name="plantitle" value="${obj.data.plantitle }"  style="width: 260px" class="easyui-validatebox" data-options="required:true" />
						</td>
					</tr>
					 <tr>
						<td style="text-align:right;"><nobr>编号:</nobr></td>
						<td>
						<input id="plancode" name="plancode" value="${obj.data.plancode }"  readonly="readonly" style="width: 260px" class="easyui-validatebox input_readonly" data-options="required:true" />
						<input  type="button"  value="验证" disabled="disabled"/><font color="red">保证编码唯一</font>
						</td>
					</tr>
					 <tr>
						<td style="text-align:right;"><nobr>执法时间：</nobr></td>
						<td>
					<input type="text" id="planstdate" name="planstdate" value="${fn:substring(obj.data.planstdate,0,10) }"   onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'planeddate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 
						&nbsp;-&nbsp; <input type="text" id="planeddate" value="${fn:substring(obj.data.planeddate,0,10) }"   name="planeddate"    onFocus="WdatePicker({minDate:'#F{$dp.$D(\'planstdate\')}',readOnly:true})" class="Wdate" readonly="readonly"/> 
						</td>
						</tr>
						<tr><td style="text-align:right;"><nobr>执法范围：</nobr></td>
					<td >
					<input  type="radio"  name="plantype" id="plantype1" value="1"  <c:if test="${obj.data.plantype==1 }">checked="checked"</c:if>     />按类别
<!-- 					<input  type="radio"  name="plantype" id="plantype2" value="2"  <c:if test="${obj.data.plantype==2 }">checked="checked"</c:if> />按区域 -->
<!-- 					<input  type="radio"  name="plantype" id="plantype3" value="3"   <c:if test="${obj.data.plantype==3 }">checked="checked"</c:if> />按特定对象 -->
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
                    <textarea rows="" cols="" style="width: 600px;height: 100px" name="plancontent" >${obj.data.plancontent }</textarea>					
					</td>
					</tr>
					
					<tr>
					<td style="text-align:right;"><nobr>备注：</nobr></td>
					<td >
                    <textarea rows="" cols="" style="width: 600px;height: 100px" name="planremark" >${obj.data.planremark }</textarea>					
					</td>
					</tr>
				</table>
	        </sicp3:groupbox>
	        
	       <div  style="width: 99%;" >
<input type="hidden" name="selecttext" id="selecttext"  value="">
	<sicp3:groupbox title="执法项设置">	
	<div   style="width: 99%;"  id="selectItems">
		<table class="table"  style="width: 45%;">
		<tr >
		<td   >
		<select name="oneType" id="oneType" onchange="queryTwoPlanDTO('')"> 
		</select> 
		 </td>
		<td id="twoTypeselect" style="display: none;" colspan="2" ><select name="twoType" id="twoType" onchange="queryThreePlanDTO('')"> 
		</select> 
		 </td>
		</tr>
			</table>
	</div>
		<table class="table"  id="item2" style="width: 50%;float: left;">
		<tr ><td><input type="checkbox" id="allitems"  onclick="allyouyi()" value=""  />选择</td><td style="text-align: center;">执法项</td><td style="text-align: center;">编号</td></tr>
			
		</table>
		
		<div style="width: 5%"></div>
		<form id="fm" method="post">
	<input type="hidden" name="oneitempid" id="oneitempid"  value="" readonly="readonly">
   <input type="hidden"   name="twoitempid" id=twoitempid  value=""  readonly="readonly">
		<table  class="table" id="item5"   style="width:99%;text-align: center;display: none">
		<table  class="table" id="item4"   style="width:45%;float: right;">
			<tr><td style="text-align: center;" >执法项</td><td style="text-align: center;">编号</td></tr>
		<tr class="title" id="item3">
	  </tr>
			</table>
			</form>
			</sicp3:groupbox>
			</div>
	   </form>
	   
	   
</body>
</html>