<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjdspb27DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Zfwsxzcfjdspb27DTO dto = new Zfwsxzcfjdspb27DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsxzcfjdspb27DTO) request.getAttribute("printbean");
	}
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">

<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>

<script language="javascript" src="<%=basePath%>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
		pluginspage="<%=basePath%>lodop/install_lodop32.exe"></embed>
</object>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s); 
	var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close");
	});

	//打印预览 
	function printView() {
		CreatePrintPage();
		LODOP.PREVIEW();
	};

	//直接打印
	function printData() {
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
		LODOP = getLodop();
		var strBodyStyle = "<style>" + document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——行政处罚决定审批表");
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
				+ document.getElementById("page1").innerHTML);
	}
</script>

<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p2{margin-top:0.108333334in;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p3{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.33333334in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:3.5729167in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.lh30{line-height: 24px;}
</style>


<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
	<body class="b1 b2">
		<div class="Noprint">

			<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
				class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
				href="javascript:void(0)" id="saveBtn" icon="icon-print"
				class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
				href="javascript:void(0)" id="backBtn" icon="icon-back"
				class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
		</div>
		<div align="center" id="page1">
			<p class="p1">
				<span class="s1">行政处罚决定审批表</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">案 由：
			<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;">
			<%if (dto.getAjdjay() != null) { %> <%=dto.getAjdjay()%><%} %></span>
			</p>
			<p class="p2">
			当事人：<span style="border-bottom: 1px solid  black;width: 543px;display: inline-block;">
			<%if (dto.getCfspdsr() != null) { %> <%=dto.getCfspdsr()%><%} %></span>
			</p>
			<p class="p2">
				<span class="s2">当事人违法的主要事实和建议作出行政处罚决定的理由、依据及内容：</span>
			</p>
			<p class="p2" style="min-height: 40px;"><%if(dto.getCfspwfss() != null && !"".equals(dto.getCfspwfss())){ %>
			<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getCfspwfss())%></span><%} else{%>
			<br><br><%} %></p>
			<p class="p2">
				<span class="s2">陈述申辩及听证情况：</span>
			</p>
			<p class="p2" style="min-height: 40px;"><%if(dto.getCssbjtzqk() != null && !"".equals(dto.getCssbjtzqk())){ %>
			<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getCssbjtzqk())%></span><%} else{%>
			<br><br><%} %></p>
			<p class="p2">
				<span class="s2">当事人陈述申辩或听证意见复核及采纳情况：</span>
			</p>
			<p class="p2"  style="min-height: 40px;">
				<%if(dto.getDsrcssbqk() != null && !"".equals(dto.getDsrcssbqk())){ %>
				<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getDsrcssbqk())%></span><%} else{%>
				<br><br><%} %>
			</p>
			<div align="right">
				<p class="p2">
					<span class="s2"> 承办人：</span>
					<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;"></span>、
					<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;"></span>    
				</p>
				<p class="p2"> 
				  	<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
				</p>
			</div>
			<p class="p2">
				<span class="s2">承办部门审查意见：</span>
			</p>
			<p class="p2"  style="min-height: 40px;">
				<%if(dto.getCbbmscyj() != null && !"".equals(dto.getCbbmscyj())){ %>
				<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getCbbmscyj())%></span><%} else{%>
				<br><br><%} %>
			</p>
			<div align="right">
				<p class="p2">
					<span class="s2"> 承办部门负责人： </span>
					<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;"></span> 
				</p>
				<p class="p2"> 
				  	<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">
				<span>法制机构审核意见：</span>
			</p>
			<p class="p2"  style="min-height: 40px;">
				<%if(dto.getCfspshbmyj() != null && !"".equals(dto.getCfspshbmyj())){ %>
				<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getCfspshbmyj())%></span><%} else{%>
				<br><br><%} %>
			</p>
			<div align="right">
				<p class="p2">负责人：  
					<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;"></span>
				</p>
				<p class="p2"> 
				  	<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
				</p>
			</div>
			<p class="p4"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p2">
				<span class="s2">审批意见： </span>
			</p>
			<p class="p2"  style="min-height: 40px;">
				<%if(dto.getCfspspyj() != null && !"".equals(dto.getCfspspyj())){ %>
				<span class="s2 lh30"><%=SysmanageUtil.replaceStrChuLast(dto.getCfspspyj())%></span><%} else{%>
				<br><br><%} %>
			</p>
			<div align="right">
				<p class="p2">负责人 ： 
					<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;"></span>
				</p>
				<p class="p2"> 
				  	<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
		   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		 	</div>
	</body></div>
</html>
