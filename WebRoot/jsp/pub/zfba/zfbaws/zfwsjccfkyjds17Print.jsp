<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsjccfkyjds17DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int page_number=1;
String ajly ="";

String v_jdjc="../../images/pub/feiduihao.jpg";
String v_tsjb="../../images/pub/feiduihao.jpg";
String v_sjjb="../../images/pub/feiduihao.jpg";
String v_xjbq="../../images/pub/feiduihao.jpg";
String v_jdcy="../../images/pub/feiduihao.jpg";
String v_ys="../../images/pub/feiduihao.jpg";
String v_qt="../../images/pub/feiduihao.jpg";

Zfwsjccfkyjds17DTO localZfwsajlydjbDTO=new Zfwsjccfkyjds17DTO();
if (request.getAttribute("mybean") != null) {
	localZfwsajlydjbDTO = (Zfwsjccfkyjds17DTO)request.getAttribute("mybean");
}	

%>
<%
String v_duihao="☑";
String v_kong="□";
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
<title>接触查封（扣押）决定书</title>
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
	//LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	//LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTML("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("200mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.ADD_PRINT_HTML("240mm","20mm","85%","100%","注：正文3号仿宋体字，存档（1）。");
    LODOP.NewPage();
	LODOP.ADD_PRINT_HTML("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("200mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.ADD_PRINT_HTML("240mm","20mm","85%","100%","注：正文3号仿宋体字，存档（2）。");
}
</script>

</head>
	<div style="width: 210mm; margin: 0 auto;display: none">
	    <body class="b1 b2">
	    <%-- <input id="zfwslydjid" name="zfwslydjid" type="hidden" value="<%=v_zfwslydjid %>" /> --%>
	<div class="Noprint">
		<!-- 
	    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
		<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
		-->
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<div align="center" id="page<%=page_number %>">
	<p class="p1">
		<span class="s1">食品药品行政处罚文书</span>
	</p>
	<p class="p2">
		<span class="s1">解除查封（扣押）决定书</span>
	</p>
	<p class="p3">
		<span class="s2"><%=localZfwsajlydjbDTO.getJckywsbh()%></span>
	</p>
	<hr style="height:2px;border:none;border-top:2px solid #555555;">
	<p class="p4">
		<span class="s3"><%=localZfwsajlydjbDTO.getJckydsr()%>：</span>
	</p>
	<p class="p5">
		<span class="s2 lh30">我局于<span class="s3"><%=localZfwsajlydjbDTO.getJckykyrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getJckykyrq().substring(5,7)%>月<%=localZfwsajlydjbDTO.getJckykyrq().substring(8,10)%>日</span>
		以<span class="s3"><%=localZfwsajlydjbDTO.getJckykybh()%></span>《查封（扣押）决定书》对<span class="s3"><%=localZfwsajlydjbDTO.getJckywpqdbh() %></span>《查封（扣押）物品清单》所列物品予以查封（扣押），现根据
		<%=localZfwsajlydjbDTO.getJckydjx()%>的规定，予以全部（或部分）解除查封（扣押）。</span>
	</p>
	<p class="p6"></p>
	<p class="p4">
		<span class="s2">附件:<%=localZfwsajlydjbDTO.getJckyfj()%>《解除查封（扣押）物品清单》</span>
	</p>
	<p class="p6"></p>
	<p class="p6"></p>
	<p class="p6"></p>
	<p class="p7"></p>
	<p class="p7"></p>
	</div>
<div id="footer">
	<p class="p8 tr">
		<span class="s2" style="margin-right: 80px">（公    章）</span>
		
	</p>
	<p class="p6">
		<span class="s2">
		<%if(!"".equals(localZfwsajlydjbDTO.getJckygzrq()) && localZfwsajlydjbDTO.getJckygzrq().length()>=10){ %>
		<%=localZfwsajlydjbDTO.getJckygzrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getJckygzrq().substring(5,7)%>月<%=localZfwsajlydjbDTO.getJckygzrq().substring(8,10) %>日
		<%}else{ %>
		    &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
		<%} %>
		</span>
	</p>
</div> 
  </body>
  </div>
</html>
