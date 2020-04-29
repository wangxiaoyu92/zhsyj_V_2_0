<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page
	import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.ZfwsajlydjbDTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	int page_number = 1;

	String v_zfwslydjid = StringHelper.showNull2Empty(request
			.getParameter("zfwslydjid"));

	String v_jdjc = "../../images/pub/feiduihao.jpg";
	String v_tsjb = "../../images/pub/feiduihao.jpg";
	String v_sjjb = "../../images/pub/feiduihao.jpg";
	String v_xjbq = "../../images/pub/feiduihao.jpg";
	String v_jdcy = "../../images/pub/feiduihao.jpg";
	String v_ys = "../../images/pub/feiduihao.jpg";
	String v_qt = "../../images/pub/feiduihao.jpg";

	ZfwsajlydjbDTO localZfwsajlydjbDTO = new ZfwsajlydjbDTO();
	if (request.getAttribute("printbean") != null) {
		localZfwsajlydjbDTO = (ZfwsajlydjbDTO) request
				.getAttribute("printbean");
		if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("1")) {
			v_jdjc = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("2")) {
			v_tsjb = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("3")) {
			v_sjjb = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("4")) {
			v_xjbq = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("5")) {
			v_jdcy = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("6")) {
			v_ys = "../../images/pub/duihao.jpg";
		} else if (localZfwsajlydjbDTO != null
				&& localZfwsajlydjbDTO.getAjdjajly().equals("7")) {
			v_qt = "../../images/pub/duihao.jpg";
		}
	}
%>
<%
	String v_duihao = "☑";
	String v_kong = "□";
	
	String v_duihao2="<span style=\"font-family:Wingdings;font-size:25px;\" >&#254;</span>";
	
	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
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

.s22 {
	clear: both;
	display: block;
	text-align:right;
	margin-bottom: 2px;
}

.s3 {
	color: black;
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

.p31 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: -0.072916664in;
	margin-left: 0.8020833in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p61 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.07013889in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	margin-left: 0.07013889in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	text-indent: 0.29166666in;
	margin-top: 0.16666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-indent: 0.36458334in;
	margin-top: 0.16666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p13 {
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p14 {
	text-indent: 3.4270833in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p142 {
	text-indent: 2em;
	word-break: break-all;
	line-height: 23px
}

.p15 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">

<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>

<script language="javascript" src="<%=basePath%>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
		pluginspage="<%=basePath%>lodop/install_lodop32.exe"></embed>
		<param name="Caption" value="我是打印控件lodop">
</object>

<style>
.Noprint {
	text-align: center;
}

.PageNext {
	page-break-after: always;
}
</style>

<script language="javascript" type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
	var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close"); 

	})

	//打印预览 
	function printView() {
		CreatePrintPage();
		LODOP.PREVIEW();
	};

	//直接打印
	function printData() {
		CreatePrintPage();
		LODOP.PRINT();
	};

	//打印维护
	function printSetup() {
		CreatePrintPage();
		LODOP.PRINT_SETUP();
	};

	//打印设计
	function printDesign() {
		CreatePrintPage();
		LODOP.PRINT_DESIGN();
	};

	function CreatePrintPage() {
		LODOP = getLodop();
		var strBodyStyle = "<style>"
				+ document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——案件来源登记表");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
				+ document.getElementById("page1").innerHTML);
		//LODOP.NEWPAGE();
		//LODOP.ADD_PRINT_HTM("20mm", "20mm", "85%", "100%", strBodyStyle
		//		+ document.getElementById("page2").innerHTML);
	}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none">
	<body class="b1 b2">
		<input id="zfwslydjid" name="zfwslydjid" type="hidden"
			value="<%=v_zfwslydjid%>" />
		<div class="Noprint">
			<!-- 
    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
	<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
	-->
			<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
				class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
				href="javascript:void(0)" id="saveBtn" icon="icon-print"
				class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
				href="javascript:void(0)" id="backBtn" icon="icon-back"
				class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
		</div>
		<div align="center" id="page<%=page_number%>">

			<p class="p1">
				<span class="s1" style="text-align:center">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">案件来源登记表</span>
			</p>
			<p class="p3">
				<span class="s2"> （&times;&times;）食药监&times;案源〔年份〕&times;号</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<%--<hr style="height:5px;border:none;border-top:5px ridge #000000;" />--%>
			<p class="p4">
				<span class="s2"> 案件来源：<%=v_duihao2 %><img alt="" src="<%=v_jdjc%>"
					class="duihaokuang">
				<监督检查
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img alt="" src="<%=v_tsjb%>" class="duihaokuang">投诉/举报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img alt="" src="<%=v_sjjb%>" class="duihaokuang">上级交办&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img alt="" src="<%=v_xjbq%>" class="duihaokuang">下级报请&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
</p>
<p class="p5">
<span class="s2">
    <img alt="" src="<%=v_jdcy%>" class="duihaokuang">监督抽验&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img alt="" src="<%=v_ys%>" class="duihaokuang">移送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img alt="" src="<%=v_qt%>" class="duihaokuang">其他
</span>
</p>
<p class="p61">
<span class="s2">当事人：</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslydsr(), 145, 0)%></span>
</p>
<p class="p61">
<span class="s2">地址:</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslydz(), 90, 0)%></span><span class="s2">邮编：</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslyyb(), 30, 0)%></span>
</p>
<p class="p6">
<span class="s2">法定代表人（负责人）/自然人:</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslyfddbrxm(), 40, 0)%></span><span class="s2">联系电话:</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslylxdh(), 40, 0)%></span>
</p>
<p class="p7">
<span class="s2">法定代表人（负责人）/自然人身份证号码：</span><span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwsajlydjbDTO.getWslyfddbrsfzh(), 75, 0)%></span>
</p>
<p class="p8">
<span class="s2">登记时间：</span><span class="s3"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(0, 4), 16, 1)%></span><span class="s2">年</span><span class="s3"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(5, 7), 13, 1)%></span><span class="s2">月</span><span class="s3"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(8, 10), 12, 1)%></span><span class="s2">日</span><span class="s3"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(11, 13), 11, 1)%></span><span class="s2">时</span><span class="s3"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(14, 16), 10, 1)%></span><span class="s2">分</span>
</p>
<hr style="height:2px;border:none;border-top:2px solid #555555;" />
<p class="p9">
<span class="s2">基本情况介绍：（负责人，案发时间、地点，重要证据，危害后果及其影响等）</span>
</p>
<p class="p10"><%=localZfwsajlydjbDTO.getAjdjjbqk()%></p>
<p class="p10"></p>
<p class="p10"></p>
<p class="p10"></p>
<p class="p11"></p>
<p class="p11"></p>
<p class="p12">
<span class="s2">附件：（现场检查笔录、投诉举报材料、检测（检验）报告、相关部门移送材料等）</span>
</p>
<p class="p13">
<span class="s2">                                  </span>
</p>
<p class="p13">
    <span class="s2">                                  </span>
</p>

<p class="p13">
<span class="s2">                          </span>
</p>
<p class="p3"  >
<span class="s2 s22">记录人：<%=localZfwsajlydjbDTO.getWslyjlr()%>(签字)</span>
</p>
<p class="p3">
<span class="s2 s22" ><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(0, 4), 16, 1)%>年<%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(5, 7), 13, 1)%>月<%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyjlsj().substring(8, 10), 12, 1)%>日</span>
</p>
<p class="p13"></p>
<hr style="height:2px;border:none;border-top:2px solid #555555; />

<p class="p6">
<span class="s2">处理意见：</span>
</p>
<p class="p14 p142">
<span class="s2"><%=localZfwsajlydjbDTO.getAjdjclyj()%></span>
</p>
<p class="p14"></p>
<p class="p14">
<span class="s2"> </span>
</p>
<p class="p3">
<span class="s2 s22">负责人：<%=localZfwsajlydjbDTO.getWslyfzr()%>(签字)   </span>
</p>
<p class="p3">
<span class="s2 s22"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyfzrqzsj().substring(0, 4), 16, 1)%>年<%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyfzrqzsj().substring(5, 7), 13, 1)%>月<%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO
					.getWslyfzrqzsj().substring(8, 10), 12, 1)%>日</span></span>
</p>
<p class="p15"></p>
<hr style="height:2px;border:none;border-top:2px solid #555555;" />

    </body>
</div>

</html>
