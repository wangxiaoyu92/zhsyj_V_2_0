<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsspb39DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 通用审批表
	Zfwsspb39DTO dto = new Zfwsspb39DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsspb39DTO) request.getAttribute("printbean");
    }	
    String v_fjcszfwstitle = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcszfwstitle")),"UTF-8");
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
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.034722224in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:right;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:4.2291665in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:2.9166667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:4.2291665in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 34px;text-indent:0.29166666in;}
</style>

<title>审批表</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——审批表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
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
		<p class="p2"><span class="s1">（<%=v_fjcszfwstitle%>）审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s2">案件名称：</span>
			<span style="border-bottom: 0px solid  white-space; display: inline-block;">
			<%if(dto.getSpajmc() != null){%><%=dto.getSpajmc()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">审批事项：</span>
			<span style="border-bottom: 0px solid  white-space; display: inline-block;">
			<%if(dto.getSpsx() != null){ %><%=dto.getSpsx()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">报请审批的理由及依据：</span>
		</p>
		<p class="p5 l24" style="min-height: 50px;">
			<%if(dto.getSplyyj() != null && !"".equals(dto.getSplyyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSplyyj())%><%}%>
		</p>
    	<p class="p6">
			<span class="s2">附件：</span>
			<%if(dto.getSpfj() != null && !"".equals(dto.getSpfj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSpfj())%><%} else{%>
				<br><%} %>
		</p>
		<br><br>
		<p class="p7">
			<span class="s2">案件承办人：</span>
			<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"></span>   
		 	<span class="s2">、</span>
		 	<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"></span> 
		</p>
		<p class="p7">
			<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;">年</span>   
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">月</span>
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">日</span>
		 	<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;"></span>  
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p5">
			<span class="s2">承办部门意见：</span>
		</p>
		<p class="p6" style="min-height: 50px;">
			<%if(dto.getSpcbbmyj() != null && !"".equals(dto.getSpcbbmyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSpcbbmyj())%><%}%>
		</p>
		<p class="p7">
			<span class="s2">部门负责人：</span>
			<span style="border-bottom: 1px solid  black;width: 200px;display: inline-block;"></span>   
		</p>
		<p class="p7">
			<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;">年</span>   
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">月</span>
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">日</span> 
		 	<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;"></span> 
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p11">
			<span class="s2">审批意见：</span>
		</p>
		<p class="p6" style="min-height: 50px;">
			<%if(dto.getSpyj() != null && !"".equals(dto.getSpyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getSpyj())%><%}%>
		</p>
		<p class="p7">
			<span class="s2">分管负责人：</span>
			<span style="border-bottom: 1px solid  black;width: 200px;display: inline-block;"></span> 
		</p>
		<p class="p7">
			<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;">年</span>   
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">月</span>
		 	<span style="border-bottom: 0px solid  word-spacing;width: 50px;display: inline-block;">日</span> 
		 	<span style="border-bottom: 0px solid word-spacing;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
</body>
</div>
</html>
