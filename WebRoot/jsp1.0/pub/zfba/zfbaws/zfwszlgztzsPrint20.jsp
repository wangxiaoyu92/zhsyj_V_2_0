<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwszlgztzs20DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Zfwszlgztzs20DTO dto=new Zfwszlgztzs20DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwszlgztzs20DTO) request.getAttribute("printbean");
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
	margin-top: 0.06944445in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.44444445in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.44444445in;
	margin-top: 0.108333334in;
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
	/* text-align: justify; */
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 3.7916667in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-indent: 2.9166667in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.s22 {
	clear: both;
	display: block;
	float: right;
	margin-bottom: 10px
}
.l24 {
	line-height: 30px;
}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>

<style>
.Noprint{text-align:center;} 
.PageNext{page-break-after: always;} 
</style>

<script language="javascript" type="text/javascript">
	var s = new Object();
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
	var LODOP; //声明为全局变量

$(function(){	
	printView();
	parent.$("#"+sy.getDialogId()).dialog("close");     
});

//打印预览 
function printView(){	
	LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——责令改正通知书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	CreatePrintPage();
  	LODOP.PREVIEW();		
};

//直接打印
function printData(){		
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
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,8,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPage();//强制分页
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,8,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
}
</script>

<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none">
<body class="b1 b2">
    <div style="width: 210mm; margin: 0 auto;display: none">
    <div class="Noprint">
	<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
	<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
	<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
     </div>
	<div align="center" id="page1">
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">责令改正通知书</span>
		</p>
		<div align="right">
			<p class="p3">
			<span class="s2">
				<%if(dto.getZlgzwsbh() != null){ %>
				<%=dto.getZlgzwsbh()%><%} %>                               
			</span>
			</p>
		</div>
		<br/>
		<hr style="height:2px;border:none;border-top:2px solid #555555;"/>
		<p class="p4">
			<span class="s3" style="width:240px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
			<%=StringHelper.myMakeStrLen(dto.getZlgzdsr(), 80, 0) %>:</span>
		</p>
		<p class="p5 l24">
			<span class="s2">经查，你（单位）</span>
			<span class="s3">
			<%if(dto.getZlgzwfxw() != null){ %>
			<%=dto.getZlgzwfxw()%>&nbsp;&nbsp;&nbsp;&nbsp;<%} else { %>
			<%=StringHelper.myMakeStrLen("", 80, 0) %><%} %>
			</span>
			<span class="s2">的行为 ，违反了</span>
			<span class="s3">
			<%if(dto.getZlgzwfgd() != null){ %>
			<%=dto.getZlgzwfgd()%>&nbsp;&nbsp;&nbsp;&nbsp;<%}else {  %>
			<%=StringHelper.myMakeStrLen("", 80, 0) %><%} %>
			</span>
			<span class="s2">的规定。</span>
		</p>
		<p class="p6 l24">
			<span class="s2">根据</span>
			<span class="s3">
			<%=StringHelper.myMakeStrLen(dto.getZlgzcfgj(), 30, 0)%></span>
			<span class="s2">第</span>
			<span class="s3">
			<%=StringHelper.myMakeStrLen(dto.getZlgzcfgjt(), 8, 0)%></span>
			<span class="s2">条第</span>
			<span class="s3">
			<%=StringHelper.myMakeStrLen(dto.getZlgzcfgjk(), 5, 0)%></span>
			<span class="s2">款第</span>
			<span class="s3">
			<%=StringHelper.myMakeStrLen(dto.getZlgzcfgjx(), 5, 0)%></span>
			<span class="s2">项的规定，责令你（单位）立即（限期）改正。改正内容及要求如下：</span>
		</p>
		<p class="p6 l24">
			<span class="s2" style="width:600px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getZlgzgznr() != null) { %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getZlgzgznr()) %><%} %>
			</span>
		</p>
	</div>
	<div id="footer">
		<p class="p9">
			<span class="s2 s22"> （公 章）</span>
		</p>
		<br>
		<p class="p8">
	   <span class="s2 s22" style="margin-right:2px">
   			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
	   </span>
	</p>
	</div>
</body>
</div>
</html>

