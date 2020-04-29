<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscssbfhyjs35DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 陈述申辩复核意见书
	Zfwscssbfhyjs35DTO dto = new Zfwscssbfhyjs35DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwscssbfhyjs35DTO) request.getAttribute("printbean");
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
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{margin-top:0.06944445in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:2.9895833in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:3.4270833in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:end;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:0.29166666in;}
</style>

<title>陈述申辩复核意见书</title>
<meta content="X" name="author">

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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——陈述申辩复核意见书");
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
		<p class="p2"><span class="s1">陈述申辩复核意见书</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s2">案由：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getAjdjay() != null) { %> <%=dto.getAjdjay()%><%} %></span> 
		</p>
		<p class="p4">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 200px;">
			<%if (dto.getSbfhdsr() != null) { %> <%=dto.getSbfhdsr()%><%} %></span> 
	         <span class="s2">法定代表人（负责人）：</span>
          	<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getSbfhfddbr() != null) { %> <%=dto.getSbfhfddbr()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">拟处罚意见：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getSbfhncfyj() != null) { %> <%=dto.getSbfhncfyj()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">陈述申辩基本情况：</span>
		</p>
		<p class="l24" style="min-height: 100px;">
			<%if(dto.getSbfhcssbjbqk() != null && !"".equals(dto.getSbfhcssbjbqk())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSbfhcssbjbqk())%><%}%>
		</p>
		<br><br>
		<p class="p4">
			<span class="s2">附件：陈述申辩笔录</span>
		</p>
		<br><br>
		<p class="p4">
			<span class="s2">复核意见：</span>
		</p>
		<p class="p4  l24" style="min-height: 30px;">
			<%if(dto.getSbfhbmyj() != null && !"".equals(dto.getSbfhbmyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSbfhbmyj())%><%}%>
		</p>
		<br><br><br>
		<div align="right">
			<p class="p7">
				<span class="s2">负责人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;"></span>
				<span class="s2"></span>
			</p>
			<br>
			<p class="p8">
				<span class="s2">
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span> 		
				</span>
			</p>
		</div>	
	</div>	
</body>
</div>
</html>
