<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwscfkyyqtzs15DTO"%>
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
	//第15个文书  查封扣押延期通知书
	Zfwscfkyyqtzs15DTO localZfwscfkyyqtzs15DTO = new Zfwscfkyyqtzs15DTO();
	if (request.getAttribute("mybean") != null) {
		localZfwscfkyyqtzs15DTO = (Zfwscfkyyqtzs15DTO) request.getAttribute("mybean");
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
		var v_cfkyyqtzsid=$("#cfkyyqtzsid").val();
		if (v_cfkyyqtzsid==null || v_cfkyyqtzsid=="" || v_cfkyyqtzsid.length== 0){
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
					url : basePath + '/pub/wsgldy/saveZfwscfkyyqtzs',
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
							$("#cfkyyqtzsid").val(result.cfkyyqtzsid);
							$("#saveBtn").linkbutton('disable');
							$("#lcwmbBtn").linkbutton('enable');	
			 		  		$("#printBtn").linkbutton('enable');
					 		alert("保存成功！");
						} else {
							 alert('保存失败：' + result.msg);
						}
					}
				});
	}
function myprint(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_cfkyyqtzsid = $("#cfkyyqtzsid").val();
	var url="<%=basePath%>pub/wsgldy/zfwscfkyyqtzsPrintIndex?ajdjid="
		+v_ajdjid+"&cfkyyqtzsid="+v_cfkyyqtzsid+"&time="+new Date().getMilliseconds();
		
	//创建模态窗口
	var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
	},function (dialogID){
		var v_retStr = sy.getWinRet(dialogID);
		
		sy.removeWinRet(dialogID);//不可缺少
		if(v_retStr.type=="ok"){ //传递回的type为ok的时候才刷新页面。   
		}
	});
}
 
//另存为模板
function saveAsMoban(){
    var obj = new Object();
    var v_ajdjid=$("#ajdjid").val();
    var v_zfwsdmz=$("#zfwsdmz").val();
    var v_cfkyyqtzsid=$("#cfkyyqtzsid").val();
    
    if (v_cfkyyqtzsid==null || v_cfkyyqtzsid=="" || v_cfkyyqtzsid.length== 0){
    	alert('请先保存，保存成功后，才能另存为模板');
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
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}

.p5 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.29166666in;
	margin-left: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.36458334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.2875in;
	margin-left: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-indent: 3.9375in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	margin-right: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-indent: 3.8645833in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p13 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
	<body class="b1 b2 zfwsbackgroundcolor">
		<form id="myform" method="post">
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<input id="cfkyyqtzsid" name="cfkyyqtzsid" type="hidden"
				value="${mybean.cfkyyqtzsid}" />
			<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">查封（扣押）延期通知书</span>
			</p>
			<div align="right">
				<p class="p3">
					<span class="s2"></span>
					<span class="s3">
						<input id="cfyqwsbh" name="cfyqwsbh"
							style="width: 300px;" value="${mybean.cfyqwsbh}" /> 
					</span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">当事人： </span>
				<span class="s3"><input id="cfyqdsr" name="cfyqdsr"
					style="width: 260px;" value="${mybean.cfyqdsr}" /></span>
				<span class="s2"> 法定代表人（负责人）： </span>
				<span class="s3"><input id="cfyqfddbr" name="cfyqfddbr" style="width: 260px;"
					value="${mybean.cfyqfddbr}" /> </span>
			</p>
			<p class="p5">
				<span class="s2">地 址： </span>
				<span class="s3"><input id="cfyqdz" name="cfyqdz"
					style="width: 270px;" value="${mybean.cfyqdz}" /> </span>
				<span class="s2">联系方式： </span>
				<span class="s3"><input id="cfyqlxfs" name="cfyqlxfs" style="width: 260px;"
					value="${mybean.cfyqlxfs}" /> </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p6">
				<span class="s2">根据《中华人民共和国行政强制法》第二十五条第一款的规定，因 </span>
				<span class="s3"><input
					id="cfyqyy" name="cfyqyy" style="width: 200px;"value="${mybean.cfyqyy}" /></span> （原因），
				<span class="s2">我局决定对</span>
				<span class="s3"><input id="cfyqcfkyjdsbh"
					name="cfyqcfkyjdsbh" style="width: 200px;"
					value="${mybean.cfyqcfkyjdsbh}" /></span>
				<span class="s2">《查封（扣押）决定书》中所查封（扣押）的物品延长查封（扣押）期限，自&times;年&times;月&times;日</span>
				<span class="s3"><input name="cfyqksrq" id="cfyqksrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.cfyqksrq}"> </span>
				<span class="s2">起延长至&times;年&times;月&times;日</span>
				<span class="s3"><input name="cfyqjsrq" id="cfyqjsrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.cfyqjsrq}"></span>
				<span class="s2">。对查封扣押的场所、设施和财物，应当妥善保存，不得使用、销毁或者擅自转移。当事人不得擅自启封。</span>
			</p>
			<p class="p7">
				<span class="s2">你单位可以对本决定进行陈述和申辩。</span>
			</p>
			<p class="p8">
				<span class="s2">如不服本决定，可在接到本决定书之日起60日内依法向 </span>
				<span class="s3"><input id="cfyqsyjsjy" name="cfyqsyjsjy" style="width: 100px;"
					value="${mybean.cfyqsyjsjy}" /> </span>
				<span class="s2">（上一级）食品药品监督管理局或者</span>
				<span class="s3"><input id="cfyqrmzf" name="cfyqrmzf" style="width: 100px;"
					value="${mybean.cfyqrmzf}" /> </span>
				<span class="s2">人民政府申请行政复议，也可以于6个月内依法向</span>
				<span class="s3"><input id="cfyqrmfy" name="cfyqrmfy" style="width: 100px;"
					value="${mybean.cfyqrmfy}" /> </span>
				<span class="s2">人民法院起诉。 </span>
			</p>
			<p class="p9"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p11">
				<span class="s2"> （公 章）</span>
			</p>
			<p class="p11">
				<span class="s2"> &times;年&times;月&times;日 <input
					name="cfyqgzrq" id="cfyqgzrq" class="Wdate"
					onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" style="width: 175px;"
					value="${mybean.cfyqgzrq}"> </span>
			</p>
			<p class="p12"></p>
			<p class="p12"></p>
			<p class="p12"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5">
				<span class="s2">注：正文3号仿宋体字，存档（1）。</span>
			</p>
			<p class="p13"></p>

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
