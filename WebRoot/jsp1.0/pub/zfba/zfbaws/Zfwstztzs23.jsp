<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwstztzs23DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}

	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	//案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request
			.getParameter("ajdjid"));
	//执法文书代码值
	String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
	//附件参数代码名称
	String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")),"UTF-8");
	//是否可以保存0否1是
	String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
	//第23个文书   听证通知书
	Zfwstztzs23DTO localZfwstztzs23DTO = new Zfwstztzs23DTO();
	if (request.getAttribute("mybean") != null) {
		localZfwstztzs23DTO = (Zfwstztzs23DTO) request
				.getAttribute("mybean");
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
window.returnValue = s; 
	$(function() {
		var v_tztzsid=$("#tztzsid").val();
		if (v_tztzsid==null || v_tztzsid=="" || v_tztzsid.length== 0){
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
		$('#myform').form('submit',	{
					url : basePath + '/pub/wsgldy/savezfwstztzs',
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
							$("#tztzsid").val(result.tztzsid);
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
    var v_ajdjid=$("#ajdjid").val();
    var v_tztzsid=$("#tztzsid").val();
    
	var url="<%=basePath%>pub/wsgldy/zfwstztzsPrintIndex?ajdjid="+v_ajdjid+"&zfwsqtbid="+v_tztzsid+"&time="+new Date().getMilliseconds();
    
    	//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '打印',
			width : 700,
			height : 650,
			url : url
		},function (dialogID){
			var v_retStr = sy.getWinRet(dialogID);
			
			sy.removeWinRet(dialogID);//不可缺少
			
			if(v_retStr.type=="ok"){ //传递回的type为ok的时候才刷新页面。   
		//window.location.reload();
	    //shuaxindata();
		}
		});
}

 
//另存为模板
   function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_tztzsid=$("#tztzsid").val();
    
    if (v_ajdjid==null || v_ajdjid=="" || v_ajdjid.length== 0){
    	alert('案件登记id为空，不能另存为模板');
    	return false;
    }
    
   // if (v_tztzsid==null || v_tztzsid=="" || v_tztzsid.length== 0){
    //	alert('请先保存，保存成功后，才能另存为模板');
    //	return false;
    //}
    
	var url="<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="+v_ajdjid+"&zfwsdmz="+v_zfwsdmz+"&time="+new Date().getMilliseconds();
    
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
    var v_zfwsdmz = $("#zfwsdmz").val();
    
	var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
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
	   	var myrow = v_retStr[0];
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		var v_zfwsmbid = myrow.zfwsmbid;
		var v_zfwsqtbid = myrow.zfwsqtbid;
		$.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time='+new Date().getMilliseconds(), {
			zfwsmbid : v_zfwsmbid,
				zfwsqtbid : v_zfwsqtbid,   
				cssbfhyjsid: $("#cssbfhyjsid").val(),
				ajdjid : $("#ajdjid").val()
		}, 
		function(result) {
			if (result.code == '0') {			
				var retdata = result.data;
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
		var s = "ok";      
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
	font-family: 仿宋_GB2312;
	color: black;
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
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋;
	font-size: 10.5pt;
}

.p4 {
	text-indent: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.3in;
	margin-left: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.35in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.29166666in;
	margin-left: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.33in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 0.37in;
	text-align: start;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	text-indent: 0.072916664in;
	margin-left: 3.7916667in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-indent: 0.4375in;
	margin-left: 3.7916667in;
	margin-right: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p13 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p14 {
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
			<input id="tztzsid" name="tztzsid" type="hidden" value="${mybean.tztzsid}" />
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">听证通知书</span>
			</p>

			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">
				<span class="s2"> </span> <span class="s3">  
					 <input id="tztzwsbh" name="tztzwsbh"  style="width: 280px;"
					  value="${mybean.tztzwsbh}" /></span>
			</p>
			<p class="p4">
				<span class="s2"> <input id="tztzdsr" name="tztzdsr"
					style="width: 240px;" value="${mybean.tztzdsr}" />：</span>
			</p>
			<p class="p5">
				<span class="s2"> 你(单位) 于&times;年&times;月&times;日 <input
					name="tztzsqrq" id="tztzsqrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.tztzsqrq}">

					向本局提出听证申请，根据《中华人民共和国行政处罚法》第四十二条规定，本局决定于&times;年&times;月&times;日&times;时&times;分
					<input name="tztzjxrq" id="tztzjxrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd   HH:mm:ss'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.tztzjxrq}"> ，
					在 
					<input id="tztzdd"	name="tztzdd" style="width: 260px;"   value="${mybean.tztzdd}" />
					（地点）公开（不公开）举行听证会。请你（单位）法定代表人或委托代理人准时出席。不按时出席听证，且事先未说明理由，又无特殊原因的，视为放弃听证权利。</span>
			</p>
			<p class="p6">
				<span class="s2">委托代理听证的，应当在听证举行前向本局提交听证代理委托书。</span>
			</p>
			<p class="p6">
				<span class="s2">本案听证主持人： <input id="tztzzcr" name="tztzzcr"
					style="width: 260px;"   value="${mybean.tztzzcr}" />
					
					 记录员： <input
					id="tztzjly" name="tztzjly" style="width: 260px;" 
					value="${mybean.tztzjly}" /> </span>
			</p>
			<p class="p7">
				<span class="s2">根据《中华人民共和国行政处罚法》第四十二条的规定，你如申请主持人回避，可在听证举行前向本局提出回避申请并说明理由。</span>
			</p>
			<p class="p8">
				<span class="s2">地 址： <input id="tztzdz" name="tztzdz"
					style="width: 260px;" value="${mybean.tztzdz}" /> </span>
			</p>
			<p class="p8">
				<span class="s2">邮政编码： <input id="tztzyzbm" name="tztzyzbm"
					style="width: 260px;"  value="${mybean.tztzyzbm}" /> </span>
			</p>
			<p class="p8">
				<span class="s2">联系电话： <input id="tztzlxdh" name="tztzlxdh"
					style="width: 260px;" value="${mybean.tztzlxdh}" />
				</span>
			</p>
			<p class="p9">
				<span class="s2"> 联 系 人： <input id="tztzlxr" name="tztzlxr"
					style="width: 260px;" value="${mybean.tztzlxr}" /> </span>
			</p>
			<p class="p10"></p>
			<p class="p11"></p>
			<p class="p11"></p>
			<p class="p11"></p>
			<p class="p12">
				<span class="s2">（公 章）</span>
			</p>
			<p class="p10">
				<span class="s2"> &times;年&times;月&times;日 <input
					name="tztzgzrq" id="tztzgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.tztzgzrq}"> </span>
			</p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p13">
				<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
			</p>
			<p class="p14"></p>

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
</html>
