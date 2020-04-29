<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsajjttljl19DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}

	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第19个文书  案件集体讨论记录
	Zfwsajjttljl19DTO localZfwsajjttljl19DTO = new Zfwsajjttljl19DTO();
	if (request.getAttribute("mybean") != null) {
		localZfwsajjttljl19DTO = (Zfwsajjttljl19DTO) request.getAttribute("mybean");
	}
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s);
	$(function() {
		var v_ajjttljlid=$("#ajjttljlid").val();
		if (v_ajjttljlid==null || v_ajjttljlid=="" || v_ajjttljlid.length== 0){
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
					url : basePath + '/pub/wsgldy/saveZfwsajjttljl',
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
							$("#ajjttljlid").val(result.ajjttljlid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
					 		alert("保存成功！");
					 		 
						} else {
							alert("保存失败：" + result.msg);
						}
					}
				});
	}
	
	function myprint(){
    var obj = new Object();
    var v_ajdjid = $("#ajdjid").val();
    var v_ajjttljlid = $("#ajjttljlid").val();
	var url = "<%=basePath%>pub/wsgldy/zfwsajjttljlPrintIndex?ajdjid="
		+v_ajdjid+"&ajjttljlid="+v_ajjttljlid+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
			title : '打印',
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
    var v_ajjttljlid=$("#ajjttljlid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
		+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
		title : '存为模板',
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
		title : '提取模板',
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
	});
}

// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
		s.type = "ok";       
		sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");    
	}
</script>
<style type="text/css">
.b1 {
	white-space-collapsing: preserve;
}

.b2 {
	margin: 1.0in 1.25in 1.0in 1.25in;
}

.s1 {
	font-weight: bold;
	color: black;
}

.s2 {
	color: black;
}
.s3 {
	text-decoration: underline;
}

.p1 {
	text-align: center;
	hyphenate: auto;
	font-family: 黑体;
	font-size: 16pt;
}

.p2 {
	text-align: center;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-align: start;
	hyphenate: auto;
	font-family: 宋体;
	font-size: 12pt;
}

.p6 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>

</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="ajjttljlid" name="ajjttljlid" type="hidden"
				value="${mybean.ajjttljlid}" />
			 <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">案件集体讨论记录</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">案 由：</span>
				<span class="s3"><input  id="ajdjay" name="ajdjay" style="width: 580px;"
						value="${mybean.ajdjay}" /></span>
			</p>
			<p class="p4">
				<span class="s2">讨论时间 ： &times;年&times;月&times;日</span>
				<span class="s3"><input	name="jttlsj" id="jttlsj" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					style="width: 175px;"  value="${mybean.jttlsj}" ></span>
				<span class="s2">到 &times;年&times;月&times;日</span>
				<span class="s3"><input	name="jttljssj" id="jttljssj" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					style="width: 175px;"  value="${mybean.jttljssj}" ></span>
			</p>
			<p class="p4">
				<span class="s2"> 地	点：</span>
				<span class="s3"><input id="jttldd" name="jttldd" style="width: 200px;"
				    value="${mybean.jttldd}" /></span>
			</p>
			<p class="p4">
				<span class="s2">主持人：</span>
				<span class="s3"><input id="jttlzcr" name="jttlzcr" style="width: 100px;"
				    value="${mybean.jttlzcr}" /></span> 
				<span class="s2">职务：</span>
				<span class="s3"><input  id="jttlzcrzw" name="jttlzcrzw" style="width: 100px;"
						    value="${mybean.jttlzcrzw}" /></span> 
				<span class="s2">记录人：</span>
				<span class="s3"><input  id="jttljlr" name="jttljlr" style="width: 100px;"
						    value="${mybean.jttljlr}" /></span>
				<span class="s2">职务：</span>
				<span class="s3"><input  id="jttljlrzw" name="jttljlrzw" style="width: 100px;"
						    value="${mybean.jttljlrzw}" /></span> 
			</p>
			<p class="p4">
				<span class="s2">参加人及职务：</span>
				<span class="s3"><input  id="jttlcjr" name="jttlcjr" style="width: 500px;"
						    value="${mybean.jttlcjr}" /></span>
			</p>
			<p class="p4">
				<span class="s2">案件承办人汇报案件情况：</span>
			</p>
			<p><textarea id="jttlzywfss" name="jttlzywfss" style="width: 800px;height: 200px;">${mybean.jttlzywfss}</textarea></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4">
				<span class="s2">参加讨论人员意见和理由：</span>
			</p>
			<p><textarea  id="jttljl" name="jttljl" style="width: 800px;height: 200px;">${mybean.jttljl}</textarea></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4">
				<span class="s2">决定意见：
				</span>
			</p>
			<p><textarea  id="jttljdyj" name="jttljdyj" style="width: 800px;height: 200px;">${mybean.jttljdyj}</textarea></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4">
				<span class="s2">主持人：</span>
				<span ><input  id="jttlzcrqz" name="jttlzcrqz" style="width: 100px;"
						    value="${mybean.jttlzcrqz}" />（签字）</span> 
				<span class="s2">记录人：</span>
				<span ><input  id="jttljlrqz" name="jttljlrqz" style="width: 100px;"
						    value="${mybean.jttljlrqz}" />
					 （签字） </span>
			</p>
			<p class="p4">
				<span class="s2">参加人员：</span>
				<span ><input  id="jttlcjryqz" name="jttlcjryqz" style="width: 300px;"
						    value="${mybean.jttlcjryqz}" />
				（签字）</span>
			</p>
			<p class="p5"></p>
			<p class="p6"></p>

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
              data-options="iconCls:'ext-icon-book_add'">另存为模板</a>
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
