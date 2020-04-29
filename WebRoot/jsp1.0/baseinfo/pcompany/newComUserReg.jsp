<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>企业信息</title>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<link rel="stylesheet" href="<%=basePath %>/css/pwd.css" type="text/css">
<script type="text/javascript">

//地图定位获取经纬度
function myselectjwd(){
	var v_address=$("#comdz").val();		
	var obj = new Object();			
	var v_url=encodeURI(encodeURI("<%=basePath%>jsp/pub/pub/pubMap.jsp?address="+v_address+"&a="+new Date().getMilliseconds()));
    var v_retSt = :(v_url,obj,900,700);
	if (v_retSt != null){
       $("#comjdzb").val(v_retSt.jdzb);
       $("#comwdzb").val(v_retSt.wdzb);	 
       //$('#comdz').val(v_retSt.aab301);
    }     
}

$(function() {
	$('#passwd').keyup(function () { 
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{6,}).*", "g"); 
	
		if (false == enoughRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-defule'); 
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-strong'); 
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-medium'); 
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-weak'); 
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	}); 

});

//从单位信息表中读取
function mySelectComfenlei(){
	 
	var obj = new Object();
	obj.singleSelect="true";	//
	var v_mycomdaleicode=$("#comdalei").val();
	var v_mycomxiaoleicode=$("#comxiaolei").val();
	obj.mycomdaleicode=v_mycomdaleicode;
	obj.mycomxiaoleicode=v_mycomxiaoleicode;

    var url = "<%=basePath%>pub/pub/selectComfenleiIndex?a="+new Date().getMilliseconds();
	var dialog = parent.sy.modalDialog({
		title : '企业信息',
		param : obj,
		width : 430,
		height : 530,
		url : url
	},function (dialogID){
		var v_retObj = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少

		if (v_retObj!=null){
			$("#comdalei").val(v_retObj.comdaleicode);
			$("#comdaleiname").val(v_retObj.comdaleiname);
			$("#comxiaolei").val(v_retObj.comxiaoleicode);
			$("#comxiaoleiname").val(v_retObj.comxiaoleiname);
		}
	});

}

function showMenu_aaa027_2() {
	var v_opkind="comreg";
	var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?aaa027flag=0&opkind='+v_opkind; 
	var obj = new Object();
	var k = :(url,obj,300,400);
	if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
		$('#aaa027').val(k.aaa027);
		$('#aaa027name').val(k.aaa027name);
		$('#comdz').val(k.aab301);
	}
}


// 保存 
function myreg() {
	var url = basePath + '/pub/pub/savePcompanyReg';
	var loginurl = basePath + '/qylogin.jsp';

	//下面的例子演示了如何提交一个有效并且避免重复提交的表单
	$.messager.progress();	// 显示进度条
	$('#myform').form('submit',{
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
		 			window.location.href=loginurl;
        		}); 	                        	                     
          	} else {
          		$.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
};


</script>
</head>
<body style="background-color: white;">

	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;background-color: white;" border="false">
	        	<div id="toolbar" fit="true">
	        	<form name="myform" id="myform" method="post">
                    <h1 style="text-align:center;font-size:20px;line-height:30px;">企业用户注册</h1>					
	        		<table  align="center" style="border-spacing:8px;" class="mytable">
	        		    <tr>
						    <td style="text-align:right;"><nobr><font class="myred">*</font>联系人移动电话(登录账号):</nobr></td>
						    <td colspan="3"><input id="comyddh" name="comyddh" style="width: 200px" 
						    class="easyui-validatebox" data-options="required:true,validType:'mobile'"/>说明：此电话作为注册成功后的登录账号</td>	        		    
	        		    </tr>
	        		    <tr>
						    <td style="text-align:right;"><nobr><font class="myred">*</font>登录密码:</nobr></td>
						    <td colspan="3" >
						    <input type="password" id="passwd" name="passwd"  autocomplete="off" style="width: 200px;float:left;vertical-align:middle;" 
						    class="easyui-validatebox" data-options="required:true,validType:'length[6,20]'" />
							&nbsp;&nbsp;&nbsp;<div style="float:left; position: static;">
								<div  id="level" class="pw-strength" style="vertical-align:middle;" >
									<div class="pw-bar"></div>
									<div class="pw-bar-on"></div>
									<div class="pw-txt">
										<span>弱</span>
										<span>中</span>
										<span>强</span>
									</div>
								</div>      	
							</div>

						    
						    </td>	        		    
	        		    </tr>
	        		    <tr>
						    <td style="text-align:right;"><nobr><font class="myred">*</font>确认密码:</nobr></td>
						    <td colspan="3">
						    <input type="password" id="repasswd" name="repasswd" style="width: 200px" 
						    class="easyui-validatebox" data-options="required:true,validType:['length[6,20]']"
						    validType="equalTo['#passwd']" /></td>	        		    
	        		    </tr>
						<tr>
							<td style="text-align:right;"><nobr><font class="myred">*</font>企业名称:</nobr></td>
							<td colspan="3"><input id="commc" name="commc" style="width: 500px" 
							class="easyui-validatebox" data-options="required:true" /></td>
						</tr> 
						<tr>
							<td style="text-align:right;"><nobr><font class="myred">*</font>所属统筹区:</nobr></td>
							<td colspan="3">
								<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027_2();" 
								   readonly="readonly" class="easyui-validatebox" data-options="required:true" />
								<input name="aaa027" id="aaa027"  type="hidden"/>
								<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
									<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
								</div>							
							</td>
						</tr>						
						<tr>
							<td style="text-align:right;"><nobr><font class="myred">*</font>企业地址:</nobr></td>
							<td colspan="3"><input id="comdz" name="comdz" style="width: 500px" 
							class="easyui-validatebox" data-options="required:true"/></td>	
						</tr>
						<tr>
	                      <td style="text-align:right;"><nobr>地图定位:</nobr></td>
						  <td colspan="3">
						     经度坐标：<input id="comjdzb" name="comjdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
						     纬度坐标：<input id="comwdzb" name="comwdzb" style="width: 80px;" readonly="readonly" data-options="required:true"/>
									<a href="javascript:void(0)" class="easyui-linkbutton" id="dtdw" 
										iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>					     
						  </td>
						</tr>
						<tr>
	                        <td style="text-align:right;"><font class="myred">*</font>企业大类:
	                        </td>						
	                        <td colspan="2">
	                           <input id="comdaleiname" name="comdaleiname" 
	                            style="width: 500px;" readonly="readonly" class="easyui-validatebox myReadOnlyColor" 
	                            data-options="required:true" />
	                           <input type="hidden" id=comdalei name="comdalei"/>
	                        </td>
							<td rowspan="2" style="text-align:left;">
								<a href="javascript:void(0)" class="easyui-linkbutton" 
								id="mySelectComfenlei" 
									iconCls="icon-search" onclick="mySelectComfenlei()">选择分类 </a>									
							</td>					
						</tr>
						<tr>
	                        <td style="text-align:right;">企业小类:
	                        </td>
	                        <td colspan="2">
	                          <input id="comxiaoleiname" name="comxiaoleiname" 
	                          style="width: 500px;" readonly="readonly" class="easyui-validatebox myReadOnlyColor" />
	                          <input type="hidden" id=comxiaolei name="comxiaolei"/>
	                        </td>	                        
						</tr>
												
						<tr>
							<td style="text-align:right;"><nobr><font class="myred">*</font>企业法人/业主:</nobr></td>
							<td colspan="3"><input id="comfrhyz" name="comfrhyz" style="width: 200px" 
							class="easyui-validatebox" data-options="required:true"/></td>						
						</tr>	
						<tr>						
							<td style="text-align:right;"><nobr>法人/业主身份证号:</nobr></td>
							<td colspan="3"><input id="comfrsfzh" name="comfrsfzh" style="width: 200px" 
							class="easyui-validatebox" data-options="validType:'idcard'"/></td>			
						</tr>
						<tr>	
							<td style="text-align:right;"><nobr>企业负责人:</nobr></td>
							<td colspan="3"><input id="comfzr" name="comfzr" style="width: 200px" 
							class="easyui-validatebox"  /></td>						
						</tr>	
						<tr>
							<td style="text-align:right;"><nobr>固定电话:</nobr></td>
							<td colspan="3"><input id="comgddh" name="comgddh" style="width: 200px" 
							class="easyui-validatebox" /></td>						
						</tr>						
					    <tr>
					      <td colspan="4">&nbsp;</td>
					    </tr>		
					    <tr>
						<td colspan="4" align=center>
						   <input type="button" value="确认注册" class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'" id="saveBtn" onclick="myreg();"/>
						   <input type="reset" value="清空重填"  class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'" id="saveBtn" onclick="myform.reset();"/>
						</td>
						</tr>
																                    
					</table>
				</form>
				</div>
        </div>        
    </div>    
</body>
</html>