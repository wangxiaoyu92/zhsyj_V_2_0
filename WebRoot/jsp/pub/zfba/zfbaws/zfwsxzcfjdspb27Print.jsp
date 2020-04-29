<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxzcfjdspb27DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
		+ request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath()
		+ "/";
	}
	int page_number=1; 
	String v_ajdjid = StringHelper.showNull2Empty(request
	.getParameter("ajdjid"));
	String v_xzcfjdspbid = StringHelper.showNull2Empty(request.getParameter("xzcfjdspbid"));
	Zfwsxzcfjdspb27DTO localZfwsxzcfjdspb27DTO = new Zfwsxzcfjdspb27DTO();
	if (request.getAttribute("printbean") != null) {
		localZfwsxzcfjdspb27DTO = (Zfwsxzcfjdspb27DTO) request
		.getAttribute("printbean");
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
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
	var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close"); 

	})

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
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——行政处罚决定审批表");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
				+ document.getElementById("page1").innerHTML);
		//LODOP.NEWPAGE();
		//LODOP.ADD_PRINT_HTM("20mm", "20mm", "85%", "100%", strBodyStyle
		//		+ document.getElementById("page2").innerHTML);
	}
</script>

<style type="text/css" id="sty1">
.b1 {
	white-space-collapsing: preserve;
}

.b2 {
	margin: 1.0in 1.25in 1.0in 1.25in;
}

.s1 {
	font-weight: bold;
	color: black;
}

.s2 {
	font-size: 10.5pt;
	color: black;
}

.s3 {
	color: black;
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
	font-family: Times New Roman;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
	word-break:break-all;
}

.p6 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.33333334in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 3.5729167in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>


<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
	<body class="b1 b2">

		<input id="xzcfjdspbid" name="xzcfjdspbid" type="hidden"
			value="<%=v_xzcfjdspbid%>" />
		<div class="Noprint">

			<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
				class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
				href="javascript:void(0)" id="saveBtn" icon="icon-print"
				class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
				href="javascript:void(0)" id="backBtn" icon="icon-back"
				class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
		</div>
		<div align="center" id="page<%=page_number%>">
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">行政处罚决定审批表</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">案 由：<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;"> <%=localZfwsxzcfjdspb27DTO.getAjdjay()%></span>
			</p>
			<p class="p3">
			当事人：<span style="border-bottom: 1px solid  black;width: 543px;display: inline-block;"> <%=localZfwsxzcfjdspb27DTO.getCfspdsr()%></span>
			</p>
			<p class="p3">
				<span class="s2">主要违法事实：
				</span>
			</p>
			<p class="p5">
				 <%=localZfwsxzcfjdspb27DTO.getCfspwfss()%>
			</p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p5"></p>
			<p class="p6">
				<span class="s3"> 根据上述情况，拟对该单位（人）给予 <%=localZfwsxzcfjdspb27DTO.getCfspcfjd()%>
					的行政处罚决定。</span>
			</p>
			<p class="p7"></p>
			<p class="p3">
				<span class="s2"> 附件： <%=localZfwsxzcfjdspb27DTO.getCfspfj()%>
				</span>
			</p>
			<p class="p8"></p>
			<p class="p4">
				<span class="s2"> 承办人：
				<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;text-align: left;">
				  <%=localZfwsxzcfjdspb27DTO.getCfspcbrqz()%> 
				  <%=localZfwsxzcfjdspb27DTO.getCfspcbrqz2()%> 
				</span>  
				   </span>
			</p>
			<p class="p4">
				<span class="s2"> 
				<%if(!"".equals(localZfwsxzcfjdspb27DTO.getCfspcbrqzrq()) && localZfwsxzcfjdspb27DTO.getCfspcbrqzrq().length()>=10){ %>
				    <%=localZfwsxzcfjdspb27DTO.getCfspcbrqzrq().substring(0,4)%>
					年<%=localZfwsxzcfjdspb27DTO.getCfspcbrqzrq().substring(5,7)%>
					月<%=localZfwsxzcfjdspb27DTO.getCfspcbrqzrq().substring(8,10)%>日
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
					&nbsp;&nbsp;&nbsp;&nbsp;月
					&nbsp;&nbsp;&nbsp;&nbsp;日
					<%} %>
				</span>
			</p>
			<p class="p7"></p>
			<p class="p4">
				<span class="s2"> 承办部门负责人： 
				 <span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;text-align: left;">
				 <%=localZfwsxzcfjdspb27DTO.getCfspcbbmfzr()%></span> 
				 </span>
			</p>
			<p class="p4">
				<span class="s2">
				   <%if(!"".equals(localZfwsxzcfjdspb27DTO.getCfspcbfzrqzrq()) && localZfwsxzcfjdspb27DTO.getCfspcbfzrqzrq().length()>=10){ %>
				    <%=localZfwsxzcfjdspb27DTO.getCfspcbfzrqzrq().substring(0,4)%>
					年<%=localZfwsxzcfjdspb27DTO.getCfspcbfzrqzrq().substring(5,7)%>
					月<%=localZfwsxzcfjdspb27DTO.getCfspcbfzrqzrq().substring(8,10)%>日
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
					&nbsp;&nbsp;&nbsp;&nbsp;月
					&nbsp;&nbsp;&nbsp;&nbsp;日
					<%} %>
				</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		
		 
			
			<p class="p3">
				<span class="s2">审核部门意见：</span>
			</p>
			<p class="p5">
				 <%=localZfwsxzcfjdspb27DTO.getCfspshbmyj()%> 
			</p>
			<p class="p4">负责人：  
				<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;text-align: left;"> 
				<%=localZfwsxzcfjdspb27DTO.getCfspshbmfzr()%> 
					 </span>
			</p>
			<p class="p4">
				<span class="s3"> 
				    <%if(!"".equals(localZfwsxzcfjdspb27DTO.getCfspshbmfzrrq()) && localZfwsxzcfjdspb27DTO.getCfspshbmfzrrq().length()>=10){ %>
				    <%=localZfwsxzcfjdspb27DTO.getCfspshbmfzrrq().substring(0,4)%>
					年<%=localZfwsxzcfjdspb27DTO.getCfspshbmfzrrq().substring(5,7)%>
					月<%=localZfwsxzcfjdspb27DTO.getCfspshbmfzrrq().substring(8,10)%>日
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
					&nbsp;&nbsp;&nbsp;&nbsp;月
					&nbsp;&nbsp;&nbsp;&nbsp;日
					<%} %>
				</span>
			</p>
			<p class="p4"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">
				<span class="s2">审批意见： </span>
			</p>
			<p class="p5">
				<%=localZfwsxzcfjdspb27DTO.getCfspspyj()%>
			</p>
			<p class="p4">负责人 ： 
				<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block; text-align: left;">
				<%=localZfwsxzcfjdspb27DTO.getCfspspyjfzr()%> 
					 </span>
			</p>
			<p class="p4">
				<span class="s3">
				    <%if(!"".equals(localZfwsxzcfjdspb27DTO.getCfspspyjfzrrq()) && localZfwsxzcfjdspb27DTO.getCfspspyjfzrrq().length()>=10){ %>
				    <%=localZfwsxzcfjdspb27DTO.getCfspspyjfzrrq().substring(0,4)%>
					年<%=localZfwsxzcfjdspb27DTO.getCfspspyjfzrrq().substring(5,7)%>
					月<%=localZfwsxzcfjdspb27DTO.getCfspspyjfzrrq().substring(8,10)%>日
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
					&nbsp;&nbsp;&nbsp;&nbsp;月
					&nbsp;&nbsp;&nbsp;&nbsp;日
					<%} %>
				</span>
			</p>
			<p class="p6"></p>
			<p class="p9"></p>

			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		 	</div>
	</body>
</html>
