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
.s1{color:black;}
.s2{font-weight:bold;color:black;}
.s3{text-decoration:underline;}
.s4{font-weight:bold;}
.p1{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p3{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p4{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29305556in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:2.40625in;margin-right:0.41666666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
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
		<p class="p2">
			<span class="s2">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
			<span class="s2">听证告知书</span>
		</p>
		<div align="right">
			<p class="p4">
				<span class="s1"><%if(dto.getTzgzwsbh() != null){ %>
				<%=dto.getTzgzwsbh()%><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p5">
			<span class="s3" style="width:240px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
			<%=StringHelper.myMakeStrLen(dto.getTzgzdsr(), 80, 0)%></span>:
		</p>
		<p class="p6 l24">
			<span>你（单位）于</span>
			<span class="s3">
			<%if(dto.getTzgzqsrq() != null && !"".equals(dto.getTzgzqsrq())){ %>
	    	<%=StringHelper.myMakeStrLen(dto.getTzgzqsrq().substring(0,4), 6, 1)%><%} else {%>
	    	<%=StringHelper.myMakeStrLen("", 6, 1)%><%} %>
			</span>
			<span>年</span>
			<span class="s3">
			<%if(dto.getTzgzqsrq() != null && !"".equals(dto.getTzgzqsrq())){ %>
			<%=StringHelper.myMakeStrLen(dto.getTzgzqsrq().substring(5,7), 4, 1)%><%} else {%>
			<%=StringHelper.myMakeStrLen("", 4, 1)%><%} %>
			</span>
			<span>月</span>
			<span class="s3">
			<%if(dto.getTzgzqsrq() != null && !"".equals(dto.getTzgzqsrq())){ %>
			<%=StringHelper.myMakeStrLen(dto.getTzgzqsrq().substring(8,10), 4, 1)%><%} else {%>
			<%=StringHelper.myMakeStrLen("", 4, 1)%><%} %>
			</span>
			<span>日至</span>
			
			<span class="s3">
			<%if(dto.getTzgzjsrq() != null && !"".equals(dto.getTzgzjsrq())){ %>
	    	<%=StringHelper.myMakeStrLen(dto.getTzgzjsrq().substring(0,4), 6, 1)%><%} else {%>
	    	<%=StringHelper.myMakeStrLen("", 6, 1)%><%} %>
			</span>
			<span>年</span>
			<span class="s3">
			<%if(dto.getTzgzjsrq() != null && !"".equals(dto.getTzgzjsrq())){ %>
			<%=StringHelper.myMakeStrLen(dto.getTzgzjsrq().substring(5,7), 4, 1)%><%} else {%>
			<%=StringHelper.myMakeStrLen("", 4, 1)%><%} %>
			</span>
			<span>月</span>
			<span class="s3">
			<%if(dto.getTzgzjsrq() != null && !"".equals(dto.getTzgzjsrq())){ %>
			<%=StringHelper.myMakeStrLen(dto.getTzgzjsrq().substring(8,10), 4, 1)%><%} else {%>
			<%=StringHelper.myMakeStrLen("", 4, 1)%><%} %>
			</span>
			<span>日</span>
			<span>，因</span>
			<span class="s3">
				<%=StringHelper.myMakeStrLen(dto.getTzgzwfxwms(), 80, 0)%></span>	
			<span>行为，违反了</span>
			<span class="s3">
				<%=StringHelper.myMakeStrLen(dto.getTzgzwfflfg(), 60, 0)%></span>
			<span>的规定。</span>
		</p>
		<p class="p7 l24">
			<span class="s4">违法行为等次：</span>
			<span>根据你（单位）违法行为的事实、性质、情节、社会危害程度和相关证据，
			你（单位）的违法行为为</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(dto.getTzgzwfxwdcstr(), 16, 0)%></span>
			<span class="s4">。</span>
		</p>
		<p class="p7 l24">
			<span class="s4">拟给予处罚的依据和种类：</span>
			<span>本机关依照</span>
			<span class="s3">
			<%=StringHelper.myMakeStrLen(dto.getTzgzyjflfg(), 40, 0)%></span>
			<span>的规定，拟对你（单位）作出下列行政处罚：</span>
		</p>
		<p class="p6 l24" style=" width:610px; word-wrap:break-word;word-break:normal;display: inline-block;">
			<%if(dto.getTzgzxzcf() != null){ %>
			<%=SysmanageUtil.replaceStrChuLast(dto.getTzgzxzcf())%><%} %>
		</p>
		<p class="p7 l24">
			<span class="s4">申请听证的期限：</span>
			<span>如你（单位）要求听证，应当自收到本告知书之日起三日内向我局提出申请。逾期视为放弃听证权利。</span>
		</p>
		<p class="p6">
			<span>联系人：
				<%=StringHelper.myMakeStrLen(dto.getGzgzlxr(), 14, 0)%></span>
			<span>电话：
				<%=StringHelper.myMakeStrLen(dto.getGzgzlxdh(), 12, 0)%></span>
			<span>地址：
				<%=StringHelper.myMakeStrLen(dto.getGzgzdz(), 20, 0)%></span>
		</p>
	</div>
	<div id="footer">
		<p class="p4">
		<span class="s2">（公    章）</span>
		</p>
		<br/>
		<p class="p4">
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
