<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsajdczjbg9DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Zfwsajdczjbg9DTO dto=new Zfwsajdczjbg9DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsajdczjbg9DTO)request.getAttribute("printbean");
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
.s3{text-decoration: underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:3.2083333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height:30px;}
.p6{text-align:right;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
.s {
	text-decoration: underline;
}
</style>
<title>食品药品行政处罚文书</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件调查终结报告");
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:3.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5");   
	LODOP.ADD_PRINT_HTM("275mm","20mm", "RightMargin:1.8cm","100mm",
			strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5"); 
	
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
	<div align="center" id="title1">
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">案件调查终结报告 </span>
		</p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<!-- 标题除了第一页 -->
	<div align="center" id="title2">
		<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
				</p>
				<p class="p2">
				<span class="s1">(案件调查终结报告)副页</span>
				</p>
				<p class="page">
					<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
				</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	
	<div align="center" id="page1">
			<p class="p3">
			<span class="s2">案由：</span> 
			<span class="s2" style="width:570px;"> <%if (dto.getAjdjay() != null) { %>
			<%=dto.getAjdjay() %><%} %></span>
			</p>
			<p class="p3 l24" style="min-height: 100px;">
				<span class="s2">当事人基本情况：</span></br>
				<%if (dto.getDczjdsrjbqk() != null && !"".equals(dto.getDczjdsrjbqk())) { %> 
				<%=SysmanageUtil.replaceStrChuLast(dto.getDczjdsrjbqk())%><%} %></p>
			<p class="p4"></p>
			<p class="p3 l24"style="min-height: 100px;">
			<span class="s2">违法事实和证据：</span></br>
			<%if (dto.getDczjwfss() != null && !"".equals(dto.getDczjwfss())) { %> 
			<%=SysmanageUtil.replaceStrChuLast(dto.getDczjwfss())%><%} %></p>
			<p class="p4 l24">
			<% if(dto.getDczjcfyj() != null && !"".equals(dto.getDczjcfyj())){%>
			<span class="s2">处罚裁量等次：</span></br>
			<%=SysmanageUtil.replaceStrChuLast(dto.getDczjcfyj())%>
			</p>
			<%} %>
			<p class="p4 l24"style="min-height: 100px;">
			<span class="s2">处罚依据及建议:</span></br>
			<% if(dto.getDczjcfjy() != null && !"".equals(dto.getDczjcfjy())){%>
			<%=SysmanageUtil.replaceStrChuLast(dto.getDczjcfjy()) %><%} %>
			</p>
		</div>
		<div id="footer">
			<p class="p6">
			<span class="s2">案件承办人：___________、__________</span>
			</p>
			<p class="p6">
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			</p> 
		</div>
</body>
</div> 
</html>
