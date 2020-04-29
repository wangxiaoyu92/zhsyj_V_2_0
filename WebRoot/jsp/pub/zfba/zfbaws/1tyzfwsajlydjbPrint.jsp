<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.ZfwsajlydjbDTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + path + "/";

	String v_duihao="<span style=\"font-family:Wingdings;font-size:18px;\" >&#254;</span>";
	String v_kong="<span style=\"font-family:Wingdings;font-size:18px;\" >&#168;</span>";	
	
	String v_jdjc = v_kong;
	String v_tsjb = v_kong;
	String v_sjjb = v_kong;
	String v_xjbq = v_kong;
	String v_jdcy = v_kong;
	String v_ys = v_kong;
	String v_qt = v_kong;	

	ZfwsajlydjbDTO dto = new ZfwsajlydjbDTO();
	if (request.getAttribute("printbean") != null) {
		dto = (ZfwsajlydjbDTO) request.getAttribute("printbean");
		if (dto != null && "1".equals(dto.getAjdjajly())) {
			v_jdjc = v_duihao;
		} else if (dto != null && "2".equals(dto.getAjdjajly())) {
			v_tsjb = v_duihao;
		} else if (dto != null && "3".equals(dto.getAjdjajly())) {
			v_sjjb = v_duihao;
		} else if (dto != null && "4".equals(dto.getAjdjajly())) {
			v_xjbq = v_duihao;
		} else if (dto != null && "5".equals(dto.getAjdjajly())) {
			v_jdcy = v_duihao;
		} else if (dto != null && "6".equals(dto.getAjdjajly())) {
			v_ys = v_duihao;
		} else if (dto != null && "7".equals(dto.getAjdjajly())) {
			v_qt = v_duihao;
		}
	}
%>

<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.wsty{
   color: black;
   border-bottom: 1px solid black;
   display: inline-block;    vertical-align:bottom;
}
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

.s22 {
	clear: both;
	display: block;
	margin-left:380px;
}

.s3 {
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
	font-family: Times New Roman;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p31 {
	margin-top: 0.108333334in;
	text-align: right;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p4 {
	text-indent: 0.06944445in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p5 {
	text-indent: -0.072916664in;
	margin-left: 0.8020833in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p61 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0.072916664in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: 0.07013889in;
	margin-top: 0.108333334in;
	text-align: start;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	margin-left: 0.07013889in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p11 {
	text-indent: 0.29166666in;
	margin-top: 0.16666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p12 {
	text-indent: 0.36458334in;
	margin-top: 0.16666667in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p13 {
	text-align: center;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p14 {
	text-indent: 2em;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p142 {
	text-indent: 2em;
	word-break: break-all;
	line-height: 23px
}

.p15 {
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
		<param name="Caption" value="我是打印控件lodop">
</object>

<style>
.Noprint {
	text-align: center;
}

.PageNext {
	page-break-after: always;
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
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——案件来源登记表");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", strBodyStyle
				+ document.getElementById("page1").innerHTML);
	}
</script>

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
			<p class="p1">
				<span class="s1" style="text-align:center">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">案件来源登记表</span>
			</p>
			<div align="right">
				<p class="p3">
					<span class="s2"><%if (dto.getAjlywsbh() != null) { %>
					<%=dto.getAjlywsbh() %><%} %></span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<span class="s2"> 案件来源：<%=v_jdjc%>监督检查
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    <%=v_tsjb%>投诉/举报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    <%=v_sjjb%>上级交办&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					    <%=v_xjbq%>下级报请&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</p>
			<p class="p5">
				<span class="s2">
				    <%=v_jdcy%>监督抽验&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <%=v_ys%>移送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <%=v_qt%>其他
				</span>
			</p>
			<p class="p61">
				<span class="s2">当事人：</span><span class="wsty" style="width:525px;">
				<%=dto.getAjlydsr()%></span>
			</p>
			<p class="p61">
			<span class="s2">地址：</span><span class="wsty" style="width:398px;"><%=
								dto.getAjlydz() %></span>
			<span class="s2">邮编：</span><span class="wsty" style="width:97px;"><%=
								dto.getAjlyyb() %></span>
			</p>
			<p class="p6">
			<span class="s2">法定代表人（负责人）/自然人：</span><span class="wsty" style="width:158px;"><%=
								dto.getAjlyfddbr() %></span>
			<span class="s2">联系电话：</span><span class="wsty" style="width:148px;"><%=
								dto.getAjlylxdh() %></span>
			</p>
			<p class="p7">
			<span class="s2">法定代表人（负责人）/自然人身份证号码：</span>
			<span class="wsty" style="width:308px;"><%=dto.getAjlyfddbrsfzh()%></span>
			</p>
			<p class="p8">
			<span class="s2">登记时间：</span>
			<% if (!"".equals(dto.getAjlydjsj()) && dto.getAjlydjsj() != null){%>
			<span class="wsty" style="width:100px;text-align: center"><%=dto.getAjlydjsj().substring(0, 4)%></span>
			<span class="s2">年</span>
			<span class="wsty" style="width:85px;text-align: center"><%=dto.getAjlydjsj().substring(5, 7)%></span>
			<span class="s2">月</span>
			<span class="wsty" style="width:80px;text-align: center"><%=dto.getAjlydjsj().substring(8, 10)%></span>
			<span class="s2">日</span>
			<span class="wsty" style="width:75px;text-align: center"><%=dto.getAjlydjsj().substring(11, 13)%></span>
			<span class="s2">时</span>
			<span class="wsty" style="width:75px;text-align: center"><%=dto.getAjlydjsj().substring(14, 16)%></span>
			<span class="s2">分</span>
			<%}else{%>
			<span class="wsty" style="width:100px;text-align: center"></span>年
			<span class="wsty" style="width:85px;text-align: center"></span>月
			<span class="wsty" style="width:80px;text-align: center"></span>日
			<span class="wsty" style="width:75px;text-align: center"></span>时
			<span class="wsty" style="width:75px;text-align: center"></span>分
			<%} %>
			
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p9">
			<span class="s2">基本情况介绍：</span>
			</p>
			<p class="p10" style="text-indent: 2em; min-height: 80px;">
			<span style="word-break: break-all; word-wrap:break-word;dispaly:inline-block;">
			<%=SysmanageUtil.replaceStrChuLast(dto.getAjlyjbqkjs()) %>
			</span></p>
			<p class="p12">
			<span class="s2">附件：<%=dto.getAjlyfj() %></span>
			</p>
			<p class="p3"  >
			<span class="s2 s22">记录人：______________(签字)</span>
			</p>
			<p class="p3">
			<span class="s2 s22" >
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			</span>
			</p>
			<p class="p13"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />

			<p class="p6">
			<span class="s2">处理意见：</span>
			<br>
			<br>
			</p>
			<p class="p14" style="text-indent: 2em; min-height: 50px;" >
			<span style="word-break: break-all; word-wrap:break-word;dispaly:inline-block;">
			<%=SysmanageUtil.replaceStrChuLast(dto.getAjlyclyj()) %>
			</span>
			</p>
			<p class="p14"></p>
			<p class="p14">
			<span class="s2"> </span>
			</p>
			<p class="p3">
			<span class="s2 s22">承办部门负责人：_____________(签字)   </span>
			</p>
			<p class="p3">
			<span class="s2 s22">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			</span>
			</p>
			<p class="p15"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
</body>
</div>
</html>
