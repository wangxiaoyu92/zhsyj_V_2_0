<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxzcfwts42DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwsxzcfwts42DTO dto=new Zfwsxzcfwts42DTO();
if (request.getAttribute("printbean") != null) {
	dto = (Zfwsxzcfwts42DTO)request.getAttribute("printbean");
}	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;}
.s2{color:black;}
.s3{font-family:仿宋_GB2312;}
.p1{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p2{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p3{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p4{text-indent:0.44791666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p6{text-align:justify;hyphenate:auto;font-family:宋体;font-size:10pt;}
.p7{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p8{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10pt;}
.p9{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.l24{line-height: 30px;text-indent:2em;}
</style>
<title>陈述申辩笔录</title>
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
	LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——行政处罚委托书");
	LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "85%", "100%", strBodyStyle
				+ document.getElementById("page1").innerHTML);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none">
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
			<span class="s1">行政处罚委托书</span>
		</p>
		<p class="p2">
			<span><%if (dto.getZfwsbh() != null) { %> <%=dto.getZfwsbh()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p3">
			<span>委托机关：</span>
			<span class="s2"><%if (dto.getWtjg() != null) { %> <%=dto.getWtjg()%><%} %></span>
		</p>
		<p class="p3">
			<span>法定代表人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
			<%if (dto.getWtjgfrdb() != null) { %> <%=dto.getWtjgfrdb()%><%} %></span>
			<span>职务：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getWtjgfrdbzw() != null) { %> <%=dto.getWtjgfrdbzw()%><%} %></span>
			<span>单位地址：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getWtjgfrdbdwdz() != null) { %> <%=dto.getWtjgfrdbdwdz()%><%} %></span>
		</p>
		<p class="p3">
			<span>受委托机关：</span>
			<span class="s2"><%if (dto.getSwtjg() != null) { %> <%=dto.getSwtjg()%><%} %></span>
		</p>
		<p class="p3">
			<span>法定代表人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
			<%if (dto.getSwtjgfrdb() != null) { %> <%=dto.getSwtjgfrdb()%><%} %></span>
			<span>职务：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			<%if (dto.getSwtjgfrdbzw() != null) { %> <%=dto.getSwtjgfrdbzw()%><%} %></span>
			<span>单位地址：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getSwtjgfrdbdwdz() != null) { %> <%=dto.getSwtjgfrdbdwdz()%><%} %></span>
		</p>
		<p class="p3 l24">
			<span>根据</span>
			<%if (dto.getGjflfggd() != null && !"".equals(dto.getGjflfggd())) { %> 
			<span class="s2"><%=dto.getGjflfggd()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span><%} %>
			<span>的规定，经</span>
			<%if (dto.getJjmc() != null && !"".equals(dto.getJjmc())) { %> 
			<span class="s2"><%=dto.getJjmc()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>局与</span>
			<%if (dto.getJdwmc() != null && !"".equals(dto.getJdwmc())) { %> 
			<span class="s2"><%=dto.getJdwmc()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>(单位)研究，现由</span>
			<%if (dto.getYjmc() != null && !"".equals(dto.getYjmc())) { %> 
			<span class="s2"><%=dto.getYjmc()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>局委托</span>
			<%if (dto.getWtdwmc() != null && !"".equals(dto.getWtdwmc())) { %> 
			<span class="s2"><%=dto.getWtdwmc()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>(单位)实施：</span>
			<%if (dto.getCfsxssfw() != null && !"".equals(dto.getCfsxssfw())) { %> 
			<span><%=dto.getCfsxssfw()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span><%} %>
			<span>。委托期限自</span>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;">
			<%if(dto.getWtksrq() != null && !"".equals(dto.getWtksrq())){ %>
			<%=dto.getWtksrq().substring(0, 4)%><%} %></span>
			<span>年</span>
			<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;">
			<%if(dto.getWtksrq() != null && !"".equals(dto.getWtksrq())){ %>
			<%=dto.getWtksrq().substring(5, 7)%><%} %></span>
			<span>月</span>
			<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;">
			<%if(dto.getWtksrq() != null && !"".equals(dto.getWtksrq())){ %>
			<%=dto.getWtksrq().substring(8, 10)%><%} %></span>
			<span>日至</span>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;">
			<%if(dto.getWtjsrq() != null && !"".equals(dto.getWtjsrq())){ %>
			<%=dto.getWtjsrq().substring(0, 4)%><%} %></span>
			<span>年</span>
			<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;">
			<%if(dto.getWtjsrq() != null && !"".equals(dto.getWtjsrq())){ %>
			<%=dto.getWtjsrq().substring(5, 7)%><%} %></span>
			<span>月</span>
			<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;">
			<%if(dto.getWtjsrq() != null && !"".equals(dto.getWtjsrq())){ %>
			<%=dto.getWtjsrq().substring(8, 10)%><%} %></span>
			<span>日止。</span>
		</p>
		<p class="p3 l24">
			<span>委托期间，<%if (dto.getWtqjdwmc() != null && !"".equals(dto.getWtqjdwmc())) { %> 
			<%=dto.getWtqjdwmc()%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			(单位)必须以<%if (dto.getWtqjyjmc() != null && !"".equals(dto.getWtqjyjmc())) { %> 
			<%=dto.getWtqjyjmc()%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			局的名义，在委托范围内实施行政处罚，并接受
			<%if (dto.getJsjjdmc() != null && !"".equals(dto.getJsjjdmc())) { %> 
			<%=dto.getJsjjdmc()%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			局的监督；由此产生的法律后果，由
			<%if (dto.getYjcdmc() != null && !"".equals(dto.getYjcdmc())) { %> 
			<%=dto.getYjcdmc()%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			局承担。<%if (dto.getWtdw() != null && !"".equals(dto.getWtdw())) { %> 
			<%=dto.getWtdw()%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			(单位)不得将委托事项再委托。</span>
		</p>
		<br><br>
		<p class="p4">
			<span>法定代表人签字：
			<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block;"></span>
			法定代表人签字：<span style="border-bottom: 0px solid  white-space;display: inline-block;"></span></span>
		</p>
		<br>
		<p class="p4">
			<span>委托机关（印章）</span>
			<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block;"></span>
			<span>受委托单位（印章）</span>
		</p>
		<p class="p6">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
		</p>
	</div>	
</body>
</div>
</html>
