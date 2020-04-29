<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscfkyyqtzs15DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
			
	Zfwscfkyyqtzs15DTO dto = new Zfwscfkyyqtzs15DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwscfkyyqtzs15DTO) request .getAttribute("printbean");
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
	border-bottom: 0px solid  white-space;display: inline-block;vertical-align:bottom;
}
.s33 {
	font-family: 仿宋_GB2312;
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
.l24 {
	line-height: 30px;
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
</object>
<style>
.Noprint{text-align:center;} 
.PageNext{page-break-after: always;} 
</style>
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
		LODOP.PRINT_INIT("执法文书——查封（扣押）延期通知书");
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
		LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",
			strBodyStyle+document.getElementById("page1").innerHTML);
		//LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",
		//添加内容
		LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
		LODOP.SET_PRINT_STYLEA(0, "FontSize", 12); 
		LODOP.NewPage();//强制分页
		
		LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",
			strBodyStyle+document.getElementById("page1").innerHTML);
		//LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",
		//添加内容
		LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
		LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
	}
</script>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm;height:297mm; margin: 0 auto;display: none">
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
			<span class="s1">查封（扣押）延期通知书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span class="s2"><%if (dto.getCfyqwsbh() != null) { %> 
				<%=dto.getCfyqwsbh()%><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 270px;display: inline-block;">
			<%if (dto.getCfyqdsr() != null) { %>
			<%=dto.getCfyqdsr()%><%}  %></span>
			<span class="s2">法定代表人（负责人）： </span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getCfyqfddbr() != null) { %>
			<%=dto.getCfyqfddbr()%><%}  %></span>
		</p>
		<p class="p5">
			<span class="s2">地址：</span>
			<span style="border-bottom: 0px solid  white-space;width: 280px;display: inline-block;">
			<%if (dto.getCfyqdz() != null) { %>
			<%=dto.getCfyqdz()%><%}  %></span>
			<span class="s2">联系方式： </span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getCfyqlxfs() != null) { %>
			<%=dto.getCfyqlxfs()%><%}  %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6 l24">
			<span class="s2">根据《中华人民共和国行政强制法》第二十五条第一款的规定，因</span> 
			<%if (dto.getCfyqyy() != null && !"".equals(dto.getCfyqyy())) { %>
			<span class="s2"> <%=dto.getCfyqyy()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>
			<%} %>
			<span class="s2">，我局决定对</span>
			<%if (dto.getCfyqcfkyjdsbh() != null && !"".equals(dto.getCfyqcfkyjdsbh())) { %>
			<span class="s2"> <%=dto.getCfyqcfkyjdsbh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span>
			<%} %>
			<span class="s2">《查封（扣押）决定书》中所查封（扣押）的物品延长查封（扣押）期限，延长期限</span>
			<%if (dto.getCfyqqx() != null && !"".equals(dto.getCfyqqx())) { %>
			<span class="s2"> <%=dto.getCfyqqx()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>
			<%} %>
            <span class="s2">日，自</span>
            <%if(dto.getCfyqksrq() != null && !"".equals(dto.getCfyqksrq())){ %>
			<span class="s2"><%=dto.getCfyqksrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getCfyqksrq() != null && !"".equals(dto.getCfyqksrq())){ %>
			<span class="s2"><%=dto.getCfyqksrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getCfyqksrq() != null && !"".equals(dto.getCfyqksrq())){ %>
			<span class="s2"><%=dto.getCfyqksrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
			<span class="s2"> 起延长至</span> 
			<%if(dto.getCfyqjsrq() != null && !"".equals(dto.getCfyqjsrq())){ %>
			<%=dto.getCfyqjsrq().substring(0, 4)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getCfyqjsrq() != null && !"".equals(dto.getCfyqjsrq())){ %>
			<%=dto.getCfyqjsrq().substring(5, 7)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getCfyqjsrq() != null && !"".equals(dto.getCfyqjsrq())){ %>
			<%=dto.getCfyqjsrq().substring(8, 10)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
			<span class="s2">。对查封扣押的场所、设施和财物，应当妥善保存，不得使用、销毁或者擅自转移。当事人不得擅自启封。</span>
		</p> 
		<p class="p8 l24">
			<span class="s2">你单位（人）可以对本决定进行陈述和申辩。如不服本决定，可自收到本决定书之日起六十日内向</span>
			<%if (dto.getCfyqsyjsjy() != null && !"".equals(dto.getCfyqsyjsjy())) { %>
			<span class="s2"> <%=dto.getCfyqsyjsjy()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			<%} %>
			<span class="s2">行政复议受理中心或者</span>
			<%if (dto.getCfyqrmzf() != null && !"".equals(dto.getCfyqrmzf())) { %>
			<span class="s2"> <%=dto.getCfyqrmzf()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			<%} %>
		    <span class="s2">人民政府申请行政复议，也可以自收到本决定书之日起六个月内依法直接向</span>
		    <%if (dto.getCfyqrmfy() != null && !"".equals(dto.getCfyqrmfy())) { %>
			<span class="s2"> <%=dto.getCfyqrmfy()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			<%} %>
			<span class="s2">人民法院提起行政诉讼。 </span>
		</p>
		<br>
		<br>

<p class="p11">
			<span class="s2">（公 章）</span>
		</p>
		<br>
		<p class="p11">
			<span class="s2">
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			 </span>
		</p>
		<br>
		<br>
		<br>
		<p class="p7">
			   <span class="s2">当事人签字：________________</span>
			   <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
		        <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			   </span>  
			</p>
	</div> 
</body>
</div>
</html>
