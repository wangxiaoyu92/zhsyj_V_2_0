<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxwdcbl7DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";

	Zfwsxwdcbl7DTO dto = new Zfwsxwdcbl7DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwsxwdcbl7DTO) request.getAttribute("printbean");
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
	font-family: 宋体;
	font-size: 22pt;
}

.p3 {
	margin-top: 0.108333334in;
	text-align: end;
	hyphenate: auto;
	font-family: 仿宋;
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
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p6 {
	text-indent: 0.25in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p7 {
	text-indent: 0in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p8 {
	text-indent: -0.13in;
	margin-left: 0.14583333in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p9 {
	text-indent: -0.1388889in;
	margin-left: 0.1388889in;
	margin-top: 0.108333334in;
	text-align: justify;
	hyphenate: auto;
	font-family: 仿宋_GB2312;
	font-size: 10.5pt;
}

.p10 {
	text-align: justify;
	hyphenate: auto;
	font-family: Times New Roman;
	font-size: 10.5pt;
}

.page {
	font-size: 10.5pt;
	text-align: right;
	margin: 0px;
	padding: 0px;
}

.l24 {
	line-height: 30px;
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
.Noprint{text-align:center;} 
.PageNext{page-break-after: always;} 
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
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——询问调查表");
		//LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");//A4 纵向
		LODOP.ADD_PRINT_HTML("60mm", "20mm", "RightMargin:1.8cm",
				"BottomMargin:4.3cm", strBodyStyle
						+ document.getElementById("page1").innerHTML);
		//添加内容
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
				strBodyStyle + document.getElementById("title1").innerHTML);
		LODOP.SET_PRINT_STYLEA(0, "PageIndex", 1);
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
				strBodyStyle + document.getElementById("title2").innerHTML);
		LODOP.SET_PRINT_STYLEA(0, "PageIndex", "2,3,4");
		LODOP.ADD_PRINT_HTM("260mm","20mm", "RightMargin:1.8cm","100mm",
				strBodyStyle+document.getElementById("footer").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5"); 
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
		<div align="center" id="title1">
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">询问调查笔录</span>
			</p>
			<p class="page">
				<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount"
					format="#">共###页</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
		<div align="center" id="title2">
			<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
				<span class="s1">（询问调查笔录）副页</span>
			</p>
			<p class="page">
				<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount"
					format="#">共###页</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
		<div align="center" id="page1">
			<p class="p4">
				<span>案 由：</span> 
				<span class="s4" style="width:590px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if(dto.getAjdjay() != null){ %> 
				<%=StringHelper.myMakeStrLen(dto.getAjdjay(), 120, 0)%><%} %></span>
			</p>
			<p class="p5">
				<span class="s2"> 调查地点： </span>
				<span class="s4" style="width:565px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if(dto.getDcbldcdd() != null){ %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldcdd(), 120, 0)%><%} %></span>

			</p>
			<p class="p5">
				<span class="s2">被调查人： </span>
				<span class="s4" style="width:120px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcblbdcr(), 60, 0)%></span>
				<span class="s2">职务： </span>
				<span class="s4" style="width:100px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcblzw(), 60, 0)%></span>
				<span class="s2">民族： </span>
				<span class="s4" style="width:60px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcblmzstr(), 40, 0)%></span>
				<span class="s2">身份证号： </span>
				<span class="s4" style="width:105px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcblsfzh(), 60, 0)%></span>
			</p>
			<p class="p5">
				<span class="s2">工作单位：</span>
				<span class="s4" style="width:160px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcblgzdw(), 60, 0)%></span>
				<span class="s2">联系方式：</span>
				<span class="s4" style="width:110px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbllxfs(), 60, 0)%></span>
				<span class="s2">地址：</span>
				<span class="s4" style="width:170px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldz(), 40, 0)%></span>
			</p>
			<p class="p5">
				<span class="s2">调查人：</span> 
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr1(), 40, 0)%></span>
				<span class="s2">、</span> 
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr2(), 40, 0)%></span> 
				<span class="s2">记录人：</span>
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbljlr(), 40, 0)%></span>  
				<span class="s2">监督检查类别：</span>
				<span class="s4" style="width:100px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbljdjclbstr(), 40, 0)%></span>
				
			</p>
			<p class="p5">
				<span class="s2">调查时间： </span>
				<span class="s4" style="width:75px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldckssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldckssj().substring(0, 4), 40, 1)%><%} %></span>
				<span class="s2">年</span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldckssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldckssj().substring(5, 7), 40, 1)%><%} %></span>
				<span class="s2">月</span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldckssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldckssj().substring(8, 10), 40, 1)%><%} %></span>
				<span class="s2">日</span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldckssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldckssj().substring(11, 13), 40, 1)%><%} %></span>
				<span class="s2">时</span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldckssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldckssj().substring(14, 16), 40, 1)%><%} %></span>
				<span class="s2">分</span>
				<span class="s2">至 </span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%if (dto.getDcbldcjssj() != null) { %> 
				<%=StringHelper.myMakeStrLen(dto.getDcbldcjssj().substring(11, 13), 40, 1)%><%} %></span>
				<span class="s2">时</span>
				<span class="s4" style="width:55px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;"> 
				<%if (dto.getDcbldcjssj() != null) { %>
				<%=StringHelper.myMakeStrLen(dto.getDcbldcjssj().substring(14, 16), 40, 1)%><%} %></span>
				<span class="s2">分</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5 l24">
				<span class="s2">我们是</span>
				<span class="s4" style="width:150px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getSpypjdgljmcqc(), 40, 0)%></span>
				<span class="s2">的执法人员 </span>
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr1(), 40, 0)%></span>
				<span class="s2">、</span>
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr2(), 40, 0)%></span>
				<span class="s2">，执法证件名称、编号是：</span> 
				<span class="s4" style="width:180px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getZfzjmc(), 60, 0)%></span>
				<span class="s2">、</span>
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr1zjbh(), 40, 0)%></span>
				<span class="s2">、</span>
				<span class="s4" style="width:80px;overflow:hidden;white-space:nowrap;word-break:keep-all;display: inline-block;">
				<%=StringHelper.myMakeStrLen(dto.getDcbldcr2zjbh(), 40, 0)%></span>
				<span class="s2"> ，请你过目。</span>
			</p>
			<p class="p7">
				<span class="s2">问：你是否看清楚？</span>
			</p>
			<p class="p7">
				<span class="s2">答：<%if(dto.getDcblsfkqc() != null){ %>
				<%=dto.getDcblsfkqc()%><%} %></span>
			</p>
			<p class="p6 l24">
				<span class="s2">我们依法就</span>
				<span class="s4"><%if(dto.getDcblygwt() != null){ %>
				<%=dto.getDcblygwt()%><%} %></span>
				<span class="s2">有关问题进行调查，请予配合。依照法律规定，对于调查人员，
					有下列情形之一的，必须回避，你也有权申请调查人员回避： （1）系当事人或当事人的近亲属；（2）与本案有直接利害关系；
					（3）与当事人有其他关系，可能影响案件公正处理的。</span>
			</p>
			<p class="p7">
				<span class="s2">问：你是否申请调查人员回避？</span>
			</p>
			<p class="p7">
				<span class="s2">答：<%if(dto.getDcblsfsqdcryhb() != null){ %>
				<%=dto.getDcblsfsqdcryhb()%><%} %></span>
			</p>
			<p class="p7">
				<span class="s2">问：你有如实接受调查的法律义务，如有意隐匿违法行为或故意作伪证将承担法律责任，你是否明白？</span>
			</p>
			<p class="p8">
				<span class="s2">答：<%if(dto.getDcblsfmbbnzwz() != null){ %>
				<%=dto.getDcblsfmbbnzwz()%><%} %></span>
			</p>
			<p class="p7">
				<span class="s2  l24" style="text-indent:0in; width:610px; word-wrap:break-word;word-break:normal;display: inline-block;">
				调查记录：
				<%if(dto.getDcbldcjl() != null){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getDcbldcjl())%><%} %>
				</span>
			</p>
			<p class="p9"></p>
			<p class="p9"></p>
			<p class="p9"></p>
			<p class="p9"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
		</div>
		<div id="footer">
			<p class="p4">
				<span class="s2">被调查人签字：</span>
				<span class="s4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span class="s2">执法人员签字：</span>
				<span class="s4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span class="s2">&nbsp;、&nbsp;</span>
				<span class="s4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</p>
				<span class="s3"> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
				</span> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span class="s3">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日 
		   		</span>
			<p class="p10"></p>
		</div>
	</body>
</div>

</html>
