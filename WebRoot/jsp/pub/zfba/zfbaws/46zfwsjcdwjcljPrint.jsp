<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsjcdwjclj46DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	}
	Zfwsjcdwjclj46DTO dto = new Zfwsjcdwjclj46DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsjcdwjclj46DTO) request.getAttribute("printbean");
	}
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css"  id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:22pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p3{text-align:start;hyphenate:auto;font-family:宋体;font-size:18pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:18pt;}
.p6{text-align:justify;hyphenate:auto;font-family:Calibri;font-size:10pt;}
/* .td1{width:7.9645834in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;}
.td2{width:0.99791664in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td3{width:1.0138889in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td4{width:1.0215277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td5{width:1.725in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:1.2305556in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-right:thin solid black;}
.td7{width:0.61569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.td8{width:1.3215277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td9{width:4.43125in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td10{width:0.99791664in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td11{width:5.9666667in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td12{width:0.50694444in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td13{width:0.50625in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td14{width:0.6152778in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td15{width:0.5083333in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td16{width:0.87569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;} */
.td3{width:116px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black; }
.td4{width:116px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td5{width:174px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:116px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-right:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td7{width:58px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td9{width:352px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td11{width:580px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.tdt{width:66px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black; }
.tdy{width:58px;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black; }
.r1{height:0.7291667in;keep-together:always;}
.r2{height:0.65625in;keep-together:always;}
.r3{height:1.0208334in;keep-together:always;}
.r4{height:1.8854167in;keep-together:always;}
.r5{height:0.88125in;keep-together:always;}
.r6{height:0.4645833in;keep-together:always;}
.r7{height:0.4604167in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;} 
.w{width: 60px;}
</style>
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
.Noprint{text-align:center;} 
.PageNext{page-break-after: always;} 
</style>
<script type="text/javascript">
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
		LODOP=getLodop();
	    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——查封（扣押）决定书");
		LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
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
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	} 
</script>
</head>
<div style="width: 210mm; margin: 0 auto;" >
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
		<table class="t1">
		<tbody>
		<tr class="r1">
			<td class="td1" colspan="11">
				<p class="p1">
					<span class="s1">汤阴县食药监局稽查队文件处理笺</span>
				</p>
			</td>
		</tr>
		<tr class="r7">
			<td class="tdt" rowspan="2">
				<p class="p2">
					<span class="s2">来文 机关</span>
				</p>
			</td>
			<td class="td3" colspan="2" rowspan="2">
				<p class="p2">
					<span class="s2">举报</span>
				</p>
			</td>
			<td class="td4" colspan="2">
				<p class="p2">
					<span class="s2">文件号</span>
				</p>
			</td>
			<td class="td5" colspan="3">
				<p class="p3">
					<span class="s2"><%=dto.getJcwjclwjbh()%></span>
				</p>
			</td>
			<td class="td6" colspan="2">
				<p class="p2">
					<span class="s2">顺序号</span>
				</p>
			</td>
			<td class="td7">
				<p class="p3">
					<span class="s2"><%=dto.getJcwjclwjsxh()%></span>
				</p>
			</td>
		</tr>
		<tr class="r7">
			<td class="td4" colspan="2">
				<p class="p2">
					<span class="s2">收到日期</span>
				</p>
			</td>
			<td class="td9" colspan="6">
				<p class="p3">
					<span class="s2">
		            <%if(dto.getJcwjclwjsdrq()!=null&&!"".equals(dto.getJcwjclwjsdrq())){ %>
					<%=dto.getJcwjclwjsdrq()%>
					<%} %></span>
				</p>
			</td>
		</tr>
		<tr class="r2">
			<td class="tdt">
				<p class="p2">
					<span class="s2">标题</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p3">
					<span class="s2"><%=dto.getJcwjclwjbt()%></span>
				</p>
			</td>
		</tr>
		<tr class="r4">
			<td class="tdt">
				<p class="p4">
					<span class="s2">领导批示</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p3"> <%=dto.getJcwjclldps() %> </p>
			</td>
		</tr>
		<tr class="r5">
			<td class="tdt">
				<p class="p2">
					<span class="s2">阅者签名</span>
				</p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4" ></p>
			</td>
			<td class="td13">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
		</tr>
		<tr class="r6">
			<td class="tdt">
				<p class="p4">
					<span class="s2">月日</span>
				</p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p2"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
			<td class="tdy">
				<p class="p4"> </p>
			</td>
		</tr>
		<tr class="r2">
			<td class="tdt">
				<p class="p2">
					<span class="s2">备注</span>
				</p>
			</td>
			<td class="td11" colspan="10">
				<p class="p5"><%=dto.getJcwjclbz() %></p>
			</td>
		</tr>
		</tbody>
		</table>
		<p class="p6"></p> 
	</div>	
</body>
</div>
</html>

