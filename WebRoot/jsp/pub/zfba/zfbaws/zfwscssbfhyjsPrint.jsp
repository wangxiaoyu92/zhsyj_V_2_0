<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscssbfhyjs35DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 陈述申辩复核意见书
	Zfwscssbfhyjs35DTO localZfwscssbfhyjs35DTO = new Zfwscssbfhyjs35DTO();
    if (request.getAttribute("printbean") != null) {
    	localZfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO) request.getAttribute("printbean");
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
	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
	<div class="Noprint">
		<!-- 
	    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
	    	class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
		<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
			class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
		-->
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" 
			class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" 
			class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" 
			class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>	
	<div align="center" id="page1">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">陈述申辩复核意见书</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s2">案&nbsp;&nbsp;由：<%=localZfwscssbfhyjs35DTO.getAjdjay()%></span>
		</p>
		<p class="p4">
			<span class="s2">当事人：<%=StringHelper.myMakeStrLen(
				localZfwscssbfhyjs35DTO.getCommc(),50,0)%>
		                   法定代表人（负责人）：<%=localZfwscssbfhyjs35DTO.getComfrhyz()%>
			</span>
		</p>
		<p class="p4">
			<span class="s2">拟处罚意见：<%=localZfwscssbfhyjs35DTO.getSbfhncfyj()%></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">陈述申辩基本情况：</span>
		</p>
		<p class="p4 l24">
			<%=localZfwscssbfhyjs35DTO.getSbfhcssbjbqk()%>
		</p>
		<p class="p4">
			<span class="s2">附件：陈述申辩笔录</span>
		</p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4">
			<span class="s2">复核部门意见：</span>
		</p>
		<p class="p4  l24">
			<%=localZfwscssbfhyjs35DTO.getSbfhbmyj()%>
		</p>
		<div align="right">
			<p class="p7">
				<span class="s2">负责人：<%=localZfwscssbfhyjs35DTO.getSbfhfzrqz()%>（签字）</span>
			</p>
			<p class="p8">
				<span class="s2">
					<%=localZfwscssbfhyjs35DTO.getSbfhfzrqzrq().substring(0,4)%>年
					<%=localZfwscssbfhyjs35DTO.getSbfhfzrqzrq().substring(5,7)%>月
					<%=localZfwscssbfhyjs35DTO.getSbfhfzrqzrq().substring(8,10)%>日
				</span>
			</p>
		</div>	
	</div>	
</body>
</div>
</html>
