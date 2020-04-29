<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwssxfzajyss5DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int page_number=1;

Zfwssxfzajyss5DTO localZfwsajlydjbDTO=new Zfwssxfzajyss5DTO();
if (request.getAttribute("printbean") != null) {
	localZfwsajlydjbDTO = (Zfwssxfzajyss5DTO) request.getAttribute("printbean");
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
.s3{font-size:10pt;color:black;}
.s4{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-right:0.038194444in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.07152778in;margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.36458334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.33333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:16pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.fr{float:right;}
.l24{line-height: 30px;}
</style>
<title>涉嫌犯罪案件移送书</title>
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
	//CreatePrintPage();
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
	  for (j = 1; j <=3; j++) { 
		CreatePrintPage(j);	 
				}; 			
	  	LODOP.PREVIEW();		
};

//直接打印
function printData(){	
    LODOP=getLodop();	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
		CreatePrintPage(j);	 
  	LODOP.PRINT();		
};

//打印维护
function printSetup() {	
    LODOP=getLodop();	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 	
	CreatePrintPage();
	LODOP.PRINT_SETUP();		
};

//打印设计
function printDesign() {
    LODOP=getLodop();	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 		
	CreatePrintPage();
	LODOP.PRINT_DESIGN();		
};
	
function CreatePrintPage(j) {
	//LODOP=getLodop(); 
	LODOP.NewPage(); 
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	/* LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 */
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("220mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
    LODOP.ADD_PRINT_HTM("250mm","20mm","85%","100%","注：抄送  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人民检察院，存档 （1）。");
    LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("220mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
    LODOP.ADD_PRINT_HTM("250mm","20mm","85%","100%","注：抄送  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人民检察院，存档 （2）。");
   // LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none">
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
<div align="center" id="page1">
		    <p class="p1">
		<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
		<span class="s1">涉嫌犯罪案件移送书</span>
		</p>
		
		<p class="p3">
		<span class="s2 fr"><%=localZfwsajlydjbDTO.getWsbh()%></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p4">
		<span class="s2"><span class="s4"><%=localZfwsajlydjbDTO.getSysbmmc()%></span>公安局：</span>
		</p>
		<p class="p5">
		<span class="s2"><span class="s4"><%=localZfwsajlydjbDTO.getDsr()%>
		                 </span>
		<%=localZfwsajlydjbDTO.getSxfzxw()%></span>
		</p>
		<p class="p7"></p>
		<p class="p8">
		<span class="s2 l24">附件：<%=localZfwsajlydjbDTO.getFujian()%> </span>
		</p>
		<p class="p7"></p>
	</div>	 
	 <div id="footer">
		<p class="p10 fr" style="margin-right: 80px"> 
		（公    章） 
		</p>
		<p style="clear:both;"></p>
		<p class="p11 fr">
		<span class="s2">
		<%if(!"".equals(localZfwsajlydjbDTO.getYsrq())&&
		localZfwsajlydjbDTO.getYsrq().length()>=10) {%>
		<%=localZfwsajlydjbDTO.getYsrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getYsrq().substring(5,7)%>月<%=localZfwsajlydjbDTO.getYsrq().substring(8,10)%>日
		<%}else {%> &nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日<%} %>
		</span>
		</p>  
		<!-- <hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;"> -->
		</p> 
		</div> 

    </body>
</div>

</html>
