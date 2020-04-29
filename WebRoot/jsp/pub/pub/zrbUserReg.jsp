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
<title>用户注册</title>

<jsp:include page="${contextPath}/inc_easyui.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<link rel="stylesheet" href="<%=basePath %>/css/pwd.css" type="text/css">
<script type="text/javascript">

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

function showMenu_aaa027() {
	var v_opkind="comreg";
	var url = basePath + 'jsp/pub/pub/selectAaa027_easyui.jsp?aaa027flag=0&opkind='+v_opkind;
	var dialog = parent.sy.modalDialogEasyui({
		title : '选择统筹区',
		width : 300,
		height : 400,
		url : url
	},function (dialogID) {
		var k = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少

		if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
			$('#aaa027').val(k.aaa027);
			$('#aaa027name').val(k.aaa027name);
			//$('#comdz').val(k.aab301);
		}
	});

}

/* function showMenu_aaa027_2() {
	var v_opkind="comreg";
	var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?aaa027flag=0&opkind='+v_opkind; 
	var obj = new Object();
	var k = :(url,obj,300,400);
	if(typeof(k.type)!="undefined" && k.type!=null && k.type=='ok'){
		$('#aaa027').val(k.aaa027);
		$('#aaa027name').val(k.aaa027name);
		$('#comdz').val(k.aab301);
	}
} */


// 保存 
function myreg() {
	var url = basePath + '/pub/pub/saveNetuserReg';
	var loginurl = basePath + '/index.jsp';

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
		 			//window.location.href=loginurl;
		 			//window.history.back();
		 			//window.location.reload();
		 			self.location=document.referrer;//返回并刷新
        		}); 	                        	                     
          	} else {
          		$.messager.alert('提示','保存失败：'+result.msg,'error');
            }
        }    
	});
};

function findpw(){
    //window.open("<%=basePath%>jsp/zrb/zrbFindUserPw.jsp");
    window.location.href="<%=basePath%>jsp/pub/pub/zrbFindUserPw.jsp";
};

</script>
</head>
<body style=" overflow-y: auto; overflow-x:hidden;">    
	<div class="easyui-layout" fit="true" >
	    <div region="west" style="width: 220px;background-color: #FAF7ED;border: none"></div>
	    <div region="east" style="width: 220px;background-color: #FAF7ED;border: none"></div>
        <div region="center"  style="overflow: true;border: none"  >
        <form name="myform" id="myform" method="post" >
     	        <div style="text-align: center;"><img src="<%=basePath%>images/zc/zctop.png" width="100%" height="100px;"/></div>
                 <h1 style="text-align:center;font-size:20px;line-height:30px;">用户注册</h1>					
	      		<table  align="center" style="border-spacing:8px;" class="mytable">
	      		    <tr>
				    <td style="text-align:right;"><nobr><font class="myred">*</font>登录账号(建议字母或数字):</nobr></td>
				    <td colspan="3"><input id="username" name="username" style="width: 200px" 
				    class="easyui-validatebox input-text" data-options="required:true,validType:'length[0,50]'"/></td>
	      		    </tr>
	      		    <tr>
				    <td style="text-align:right;"><nobr><font class="myred">*</font>真实姓名:</nobr></td>
				    <td colspan="3"><input id="description" name="description" style="width: 200px" 
				    class="easyui-validatebox input-text" data-options="required:true,validType:'length[0,50]'"/></td>
	      		    </tr>	        		    
	      		    <tr>
				    <td style="text-align:right;"><nobr><font class="myred">*</font>登录密码:</nobr></td>
				    <td colspan="3" >
				    <input type="password" id="passwd" name="passwd"  autocomplete="off" style="width: 200px;float:left;vertical-align:middle;" 
				    class="easyui-validatebox input-text" data-options="required:true,validType:'length[6,20]'" />
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
				    class="easyui-validatebox input-text" data-options="required:true,validType:['length[6,20]']"
				    validType="equalTo['#passwd']" /></td>	        		    
	      		    </tr>
				<tr>
					<td style="text-align:right;"><nobr><font class="myred">*</font>所属统筹区:</nobr></td>
					<td colspan="3">
						<input name="aaa027name" id="aaa027name"  style="width: 200px; " onclick="showMenu_aaa027();" 
						   readonly="readonly" class="easyui-validatebox input-text" data-options="required:true" />
						<input name="aaa027" id="aaa027"  type="hidden"/>
						<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
							<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
						</div>							
					</td>
				</tr>	
				<tr>
					<td style="text-align:right;"><nobr><font class="myred">*</font>联系电话:</nobr></td>
					<td colspan="3"><input id="mobile" name="mobile" style="width: 200px" 
					class="easyui-validatebox input-text" data-options="required:true,validType:'mobile'"/></td>
				</tr>																
				<tr>
					<td style="text-align:right;"><nobr><font class="myred">*</font>联系地址:</nobr></td>
					<td colspan="3"><input id="userlxdz" name="userlxdz" style="width: 500px" 
					class="easyui-validatebox input-text" data-options="required:true,validType:'length[0,200]'"/></td>
				</tr>
				<tr>
					<td style="text-align:right;"><nobr><font class="myred">*</font>电子邮箱email(找回密码用到):</nobr></td>
					<td colspan="3"><input id="useremail" name="useremail" style="width: 500px" 
					class="easyui-validatebox input-text" 
					data-options="required:true,validType:['length[0,100]','email']"/></td>
				</tr>						
				<tr>
					<td style="text-align:right;"><nobr><font class="myred">*</font>单位名称:</nobr></td>
					<td colspan="3"><input id="userdwmc" name="userdwmc" style="width: 500px" 
					class="easyui-validatebox input-text" data-options="required:true,validType:'length[0,200]'" /></td>
				</tr> 						
				
			    <tr>
			      <td colspan="4">&nbsp;</td>
			    </tr>		
			    <tr>
				<td colspan="4" align=center>
				   <input type="button" value="确认注册" class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'" id="saveBtn" onclick="myreg();"/>
				   &nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="清空重填"  class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'" id="BtnReset" onclick="myform.reset();"/>

				   &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="返回"  class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'"  onclick="self.location=document.referrer;"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="找回密码"  class="btn_bg" onMouseOver="this.className='btn_bg_hover'" onMouseOut="this.className='btn_bg'" id="BtnFindPwd" onclick="findpw();"/>
				</td>
				</tr>
														                    
			</table>
	        	  
           </form> 
				
        </div>  
        </div>  
             
</body>
</html>