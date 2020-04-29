<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
	String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
	String v_transfrom=StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_nodename=URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")),"UTF-8");
	String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
	String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
	String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
	String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	
	//获取分支节点流向值
	WorkflowService v_WorkflowService=new WorkflowService();
	List<Wf_node_trans> v_listWf_node_trans=(List<Wf_node_trans>)v_WorkflowService.queryWfnodeTransList(v_psbh,v_transfrom);	
	
	String v_nextchecked="";
	int v_transCount=0;
	if (v_listWf_node_trans!=null){
	   v_transCount=v_listWf_node_trans.size();
	   if (v_transCount==1){
		   v_nextchecked="checked='checked'";
	   }
	   
	}	
%>
<!DOCTYPE html>
<html>
<head>
<title>案件办理：<%=v_nodename %></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s; 
  
$(function(){
  var v_ajslCommonURL=encodeURI(encodeURI("<%=basePath%>jsp/pub/zfba/zfbalc/ajslCommon.jsp?ajdjid=<%=v_ajdjid%>&psbh=<%=v_psbh%>&nodename=<%=v_nodename%>&nodeid=<%=v_nodeid%>&fjcsdmlb=<%=v_fjcsdmlb%>&fjcsdlbh=<%=v_fjcsdlbh%>&ywbh=<%=v_ywbh%>"));
  //$("#ajslcommonframe").attr("src",v_ajslCommonURL); 
  document.getElementById("ajslcommonframe").src=v_ajslCommonURL; 
});

//提交流程
function tijiaoliucheng(){	 

  var v_transname ="";
  v_transname=$('#xuanzeliuxiang input[name="transname"]:checked ').val();
  if (v_transname==undefined){
	  alert("请选择办理流向");
	  return false;
  }
  
  var cfmMsg= "确定要提交流程吗?";
  var v_transyy=$("#transyy").val();
  
  var v_transval="七日内做出决定";
  var v_shifouTongguo="1";
  
  var v_url=encodeURI(encodeURI("<%=basePath%>workflow/doWfprocess?ywlcid=<%=v_ywlcid%>&transval="+v_transval+"&shifouTongguo="+v_shifouTongguo+"&transname="+v_transname+"&transyy="+v_transyy+"&time="+new Date().getMilliseconds()));
 $.messager.confirm('确认', cfmMsg, function (r) {
    if(r){
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
		$.ajax({
			url:v_url,
			type:'post',
			async:true,
			cache:false,
			timeout: 100000,
			//data:formData,
			error:function(){
			    parent.$.messager.progress('close');
				alert("服务器繁忙，请稍后再试！");
			},
	        success: function(result){
				parent.$.messager.progress('close');
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
			 		parent.$.messager.alert('提示','提交流程成功！','info',function(){
			 			//closeAndRefreshWindow();
			 			closeWindow();
	        		}); 	                        	                     
              	} else {
              		parent.$.messager.alert('提示','提交流程失败：'+result.msg,'error');
                }
	        }  
			
		});	
    }
 })   
}

//关闭窗口
function closeWindow(){	
	sy.setWinRet("ok");
   	parent.$("#"+sy.getDialogId()).dialog("close");
};

</script>
</head>
<body>
   <iframe name="ajslcommonframe" id="ajslcommonframe" src="" width="100%" height="800px;"  scrolling="no" frameborder="0" ></iframe>	
	<div style="text-align: center;">
    <sicp3:groupbox title="">   
     <table width="100%" height="60px;">
      <tr>
        <td width="15%" align="right">请选择下一节点流向：</td>
        <td width="88%" align="left">
	     <div id="xuanzeliuxiang">
		      <%for (Wf_node_trans v_Wf_node_trans:v_listWf_node_trans){%>
		         <input type="radio" name="transname" <%=v_nextchecked%> id="transname"  value="<%=v_Wf_node_trans.getTransname() %>" style="cursor: pointer;"/><%=v_Wf_node_trans.getTransname() %>&nbsp;&nbsp;&nbsp;&nbsp;
		      <%} %>                      
	     </div>	         
        </td>
      </tr>

       <tr>
         <td align="right">
                             处理意见： 
         </td>
         <td align="left">
			<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;" 
			 rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>              
         </td>
       </tr>
     </table>			

	</sicp3:groupbox>	
	</div>
	<div style="text-align: center;height: 100px">
	<br>
		<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="tijiaoliucheng()"
			              data-options="iconCls:'icon-save'">提交流程</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeWindow();"
	              data-options="iconCls:'icon-back'">关闭</a>
	</div>
</body>
</html>