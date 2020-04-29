<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>领导信箱</title>
<jsp:include page="${contextPath}/inc_gzfw.jsp"></jsp:include>
<jsp:include page="head.jsp"></jsp:include>
<script type=text/javascript>
$(function(){
	$("#myform").validationEngine( {
		validationEventTriggers : "blur", //will validate on keyup and blur
		promptPosition : "centerRight",//OPENNING BOX POSITION, IMPLEMENTED: topLeft, topRight, bottomLeft,  centerRight, bottomRight
		prettySelect : true
	});
	
	$('#RadioGroup1_0').click(function(){
		$("tr[name='xm']").hide();
		$('#hdXm').val("");
		$('#hdLxdh').val("");

	});
	$('#RadioGroup1_1').click(function(){
		$("tr[name='xm']").show();
	});
	$('#RadioGroup1_2').click(function(){
		$('#hdCxmm').val("");
		$('#qhdCxmm').val("");
		$('#cxmm').hide();
	});
	$('#RadioGroup1_3').click(function(){
		$('#cxmm').show();
	});
});

function save(){
	var yzm=$('#yzm').val();
	var status = $("#myform").validationEngine("validate");
	if(status){
		if(yzm=="" || yzm.length<4){
			alert("请输入验证码!");
			$("#yzm").focus();
		}else{
		var formData = $("#myform").serialize();
		$.ajax({
			url:"zmhd_save.action?time="+new Date().getMilliseconds(),                                                        
	 		type:'post',
	 		async:true,
	 		cache:false,
	 		timeout: 100000,
	 		data:formData,
	 		error:function(){
	 			alert("服务器繁忙，请稍后再试！");
	 		},
	 		success: function(result){
	 			var datas=new Array();
	 			datas=result.split("*");
	            if(datas[0]=="1"){	    
	               alert("提交成功！查询码为 "+datas[1]+",请牢记!");
	               myform.reset();
	               $('#yzmimg').attr('src','<%=request.getContextPath()%>/servlet/CodeSevlet?' + Math.random());
	            }else if(datas[0]=="2"){
	               alert("验证码输入有误");
	            }else{
	                alert("提交失败！");
	            }
	            $('#xm').show();
	         }
		});
		}
	}
}

function changeImage(obj){  
	obj.src = '<%=request.getContextPath()%>/servlet/CodeSevlet?' + Math.random(); 
}
</script>
</head>
<body>
<div class="clear"></div>
<div class="mid_bg">
  <div class="top_4">
    <div class="top_4d fl" id="DangQianWeiZhi"><span>当前位置</span>&nbsp;&gt;&nbsp;政民互动&nbsp;&gt;&nbsp;领导信箱</div>    
    <div class="top_4c fr">
      <div class="top_4c_1 fl"><img src="<%=contextPath%>/jsp/gzfw/images/bg13.gif" width="19" height="19" /></div>
      <div class="top_4c_2 fl"><input type="text" name="textfield" id="textfield" class="txt_1" /></div>
      <div class="top_4c_3 fl"><a href="#" class="btn_1">搜索</a></div>
    </div>    
  </div>
  <div class="ntit_3">
  	<ul>
      <li class="marr10"><a href="wtzx.jsp">问题咨询</a></li>
      <li class="marr10"><a href="fwts.jsp">服务投诉</a></li>
      <li class="marr10"><a href="yjzq.jsp">意见征求</a></li>
      <li><a href="mail.jsp" class="curr">领导信箱</a></li>
    </ul>
  </div>
  
  <div class="h40 clear"></div>
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="consult_1">
	 <tr>
	    <td align="center" valign="middle" class="consult_tit">特<br />别<br />说<br />明</td>
	    <td class="consult_line">
	      <div class="consult_1a">
	        <p>1．本栏目主要提供业务办理方面的法规政策咨询服务，有关执法投诉、案件举报等涉及具体个案的内容请访问网站相应栏目。</p>
	        <p>2．不得在本栏目发布任何不符合国家法律法规规定的信息，不得发布任何带有谩骂、侮辱以及包含人身攻击等内容的信息。 </p>
	        <p>3．为了您能够得到及时、准确的服务，请您必须将咨询表单中所有项目都予以填写，并保证信息完整、准确、真实、有效。 </p>
	        <p>4．为提高工作效率，您的问题可直接向当地食品药品监督管理局反映。</p>
	        <p>5．提问时，请注意用词要言简意赅，提问内容不要超过500字。 </p>
	        <p>6．处理流程：群众发送咨询 --> 河南食品药品监督管理局处理咨询 --> 群众凭信件编号和查询密码查询回复意见。 </p>
	        <p>7．办理时限：7个工作日。</p>
	      </div>
	    </td>
	 </tr>
  </table>
  
  <div class="h40 clear"></div>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="consult_1">
	  <tr>
	    <td align="center" valign="middle" class="consult_tit">在<br />线<br />提<br />交</td>
	    <td class="consult_line">
	      <div class="consult_1a">
	      <form id="myform" >
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <input name="hdType"  id="hdType" value="2" type="hidden"/> 
			  <tr>
			    <td>邮件标题：</td>
			    <td>
			       <input type="text" name="hdBt" id="hdBt" style="height: 25px;width: 333px;font-size: 15px" class="validate[required]"  />
			       <span class="txt_red">*</span>
			    </td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td height="30" valign="top"><span class="txt_grey">标题尽量简短、概括。</span></td>
			  </tr>
			  <tr>
			    <td>邮件内容：</td>
			    <td><textarea name="hdNr" id="hdNr" cols="80" rows="7" class="validate[required]" ></textarea><span class="txt_red">*</span></td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td height="30" valign="top"><span class="txt_grey">主要意见内容、或建议内容等，尽量详细。</span></td>
			  </tr>
			  
			  <tr>
			    <td>是否公开：</td>
			    <td>
			  	  <input name="hdSfgk" type="radio" id="RadioGroup1_2" value="Y" checked="checked" />公开
			  	  <input type="radio" name="hdSfgk" value="N" id="RadioGroup1_3" />不公开
				  <div style="display:none;" id="cxmm">
				     <br/>
				     <table>
				        <tr>
				          <td>
				            <span class="padl10">查询密码：</span>
				          </td>
				          <td>
				            <input type="password" style="height: 25px;width: 333px;font-size: 15px" name="hdCxmm" id="hdCxmm" class="validate[required]" /><span class="txt_red">*</span>
				          </td>
				        </tr>
				        <tr>
				          <td>
				             <span>确认密码：</span> 
				          </td>
				          <td>
				             <input type="password" style="height: 25px;width: 333px;font-size: 15px" name="qhdCxmm" id="qhdCxmm" class="validate[required]" /><span class="txt_red">*</span><span id="mm" class="txt_red" style="display: none">两次密码输入不一致</span>
				          </td>
				        </tr>
				     </table>
				  </div>
			     </td>
			  </tr>
			  <tr>
			    <td>是否匿名：</td>
			    <td>
			    	<input name="hdSfnm" type="radio" id="RadioGroup1_0" value="Y" />匿名
			      	<input type="radio" name="hdSfnm" value="N" id="RadioGroup1_1" checked="checked" /> 不匿名
			    </td>
			  </tr>
			  <tr name="xm">
			    <td>您的姓名：</td>
			    <td>
			      <input type="text" style="height: 25px;width: 333px;font-size: 15px" name="hdXm" id="hdXm"  class="validate[required]"/>
			      <span class="txt_red">*</span>
			    </td>
			  </tr>
			  <tr name="xm"><td>性别:</td>
			  	 <td>
			  		<input name="hdSex" type="radio" id="RadioGroup2_0" value="1" checked="checked" />先生
			        <input type="radio" name="hdSex" value="0" id="RadioGroup2_1" class="validate[required]" />女士
			  	 </td>
			  </tr>
			  <tr name="xm">
			      <td  width="80"><span >电话或手机：</span></td>
			      <td><input type="text" style="height: 25px;width: 333px;font-size: 15px" name="hdLxdh" id="hdLxdh"  class="validate[required,custom[lxdh]]" maxlength="11"/><span class="txt_red">*</span></td>  
			  </tr>
			  <tr>
			    <td>验证码：</td>
			    <td><input type="text" style="height: 25px;width: 333px;font-size: 15px" name="yzm" id="yzm" maxlength="6"/>
			      <img src="servlet/CodeSevlet" width="165" id="yzmimg" border="0" onclick="changeImage(this)" alt="请输入此验证码，如看不清请点击刷新。" style="cursor:pointer" />
			    </td>     
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			    <td class="padt10"><a href="#" class="btn_4" onclick="save();">确认提交</a></td>
			  </tr>
			</table>
			</form>
	      </div>
	    </td>
	  </tr>
	</table>
  <div class="h20 clear"></div>
</div><!--mid_bg.end-->
<div class="clear"></div>
<%@ include file="footer.jsp"%>
</body>
</html>