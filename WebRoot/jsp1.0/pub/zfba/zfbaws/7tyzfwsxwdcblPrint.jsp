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
	border-bottom: 1px solid  black;display: inline-block; vertical-align:bottom;
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
		var strBodyStyle = "<style>" + document.getElementById("sty1").innerHTML + "</style>";
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——询问调查表");
		LODOP.ADD_PRINT_HTM("60mm", "20mm", "RightMargin:1.8cm",
				"BottomMargin:4.3cm", strBodyStyle + document.getElementById("page1").innerHTML);
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
				<span class="s4" style="width:550px; ">
				<%if(dto.getAjdjay() != null){ %> 
				<%=dto.getAjdjay()%><%} %></span>
			</p>
			<p class="p5">
				<span class="s2">调查时间： </span>
				<%if(dto.getDcbldckssj() != null && !"".equals(dto.getDcbldckssj())){ %>
				<%=dto.getDcbldckssj().substring(0, 4)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>年</span>
				<%if(dto.getDcbldckssj() != null && !"".equals(dto.getDcbldckssj())){ %>
				<%=dto.getDcbldckssj().substring(5, 7)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>月</span>
				<%if(dto.getDcbldckssj() != null && !"".equals(dto.getDcbldckssj())){ %>
				<%=dto.getDcbldckssj().substring(8, 10)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>日</span>
				<%if(dto.getDcbldckssj() != null && !"".equals(dto.getDcbldckssj())){ %>
				<%=dto.getDcbldckssj().substring(11, 13)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>时</span>
				<%if(dto.getDcbldckssj() != null && !"".equals(dto.getDcbldckssj())){ %>
				<%=dto.getDcbldckssj().substring(14, 16)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>分</span>
				至
				<%if(dto.getDcbldcjssj() != null && !"".equals(dto.getDcbldcjssj())){ %>
				<%=dto.getDcbldcjssj().substring(11, 13)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>时</span>
				<%if(dto.getDcbldcjssj() != null && !"".equals(dto.getDcbldcjssj())){ %>
				<%=dto.getDcbldcjssj().substring(14, 16)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>分</span>
			</p>
			<p class="p5">
				<span class="s2"> 调查地点： </span>
				<span class="s4" style="width:535px; "><%if (dto.getDcbldcdd() != null) { %>
				<%=dto.getDcbldcdd()%><%} %></span>
			</p>
			<p class="p5">
				<span class="s2">被调查人： </span>
				<span class="s4" style="width:100px; "><%if (dto.getDcblbdcr() != null) { %>
				<%=dto.getDcblbdcr()%><%} %></span>
				<span class="s2">性别： </span>
				<span class="s4" style="width:40px; ">
				<%if(dto.getDcblbxwrxbstr()!=null){%><%=dto.getDcblbxwrxbstr()%><%} %></span>
				<span class="s2">民族： </span>
				<span class="s4" style="width:40px; ">
				<%if(dto.getDcblmzstr()!=null){%><%=dto.getDcblmzstr()%><%} %></span> 
				<span class="s2">职务： </span>
				<span class="s4" style="width:80px; "><%if (dto.getDcblzw() != null) { %>
				<%=dto.getDcblzw()%><%} %></span>
			</p>
			<p class="p5">
				<span class="s2">身份证号： </span>
				<span class="s4" style="width:200px; "><%if (dto.getDcblsfzh() != null) { %>
				<%=dto.getDcblsfzh()%><%} %></span>
				<span class="s2">工作单位：</span>
				<span class="s4" style="width:240px; "><%if (dto.getDcblgzdw() != null) { %>
				<%=dto.getDcblgzdw()%><%} %></span> 
			</p>
			<p class="p5">
				<span class="s2">联系方式：</span>
				<span class="s4" style="width:110px; "> <%if (dto.getDcbllxfs() != null) { %>
				<%=dto.getDcbllxfs()%><%} %></span>
				<span class="s2">地址：</span>
				<span class="s4" style="width:170px; "><%if (dto.getDcbldz() != null) { %>
				<%=dto.getDcbldz()%><%} %></span>
				<span class="s2">邮编：</span>
				<span class="s4" style="width:120px; "><%if (dto.getDcblbdcryb() != null) { %>
				<%=dto.getDcblbdcryb()%><%} %></span> 
			</p>
			<p class="p5">
				<span class="s2">调查人：</span> 
				<span class="s4" style="width:80px; "><%if (dto.getDcbldcr1() != null) { %>
				<%=dto.getDcbldcr1()%><%} %></span>
				<span class="s2">、</span> 
				<span class="s4" style="width:80px; "><%if (dto.getDcbldcr2() != null) { %>
				<%=dto.getDcbldcr2()%><%} %></span> 
				<span class="s2">记录人：</span>
				<span class="s4" style="width:80px; "><%if (dto.getDcbljlr() != null) { %>
				<%=dto.getDcbljlr()%><%} %></span>  
				<span class="s2">监督检查类别：</span>
				<span class="s4" style="width:80px; ">
				<%if(dto.getDcbljdjclbstr()!=null) %><%=dto.getDcbljdjclbstr()%><% %></span>
				
			</p>
			
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p5 l24">
				<span class="s2">我们是</span>
				<span class="s2">
				<%if (dto.getSpypjdgljmcqc() != null && !"".equals(dto.getSpypjdgljmcqc())) { %> 
				<%=dto.getSpypjdgljmcqc()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">的执法人员 </span>
				<span class="s2">
				<%if (dto.getDcbldcr1() != null && !"".equals(dto.getDcbldcr1())) { %> 
				<%=dto.getDcbldcr1()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">、</span>
				<span class="s2">
				<%if (dto.getDcbldcr2() != null && !"".equals(dto.getDcbldcr2())) { %> 
				<%=dto.getDcbldcr2()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">，执法证件名称、编号是：</span> 
				<span class="s2">
				<%if (dto.getDcbldcr1zjbh() != null && !"".equals(dto.getDcbldcr1zjbh())) { %> 
				<%=dto.getDcbldcr1zjbh()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>、
				<span class="s2">
				<%if (dto.getDcbldcr2zjbh() != null && !"".equals(dto.getDcbldcr2zjbh())) { %> 
				<%=dto.getDcbldcr2zjbh()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2"> ，请你过目。</span>
			</p>
			<p class="p7">
				<span class="s2">问：你是否看清楚？</span>
			</p>
			<p class="p7">
				<span class="s2">答：<span class="s2" style="width: 300px;"><%if (dto.getDcblsfkqc() != null) { %>
				<%=dto.getDcblsfkqc()%><%} %></span></span>
			</p>
			<p class="p6 l24">
				<span class="s2">我们依法就</span>
				<span class="s2">
				<%if (dto.getDcblygwt() != null && !"".equals(dto.getDcblygwt())) { %> 
				<%=dto.getDcblygwt()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">有关问题进行调查，请予配合。依照法律规定，对于调查人员，
					有下列情形之一的，必须回避，你也有权申请调查人员回避：（1）系当事人或当事人的近亲属；（2）与本案有直接利害关系； （3）与当事人有其他关系，可能影响案件公正处理的。</span>
			</p>
			<p class="p7">
				<span class="s2">问：你是否申请调查人员回避？</span>
			</p>
			<p class="p7">
				<span class="s2">答：<span class="s2" style="width: 300px;"> <%if (dto.getDcblsfsqdcryhb() != null) {%>
				<%=dto.getDcblsfsqdcryhb()%><%} %> </span></span>
			</p>
			<p class="p7">
				<span class="s2">问：你有如实接受调查的法律义务，如有意隐匿违法行为或故意作伪证将承担法律责任，你是否明白？</span>
			</p>
			<p class="p7">
				<span class="s2">答：<span class="s2" style="width: 300px;"> <%if (dto.getDcblsfmbbnzwz() != null) { %>
				<%=dto.getDcblsfmbbnzwz()%><%} %> </span></span>
			</p>
			<p class="p7 l24" style="text-indent:0in; width:610px;min-height: 50px; ">
				<span class="s2" > 调查记录： </span>
				<%if (dto.getDcbldcjl() != null && !"".equals(dto.getDcbldcjl())) { %> 
				<%=SysmanageUtil.replaceStrChuLast(dto.getDcbldcjl())%> <%} %>
			</p>
		</div>
		<div id="footer">
			<p >
				<span class="s2">被调查人签字：________________
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
				日期：_______年_____月_____日</span>
				</span> 
			</p>
			<p>
				  <span class="s2">调查人签字：_________________
				  <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
					日期：_______年_____月_____日</span>
		   		</span>
		   	</p>
		   	<p >
				<span class="s2">记录人签字：_________________
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
				 日期：_______年_____月_____日</span>
				</span> 
			</p>
			<p class="p10"></p>
		</div>
	</body>
</div>

</html>
