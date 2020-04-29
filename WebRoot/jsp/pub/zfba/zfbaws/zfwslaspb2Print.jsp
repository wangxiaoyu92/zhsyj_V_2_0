<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwslaspb2DTO"%>
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
	int page_number = 1;
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	Zfwslaspb2DTO localZfwslaspb2DTO = new Zfwslaspb2DTO();
	if (request.getAttribute("printbean") != null) {
		localZfwslaspb2DTO = (Zfwslaspb2DTO) request
				.getAttribute("printbean");
	}
	String ajly=localZfwslaspb2DTO.getAjdjajly();
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
<script type="text/javascript">
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
		LODOP.PRINT_INITA(0, 0, "200mm", "280mm", "执法文书——立案审批表");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
				+ document.getElementById("page1").innerHTML);
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
	color: black;
}

.s3 {
	font-size: 10.5pt;
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
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 22pt;
	word-break:break-all;
}

.p6 {
	text-indent: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
	word-break:break-all;
}

.p7 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.29166666in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 0.29166666in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	margin-right: 0.038194444in;
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	margin-top: 0.21666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 22pt;
}

.p13 {
	margin-top: 0.108333334in;
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
	 
}

.p14 {
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 12pt;
}

.p15 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>

</head>
<div style="width: 210mm; margin: 0 auto;display: none">
	   <body class="b1 b2">
	   	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
		<div class="Noprint">
			<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
				class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
				href="javascript:void(0)" id="saveBtn" icon="icon-print"
				class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
				href="javascript:void(0)" id="backBtn" icon="icon-back"
				class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
		</div>
			<div align="center" id="page<%=page_number %>">
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">立案审批表</span>
			</p>
			
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p3">
				<span class="s2">案 由：
					<%=localZfwslaspb2DTO.getAjdjay()%>
				 </span>
			</p>
			<p class="p3">
				<span class="s2">当事人：<%=StringHelper.myMakeStrLen(localZfwslaspb2DTO.getLaspdsr(),20,0)%>
				 </span> 法定代表人（负责人）：
				 <%=localZfwslaspb2DTO.getLaspfddbrxm()%>
				 </span>
			</p>
			<p class="p4">
				<span class="s2">地 &nbsp;&nbsp;址：<%=StringHelper.myMakeStrLen(localZfwslaspb2DTO.getLaspdz(),10,0)%> 
				 </span> 联系方式：
				 <%=localZfwslaspb2DTO.getLasplxfs()%>
				  </span>
			</p>
			<p class="p4">
				<span class="s2">案件来源：
				<%=localZfwslaspb2DTO.getAjdjajlystr()%>
			 </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5">
				<span class="s3">案情摘要： 
				</span>
				
			</p> 
			<p class="p6"> <%=localZfwslaspb2DTO.getLaspaqzy()%> </p>
			<p class="p4">
				<span class="s2"> </span>
			</p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p7"></p>
			<p class="p8">
				<span class="s2">经初步审查，当事人的行为涉嫌违反了
				<%=localZfwslaspb2DTO.getLaspflfg()%>
					的规定，申请予以立案。
					
					</span>
			</p>
			<p class="p10" style="margin-right:50px">
				<span class="s2"> 经办人1：
					<%=localZfwslaspb2DTO.getLaspjbr()%></span><br><br>
				<span class="s2"> 经办人2：
					<%=localZfwslaspb2DTO.getLaspjbr2()%></span>
			</p>
			<p class="p10">
				<span class="s2">  
				<%if(!"".equals(localZfwslaspb2DTO.getLaspjbrqzrq()) 
					&& localZfwslaspb2DTO.getLaspjbrqzrq().length() >= 10){ %>
						<%=localZfwslaspb2DTO.getLaspjbrqzrq().substring(0,4)%>
					年<%=localZfwslaspb2DTO.getLaspjbrqzrq().substring(5,7)%>
					月<%=localZfwslaspb2DTO.getLaspjbrqzrq().substring(8,10)%>日 
					<%}else{%>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日  <%}%>
				  </span>
			</p>
			<p class="p4"></p>
			<p class="p8">
				<span class="s2">建议本案由 
					&nbsp;&nbsp;&nbsp;<%=localZfwslaspb2DTO.getLaspjyzb()%>
				     承办。</span>
				<span class="s2">由   <%=localZfwslaspb2DTO.getLaspjyxb()%> 协办。</span><br>
			</p> 
			</p>
			<p class="p10">
				<span class="s2"> 承办部门负责人：
					<%=localZfwslaspb2DTO.getLaspcbbmfzr()%>
				  </span>
			</p>
			<p class="p10">
			 	<span class="s2">
			 	<%if(!"".equals(localZfwslaspb2DTO.getLaspcbbmfzrqzrq()) 
					&& localZfwslaspb2DTO.getLaspcbbmfzrqzrq().length() >= 10){ %>
					<%=localZfwslaspb2DTO.getLaspcbbmfzrqzrq().substring(0,4)%>
					年<%=localZfwslaspb2DTO.getLaspcbbmfzrqzrq().substring(5,7)%>
					月<%=localZfwslaspb2DTO.getLaspcbbmfzrqzrq().substring(8,10)%>日
					<%}else{%>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日  <%}%>
			 </span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p12">
				<span class="s3"> 审批意见：</span> 
			</p> 
			<p class="p6">
				<%=localZfwslaspb2DTO.getLaspspyj()%>
			</p>
			<p class="p13">
				<span class="s2"> </span>
			</p>
			<p class="p10">
				<span class="s2"> 分管负责人：
					<%=localZfwslaspb2DTO.getLaspfgfzr()%>
				 </span>
			</p>
			<p class="p10">
				<span class="s2"> 
					<%if(!"".equals(localZfwslaspb2DTO.getLaspfgfzrqzrq()) 
					&& localZfwslaspb2DTO.getLaspfgfzrqzrq().length() >= 10){ %>
					<%=localZfwslaspb2DTO.getLaspfgfzrqzrq().substring(0,4)%>
					年<%=localZfwslaspb2DTO.getLaspfgfzrqzrq().substring(5,7)%>
					月<%=localZfwslaspb2DTO.getLaspfgfzrqzrq().substring(8,10)%>日
					<%}else{%>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日  <%}%>
				 </span>
			</p>
			<p class="p13"></p>
			<p class="p14"></p>
			<p class="p15"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
  
	</body>
</div>

</html>
