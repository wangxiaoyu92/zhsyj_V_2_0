<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxxclwptzs16DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	// 执法文书先行处理物品通知书
	Zfwsxxclwptzs16DTO dto = new Zfwsxxclwptzs16DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsxxclwptzs16DTO) request.getAttribute("printbean");
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
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.36458334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:2.7881944in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-right:0.29166666in;margin-top:0.108333334in;text-align:center;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-indent:4.0631943in;margin-right:0.29166666in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-indent:0.06944445in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 34px;}
</style>

<title>先行处理物品通知书</title>
<meta content="X" name="author">

<jsp:include page="${path}/inc.jsp"></jsp:include>
<script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 
		pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>

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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——先行处理物品通知书");
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTML("220mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPage();//强制分页
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTML("220mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
}
</script>
</head>
<div style="width: 210mm; margin: 0 auto; display: none;">
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
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">先行处理物品通知书</span></p>
		<div align="right">
			<p class="p3">
				<span class="s2"><%if (dto.getXxclwsbh() != null) { %>
				<%=dto.getXxclwsbh() %><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<%if (dto.getXxcldsr() != null && !"".equals(dto.getXxcldsr())) { %>
			<span class="s2"> <%=dto.getXxcldsr()%>:</span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>:
			<%} %>
		</p>
		<p class="p5 l24">
			<span class="s2">我局于</span>
			<%if(dto.getXxclcfkyrq() != null && !"".equals(dto.getXxclcfkyrq())){ %>
			<span class="s2"><%=dto.getXxclcfkyrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getXxclcfkyrq() != null && !"".equals(dto.getXxclcfkyrq())){ %>
			<span class="s2"><%=dto.getXxclcfkyrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getXxclcfkyrq() != null && !"".equals(dto.getXxclcfkyrq())){ %>
			<span class="s2"><%=dto.getXxclcfkyrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
			<span class="s2">以</span>
			<%if(dto.getXxclcfkyjdsbh() != null && !"".equals(dto.getXxclcfkyjdsbh())){ %>
			<span class="s2"><%=dto.getXxclcfkyjdsbh()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span><%} %>
			<span class="s2">《查封（扣押）决定书》查封（扣押）了你（单位）的物品。为防止造成不必要的损失，
			根据《食品药品行政处罚程序规定》第二十九条第二款的规定，本局决定对</span>
			<%if(dto.getXxclwplb() != null && !"".equals(dto.getXxclwplb())){ %>
			<span class="s2"><%=dto.getXxclwplb()%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span><%} %>
			<span class="s2">物品予以先行处理。</span>
		</p>
		<p class="p6">
			<span class="s2">处理方式：<%if(dto.getXxclclfs() != null){ %>
			<%=dto.getXxclclfs()%><%} %></span>
		</p>
		<p class="p7"></p>
		<p class="p6">
			<span class="s2">附件：<%if(dto.getXxclfj() != null){ %>
			<%=dto.getXxclfj()%><%} %></span>
		</p>
	<div align="right" >
	     <br>
	     <br>
	     <br>
		<p class="p9">
			<span class="s2">（公   章）&nbsp;&nbsp;&nbsp;</span>
		</p>
		<br>
		<p class="p9">
			<span class="s2">
				 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			</span>
		</p>
		<br><br><br>
		<p class="p7">
			   <span class="s2">当事人签字：_______________</span>
			   <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			     <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			</p>
	  </div> 
	</div>
</body>
</div>
</html>
