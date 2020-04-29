<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscfkyjds12DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
			
	Zfwscfkyjds12DTO dto = new Zfwscfkyjds12DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwscfkyjds12DTO) request.getAttribute("printbean");
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
.s {
	text-decoration: underline;
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
	font-family: 宋体;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: left;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.29166666in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 4.0833335in;
	margin-right: 0.875in;
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 4.0833335in;
	margin-right: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: right;
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
	text-indent: 2.84375in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}

.l24 {
	line-height: 30px;
}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">

<jsp:include page="${path}/inc.jsp"></jsp:include>

<script language="javascript" src="<%=basePath%>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
		pluginspage="<%=basePath%>lodop/install_lodop32.exe"></embed>
</object>
<style>
.Noprint{text-align:center;} 
</style>
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
		LODOP=getLodop();
	    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——查封（扣押）决定书");
		LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
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
		LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTML("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
		//添加内容
		LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
		LODOP.SET_PRINT_STYLE("FontSize",12); 
		LODOP.NewPage();
		//强制分页		
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTML("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
		//添加内容
		LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
		LODOP.SET_PRINT_STYLE("FontSize",12);
	}
</script>
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
				<span class="s1">查封（扣押）决定书</span>
			</p>
			<p class="p3">
				<span class="s2"><%if(dto.getCfkywsbh() != null){ %>
				<%=dto.getCfkywsbh()%><%} %></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2">当事人：</span>
				<span style="width: 300px;border-bottom: 1px solid  black;display: inline-block;">
				 <%=dto.getCfkydsr()%></span>
				<span class="s2">法定代表人（负责人）：</span>
				<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
				<%=dto.getCfkyfddbr()%></span>
			</p>
			<p class="p4">
				<span class="s2">地&nbsp;&nbsp;&nbsp;&nbsp;址：</span>
				<span style="border-bottom: 1px solid  black;width: 300px;display: inline-block;">
				<%=dto.getCfkydz()%></span>
				<span class="s2">联系方式：</span>
				<span style="border-bottom: 1px solid  black;width: 185px;display: inline-block;">
				<%=dto.getCfkylxfs()%></span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5 l24">
				<span class="s2">根据</span>
				<span class="s"><%if(dto.getCfkyflmc() != null){ %>
				《<%=dto.getCfkyflmc()%><%} %> 》</span>
				<span class="s2">第</span>
				<span class="s"><%if(dto.getCfkyflt() != null){ %>
				<%=dto.getCfkyflt()%><%} %></span>
		 		<span class="s2">条第</span>
				<span class="s"><%if(dto.getCfkyflk() != null){ %>
				<%=dto.getCfkyflk()%><%} %></span>
				<span class="s2">款第</span>
				<span class="s"><%if(dto.getCfkyflx() != null){ %> 
				<%=dto.getCfkyflx()%><%} %></span>
				<span class="s2">项、《食品药品行政处罚程序规定》第二十七条的规定，你单位（人）</span>
				<span class="s"><%if(dto.getCfkyndwhr() != null){ %>
				<%=dto.getCfkyndwhr()%><%} %></span>
				<span class="s2">涉嫌（存在）</span>
				<span class="s"><%if(dto.getCfkysxczwt() != null){ %>
				<%=dto.getCfkysxczwt()%><%} %></span>
				<span class="s2">问题，现决定对你单位（人）的有关物品/场所予以查封（扣押）。在查封（扣押）期间，
						对查封扣押的场所、设施和财物，应当妥善保存，不得使用、销毁或者擅自转移。当事人不得擅自启封。</span>
			</p>
			<p class="p7">
				<span class="s2">查封（扣押）物品保存地点/场所地点：
					<span class="s"><%if(dto.getCfkybcdd() != null){ %>
					<%=dto.getCfkybcdd()%><%} %></span>
				 </span>
			</p>
			<p class="p7">
				<span class="s2"> 查封（扣押）物品期限： 自</span>
 					<span class="s"><%=dto.getCfkyksrq().substring(0,4)%> </span>年
					<span class="s"><%=dto.getCfkyksrq().substring(5,7)%> </span>月
					<span class="s"><%=dto.getCfkyksrq().substring(8,10)%> </span>日至
					<span class="s"> <%=dto.getCfkyjsrq().substring(0,4)%> </span>年
					<span class="s"><%=dto.getCfkyjsrq().substring(5,7)%> </span>月
					<span class="s"><%=dto.getCfkyjsrq().substring(8,10)%> </span>日
				 </span>
			</p>
			<p class="p7">
				<span class="s2">查封扣押物品保存条件： 
					<span class="s"><%if(dto.getCfkybctj() != null){ %>
					<%=dto.getCfkybctj()%><%} %></span>
			 	</span>
			</p>
			<p class="p7">
				<span class="s2">本决定书附</span>
					<span class="s"><%if(dto.getCfkywpqdwsbh() != null){ %>
					<%=dto.getCfkywpqdwsbh()%><%} %></span>
				<span class="s2">《查封（扣押）物品清单》</span>
			</p>
			<p class="p7">
				<span class="s2">你单位可以对本决定进行陈述和申辩。</span>
			</p>
			<p class="p7 l24">
				<span class="s2">如不服本决定，可在接到本决定书起60日内依法向</span>
				 <span class="s">
				 <%=StringHelper.myMakeStrLen(dto.getCfkyyfxsyj(), 10, 0)%></span>
				<span class="s2">食品药品监督管理局或者</span>
				<span class="s"> 
				<%=StringHelper.myMakeStrLen(dto.getCfkyyfxrmzf(),10, 0)%></span>
				 <span	class="s2">人民政府申请行政复议，也可以于6个月内依法向</span>
				 <span class="s">
				 <%=StringHelper.myMakeStrLen(dto.getCfkyyfxrmfy(), 10, 0)%></span>
				 <span	class="s2">人民法院起诉。 </span>
			</p>
			<p class="p7"></p>
			<p class="p4"></p>
			<p class="p10"></p>
			<p class="p11"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p12"></p>
		</div>
		<div id="footer">
			<p class="p9">
				<span class="s2">（公 章）</span>
			</p>
			<p class="p9">
				<span class="s2">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
				 </span>
			</p>
		</div>
	</body>
	</div>
</html>
