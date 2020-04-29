<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwssxfzajyss5DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwssxfzajyss5DTO dto=new Zfwssxfzajyss5DTO();
if (request.getAttribute("printbean") != null) {
	dto = (Zfwssxfzajyss5DTO) request.getAttribute("printbean");
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
.p3{margin-right:0.038194444in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.07152778in;margin-top:0.06944445in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;
	text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;margin-left:0.072916664in;margin-right:0.038194444in;
	text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.36458334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.33333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:16pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
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
    LODOP=getLodop();
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——涉嫌犯罪案件移送书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
	CreatePrintPage();	 
  	LODOP.PREVIEW();		
};

//直接打印
function printData(){	
    LODOP=getLodop();	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——涉嫌犯罪案件移送书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
	CreatePrintPage();	 
  	LODOP.PRINT();		
};

//打印维护
function printSetup() {	
    LODOP=getLodop();	
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——涉嫌犯罪案件移送书");
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
	
function CreatePrintPage() {
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
    LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
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
		<span class="s1">涉嫌犯罪案件移送书</span>
		</p>
		
		<p class="p3">
		<span class="s2 fr"><%if (dto.getWsbh() != null) { %> <%=dto.getWsbh()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p4">
		<span class="s2">
		<%if (dto.getSysbmmc() != null && !"".equals(dto.getSysbmmc())) { %> 
		<%=dto.getSysbmmc()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
		公安局：</span>
		</p>
		<p class="p5 l24">
		<span class="s2">
		<span class="s2">
		<%if (dto.getDsr() != null && !"".equals(dto.getDsr())) { %> 
		<%=dto.getDsr()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
		</span>
		涉嫌
		<span>
		<%if (dto.getSxfzxw() != null && !"".equals(dto.getSxfzxw())) { %> 
		<%=dto.getSxfzxw()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span><%} %>
		</span>
		一案，经初步调查，当事人涉嫌构成犯罪，根据《中华人民共和国行政处罚法》第二十二条、
		《行政执法机关移送涉嫌犯罪案件的规定》第三条的规定，现移送你单位依法查处。
		一案，经初步调查，当事人涉嫌构成犯罪，根据《中华人民共和国行政处罚法》第二十二条、《行政执法机关移送涉嫌犯罪案件的规定》第三条的规定，现移送你单位依法查处。</span>
		</p>
		<p class="p5 l24">根据《行政执法机关移送涉嫌犯罪案件的规定》第十二条的规定，
		我局将在接到你局立案通知书之日起3日内将涉案物品及与案件有关的其他材料移交你局。</p> 
		<p class="p5 l24">根据《行政执法机关移送涉嫌犯罪案件的规定》第八条的规定，
		你单位如认为当事人没有犯罪事实，或者犯罪事实显著轻微，不需要追究刑事责任，依法不予立案的，请说明理由，并书面通知我局，退回有关案卷材料。</p>   
		<p class="p7"></p>
		<p class="p5">
			<span>联系人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block; ">
			<%if (dto.getLxr() != null) { %> <%=dto.getLxr() %><%} %> </span>
			<span>联系电话：</span>
			<span><%if (dto.getLxdh() != null) { %> <%=dto.getLxdh() %><%} %></span>
		</p>
		<p class="p7"></p>
		<p class="p8">
		<span class="s2 l24">附件：
		<%if (dto.getFujian() != null) { %>
		<%=dto.getFujian()%><%} %> </span>
		</p>
		<p class="p7"></p>
		<br>
		<br>
		<p class="p10 fr" style="margin-right: 180px"> 
		（公    章） 
		</p> 
		<br>
		<br>
		<p class="p11 fr">
		 	<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
		</p>   
		</div> 
</body>
</div>
</html>
