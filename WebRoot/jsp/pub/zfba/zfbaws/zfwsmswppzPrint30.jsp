<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsmswppz30DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwsmswppz30DTO dto = new Zfwsmswppz30DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsmswppz30DTO) request.getAttribute("printbean");
	}
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

.p4 {
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.29166666in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.2777778in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}

.s22 {
	text-align: right;
}
.lh { line-height: 30px;}
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
</object>

<style>
.Noprint {
	text-align: center;
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

	});

	//打印预览 
	function printView() {
		LODOP = getLodop();
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——责令改正通知书");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
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
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p7'><span class='s2'>注：存档（1），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（1）。</span></p>");
		LODOP.NewPage();//强制分页
		
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p7'><span class='s2'>注：存档（2），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（2）。</span></p>");
		LODOP.NewPage();//强制分页
		
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p7'><span class='s2'>注：存档（3），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（3）。</span></p>");
	}
</script>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>

<body class="b1 b2">
	<div style="width: 210mm; margin: 0 auto;display: none">
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
				<span class="s1"><%if (dto.getXzjgmc() != null) { %>
				<%=dto.getXzjgmc() %><%} %>
			</span>
			</p>
			<p class="p2">
				<span class="s1">没收物品凭证</span>
			</p>
			<div align="right">
				<p class="p3">
				<span class="s2"><%if(dto.getMspzwsbh() != null){ %>
					<%=dto.getMspzwsbh() %><%} %>                               
				</span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">案 由：</span> 
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if(dto.getAjdjay() != null){ %><%=dto.getAjdjay()%><%} %></span>
			</p>
			<p class="p4">
				<span class="s2">当事人：</span>
				<span style="border-bottom: 0px solid  white-space;width: 280px;display: inline-block;">
				<%if(dto.getMswpdsr() != null){ %><%=dto.getMswpdsr()%><%} %></span>
				<span class="s2">地 址：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if(dto.getMswpdz() != null){ %><%=dto.getMswpdz()%><%} %></span>
			</p>
			<p class="p4">
				<span class="s2">执行机关：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if(dto.getMswpzxjg() != null){ %><%=dto.getMswpzxjg()%><%} %></span>
			</p>
			<p class="p4"></p>
			<p class="p5 lh">
				<span class="s2">根据</span>
				<%if(dto.getCfjdwsbh() != null && !"".equals(dto.getCfjdwsbh())){ %>
				<span class="s2"><%=dto.getCfjdwsbh()%></span><%} else{%>
				<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block;"></span><%} %>
				<span class="s2">《行政处罚决定书》的决定，对你（单位）的涉案物品进行没收。</span>
			</p>
			<p class="p6"></p>
			<p class="p5 lh">
				<span class="s2">附件：<%if(dto.getMswpfj() != null){ %>
				<%=dto.getMswpfj()%><%} %></span>
			</p>
			<br><br><br>
			<p class="p11">
				<span class="s2"> </span>
			</p>
			<br><br><br>
			<p class="p7 s22">
			    <span class="s2"> （公 章）</span>
			    <span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
	        </p>
	        <br>
	        <p class="p8 s22">
			<span class="s2">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</span>
			</p>
		</div>
			
	</div>
</body>
</html>

