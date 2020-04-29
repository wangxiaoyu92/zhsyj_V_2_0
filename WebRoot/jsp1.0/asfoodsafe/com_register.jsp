<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.*" %>
<%@ page import="com.zzhdsoft.utils.db.PubFunc"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息注册</title>
<jsp:include page="head.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<style>
	table{margin-bottom:20px}
	table tr{height:30px;line-height:30px;}
</style>
<script type="text/javascript">
//用户名验证标志 yes可以使用
var userNameCheckFlag="no";
//检查用户名是否存在
function checkUserNameExist(){
	var com_user_name=$("#com_user_name").val();
	if(com_user_name.length>=6){
		$("#tipMsg").html("正在检查帐号名称是否有其他人使用，请稍等......");
		$.ajax({
			url:"com_checkUserNameExist.action?user_name="+com_user_name+"&time="+new Date().getMilliseconds(),
			type:'post',
			async:true,
			cache:false,
			timeout: 100000,
			data:'',
			error:function(){
				alert("服务器繁忙，请稍后再试！");
			},
			success: function(result){
		        if(result=="1"){
		        	userNameCheckFlag="no";
		        	$("#tipMsg").html("<font color=red>此帐号已被其他人使用!</font>");
		        }else{
		        	userNameCheckFlag="yes";//更改标志
		        	$("#tipMsg").html("<font color=green>此帐号名称可以使用!</font>");
		        }
		     }
	   });	
	}
};

//保存提交表单
$(function(){
	//检验表单
	$("#myform").validationEngine({
		validationEventTriggers:"keyup blur", //will validate on keyup and blur
		promptPosition:"centerRight",//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
		prettySelect:true//,是否使用美化过的select
	 });
	 
	  //自动加载省份
	  $('#com_province').combobox({
		url:'region/region_loadRegion.action?id=0',
		valueField:'id',
		textField:'text',
		required:true,//必填项目
		editable:false,//不可编辑
		onChange:function(newValue,oldValue){
		    loadCity(newValue);
	    },
	    onSelect:function(newValue,oldValue){
		   $('#comProvince').val($('#com_province').combobox('getText'));
	    },
	    onLoadSuccess:function(){
       }   
	  });
	  
	  $('#com_province').combobox('setValue', '410000');//河南省
	  $('#com_city').combobox('setValue', '410900');//濮阳市
	  //$('#com_county').combobox('setValue', '411503');//平桥区
	  $('#comProvince').val('河南省');
	  $('#comCity').val('濮阳市');
});


function loadCity(id){
	  $('#com_city').combobox({
		url:'region/region_loadRegion.action?id='+id,
		valueField:'id',
		textField:'text',
		required:true,//必填项目
		editable:false,//不可编辑
		onChange:function(newValue,oldValue){ 
			loadCountry(newValue);  
	    },
	    onSelect:function(newValue,oldValue){ 
		   $('#comCity').val($('#com_city').combobox('getText'));
	    },
	    onLoadSuccess:function(){
       }  
	  });  
}
function loadCountry(id){
	  $('#com_county').combobox({
		url:'region/region_loadRegion.action?id='+id,
		valueField:'id',
		textField:'text',
		required:true,//必填项目
		editable:false,//不可编辑 
		onChange:function(newValue,oldValue){ 
	    },
	    onSelect:function(newValue,oldValue){ 
		 $('#comCounty').val($('#com_county').combobox('getText'));
	    },
	    onLoadSuccess:function(){
       }  
	  });  
}

function addHttp(){
	var val=$('#com_web').val();
	if(val.length>0){
		if(val.indexOf('http://')==-1){
			$('#com_web').val('http://'+val);
		}
	}
}

function reg(){
	var status=$("#com_myform").validationEngine("validate");
	if(status){//表单验证通过
		if(userNameCheckFlag=="yes"){//用户名不重复,且营业执照合格 && isYyzzh($('#com_zjhm').val())
		   var com_province=$('#com_province').combobox('getValue');
		   if(com_province.length==0){
		   	alert('请选择所在地区的省份！');
		   	return false;
		   }
		   
		   var com_city=$('#com_city').combobox('getValue');
		   if(com_city.length==0){
		   	alert('请选择所在地区的市！');
		   	return false;
		   }
		   
		   var com_county=$('#com_county').combobox('getValue');
		   if(com_county.length==0){
		   	alert('请选择所在地区的县区！');
		   	return false;
		   }
		   
		   if($("#receiveTk").attr("checked")==false){
			   	alert('由于您不同意网站注册条款，不能注册！');
			   	return false;
		   }
	   
		//提交注册
		 $("#check_info").html("注册检测中，请稍候...");
		    var formData=$('#com_myform').serialize();
		    $("#saveBtn").hide();
			$.ajax({
			url:"com_register.action?time="+new Date().getMilliseconds(),
			type:'post',
			async:true,
			cache:false,
			timeout: 100000,
			data:formData,
			error:function(){
			   alert("服务器繁忙，请稍后再试！");
			},
			success: function(result){
			   if(result=="1"){
			   		alert("注册成功，即将跳往企业登陆入口！");
		            window.location.href='user_login.jsp'
			   }else if(result=="2"){
		         alert("该用户已存在，请重新输入！");
		         $('#com_user_name').focus();
		       }else if(result=="3"){
		         	alert("该证件号码已存在,请填写正确的证件号码！如果发现证件号码被冒用，请电话联系我们！");
		         	$('#com_zjhm').focus();
		       }else{
		       	  alert("注册失败！");
		       }
		     }
		});
		$("#saveBtn").show();
		}else{
			alert('用户名重复,请换用其他用户名！');
			return ;
		}
	}else{
		alert('请检查是否有漏填项！');
		return ;
	}
		   
}

function changeTip(){
/*
	var qylx=$('#qylx').val();
	if(qylx=="1"){
		$('#tipText').html('营业执照号');
	}else if(qylx=="2"){
		$('#tipText').html('生工加工许可证');
	}else if(qylx=="3"){
		$('#tipText').html('食品流通许可证');
	}else if(qylx=="4"){
		$('#tipText').html('餐饮服务许可证');
	}else{
		$('#tipText').html('营业执照号');
	}
	*/
}
function checkYyzzh(val){
 var result=isYyzzh(val);
 if(result==false){
 	$('#yyzzhtip').html('营业执照不正确！');
 }
}
</script>
</head>
<body>
<div class="mainbody">

</div>

<div class="news_page">
	<div class="news_content news_list_content">
		<h1 style="text-align:center">企业信息注册</h1>
<form id="com_myform" name="com_myform" method="post" action="">
<table width="70%" border="0" cellpadding="0" cellspacing="0" align="left">
<tr>
	<td><font class="red">*</font>用 户 名： </td>
	<td><input name="comUserName" id="com_user_name" type="text" size="35" class="validate[required,minSize[6],maxSize[20],custom[username]] input-text" onblur="checkUserNameExist()"/>
	<div id="tipMsg"/>
</td>
</tr>

<tr>
	<td><font class="red">*</font>登录密码：</td>
	<td><input id="com_pwd" name="comPwd" type="password" size="35" class="validate[required,minSize[6],maxSize[20]] input-text"/></td>
</tr>

<tr>
	<td><font class="red">*</font>确认密码：</td>
	<td><input type="password" size="35" class="validate[required,condRequired[com_pwd],equals[com_pwd]] input-text"/></td>
</tr>

<tr>
	<td><font class="red">*</font>企业名称：</td>
	<td><input name="comMc" id="com_name" type="text" size="35" class="validate[required,maxSize[200]] input-text"/></td>
</tr>

<tr>
	<td><font class="red">*</font>企业性质： </td>
	<td>
	<select id="com_qyxz" name="comQyxz" class="validate[required] input-text">
	  <option value="">请选择企业性质</option>
	  <option value="1">国有</option>
	  <option value="2">集体</option>
	  <option value="3">股份</option>
	  <option value="4">私营</option>
	  <option value="5">合资</option>
	  <option value="6">外资</option>
	  <option value="7">其他</option>
	</select>
	</td>
</tr>
<tr style="display:none">
	<td><font class="red">*</font>企业类型：</td>
	<td>
	<select id="qylx" name="comQylx" class="validate[required] input-text" onchange="changeTip()">
	  <option value="">请选择企业类型</option>
	   <option value="1" selected>普通企业</option>
	   <option value="2">食品生工加工企业</option>
	   <option value="3">食品流通企业</option>
	   <option value="4">餐饮服务企业</option>
	   <option value="5">其他</option>
	 </select>
	 </td>
</tr>
<tr>
	<td><font class="red">*</font><span id="tipText">营业执照号</span>:</td>
	<td><input type="text" id="com_zjhm" name="comZjhm" value="" maxlength="15" class="validate[required,maxSize[15]] input-text" onpropertychange="if(isNaN(value)) value=value.substring(0,value.length-1);" />
		<span id="yyzzhtip" style="color:red"></span>
	</td>
</tr>

<tr>
	<td><font class="red">*</font>所在地区：</td>
	<td>
		<select name="comProvinceDm" class="easyui-combobox" readonly="true" id="com_province" style="width:100px;"></select>
		<select name="comCityDm" class="easyui-combobox" readonly="true" id="com_city" style="width:100px;"></select>
		<select name="comCountyDm" class="easyui-combobox text-input" readonly="true" id="com_county" style="width:100px;"></select>
		
		<input type="hidden" id="comProvince" name="comProvince"/>
		<input type="hidden" id="comCity" name="comCity"/>
		<input type="hidden" id="comCounty" name="comCounty"/>
	</td>
</tr>
<tr>
	<td><font class="red">*</font>公司地址：</td>
	<td><input name="comAddress" type="text" size="35" class="validate[required,maxSize[200]] input-text"/></td>
</tr>
<tr>
	<td><font class="red">*</font>企业法人：</td>
	<td><input name="comLxr" type="text" size="35"  class="validate[required,maxSize[50]] input-text"/></td>
</tr>
<tr>
	<td><font class="red">*</font>联系电话：</td>
	<td><input name="comLxdh" type="text" maxlength="13" size="35" class="validate[required,custom[phone]] input-text"/></td>
</tr>
<tr>
	<td><font class="red">*</font>传真：</td>
	<td><input name="comFax" type="text" maxlength="13" size="35" class="validate[custom[phone]] input-text"/></td>
</tr>
<tr>
	<td><font class="red">*</font>邮编：</td>
	<td><input name="comZip" type="text" maxlength="13" size="35" class="validate[custom[chinaZip]] input-text"/></td>
</tr>
<tr>
	<td><font class="red">*</font>电子邮箱： </td>
	<td>
		<input name="comEmail" type="text" size="35" class="validate[required,custom[email]] input-text" />
	</td>
</tr>
<tr>
	<td>企业网址：</td>
	<td><input name="comWeb" id="com_web" type="text" size="35" class="validate[custom[url]] input-text" onblur="addHttp();" /></td>
</tr>
<tr>
	<td colspan="2">
		<input type="checkbox" id="receiveTk" checked />我同意 <a href="tk.jsp" target="_blank">会员服务协议</a>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="button" value="确认注册" class="inp_L1" onMouseOver="this.className='inp_L2'" onMouseOut="this.className='inp_L1'" id="saveBtn" onclick="reg();"/>
		<input type="reset" value="清空重填"  class="inp_L1" onMouseOver="this.className='inp_L2'" onMouseOut="this.className='inp_L1'" id="resetBtn" onclick="com_myform.reset();"/>
		<a href="user_login.jsp">企业登录</a> |  <a href="index.html">返回追溯平台首页</a>
	</td>
</tr>

<tr>
<td colspan="2">
<div id="check_info" color="red" style="widht:100%;font-size:12px;color:red;" style="float:left;"></div>
</td>
</tr>
</table>
   </form>
	</div>
	<div style="width:96%;margin-left:15px;text-align:center">
        <ul id="page_list"></ul>
    </div>  
</div>

<%@ include file="footer.jsp"%>
</body>
</html>