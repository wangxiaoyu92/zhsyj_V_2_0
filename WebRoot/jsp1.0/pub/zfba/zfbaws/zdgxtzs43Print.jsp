<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwszdgxtzs43DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 指定管辖通知书
	Zfwszdgxtzs43DTO dto = new Zfwszdgxtzs43DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwszdgxtzs43DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-weight:bold;}
.s3{color:black;}
.s4{color:red;}
.s5{color:#333333;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:0.65625in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:start;hyphenate:auto;font-family:仿宋;font-size:16pt;}
.p11{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:2em;}
</style>
<meta content="Administrator" name="author">

<jsp:include page="${path}/inc.jsp"></jsp:include>
<script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 
		pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
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
	LODOP=getLodop();  
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——指定管辖通知书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
}
</script>
</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
<body class="b1 b2">
	<div class="Noprint"> 
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" 
			class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" 
			class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" 
			class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>	
	<div align="center" id="page1">	
		<p class="p1">
			<span class="s1"><%if (dto.getXzjgmc() != null) { %><%=dto.getXzjgmc() %><%} %></span>
		</p>
		<p class="p2">
			<span class="s2">指定管辖通知书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span><%if (dto.getZfwsbh() != null) { %><%=dto.getZfwsbh() %><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p5">
			<%if (dto.getTzdwmc() != null && !"".equals(dto.getTzdwmc())) { %>
			<span class="s3"><%=dto.getTzdwmc() %>:</span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>:<%} %>
		</p>
		<p class="p6 l24">
			<span>关于
			<%if (dto.getGyaj() != null && !"".equals(dto.getGyaj())) { %>
			<span><%=dto.getGyaj() %></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span><%} %>
			一案管辖权问题，经研究，现决定将该案指定
			<%if (dto.getZdgxdw() != null && !"".equals(dto.getZdgxdw())) { %>
			<span><%=dto.getZdgxdw() %></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
			（单位）管辖。请你们接到此通知后及时办理案件移交手续。</span>
		</p>
		<br><br><br><br>
		<p class="p7">
			<span class="s3">（公    章）</span>
		</p>
		<br>
		<p class="p8">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
		</p>
		</div>
</body>
</div>
</html>
