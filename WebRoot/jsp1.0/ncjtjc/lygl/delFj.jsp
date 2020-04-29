<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="java.util.*"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.askj.ncjtjc.dto.LyDTO"%>

<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
	List fjList = (List)request.getAttribute("fjList");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附件预览</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
<script type="text/javascript"> 
	//删除附件
	function delFj(){
		var fjid = [];		
		$("input:checked").each(function(){
			fjid.push(this.value);
		});
		if(fjid.length>0){
			$.ajax({
	    		url: basePath + '/jg/ncjtjc/lygl/delFj',
	    		type: 'post',
	    		async: true,
	    		cache: false,
	    		timeout: 100000,
	    		data: 'fjname=' + fjid,
	    		dataType: 'json',
	    		error: function() {
	    			$.messager.alert('提示','服务器繁忙，请稍后再试！','info');				
	    		},
	    		success: function(result){
	    			if (result.code=='0'){	
		        		$.messager.alert('提示','删除成功','info',function(){
		        			closeAndRefreshWindow();
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
		var s = new Object();      
		s.type = "ok";
		window.returnValue = s;   
		window.close();    
	} 
	  
	//关闭窗口  
	function closeWindow(){
		parent.$("#"+sy.getDialogId()).dialog("close");
	   /*  window.close(); */
	}

	function showPic(imgUrl){
			var dialog = parent.sy.modalDialog({ 
				width : 980,
				height : 500, 
				url : imgUrl
			});
		//alert(imgUrl);					
		/* window.popwindow(imgUrl,80,60); */
	}
</script>
</head>
<body>
<form id="fm"  method="post">
	<sicp3:groupbox title="上传图片预览">
	<%
	if(null!=fjList && fjList.size()>0){
	%>
	<div class="box" id="box">
		<ul>			
	<% 
		LyDTO fj = null;
   		for(int i=0;i<fjList.size();i++){
   		 	fj = (LyDTO)fjList.get(i);
   		 	String fjpath = contextPath + fj.getFjpath();
   		 	Long fjid = fj.getFjid();
   		 	String imgUrl = contextPath + "/jsp/wl/zy/fjViewTool.jsp?img_src=" + fjpath;
   	%>
   	<li>
       	<a href="<%=fjpath %>" data-lightbox="fj" ><img class="example-image" src="<%=fjpath %>"  width="100%" height="100%"/></a><br/>
<%--       	<a onclick="showPic('<%=imgUrl %>');"><img class="example-image" src="<%=fjpath %>"  width="100%" height="100%" /></a><br/>--%>
		<div style="text-align: center;margin:2px 0 2px 0;">
			<input type="checkbox" name="ck" value="<%=fjid %>" /><font color="white">选中</font>
		</div>
	</li>
    <%
   		}
   	%>  			
		</ul>
	</div>
	<% 
    }
    %>
	</sicp3:groupbox>
	<table style="width: 99%;">
        <tr>
			<td style="text-align:center;">
				<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel"  onclick="delFj();" id="btnDel" >删除</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-undo"  onclick="closeWindow();" id="btnCancel" >取消</a>
			</td>
        </tr>
	</table>
</form>
</body>
</html>