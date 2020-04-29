<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.net.URLDecoder"%>
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
String v_plancode =  URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("plancode")),"utf-8"); 

 %>
<!DOCTYPE html>
<html>
<head>
<title>设置执行范围</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var str2="<tr><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>";
var str3="<tr class='title' id='item3'> </tr>";
var allitems;
var olditems;
$(function(){
 getitemsByplan();
});

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
var oldvalue=$('#selecttext').val();
$('#twoType').empty();
$('#twoTypeselect').css('display','none');
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
messageWindow("open");
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
					messageWindow("close");
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
messageWindow("open"); 

$('#item4').empty();
$('#item4').append(str2).append(str3);
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
					$('#item2').append("<tr  class='"+mydata[i].itempid+"' ><td><input type='checkbox' onclick=\"youyi('"+mydata[i].contentid+"','"+mydata[i].content+"','"+mydata[i].itemid+"','"+mydata[i].itemname+"')\" name='itmes1' id='"+mydata[i].contentid+"a' value='"+mydata[i].contentid+"&"+mydata[i].itemid+"'  /></td><td>"+mydata[i].content+"<font color='red'>["+mydata[i].itemname+"]</font></td><td>"+mydata[i].contentid+"</td></tr>");
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
					messageWindow("close");	
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
		$('#item3').before("<tr class='item_3' id='"+allitems[i].contentid+"' ><td><input type='hidden'  name='items' value='"+allitems[i].contentid+"&"+allitems[i].itemid+"'  />"+allitems[i].content+"<font color='red'>["+allitems[i].itemname+"]</font></td><td>"+allitems[i].contentid+"</td></tr>");
	
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
		var url = basePath + 'supervision/savePicset';
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
	
	
</script>

</head>

<body >
<div  style="width: 99%;" >
<input type="hidden" name="selecttext" id="selecttext"  value="">
	<sicp3:groupbox title="执法项设置">	
	<div  >
		<table    style="width: 50%;display: inline-table;">
		<tr >
		<td style="width:30px">
		<select name="oneType" id="oneType" onchange="queryTwoPlanDTO('')"> 
		</select> 
		 </td >
		<td id="twoTypeselect" style="width:50px;display: none;" colspan="2" >
		<select name="twoType" id="twoType" onchange="queryThreePlanDTO('')"> 
		</select> 
		 </td>
		 
		</tr>
			</table>
			<table   style="width:45%; display: inline-table; position: absolute;right:0px">
		<tr><td align="center" rowspan="2"><font style="font-size: 14px;" color="blue">已经选中的检查项</font></td></tr>
			</table>
	</div>
        <div  style="width: 95%;">   
        
		<table class="table"  id="item2" style="width: 50%;float: left;">
		<tr>
		<td style="width: 5%"><input type="checkbox" id="allitems"  onclick="allyouyi()" value=""  />选择</td>
		<td style="text-align: center;width: 40%">执法项</td>
		<td style="text-align: center;width: 5%">编号</td>
		</tr>
		</table>
		
		<div style="width: 5%"></div>
		<form id="fm" method="post">
	<input type="hidden" name="planid" id="planid"  value="<%=v_planid%>">
	<input type="hidden" name="plancode" id="plancode"  value="<%=v_plancode%>">
	<input type="hidden" name="oneitempid" id="oneitempid"  value="" readonly="readonly">
   <input type="hidden"   name="twoitempid" id=twoitempid  value=""  readonly="readonly">
		
		<table  class="table" id="item4"   style="width:45%;float: right;">
			<tr><td style="text-align: center;" >执法项</td>
			<td style="text-align: center;">编号</td></tr>
		<tr class="title" id="item3">
	  </tr>
			</table>
			</form>
			</div>
			</sicp3:groupbox>
			</div>
</body>
</html>