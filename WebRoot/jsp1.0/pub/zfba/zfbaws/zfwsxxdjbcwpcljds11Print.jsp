<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxxdjbcwpcljds11DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwsxxdjbcwpcljds11DTO dto=new Zfwsxxdjbcwpcljds11DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwsxxdjbcwpcljds11DTO)request.getAttribute("mybean");
}	

%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s3{color:black;}
.s4{font-size:16pt;color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;margin-top:0.034722224in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.36458334in;margin-left:0.072916664in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.36458334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.36458334in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align:right;}
.lh30{line-height:30px;}
</style>
<title>先行登记保存物品处理决定书</title>
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
	
})

//打印预览 
function printView(){	
	LODOP=getLodop();
    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——先行登记保存物品处理决定书");
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
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,703,10,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPageA();//强制分页
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,703,10,131, "第    二    联");  
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
		<span class="s1">品药品行政处罚文书</span>
		</p>
		<p class="p2">
		<span class="s1">先行登记保存物品处理决定书</span>
		</p>
		<p class="p3 tr">
		<span class="s2"><%if(dto.getXxclwsbh() != null){ %>
		<%=dto.getXxclwsbh()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
		<span class="s3"><%=StringHelper.myMakeStrLen(dto.getXxcldsr(),0,0) %>：</span>
		</p>
		<p class="p5 lh30">
		<span class="s3">依据《中华人民共和国行政处罚法》第三十七条第二款的规定，本机关对
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			<%=dto.getXxcltzswsbh() %>
			《先行登记保存物品通知书》中《先行登记保存物品清单》载明的物品，作出以下处理决定：</span>
		</p>
		<p class="p6 lh30">
			<span class="s3" style="text-indent:0in; width:610px; word-wrap:break-word;word-break:normal;display: inline-block;">
			<%if(dto.getXxclwbnr() != null){ %>
			<%=SysmanageUtil.replaceStrChuLast(dto.getXxclwbnr()) %><%} %></span>
		</p>
		<p class="p7"></p>
		<p class="p7"></p>
		<p class="p7"></p>
		<p class="p8 lh30">
			<span class="s3">附件：<%=dto.getXxclfjxx()%></span>
		</p>
		<p class="p9"></p>
		<p class="p6">
		<span class="s3">                                                    </span>
		</p>
		<br/><br/><br/>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p11">
		</p>
		<p class="p12"></p>
	</div>
	<div id="footer">
		<p class="p10 tr">
		<span class="s3">（公    章）&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</p>
		<br/>
		<p class="p10 tr">
		<span class="s3">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
		</span>
		</p>
	</div>
</html>
