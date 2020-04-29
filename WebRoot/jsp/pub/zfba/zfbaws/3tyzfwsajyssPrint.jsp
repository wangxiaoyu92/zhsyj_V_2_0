<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsajyss3DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 执法文书案件移送书
	Zfwsajyss3DTO dto = new Zfwsajyss3DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsajyss3DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{color:black;}
.s2{font-weight:bold;color:black;}
.s33{color:black;text-decoration:underline;}
.s3{border-bottom: 1px solid  black;width: 205px;display: inline-block;}
.p1{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p3{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p4{text-indent:3.1930556in;margin-right:0.06944445in;margin-top:0.108333334in;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt; }
.p5{text-indent:0.06944445in;margin-top:0.06944445in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2em;margin-left:0.072916664in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;line-height:1.5}
.p7{text-indent:0.29166666in;margin-top:0.21666667in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;height:80px;}
.p8{text-indent:0.36458334in;margin-top:0.21666667in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;
	font-size:10.5pt;margin-left:4.18in;}
.p10{text-indent:0.4375in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p111{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:400px;}
.p12{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:4.18in;}
.p13{text-indent:1.3125in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.l24{line-height: 24px;}
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件移送书");
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
		<span class="s1"></span>
		</p>
		<p class="p2">
		<span class="s2">食品药品行政处罚文书</span>
		</p>
		<p class="p3">
		<span class="s2">案件移送书</span>
		</p>
		<p class="p4">
		<span class="s1" style="float: right;"><%if (dto.getZfwsbh() != null) { %>
		<%=dto.getZfwsbh()%><%} %></span>
		</p></br>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p5">
		<span class="s1">
		<%if (dto.getAjysbmmc() != null && !"".equals(dto.getAjysbmmc())) { %> 
		<%=dto.getAjysbmmc()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span><%} %>：</span>
		</p>
		<p class="p6 l24">
		<span class="s1"></span>
		<%if (dto.getAjysms() != null && !"".equals(dto.getAjysms())) { %> 
		<%=dto.getAjysms()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 400px;display: inline-block;"></span><%} %>
		<span class="s1">一案，经调查，</span>
		<%if (dto.getAjysysyy() != null && !"".equals(dto.getAjysysyy())) { %> 
		<%= dto.getAjysysyy()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 400px;display: inline-block;"></span><%} %>
		<span class="s1">，根据《中华人民共和国行政处罚法》第</span>
		<%if (dto.getAjysdjt() != null && !"".equals(dto.getAjysdjt())) { %> 
		<%=dto.getAjysdjt()%><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span><%} %>
		<span class="s1">条的规定，现移送你单位处理。案件处理结果请函告我局。</span>
		</p>
		<p class="p7"></p>
		<p class="p8">
		<span class="s1">附件：案情简介及有关材料<%if(dto.getAjysclzs() != null && !"".equals(dto.getAjysclzs())){ %>
		<%=dto.getAjysclzs()%><%} else{%>____<%} %>件。                                             </span>
		</p>
		<p class="p8"></p>
		<p class="p12">
		<span class="s1">（公    章）</span>
		</p>
		<p class="p11"></p>
		<p class="p9"> 
		<span class="s1"><span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日</span>
		</p>
	</div>
</body>
</div>
</html>
