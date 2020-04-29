<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsdshz38DTO" %>
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

Zfwsdshz38DTO localZfwsajlydjbDTO=new Zfwsdshz38DTO();
if (request.getAttribute("mybean") != null) {
	localZfwsajlydjbDTO = (Zfwsdshz38DTO)request.getAttribute("mybean");
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
.s2{font-family:Times New Roman;font-weight:bold;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋;font-size:22pt;}
.p3{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:-1.6041666in;margin-left:1.6770834in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
</style>
<title>送达回执</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
}
</script>

</head>
	<div style="width: 210mm; margin: 0 auto;display: none">
	    <body class="b1 b2">
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
			<span class="s2">送达回执</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
			<p class="p3">
			<span class="s3">受送达单位（人）：<span style="border-bottom: 1px solid  black;text-align:left; width:520px;display: inline-block;"><%=localZfwsajlydjbDTO.getSdhzssddw()%></span></span>
			</p>
			<p class="p3">
			<span class="s3">送达文书名称及文书编号：<span style="border-bottom: 1px solid  black;text-align:left; width:480px;display: inline-block;"><%=localZfwsajlydjbDTO.getSdhzwsmcbh() %></span></span>
			</p>
			<!-- <p class="p4">
			<span class="s3">中检集团中原农产品检测（河南）有限公司的检验报告（CCICZY2015JD6376）</span>
			</p>
			<p class="p5"></p> -->
			
			<div style="width:320px;float:left;">
			<p class="p3">
			<span class="s3">送达方式：<span style="border-bottom: 1px solid  black;text-align:left; width:230px;display: inline-block;"><%=localZfwsajlydjbDTO.getSdhzsdfsstr() %> </span>            
			</span>
			</p>
			<p class="p3">
			<span class="s3">送达人：<span style="border-bottom: 1px solid  black;text-align:left; width:240px;display: inline-block;"> <%=localZfwsajlydjbDTO.getSdhzsdr() %> </span>        
			</span>
			</p>
			<p class="p3">
			<span class="s3">受送达单位（人）：<span style="border-bottom: 1px solid  black;text-align:left; width:170px;display: inline-block;"><%=localZfwsajlydjbDTO.getSdhzssddwqz() %></span>                 
			</span>
			</p>
			</div>
			
			<div style="width:320px;float:right;">
			<p class="p3">
			<span class="s3">送达地点：<span style="border-bottom: 1px solid  black;text-align:left; width:200px;display: inline-block;"><%=localZfwsajlydjbDTO.getSdhzsddd()  %></span></span>
			</p>
			<p class="p3">
			<span class="s3">送达日期:<span style="border-bottom: 1px solid  black;text-align:left; width:200px;display: inline-block;">
			<% if(!"".equals(localZfwsajlydjbDTO.getSdhzsdqzrq())&&localZfwsajlydjbDTO.getSdhzsdqzrq().length()>=16){ %>
			<%=localZfwsajlydjbDTO.getSdhzsdqzrq().substring(0,4) %>年
			<%=localZfwsajlydjbDTO.getSdhzsdqzrq().substring(5,7) %>月
			<%=localZfwsajlydjbDTO.getSdhzsdqzrq().substring(8,10) %>日
			<%=localZfwsajlydjbDTO.getSdhzsdqzrq().substring(11,13) %>时
			<%=localZfwsajlydjbDTO.getSdhzsdqzrq().substring(14,16) %>分
			<%}else{ %>
			  &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
			  &nbsp;&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;分
			<%} %>
			    </span>
			</span>
			</p>
			<p class="p3">
			<span class="s3">送达日期:<span style="border-bottom: 1px solid  black;text-align:left; width:200px;display: inline-block;">
			<%if(!"".equals(localZfwsajlydjbDTO.getSdhzssddwqzrq())&&localZfwsajlydjbDTO.getSdhzssddwqzrq().length()>=16){ %>
			<%=localZfwsajlydjbDTO.getSdhzssddwqzrq().substring(0,4) %>年
			<%=localZfwsajlydjbDTO.getSdhzssddwqzrq().substring(5,7) %>月
			<%=localZfwsajlydjbDTO.getSdhzssddwqzrq().substring(8,10) %>日
			<%=localZfwsajlydjbDTO.getSdhzssddwqzrq().substring(11,13) %>时
			<%=localZfwsajlydjbDTO.getSdhzssddwqzrq().substring(14,16) %>分
			<%}else{ %>
			  &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
			  &nbsp;&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;分
			<%} %>
			</span>
			</span>
			</p> 
			<p class="p6" style="height: 150;"></p> 
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
			<p class="p5">
			<span class="s3">备注：<%=localZfwsajlydjbDTO.getSdhzbz()%></span>
			</p> 
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>

			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p7"></p>
	</div>
	<div id="footer">
		  <hr style="height:2px;border:none;border-top:2px solid #555555;">
	</div>
		  </body>
		  </div> 
</html>
