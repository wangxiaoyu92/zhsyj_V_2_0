<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="java.text.SimpleDateFormat,java.util.*,java.net.*" pageEncoding="UTF-8"%>

<% 
	String contextPath = request.getContextPath();
	//String basePath = GlobalConfig.getAppConfig("apppath");
	//if (null==basePath || "".equals(basePath)){
		String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	//}
	
	System.out.println("basePathbasePathbasePathbasePath  "+contextPath);
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.p1{text-indent:0.4375in;margin-left:0.29166666in;text-align:justify;hyphenate:auto;keep-together.within-page:always;keep-with-next.within-page:always;font-family:Times New Roman;font-size:10pt;}
.p2{margin-right:-0.10625in;text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:18pt;}
.p3{margin-right:-0.10625in;text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p4{text-indent:2.0833333in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p5{text-indent:0.33333334in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p6{text-indent:0.33333334in;margin-right:-0.00625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p7{text-indent:0.25in;margin-left:0.49861112in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p8{margin-left:0.49861112in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p9{text-indent:4.3333335in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p10{text-indent:2.1666667in;margin-right:-0.00625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p11{margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p12{text-indent:0.33333334in;margin-right:0.0034722222in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p13{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:18pt;}
.p14{text-indent:2.25in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p15{text-indent:0.33333334in;text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p16{text-indent:4.0in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p17{text-indent:4.9166665in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p18{margin-left:0.49861112in;margin-right:0.14375in;text-align:end;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p19{text-indent:2.3333333in;margin-right:-0.10625in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p20{margin-left:0.49861112in;margin-right:-0.10625in;text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p21{text-indent:4.8333335in;text-align:start;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p22{text-indent:0.5in;text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p23{text-align:justify;hyphenate:auto;font-family:Calibri;font-size:10pt;}
.s1{color:black;}
.s2{color:black;text-decoration:underline;}
.Noprint{text-align:center;} 
</style>
<script language="javascript" type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
window.returnValue = s; 
var LODOP; //声明为全局变量
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
		
		LODOP.PRINT_INITA(0,0,"210mm","297mm","系统_食品经营_打印");
		LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
 		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",document.getElementById("page1").innerHTML);
		
	};	

</script>
<meta content="flame" name="author">

 <jsp:include page="${contextPath}/inc.jsp"></jsp:include>  
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>
</head>
<body class="b1 b2">
<div class="Noprint">
	<!-- 
    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
	<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
	-->
	<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
	<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
	<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
</div>
<br/>
<div align="center" id="page1" style="width: 80%;margin-left: 10%">
<table style="width: 80%;margin-left: 10%">
<tr>
<td style="border-bottom: 1px dotted #036">
<br>
<p class="p2" style="margin-right:-0.10625in;text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:18pt;font-weight: bold;">
<span class="s1" style="color:black;">《食品经营许可证》${type }申请准予通知书</span>
</p>
<p class="p3" style="margin-right:-0.10625in;text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:12pt;" >
<span class="s1" style="color:black;">（第一联由许可机关留存）</span>
</p>

</table>
</div>
</body>
</html>
