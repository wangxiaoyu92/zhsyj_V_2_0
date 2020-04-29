<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxzcfsxgzs26DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,com.zzhdsoft.siweb.entity.sysmanager.Sysuser"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwsxzcfsxgzs26DTO dto=new Zfwsxzcfsxgzs26DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsxzcfsxgzs26DTO)request.getAttribute("mybean");
	}	
	Sysuser user = SysmanageUtil.getSysuser();
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{color:black; text-decoration: underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.308333334in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.308333334in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.35in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:4.0833335in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p15{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align:right;}
.lh30{line-height: 24px;}
</style>
<title>刑事处罚事先告知书</title>
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
window.returnValue = s; 
var LODOP; //声明为全局变量

$(function(){	
	printView();
	window.close();
});

//打印预览 
function printView(){	
	LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚事先告知书");
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
		<span class="s1">行政处罚事先告知书</span>
		</p>
		<p class="p3 tr">
		<span class="s2 "><%if(dto.getSxgzwsbh() != null){ %>
		<%=dto.getSxgzwsbh()%><%} %></span>
		</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
		<span class="s2"><%if(dto.getSxgzdsr() != null){ %>
		<%=dto.getSxgzdsr()%><%} %>&nbsp;&nbsp;:</span>
		</p>
		<p class="p5 lh30">
		<span class="s2">经查，你（单位）</span>
		<%if(dto.getSxgzwfxw() != null && !"".equals(dto.getSxgzwfxw())){ %>
		<span class="s3">
		<%=dto.getSxgzwfxw()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else {%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 60, 0) %></span><%} %>
		<span class="s2">的违法行为，违反了</span>
		<%if(dto.getSxgzwfgd() != null && !"".equals(dto.getSxgzwfgd())){ %>
		<span class="s3"><%=dto.getSxgzwfgd()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else {%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
		<span class="s2">的规定</span>
		<%if(!user.getAaa027().startsWith("4117")){ %>
		<span class="s2">。</span>
		</p>
		<p class="p5 lh30">
		<span class="s2">从你（单位）违法行为的事实、性质、情节、社会危害程度和证据看，你（单位）的违法行为属于</span>
		<%if(dto.getWfxwdcstr() != null && !"".equals(dto.getWfxwdcstr())){ %>
		<span class="s3"><%=dto.getWfxwdcstr()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 20, 0) %></span><%} %>。
		</p>
		<p class="p5 lh30">
		<%} else {%><span class="s2">,</span><%} %>
		<span class="s2">依据</span>
		<%if(dto.getSxgzyjgd() != null && !"".equals(dto.getSxgzyjgd())){ %>
		<span class="s3"><%=dto.getSxgzyjgd()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else {%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 50, 0) %></span><%} %>
		<span class="s2">的规定，我局拟对你（单位）进行以下行政处罚：</span>
		<span class="s2"><%if(dto.getSxgzxzcf() != null && !"".equals(dto.getSxgzxzcf())){ %>
		<%=SysmanageUtil.replaceStrChuLast(dto.getSxgzxzcf())%><%} else{%>
		<br><br><br><br><br><br><br><%} %>
		</span>
		</p>
		<p class="p6 lh30">
		<span class="s2">依据《中华人民共和国行政处罚法》第六条第一款、第三十一条规定，你（单位）可在收到本告知书之日起3日内到</span>
		<%if(dto.getSxgzcxdd() != null && !"".equals(dto.getSxgzcxdd())){ %>
		<span class="s3"><%=dto.getSxgzcxdd()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else {%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 50, 0) %></span><%} %>
		<span class="s2">（地点）进行陈述、申辩。逾期视为放弃陈述、申辩。</span>
		</p>
		<p class="p7">
		<span class="s2">特此告知。</span>
		</p>
	</div>
	<div id="footer">
		<p class="p11 tr">
		<span class="s2">（公    章）</span>
		</p>
		<br/>
		<p class="p12 tr">
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
