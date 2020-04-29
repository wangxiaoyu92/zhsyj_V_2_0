<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsajjttljl19DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
			
	Zfwsajjttljl19DTO dto = new Zfwsajjttljl19DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsajjttljl19DTO) request.getAttribute("printbean");
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
.page {
	font-size: 10.5pt;
	text-align: right;
	margin: 0px;
	padding: 0px;
}
.l24{line-height: 25px;}
.lin{ border-bottom: 0px;text-align:left;display: inline-block;}
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
<script type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s);  
 var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close");
	});

	//打印预览 
	function printView() {
		LODOP = getLodop();
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——案件集体讨论记录");
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
		
		var strBodyStyle = "<style>" + document.getElementById("sty1").innerHTML + "</style>";
		LODOP.ADD_PRINT_HTM("60mm", "20mm", "RightMargin:1.8cm",
				"BottomMargin:4.5cm", strBodyStyle + document.getElementById("page1").innerHTML);
		//添加内容
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
				strBodyStyle + document.getElementById("title1").innerHTML);
		LODOP.SET_PRINT_STYLEA(0, "PageIndex", 1);
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
				strBodyStyle + document.getElementById("title2").innerHTML);
		LODOP.SET_PRINT_STYLEA(0, "PageIndex", "2,3,4,5");
		LODOP.ADD_PRINT_HTM("260mm","20mm", "RightMargin:1.8cm","100mm",
			strBodyStyle+document.getElementById("footer").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5");
	}
</script>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
<body class="b1 b2">
	<div class="Noprint">
			<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
				class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
				href="javascript:void(0)" id="saveBtn" icon="icon-print"
				class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
				href="javascript:void(0)" id="backBtn" icon="icon-back"
				class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<div align="center" id="title1">
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">案件集体讨论记录</span>
		</p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount"
				format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="title2">
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">（案件集体讨论记录）副页</span>
		</p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount"
				format="#">共###页</span>
		</p>

		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">	 
		<p class="p4">
			<span class="s2">案 由：</span>
			<span class="s2"><%if (dto.getAjdjay() != null) { %>
			<%=dto.getAjdjay()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">讨论时间 ：</span> 
			<%if(dto.getJttlsj() != null && !"".equals(dto.getJttlsj())){ %>
			<span class="s2"><%=dto.getJttlsj().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getJttlsj() != null && !"".equals(dto.getJttlsj())){ %>
			<span class="s2"><%=dto.getJttlsj().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getJttlsj() != null && !"".equals(dto.getJttlsj())){ %>
			<span class="s2"><%=dto.getJttlsj().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
			<%if(dto.getJttlsj() != null && !"".equals(dto.getJttlsj())){ %>
			<span class="s2"><%=dto.getJttlsj().substring(11,13)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">时</span>
			<%if(dto.getJttlsj() != null && !"".equals(dto.getJttlsj())){ %>
			<span class="s2"><%=dto.getJttlsj().substring(14,16)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">分到</span>
			<%if(dto.getJttljssj() != null && !"".equals(dto.getJttljssj())){ %>
			<span class="s2"><%=dto.getJttljssj().substring(11,13)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">时</span>
			<%if(dto.getJttljssj() != null && !"".equals(dto.getJttljssj())){ %>
			<span class="s2"><%=dto.getJttljssj().substring(14,16)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">分</span>
		</p>	
		<p class="p4">	
			<span class="s2">地&nbsp;&nbsp;点：</span>
			<span class="s2"><%if (dto.getJttldd() != null) { %>
			<%=dto.getJttldd()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">主持人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getJttlzcr() != null) { %> <%=dto.getJttlzcr()%><%} %></span>
			<span class="s2">职务：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getJttlzcrzw() != null) { %> <%=dto.getJttlzcrzw()%><%} %></span>
		    <span class="s2">记录人：</span>
		    <span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getJttljlr() != null) { %> <%=dto.getJttljlr()%><%} %></span>
		    <span class="s2">&nbsp;职务：</span>
		    <span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getJttljlrzw() != null) { %> <%=dto.getJttljlrzw()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">参加人：</span>
			<span class="s2"><%if (dto.getJttlcjr() != null) { %>
			<%=dto.getJttlcjr()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人汇报案件情况：</span>
		</p>
		<p class="p4 l24" style="min-height: 50px;">
		<%if(dto.getJttlzywfss() != null){ %>
		<%=SysmanageUtil.replaceStrChuLast(dto.getJttlzywfss())%><%} %>
		</p>
		<p class="p4">
			<span class="s2">参加讨论人员意见和理由：</span>
		</p>
		<p class="p4 l24" style="min-height: 50px;">
		<%if(dto.getJttljl() != null){ %>
		<%=SysmanageUtil.replaceStrChuLast(dto.getJttljl())%><%} %>
		</p>
		<p class="p4">
			<span class="s2">决定意见： </span>
		</p>
		<p class="p4 l24" style="min-height: 50px;">
		<%if(dto.getJttljdyj() != null){ %>
		<%=SysmanageUtil.replaceStrChuLast(dto.getJttljdyj())%><%} %>
		</p>
	 </div>
	 <div id="footer">
		<p class="p4">
			<span class="s2">主持人： </span>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>
            <span class="s2">记录人：</span>
            <span style="border-bottom: 0px solid  white-space;display: inline-block;"></span>
		</p>
		<p class="p4">
			<span class="s2">参加人员：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;"></span>
		</p>
	 </div>
</body>
</div>
</html>
