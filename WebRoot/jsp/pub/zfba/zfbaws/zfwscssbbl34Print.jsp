<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwscssbbl34DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwscssbbl34DTO dto=new Zfwscssbbl34DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwscssbbl34DTO)request.getAttribute("mybean");
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
.p3{margin-right:0.11111111in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:-0.12361111in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——陈述申辩笔录");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:4.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
  	 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5"); 
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
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">陈述申辩笔录</span></p>
		<p class="page" align="right">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<!-- 标题除了第一页 -->
	<div align="center" id="title2">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">(陈述申辩笔录)副页</span></p>
		<p class="page" align="right">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">
			<p class="p4">
				<span class="s2">案由：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getAjdjay() != null) { %> <%=dto.getAjdjay()%><%} %></span> 
			</p>
			<p class="p4">
				<span class="s2">当事人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getCssbdsr() != null) { %> <%=dto.getCssbdsr()%><%} %></span> 
			</p>
			<p class="p4">
				<span class="s2">陈述申辩人：</span> 
				<span style="border-bottom: 0px solid  white-space;width: 270px;display: inline-block;">
				<%if (dto.getCssbr() != null) { %> <%=dto.getCssbr()%><%} %></span> 
				<span>联系方式：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getCssbrlxfs() != null) { %> <%=dto.getCssbrlxfs()%><%} %></span> 
			</p>
			<p class="p4">
				<span class="s2">委托代理人：</span>
				<span style="border-bottom: 0px solid  white-space;width: 110px;display: inline-block;">
				<%if (dto.getCssbwtdlr() != null) { %> <%=dto.getCssbwtdlr()%><%} %></span> 
				<span>职务：</span>
				<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;">
				<%if (dto.getCssbwtdlrzw() != null) { %> <%=dto.getCssbwtdlrzw()%><%} %></span>
			    <span>身份证号：</span>
			    <span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getCssbwtdlrsfzh() != null) { %> <%=dto.getCssbwtdlrsfzh()%><%} %></span>
			</p>
			<p class="p4">
				<span class="s2">承办人：</span>
				<span style="border-bottom: 0px solid  white-space;width: 230px;display: inline-block;">
				<%if (dto.getCssbcbr() != null) { %> <%=dto.getCssbcbr()%><%} %></span>
				<span>记录人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;">
				<%if (dto.getCssbjlr() != null) { %> <%=dto.getCssbjlr()%><%} %></span>
			</p>
			<p class="p5">
				<span class="s2">陈述申辩地点：</span>
				<span style="border-bottom: 0px solid  white-space;width: 190px;display: inline-block;">
				<%if (dto.getCssbdd() != null) { %> <%=dto.getCssbdd()%><%} %></span>
	      		<span>时间：</span>
	      		<%if(dto.getCssbsj() != null && !"".equals(dto.getCssbsj())){ %>
				<span class="s2"><%=dto.getCssbsj().substring(0, 4)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">年</span>
				<%if(dto.getCssbsj() != null && !"".equals(dto.getCssbsj())){ %>
				<span class="s2"><%=dto.getCssbsj().substring(5, 7)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">月</span>
				<%if(dto.getCssbsj() != null && !"".equals(dto.getCssbsj())){ %>
				<span class="s2"><%=dto.getCssbsj().substring(8, 10)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">日</span>
				<%if(dto.getCssbsj() != null && !"".equals(dto.getCssbsj())){ %>
				<span class="s2"><%=dto.getCssbsj().substring(11,13)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">时</span>
				<%if(dto.getCssbsj() != null && !"".equals(dto.getCssbsj())){ %>
				<span class="s2"><%=dto.getCssbsj().substring(14,16)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">分到</span>
				<%if(dto.getCssbjzsj() != null && !"".equals(dto.getCssbjzsj())){ %>
				<span class="s2"><%=dto.getCssbjzsj().substring(11,13)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">时</span>
				<%if(dto.getCssbjzsj() != null && !"".equals(dto.getCssbjzsj())){ %>
				<span class="s2"><%=dto.getCssbjzsj().substring(14,16)%></span><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 20px;display: inline-block;"></span><%} %>
				<span class="s2">分</span>
			</p>
			<p class="p5">
				<span class="s2">陈述申辩内容：</span>
			</p>
			<p class="p5" style="min-height: 200px; line-height: 24px;">
				<%if(dto.getCssbnr() != null && !"".equals(dto.getCssbnr())){ %>
				<span class="s2"><%=SysmanageUtil.replaceStrChuLast(dto.getCssbnr())%></span><%}%>
			</p>
		</div>
		<div id="footer">
			<p class="p4">
				<span class="s2">陈述申辩人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 150px;"></span> 
				<span>承办人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 150px;"></span> 
				<span>记录人：</span>
				<span style="border-bottom: 0px solid  white-space;display: inline-block;"></span>
			</p>
			<p class="p6"> 
				<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 10px;"></span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
		   		<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 50px;"></span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
		   		<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 50px;"></span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日 
			</p> 
		</div>	
	</body>
</div>
</html>
