<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsjccfkyjds17DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwsjccfkyjds17DTO dto=new Zfwsjccfkyjds17DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwsjccfkyjds17DTO)request.getAttribute("mybean");
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
.s3{text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{line-height:24px;text-indent:0.29166666in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:3.8645833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-right:0.36458334in;margin-top:0.108333334in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.072916664in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align:right;}
.lh30{line-height: 30px;}
</style>
<title>解除查封（扣押）决定书</title>
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
	s.type = "ok";       
	sy.setWinRet(s); 
var LODOP; //声明为全局变量

$(function(){	
	printView();
	parent.$("#"+sy.getDialogId()).dialog("close");
});

//打印预览 
function printView(){	
LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——解除查封（扣押）决定书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
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
		<span class="s1">解除查封（扣押）决定书</span>
	</p>
	<p class="p3">
		<span class="s2"><%if (dto.getJckywsbh() != null) { %>
		<%=dto.getJckywsbh()%><%} %></span>
	</p>
	<hr style="height:2px;border:none;border-top:2px solid #555555;">
	<p class="p4">
		<%if (dto.getJckydsr() != null && !"".equals(dto.getJckydsr())) { %>
			<span class="s2"> <%=dto.getJckydsr()%>:</span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>:
			<%} %>
	</p>
	<p class="p5 lh30">
		<span class="s2">我局于</span>
		<%if(dto.getJckykyrq() != null && !"".equals(dto.getJckykyrq())){ %>
		<span class="s2"><%=dto.getJckykyrq().substring(0, 4)%></span><%} else {%>
		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
		<span class="s2">年</span>
		<%if(dto.getJckykyrq() != null && !"".equals(dto.getJckykyrq())){ %>
		<span class="s2"><%=dto.getJckykyrq().substring(5, 7)%></span><%} else {%>
		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
		<span class="s2">月</span>
		<%if(dto.getJckykyrq() != null && !"".equals(dto.getJckykyrq())){ %>
		<span class="s2"><%=dto.getJckykyrq().substring(8, 10)%></span><%} else {%>
		<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
		<span class="s2">日以</span>
		<%if (dto.getJckykybh() != null && !"".equals(dto.getJckykybh())) { %>
		<span class="s2"><%=dto.getJckykybh()%></span><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
		<%} %>
		<span class="s2">《查封（扣押）决定书》对</span>
		<%if (dto.getJckywpqdbh() != null && !"".equals(dto.getJckywpqdbh())) { %>
		<span class="s2"> <%=dto.getJckywpqdbh()%></span><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
		<%} %>
		<span class="s2">《查封（扣押）物品清单》所列物品予以查封（扣押），现根据</span>
		<%if (dto.getJckydjx() != null && !"".equals(dto.getJckydjx())) { %>
		<span class="s2"> <%=dto.getJckydjx()%></span><%} else { %>
		<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span>
		<%} %>
		<span class="s2">的规定，予以全部（或部分）解除查封（扣押）。</span>
	</p>
	<p class="p4"> 
		<span class="s2">行政机关联系人:</span>
		<%if (dto.getJckyxzjglxr() != null) { %>
		<span style="border-bottom: 0px solid  white-space;width: 250px;display: inline-block;"><%=dto.getJckyxzjglxr()%></span><%}%>
		<span class="s2">联系电话:<%if (dto.getJckylxdh() != null) { %>
		<%=dto.getJckylxdh()%><%} %></span>
	</p>
	<p class="p4">
		<span class="s2">附件:<%if (dto.getJckyfj() != null) { %>
		<%=dto.getJckyfj()%><%} %>
		</span>
	</p> 
	<br>
	<br>
	<br>
	<p class="p8 tr">
		<span class="s2" style="margin-right: 80px">（公    章）</span>
		
	</p>
	<p class="p6">
		<span class="s2">
		    <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
	   		 <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
		</span>
	</p>
	<br>
	<br>
	<br>
	<p class="p5">
			   <span class="s2">当事人签字：_______________</span>
			   <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			   <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			</p>
</div> 
  </body>
  </div>
</html>
