<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjabg40DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwsxzcfjabg40DTO dto = new Zfwsxzcfjabg40DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsxzcfjabg40DTO) request.getAttribute("printbean");
	} 
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1 {
	white-space-collapsing: preserve;
}
.b2 {
	margin: 1.0in 1.2479167in 1.0in 1.2479167in;
}
.s1 {
	font-weight: bold;
	color: black;
}
.s2 {
	font-family: Times New Roman;
	font-weight: bold;
	color: black;
}
.s3 {
	color: black;
}
.s4 {
	color: black;
	text-decoration: underline;
}

.p1 {
	text-align: center;
	hyphenate: auto;
	font-family: 黑体;
	font-size: 16pt;
}

.p2 {
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋;
	font-size: 22pt;
}

.p3 {
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 3.1944444in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 3.9958334in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 22pt;
}

.p8 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>
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

<style>
.Noprint {
	text-align: center;
}
</style>

<script language="javascript" type="text/javascript">
var s = new Object();   
s.type = "";   //设为空不刷新父页面
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
		var strBodyStyle = "<style>"
				+ document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——行政处罚结案报告");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "85%", "100%", strBodyStyle
				+ document.getElementById("page1").innerHTML);
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
		<p class="p2"> <span class="s2">行政处罚结案报告</span> </p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案 由：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if(dto.getAjdjay() != null){ %><%=dto.getAjdjay()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">案件来源：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if(dto.getAjdjajlystr() != null){ %><%=dto.getAjdjajlystr()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">被处罚单位（人）： </span>
			<span style="border-bottom: 0px solid  white-space;width: 230px;display: inline-block;">
			<%if(dto.getJabgbcfdwr() != null){%><%=dto.getJabgbcfdwr()%><%} %></span> 
			<span class="s3">法定代表人（负责人）： </span>
			<span style="border-bottom: 0px solid  white-space; display: inline-block;">
			<%if(dto.getJabgfddbr() != null){ %><%=dto.getJabgfddbr()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">立案日期： </span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabglarq() != null && !"".equals(dto.getJabglarq())){ %>
			<%=dto.getJabglarq().substring(0, 4)%><%} %></span>
			<span class="s3">年</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabglarq() != null && !"".equals(dto.getJabglarq())){ %>
			<%=dto.getJabglarq().substring(5, 7)%><%} %></span>
			<span class="s3">月</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabglarq() != null && !"".equals(dto.getJabglarq())){ %>
			<%=dto.getJabglarq().substring(8, 10)%><%} %></span>
			<span class="s3">日</span>
			<span style="border-bottom: 0px solid  white-space;width: 70px;display: inline-block;"></span>
			<span class="s3">处罚日期：</span>
			<span style="border-bottom: 10px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgcfrq() != null && !"".equals(dto.getJabgcfrq())){ %>
			<%=dto.getJabgcfrq().substring(0, 4)%><%} %></span>
			<span class="s3">年</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgcfrq() != null && !"".equals(dto.getJabgcfrq())){ %>
			<%=dto.getJabgcfrq().substring(5, 7)%><%} %></span>
			<span class="s3">月</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgcfrq() != null && !"".equals(dto.getJabgcfrq())){ %>
			<%=dto.getJabgcfrq().substring(8, 10)%><%} %></span>
			<span class="s3">日</span>
		</p>
		<p class="p3">
			<span class="s3">处罚文书号：</span>
			<span style="border-bottom: 0px solid  white-space;width: 270px;display: inline-block;">
			<%if(dto.getJabgcfwsh() != null){ %><%=dto.getJabgcfwsh()%><%} %></span>
			<span class="s3">结案日期：</span>   
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgjarq() != null && !"".equals(dto.getJabgjarq())){ %>
			<%=dto.getJabgjarq().substring(0, 4)%><%} %></span>
			<span class="s3">年</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgjarq() != null && !"".equals(dto.getJabgjarq())){ %>
			<%=dto.getJabgjarq().substring(5, 7)%><%} %></span>
			<span class="s3">月</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJabgjarq() != null && !"".equals(dto.getJabgjarq())){ %>
			<%=dto.getJabgjarq().substring(8, 10)%><%} %></span>
			<span class="s3">日</span>
		</p>
		<p class="p3">
			<span class="s3">承办人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;">
			<%if(dto.getJabgcbr() != null){ %><%=dto.getJabgcbr()%><%} %></span>
			 <span class="s3">填写人：</span>  
			 <span style="border-bottom: 0px solid  white-space; display: inline-block;">
			<%if(dto.getJabgtxr() != null){ %><%=dto.getJabgtxr()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3" style="height: 150px;">
			<span class="s3">处罚种类和幅度：</span>
			<span class="s3"><%if(dto.getJabgcfzlhfd() != null && !"".equals(dto.getJabgcfzlhfd())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getJabgcfzlhfd())%></span><%} else{%>
				<br><br><br><%} %>
		</p> 
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	    <p class="p3" style="height: 100px;">
			<span class="s3">执行结果：</span>
			<span class="s3"><%if(dto.getJagdzxjg() != null && !"".equals(dto.getJagdzxjg())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getJagdzxjg())%></span><%} else{%>
				<br><br><br><%} %>
		</p> 
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">结案方式： </span>
			<span class="s3"><%if(dto.getJagdjafsstr() != null && !"".equals(dto.getJagdjafsstr())){ %>
				<%=dto.getJagdjafsstr()%></span><%} else{%>
				&nbsp;&nbsp;&nbsp;&nbsp;1.自动履行&nbsp;&nbsp;&nbsp;&nbsp;2.复议结案&nbsp;&nbsp;&nbsp;&nbsp;
				3.诉讼结案&nbsp;&nbsp;&nbsp;&nbsp;4.强制执行&nbsp;&nbsp;&nbsp;&nbsp;5.其他<%} %>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">归档日期：  </span>
			<span style="border-bottom: 0px solid white-space;width: 50px;display: inline-block;">
			<%if(dto.getJagdrq() != null && !"".equals(dto.getJagdrq())){ %>
			<%=dto.getJagdrq().substring(0, 4)%><%} %></span>
			<span class="s3">年</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJagdrq() != null && !"".equals(dto.getJagdrq())){ %>
			<%=dto.getJagdrq().substring(5, 7)%><%} %></span>
			<span class="s3">月</span>
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;">
			<%if(dto.getJagdrq() != null && !"".equals(dto.getJagdrq())){ %>
			<%=dto.getJagdrq().substring(8, 10)%><%} %></span>
			<span class="s3">日</span>
			<span class="s3">档案归类：</span>
			<span style="border-bottom: 0px solid white-space;width: 140px;display: inline-block;">
			<%if(dto.getJagddaglstr() != null){ %><%=dto.getJagddaglstr()%><%} %></span>
			<span class="s3">保存期限：</span>  
			<span style="border-bottom: 0px solid white-space;display: inline-block;">
			<%if(dto.getJagdbcqx() != null){ %><%=dto.getJagdbcqx()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3" style="height: 150px;">
			<span class="s3">审批意见：</span>
			<span class="s3"><%if(dto.getJagdspyj() != null && !"".equals(dto.getJagdspyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getJagdspyj())%></span><%} else{%>
				<br><br><br><%} %>
		</p> 
		<p class="p6">
			<span class="s3">分管负责人：</span>
			<span style="border-bottom: 1px solid  black;width: 150px;display: inline-block;"></span>
		</p>
		<p class="p6"> 
		  	<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
</body>
</div>
</html>