<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.askj.zfba.dto.Zfwsspypxzcfwsfy36DTO"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsspypxzcfwsfy36DTO dto = new Zfwsspypxzcfwsfy36DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsspypxzcfwsfy36DTO) request.getAttribute("printbean");
	}
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
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
</object>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
sy.setWinRet(s); 
var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close");  
	});

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
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——附页");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "85%", "100%", strBodyStyle
				+ document.getElementById("page1").innerHTML);
	}
</script>
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

.s3 {
	font-family: 仿宋_GB2312;
	color: black;
}

.s4 {
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
	font-family: 仿宋;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>



<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none">
	   <body class="b1 b2">
		 	<div class="Noprint">
					<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
						class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
						href="javascript:void(0)" id="saveBtn" icon="icon-print"
						class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
						href="javascript:void(0)" id="backBtn" icon="icon-back"
						class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
			</div>
			<div align="center" id="page1">
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">（
				<%if(dto.getZfwsdmz() != null && !"".equals(dto.getZfwsdmz())){ %>
				<span class="s1"><%=dto.getZfwsdmz()%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span><%} %>
				）副页</span>
			</p>
			<p class="p3" align="right">
				<span class="s3"> 第 页，共 页</span>
			</p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5">
				<span>被调查人签字：</span> <span style="border-bottom: 0px solid  white-space;display: inline-block;width: 300px;"></span>
				<span> 执法人员签字：</span> <span style="border-bottom: 0px solid  white-space;display: inline-block;"></span>
			</p>
			<p class="p5">
				<span> </span>
			</p>
			<p class="p5">
				<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 10px;"></span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
		   		<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 200px;"></span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
		   		<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 50px;"></span>
			</p>

			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
 	</div>
	</body></div>
</html>
