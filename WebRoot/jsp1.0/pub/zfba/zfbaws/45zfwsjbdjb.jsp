<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.zfwsjbdjb45DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	} 
	//安监登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第12个文书 查封扣押决定书
	zfwsjbdjb45DTO dto= new zfwsjbdjb45DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (zfwsjbdjb45DTO) request.getAttribute("mybean");
	} 
%> 
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">.b1{white-space-collapsing:preserve;}
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.p1{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p3{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.s1{font-weight:bold;}
.s2{font-size:18pt;font-weight:bold;}
.s3{font:bold;}
.s4{text-align:right; font-size:18pt;font-weight:bold;}
.s5{text-align: right; margin-right: 30px;} 
.in{width: 270px;}
</style>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";       
	sy.setWinRet(s);
 $(function() {
	var v_jbdjbid=$("#jbdjbid").val();
	if (v_jbdjbid==null || v_jbdjbid=="" || v_jbdjbid.length== 0){
		$("#lcwmbBtn").linkbutton('disable');	
		$("#printBtn").linkbutton('disable');
	}else{
		$("#lcwmbBtn").linkbutton('enable');	
		$("#printBtn").linkbutton('enable');
	}
	 
}); 
	function mysave() {
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
		parent.$.messager.progress({
			text : '正在提交....'
		});
		$('#myform').form(
				'submit',
				{
					url : basePath + '/pub/wsgldy/savejbdjb45',
					onSubmit : function() {
						var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
						if (!isValid) {
							parent.$.messager.progress('close'); // 如果表单是无效的则隐藏进度条 
						}
						return isValid;
					},
					success : function(result) {
						parent.$.messager.progress('close');// 隐藏进度条  
						result = $.parseJSON(result);
						if (result.code == '0') {  
							$("#jbdjbid").val(result.jbdjbid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
					 		alert("保存成功！");
						} else {
							parent.$.messager.alert('提示', '保存失败：' + result.msg,
									'error');
						}
					}
				});
	}
function myprint(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_jbdjbid = $("#jbdjbid").val(); 
	var url="<%=basePath%>pub/wsgldy/zfwsjbdjb45PrintIndex?ajdjid="
		+v_ajdjid+"&jbdjbid="+v_jbdjbid+"&time="+new Date().getMilliseconds();
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});
}
  //另存为模板
   function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_jbdjbid=$("#jbdjbid").val();
    if (v_jbdjbid==null || v_jbdjbid=="" || v_jbdjbid.length== 0){
    	alert('文书还没有保存为空，不能另存为模板');
    	return false;
    } 
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
		+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
    //创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		width : 650,
		height : 300,
		url : url
	});
}

//提取模板

function tqMoban(){
    var obj = new Object();
    var v_zfwsdmz=$("#zfwsdmz").val();
	var url=encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
		+v_zfwsdmz+"&zfwsdmmc=<%=v_fjcsdmmc%>&time="+new Date().getMilliseconds()));
  	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : ' ',
		param :obj,
		width : 900,
		height : 500,
		url : url
	},function (dialogID){
		var v_retStr = sy.getWinRet(dialogID);
		sy.removeWinRet(dialogID);//不可缺少
		if (v_retStr!=null && v_retStr.length>0){
	   		var myrow=v_retStr[0];
			parent.$.messager.progress({
			text : '数据加载中....'
		});
		var v_zfwsmbid=myrow.zfwsmbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid
		}, 
		function(result) {
			if (result.code=='0') {			
				var retdata =result.data;
				//var kk=$.parseJSON(retdata);
				//$('form').form('load',retdata);
				GloballoadData(retdata);
			} else {
				parent.$.messager.alert('提示','查询模板信息失败：'+result.msg,'error');
		    }	
			parent.$.messager.progress('close');
		}, 'json');
	 }
		
	})
  
} 

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
			s.type = "ok";       
			sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>
<title>中华人民共和国药品监督行政执法文书</title>
</head>
<div style="width: 210mm; margin: 0 auto">
<body class="b1 b2 zfwsbackgroundcolor">
     <form id="myform" method="post"> 
           <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="jbdjbid" name="jbdjbid" type="hidden" value="${mybean.jbdjbid}"/>
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
		<p class="p2">
		   <span class="s1">中华人民共和国药品监督行政执法文书</span>
		</p> 
		<p class="p2">
		   <span class="s2">举  报  登  记  表</span> 
		</p>
		<p class="s5">
		    <span class="s5"><input class="in" id="jbdjbh" name="jbdjbh" value="${mybean.jbdjbh}"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
		<span>举报人：</span><span class="s3"><input class="in" id="jbdjjbr" name="jbdjjbr" value="${mybean.jbdjjbr}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<span> 联系方式：</span><span class="s3"><input class="in" id="jbdjlxfs" name="jbdjlxfs" value="${mybean.jbdjlxfs}"></span>
		</p>
		<p class="p3">
		<span>举报形式：</span><span class="s3"><input class="in" id="jbdjjbxs" name="jbdjjbxs" value="${mybean.jbdjjbxs}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
		<span>时    间：</span><span class="s3"><input class="in" id="jbdjjbsj" name="jbdjjbsj" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;" value="${mybean.jbdjjbsj}"></span>
		</p>
		<p class="p3">
		<span>举报内容：</span>
		</p>
		<p class="p3">
		<textarea class="easyui-validatebox bbtextarea" id="jbdjjbnr"
				name="jbdjjbnr" style="width: 800px;height: 200px;">${mybean.jbdjjbnr}</textarea>
		</p> 
		<p class="s5">
		<span>记录人：</span><span class="s3"><input id="jbdjjlrqz" name="jbdjjlrqz" value="${mybean.jbdjjlrqz}"> </span>
		</p>
		<p class="p3">
		<span> </span>
		</p>
		<p class="s5">
		   <span>年 月 日</span><span class="s3"><input id="jbdjjlrqzrq" name="jbdjjlrqzrq"  class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;" value="${mybean.jbdjjlrqzrq}"> </span>
		</p> 
		<p class="p3">
		<span>处理意见：</span>
		</p> 
		<p class="p3">
		<textarea class="easyui-validatebox bbtextarea" id="jbdjclyj"
				name="jbdjclyj" style="width: 800px;height: 200px;">${mybean.jbdjclyj}</textarea>
		</p>
		<p class="s5">
		<span>负责人：</span><span class="s3"><input id="jbdjfzrqz" name="jbdjfzrqz" value="${mybean.jbdjfzrqz}"> </span>
		</p>  
		<p class="s5">
		<span>年 月日</span><span class="s3"><input id="jbdjfzrqzrq" name="jbdjfzrqzrq"  class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;" value="${mybean.jbdjfzrqzrq}"> </span>
		</p>
		<p class="p3"></p>
   
   <hr style="height:2px;border:none;border-top:2px solid #555555;" />
  <table>
			   <tr align="right" style="height: 60px;">
			       <td  align="right">
			       <% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
			       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			           <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
			              data-options="iconCls:'icon-save'">保存</a>
			              <%} %>
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			           
			           <a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
			              data-options="iconCls:'icon-print'">打印</a>
			              
			           <% if (v_canbaocun==null ||"".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>   
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
			           
			           <a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
			              data-options="iconCls:'ext-icon-book_add'">另存为模块</a>
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			           
			           <a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
			              data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
			            <%} %>
			              
			           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		           	           	                
			
			           <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
			              data-options="iconCls:'icon-back'">关闭</a>
			       </td>
			   </tr>
			</table>
  </form>	 	
</body>
</div>
</html>