<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsft13DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
	Zfwsft13DTO dto = new Zfwsft13DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsft13DTO) request.getAttribute("mybean");
	}
	String v_ajdjid = StringHelper.showNull2Empty(request
			.getParameter("ajdjid"));
	String zfwsdmz = StringHelper.showNull2Empty(request
			.getParameter("zfwsdmz"));
	String fdqbr = "";
	if (dto.getSpypjdgljmc() != null && !"".equals(dto.getSpypjdgljmc())) {
		//封条地区转换
		String fdq = dto.getSpypjdgljmc();
		String[] str =  fdq.split("");
		
		for (String string : str) {
			fdqbr += string+"<br/>";
		}
	}
	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
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
	color: black;
	text-decoration: underline;
	text-align: end;
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
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
	text-align: end;
}

.p4 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p5 {
	text-indent: -0.072916664in;
	margin-left: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p6 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p7 {
	text-indent: 0.36458334in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p8 {
	text-indent: 0.4375in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p9 {
	text-indent: -5.1041665in;
	margin-left: 5.1041665in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p10 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10pt;
}

.p11 {
	text-align: end;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10pt;
}

#ft{
	width:275px;
	height:550px;
	background-color: white;
	border:1px solid black;
	margin-left:220px;
}
#f1{
	float:right;padding:20px;
}
#f2{
	float:right;padding-top:250px;
}
#f2 span{
	font:bold 15px/15px 新宋体;
}
#f1 span{
	font:bold 30px/30px 新宋体;
}
.date{
	font-size:12px;
}
</style>
<title>封条</title>
<meta content="X" name="author">
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);   
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;

	$(function(){
		if($("#ftid").val()==""){
			$("#printBtn").linkbutton('disable');
		}
	});
	
	function chageword(){
		$("#t1").html($("#xztzwsbh").val());
		$("#t2").html($("#xztzwsbh").val());
	}				


	//保存
	function mysave() {
		var url = basePath + 'pub/wsgldy/saveZfwsft13';
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		parent.$.messager.progress({
			text : '正在提交....'
		}); // 显示进度条

		$('#myform').form(
				'submit',
				{
					url : url,
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
							$("#saveBtn").linkbutton('disable');
							$("#printBtn").linkbutton({disabled:false});
							alert("保存成功！");
						} else {
							parent.$.messager.alert('提示', '保存失败：' + result.msg,
									'error');
						}
					}
				});
	}
	//打印
	function myprint() {
		var obj = new Object();
		var v_zfwslydjid = $("#ajdjid").val();

		var url = "<%=basePath%>pub/wsgldy/ZfwsftIndexPrint?ajdjid="+v_zfwslydjid+"&time="+new Date().getMilliseconds();
		
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : ' ',
			width : 700,
			height : 650,
			url : url
		});
	}
	
	
	function makeft(){
		dq();
		nf();
	}
	
	//地区
	function dq(){
		var dq = $("#spypjdgljmc").val();
		var arr =  dq.split("");
		var str ="" ;
		for(var i =0;i<arr.length;i++){
			str= str + arr[i] +"<br/>";
		}
		$("#dq").html(str);
	}
	//年份
	function nf(){
		var nf = $("#ftyzrq").val();
		var arr = nf.split("-");
		arry = arr[0].split("");
		arrm = arr[1].split("");
		arrd = arr[2].split("");
 		$("#year").html(word(arry[0])+"<br/>"+word(arry[1])+"<br/>"+word(arry[2])+"<br/>"+word(arry[3]));
		$("#moth").html("<br/>"+word(arrm[0])+"<br/>"+word(arrm[1]));
		$("#day").html("<br/>"+word(arrd[0])+"<br/>"+word(arrd[1])); 
	}
	//中文数字
	function word(n){
		switch(n)
		{
		case "1":
		  	n =	"一"; 
		  break;
		case "2":
		 	n =	"二";
		  break;
		case "3":
		 	n =	"三";
		  break;
		case "4":
		 	n =	"四";
		  break;
		case "5":
		 	n =	"五";
		  break;
		case "6":
		 		n ="六";
		  break;
		case "7":
		 		n ="七";
		  break;
		case "8":
		 		n ="八";
		  break;
		case "9":
		 		n ="九";
		  break;
		case "0":
		 		n ="零";
		  break;
		}
		return n;
	}
	
	// 关闭并刷新父窗口
	function closeAndRefreshWindow(){
		var s = new Object();   
			s.type = "ok";       
			sy.setWinRet(s);
		parent.$("#"+sy.getDialogId()).dialog("close");   
	}
</script>
</head>
<body class="b1 b2 zfwsbackgroundcolor">
	<form id="myform" method="post">
		<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>" />
		<input id="ftid" name="ftid" type="hidden"
			value="${mybean.ftid}" />

		<div id="ft">
			<div id="f1">
				<span><%=fdqbr %>食<br />品<br />药<br />品<br />监<br />督<br />管<br />理<br />局<br />
				<br /> 封<br> </span>
				<p>（印章）</p>
			</div>
			<div id="f2">
			<input name="ftyzrq" id="ftyzrq" class="Wdate easyui-validatebox bbtextarea"
				data-options="required:true" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
				style="width: 150px;" value="${mybean.ftyzrq}" />
			</div>
		</div>
		<p></p>
		<p></p>
		<p></p>
		<p></p>
		<div id="btn">
			<table>
				<tr align="right" style="height: 60px;">
					<td colspan=4 align="right">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</br> <a
						href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton"
						onclick="mysave()" data-options="iconCls:'icon-save'">保存</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
						href="javascript:void(0);" id="printBtn" class="easyui-linkbutton"
						onclick="myprint();" data-options="iconCls:'icon-print'">打印</a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
						href="javascript:void(0);" id="BtnFanhui"
						class="easyui-linkbutton" onclick="closeAndRefreshWindow();"
						data-options="iconCls:'icon-back'">关闭</a>
					</td>
				</tr>
			</table>
		</div>

	</form>
</body>
</html>
