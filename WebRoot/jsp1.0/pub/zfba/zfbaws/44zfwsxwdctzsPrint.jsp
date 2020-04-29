<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.ZfwsxwdctzsDTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int page_number=1; 
ZfwsxwdctzsDTO localZfwsxwdctzsDTO=new ZfwsxwdctzsDTO();
if (request.getAttribute("printbean") != null) {
	localZfwsxwdctzsDTO = (ZfwsxwdctzsDTO)request.getAttribute("printbean");
}	

%> 
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{line-height:24px;text-indent:0.29166666in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:3.8645833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-right:0.36458334in;margin-top:0.108333334in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.072916664in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align:right;}
.lh30{line-height: 30px;}
</style>
<title>询问调查通知书</title>
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
	
})

//打印预览 
function printView(){	
LODOP=getLodop();  
	//var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
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
	//LODOP=getLodop();  
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTML("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTML("240mm","20mm","85%","100%","注：正文3号仿宋体字，存档（1）。");
    LODOP.NewPage();
	LODOP.ADD_PRINT_HTML("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTML("200mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
	//LODOP.ADD_PRINT_HTML("240mm","20mm","85%","100%","注：正文3号仿宋体字，存档（2）。");
}
</script>

</head>
	<div style="width: 210mm; margin: 0 auto;display: none">
	    <body class="b1 b2">
	    <%-- <input id="zfwslydjid" name="zfwslydjid" type="hidden" value="<%=v_zfwslydjid %>" /> --%>
	<div class="Noprint"> 
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<div align="center" id="page<%=page_number %>">
	<p class="p1">
		<span class="s1">食品药品行政处罚文书</span>
	</p>
	<p class="p2">
		<span class="s1">询问调查通知书</span>
	</p>
	<p class="p3">
		<span class="s2"><%=localZfwsxwdctzsDTO.getXwdcsbh()%></span>
	</p>
	<hr style="height:2px;border:none;border-top:2px solid #555555;">
	<p class="p4">
		<span class="s3"><%=localZfwsxwdctzsDTO.getXwdcdsr()%></span>：
	</p>
	<p class="p5">
		<span class="s2">根据《中华人民共和国行政处罚法》第三十七条的规定，你有如实回答询问、协助调查的义务。为调查了解<span class="s2">
		<%=localZfwsxwdctzsDTO.getXwdczynr()%>，请你于
		<%if(localZfwsxwdctzsDTO.getXwdcjzrq().length()>=10){ %>
		<%=localZfwsxwdctzsDTO.getXwdcjzrq().substring(0,4)%>年
		<%=localZfwsxwdctzsDTO.getXwdcjzrq().substring(5,7)%>月
		<%=localZfwsxwdctzsDTO.getXwdcjzrq().substring(8,10)%>日
		<%}else{ %>
		 &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
		<%} %>
		</span>
		到<span class="s2"><%=localZfwsxwdctzsDTO.getXwdcxwdz()%></span>接受询问（调查），并携带以下资料<span class="s3">
		<%=localZfwsxwdctzsDTO.getXwdcxdzl() %></span>。</span>
	</p> 
	<p class="p5">
		<span class="s2">特此通知。</span>
	</p> 
	<br>
	<br>
	<br>
	<p class="p8 tr">
		<span class="s2" style="margin-right: 80px">（公    章）</span>
		
	</p>
	<p class="p6">
		<span class="s2">
		<%-- <%if(!"".equals(localZfwsxwdctzsDTO.getXwdcqzrq()) && localZfwsxwdctzsDTO.getXwdcqzrq().length()>=10){ %>
		<%=localZfwsxwdctzsDTO.getXwdcqzrq().substring(0,4)%>年<%=localZfwsxwdctzsDTO.getXwdcqzrq().substring(5,7)%>月<%=localZfwsxwdctzsDTO.getXwdcqzrq().substring(8,10) %>日
		<%}else{ %> --%>
		    &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
		<%-- <%} %> --%>
		</span>
	</p>
	<br>
	<br>
	<br>
	<p class="p5">
			   <span class="s2">当事人签字：_______________</span>
			   <%-- <span style="border-bottom: 1px solid  black;display: inline-block; width: 150px;">
			   <%=localZfwsxwdctzsDTO.getXwdcdsrqz()%></span>
			   <span> --%>
			    <%-- <%if(localZfwsxwdctzsDTO.getXwdcdsrqzrq().length() >= 10){ %>
			    <%=localZfwsxwdctzsDTO.getXwdcdsrqzrq().substring(0, 4)%> 年
			    <%=localZfwsxwdctzsDTO.getXwdcdsrqzrq().substring(5, 7)%> 月
			    <%=localZfwsxwdctzsDTO.getXwdcdsrqzrq().substring(8, 10)%> 日
			    <% }else{%> --%>
			        &nbsp;&nbsp;&nbsp; 年
			        &nbsp;&nbsp;&nbsp; 月
			        &nbsp;&nbsp;&nbsp; 日
			    <%--   <%} %> --%>
			   </span>  
			</p>
</div> 
  </body>
  </div>
</html>
