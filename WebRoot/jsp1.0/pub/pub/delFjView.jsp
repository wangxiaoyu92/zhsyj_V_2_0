<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>

<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
	List fjList = (List)request.getAttribute("fjList");
    String v_ZuoWeiIframe = StringHelper.showNull2Empty(request.getParameter("ZuoWeiIframe"));
    if (v_ZuoWeiIframe==null || "".equals(v_ZuoWeiIframe)){
    	v_ZuoWeiIframe="0";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    System.out.println("v_ZuoWeiIframe "+v_ZuoWeiIframe);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附件预览</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript"> 
	var s = new Object();      
	s.type = "ok";
	sy.setWinRet(s);
		
	//删除附件
	function delFj(){
		var fjid = [];		
		$("input:checked").each(function(){
			fjid.push(this.value);
		});
		if(fjid.length>0){
			$.ajax({
	    		url: basePath + '/pub/pub/delFj',
	    		type: 'post',
	    		async: true,
	    		cache: false,
	    		timeout: 100000,
	    		data: 'fjid=' + fjid,
	    		dataType: 'json',
	    		error: function() {
	    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');				
	    		},
	    		success: function(result){
	    			if (result.code=='0'){	
		        		$.messager.alert('提示','删除成功','info',function(){
		        			closeAndRefreshWindow();
		        			parent.myrefreshfrm();//gu20170110
		        			parent.iframeuse();//gu20170110
		                }); 	                        
	              	} else {
	              		$.messager.alert('提示','删除失败:'+result.msg,'error');
	                }
		        }  
			});
		}else{
			$.messager.alert('提示','请先选择要删除的附件！','info');
		}
	}

		
	//关闭并刷新父窗口
	function closeAndRefreshWindow(){      
		s.type = "ok";
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");
	} 

	//预览图片
	function showPic(imgUrl){
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 800,
			height : 600,
			url : imgUrl
		});
	}
</script>
</head>
<body>
<form id="fm"  method="post">
	
	<%
		if(null!=fjList && fjList.size()>0){
	%>
	<sicp3:groupbox title="上传图片预览">
	<div class="box" id="box">
		<ul>			
	<% 
		FjDTO fj = null;
   		for(int i=0;i<fjList.size();i++){
   		 	fj = (FjDTO)fjList.get(i);
   		 	String fjpath = contextPath + fj.getFjpath();
   		 	String fjid = fj.getFjid();
   		 	String imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + fjpath;
   	%>
   	<li>
<!--        	<a href="<%=fjpath %>" data-lightbox="fj" ><img class="example-image" src="<%=fjpath %>"  width="100%" height="100%"/></a><br/> -->
      	<a onclick="showPic('<%=imgUrl %>');"><img class="example-image" src="<%=fjpath %>"  width="100%" height="100%" /></a><br/>
		<div style="text-align: center;margin:2px 0 2px 0;">
			<input type="checkbox" name="ck" value="<%=fjid %>" /><font color="white">选中</font>
		</div>
	</li>
    <%
   		}
   	%>  			
		</ul>
	</div>
	</sicp3:groupbox>
	<table style="width: 99%;">
        <tr>
			<td style="text-align:center;">
			    <% if (op!=null && !"view".equalsIgnoreCase(op)){ %>
				<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel"  onclick="delFj();" id="btnDel" >删除</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%} %>
				<% if (!"1".equalsIgnoreCase(v_ZuoWeiIframe)){ %>
				<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  onclick="closeAndRefreshWindow();" id="btnCancel" >退出</a>
				<%} %>
			</td>
        </tr>
	</table>	
	<% 
    }
     %>

</form>
</body>
</html>