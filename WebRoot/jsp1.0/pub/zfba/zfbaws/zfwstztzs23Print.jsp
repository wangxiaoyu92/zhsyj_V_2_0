<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwstztzs23DTO"%>
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

	String op = StringHelper.showNull2Empty(request.getParameter("op"));
	String v_ajdjid = StringHelper.showNull2Empty(request
			.getParameter("ajdjid"));
	int page_number=1; 
	Zfwstztzs23DTO localZfwstztzs23DTO = new Zfwstztzs23DTO();
	if (request.getAttribute("printbean") != null) {
		localZfwstztzs23DTO = (Zfwstztzs23DTO) request.getAttribute("printbean");
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
	    LODOP = getLodop();
		//var strBodyStyle = "<style>"+document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——听证通知书");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
		CreatePrintPage();
		LODOP.PREVIEW();
	};

	//直接打印
	function printData() {
	    LODOP = getLodop();
		//var strBodyStyle = "<style>"+document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——听证通知书");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
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
		//LODOP = getLodop();
		var strBodyStyle = "<style>"+document.getElementById("sty1").innerHTML + "</style>";
		//LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——听证通知书");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTML("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle+document.getElementById("page1").innerHTML);
		 
		LODOP.ADD_PRINT_HTML("215mm", "20mm", "80%", "100%", strBodyStyle+document.getElementById("gzsj").innerHTML);
		LODOP .ADD_PRINT_HTML("240mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", "注：正文3号仿宋体字，存档（1）。");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);   
		LODOP.NewPage();
		LODOP.ADD_PRINT_HTML("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP.ADD_PRINT_HTML("215mm", "20mm", "80%", "100%", strBodyStyle+document.getElementById("gzsj").innerHTML);
		LODOP .ADD_PRINT_HTML("240mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", "注：正文3号仿宋体字，存档（2）。");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);   
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
	font-family: 仿宋_GB2312;
	color: black;
}
.s4 {
	text-decoration:underline;
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
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋;
	font-size: 10.5pt;
}

.p4 {
	text-indent: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: 0.3in;
	margin-left: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.35in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.29166666in;
	margin-left: 0.072916664in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.33in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: 0.37in;
	text-align: start;
	text-align: start;
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
	text-indent: 0.072916664in;
	margin-left: 3.7916667in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-indent: 0.4375in;
	margin-left: 3.7916667in;
	margin-right: 0.29166666in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p13 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p14 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}
</style>


</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto;display: none">
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
			<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">听证通知书</span>
			</p>

			<p class="p3">
				    <span class="s3">
					<%=localZfwstztzs23DTO.getTztzwsbh()%>
					</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2 s4"> <%=localZfwstztzs23DTO.getTztzdsr()%></span> ：
			</p>
			<p class="p5">
				<span class="s2"> 你(单位) 于
				<span class="s4">
				<%if(!"".equals(localZfwstztzs23DTO.getTztzsqrq())&&localZfwstztzs23DTO.getTztzsqrq().length()>=10){ %>
				<%=localZfwstztzs23DTO.getTztzsqrq().substring(0,4)%>
					年<%=localZfwstztzs23DTO.getTztzsqrq().substring(5,7)%>
					月<%=localZfwstztzs23DTO.getTztzsqrq().substring(8,10)%>日  
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
					<%} %>
                </span>     
					向本局提出听证申请，根据《中华人民共和国行政处罚法》第四十二条规定，本局决定于<span class="s4">
					<%if(!"".equals(localZfwstztzs23DTO.getTztzjxrq())&&localZfwstztzs23DTO.getTztzjxrq().length()>=16){ %>
					<%=localZfwstztzs23DTO.getTztzjxrq().substring(0,4)%>
					年<%=localZfwstztzs23DTO.getTztzjxrq().substring(5,7)%>
					月<%=localZfwstztzs23DTO.getTztzjxrq().substring(8,10)%>日
					<%=localZfwstztzs23DTO.getTztzjxrq().substring(11,13)%>时  
					<%=localZfwstztzs23DTO.getTztzjxrq().substring(14,16)%>分  
					<%}else{ %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;时&nbsp;&nbsp;&nbsp;&nbsp;分
					<%} %></span>
					，在 <span class="s4"><%=localZfwstztzs23DTO.getTztzdd() %></span>
					（地点）公开（不公开）举行听证会。请你（单位）法定代表人或委托代理人准时出席。不按时出席听证，且事先未说明理由，又无特殊原因的，视为放弃听证权利。
					</span>
			</p>
			<p class="p6">
				<span class="s2">委托代理听证的，应当在听证举行前向本局提交听证代理委托书。</span>
			</p>
			<p class="p6">
				<span class="s2">本案听证主持人：</span>
				<span class="s4" style="text-indent: 0in;width:100px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;"> 
				<%=StringHelper.myMakeStrLen(localZfwstztzs23DTO.getTztzzcr(),20,0) %></span>
                <span class="s2">记录员：</span>
                <span class="s4" style="text-indent: 0in;width:100px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;"> 
                   <%=StringHelper.myMakeStrLen(localZfwstztzs23DTO.getTztzjly(),20,0) %></span> 
			</p>
			<p class="p7">
				<span class="s2">根据《中华人民共和国行政处罚法》第四十二条的规定，你如申请主持人回避，可在听证举行前向本局提出回避申请并说明理由。</span>
			</p>
			<p class="p8">
				<span class="s2">地 址：<%=localZfwstztzs23DTO.getTztzdz()%>  </span>
			</p>
			<p class="p8">
				<span class="s2">邮政编码：<%=localZfwstztzs23DTO.getTztzyzbm()%>
				 </span>
			</p>
			<p class="p8">
				<span class="s2">联系电话：<%=localZfwstztzs23DTO.getTztzlxdh()%>
				</span>
			</p>
			<p class="p9">
				<span class="s2">联 系 人：<%=localZfwstztzs23DTO.getTztzlxr()%> 
			    </span>
			</p>
			<p class="p10"></p>
			<p class="p11"></p>
			<p class="p11"></p>
			<p class="p11"></p>
		</div>
		<div id="gzsj"><!-- 公章和时间 -->
			<p class="p12">
				<span class="s2">（公 章）</span>
			</p>
			<p class="p10">
				<span class="s2"> 
				<%if(!"".equals(localZfwstztzs23DTO.getTztzgzrq())&&localZfwstztzs23DTO.getTztzgzrq().length()>=10){ %>
				<%=localZfwstztzs23DTO.getTztzgzrq().substring(0,4)%>
					年<%=localZfwstztzs23DTO.getTztzgzrq().substring(5,7)%>
					月<%=localZfwstztzs23DTO.getTztzgzrq().substring(8,10)%>日  
				<%}else{ %>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
				<%} %>	
				  </span>
			</p>
		    <hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
			<p class="p3">
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p10"></p>
			<p class="p13"> 
			</p>
			<p class="p14"></p>
 		
	</body></div>
</html>
