<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwstzgzs22DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwstzgzs22DTO dto = new Zfwstzgzs22DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwstzgzs22DTO)request.getAttribute("mybean");
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
.p3{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.36458334in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:4.1666665in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:2.9895833in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24 {line-height: 24px;}
</style>
<title>听证告知书</title>
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
	
})

//打印预览 
function printView(){	
	LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——听证告知书");
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
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,8,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPage();//强制分页
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,8,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
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
		<span class="s1">听证告知书</span>
		</p>
		<p class="p3">
			<span class="s2"><%if(dto.getTzgzwsbh() != null){ %>
			<%=dto.getTzgzwsbh()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<span class="s2">
			<%=StringHelper.myMakeStrLen(dto.getTzgzdsr(), 30, 0)%>：</span>
		</p>
		<p class="p5 l24">
			<span class="s2">你(单位)</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(dto.getTzgzwfxwms(), 80, 0)%></span>
			<span class="s2">的行为，违反了</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(dto.getTzgzwfflfg(), 60, 0)%></span>
			<span class="s2">的规定。</span>
		</p>
		<p class="p5 l24">
			<span class="s2">依据</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(dto.getTzgzyjflfg(), 60, 0)%></span>
			<span class="s2">的规定，拟对你(单位)进行以下行政处罚：</span>
		</p>
		<p class="p5 l24">
			<%if(dto.getTzgzxzcf() != null && !"".equals(dto.getTzgzxzcf() != null)){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getTzgzxzcf())%><%} else {%>
				<br>
				<br>
				<br>
			<%} %>
		</p>
		<p class="p5">
			<span class="s2">根据《中华人民共和国行政处罚法》第四十二条第一款的规定，你(单位)有权要求举行听证。</span>
		</p>
		<p class="p5">
			<span class="s2">如你(单位)要求听证，应当在收到本告知书后3日内告之我局。逾期视为放弃听证权利。</span>
		</p>
		<p class="p7">
			<span class="s2">地    址：<%if(dto.getGzgzdz() != null){ %>
			<%=dto.getGzgzdz()%><%} %></span>
		</p>
		<p class="p7">
			<span class="s2">邮政编码：<%if(dto.getGzgzyzbm() != null){ %>
			<%=dto.getGzgzyzbm()%><%} %></span>
		</p>
		<p class="p7">
			<span class="s2">联系电话：<%if(dto.getGzgzlxdh() != null){ %>
			<%=dto.getGzgzlxdh()%><%} %></span>
		</p>
		<p class="p7">
			<span class="s2">联 系 人：<%if(dto.getGzgzlxr() != null){ %>
			<%=dto.getGzgzlxr()%><%} %></span>
		</p>
	</div>
	<div id="footer" align="right">
		<p class="p6">
		<span class="s2">（公    章）</span>
		</p>
		<br/>
		<p class="p6">
		<span class="s2">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
		   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
		   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日 
   		</span>
		</p>
	</div>
</body>
</div>
</html>