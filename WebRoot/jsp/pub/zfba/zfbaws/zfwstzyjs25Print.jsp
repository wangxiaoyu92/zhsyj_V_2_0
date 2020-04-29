<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwstzyjs25DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwstzyjs25DTO dto=new Zfwstzyjs25DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwstzyjs25DTO)request.getAttribute("mybean");
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
.s3{color:black;text-decoration: underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2.6388888in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.p5{line-height: 24px;}
.s44{text-indent:2em;}
.tr{text-align: right;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
</style>
<title>听证意见书</title>
<meta content="X" name="author">

<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>

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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——听证意见书");
	
	LODOP.ADD_PRINT_HTM("60mm","20mm","RightMargin:1.8cm","BottomMargin:4.4cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
			strBodyStyle + document.getElementById("title1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", 1);
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
			strBodyStyle + document.getElementById("title2").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "2,3,4");
	LODOP.ADD_PRINT_HTM("260mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5");   
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
	<!-- 标题第一页 -->
	<div align="center" id="title1">
		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s1">听证意见书</span>
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
			<span class="s1">(听证意见书)副页</span>
		</p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">
		<p class="p3">
			<span class="s2">案 由：</span>
			<span class="s2"><%if (dto.getAjdjay() != null) { %>
			<%=dto.getAjdjay()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 275px;display: inline-block;">
			<%if (dto.getTzyjdsr() != null) { %><%=dto.getTzyjdsr() %><%} %></span>
			<span class="s2">法定代表人（负责人）：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getTzyjfddbr() != null) { %><%=dto.getTzyjfddbr() %><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">听证时间：</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzkssj() != null && !"".equals(dto.getTzyjtzkssj())){ %>
			<%=dto.getTzyjtzkssj().substring(0, 4)%><%} %></span>
			<span>年</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzkssj() != null && !"".equals(dto.getTzyjtzkssj())){ %>
			<%=dto.getTzyjtzkssj().substring(5, 7)%><%} %></span>
			<span>月</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzkssj() != null && !"".equals(dto.getTzyjtzkssj())){ %>
			<%=dto.getTzyjtzkssj().substring(8, 10)%><%} %></span>
			<span>日</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzkssj() != null && !"".equals(dto.getTzyjtzkssj())){ %>
			<%=dto.getTzyjtzkssj().substring(11, 13)%><%} %></span>
			<span>时</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzkssj() != null && !"".equals(dto.getTzyjtzkssj())){ %>
			<%=dto.getTzyjtzkssj().substring(14, 16)%><%} %></span>
			<span class="s2">分至</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzjssj() != null && !"".equals(dto.getTzyjtzjssj())){ %>
			<%=dto.getTzyjtzjssj().substring(11, 13)%><%} %></span>
			<span>时</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 30px">
			<%if(dto.getTzyjtzjssj() != null && !"".equals(dto.getTzyjtzjssj())){ %>
			<%=dto.getTzyjtzjssj().substring(14, 16)%><%} %></span>
			<span class="s2">分</span>
		</p>
		<p class="p4">
			<span class="s2">听证主持人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block;">
			<%if (dto.getTzyjtzzcr() != null) { %><%=dto.getTzyjtzzcr() %><%} %></span>
	        <span class="s2">听证方式：</span>
	        <span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getTzyjtzfs() != null) { %><%=dto.getTzyjtzfs() %><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p5">
		<span class="s2">案件基本情况：</span>
		</p>
		<p class="p5 s44" style="min-height: 80px;">
			<%if(dto.getTzyjajjbqk() != null && !"".equals(dto.getTzyjajjbqk())){ %>
			<%=SysmanageUtil.replaceStrChuLast(dto.getTzyjajjbqk())%><%} %>
		</p>
		<p class="p5" style="width:640px; word-wrap:break-word;word-break:normal;display: inline-block;">
			<span class="s2">申请人主要理由：</span>
		</p>
		<p class="p5 s44"style="min-height: 80px;">
			<%if(dto.getTzyjsqrzyly() != null){ %>
			<%=SysmanageUtil.replaceStrChuLast(dto.getTzyjsqrzyly())%><%} %>
		</p>
		<p class="p5">
			<span class="s2">听证意见：</span>
		</p>
		<p class="p5 s44" style="min-height: 80px;"">
			<%if(dto.getTzyj() != null){ %> 
			<%=SysmanageUtil.replaceStrChuLast(dto.getTzyj())%><%} %>
		</p>
	</div>
	<div id="footer">
		<p class="p3 tr">
			<span class="s2">听证主持人签字：</span>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
		</p>
		<p class="p3 tr">
		<span class="s2">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
	   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
	   		<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 50px;"></span>
		</span>
		</p>
	</div>
</body>
</div>
</html>
