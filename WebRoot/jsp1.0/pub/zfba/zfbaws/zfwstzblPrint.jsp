<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwstzbl24DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 案件登记id	
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 听证笔录
	Zfwstzbl24DTO localZfwstzbl24DTO = new Zfwstzbl24DTO();
    if (request.getAttribute("printbean") != null) {
    	localZfwstzbl24DTO = (Zfwstzbl24DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:4.5833335in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:0.29166666in;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
</style>

<title>听证笔录</title>
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
.PageNext{page-break-after: always;} 
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——听证笔录");
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:5.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
  	 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5"); 
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5"); 
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto; display: none;">
<body class="b1 b2">
	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
	<div class="Noprint">
		<!-- 
	    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
	    	class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
		<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
			class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
		-->
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" 
			class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" 
			class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" 
			class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>	
	<!-- 标题第一页 -->
	<div align="center" id="title1">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">听证笔录</span></p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<!-- 标题除了第一页 -->
	<div align="center" id="title2">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">(听证笔录)副页</span></p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">
		<p class="p4">
			<span class="s2">案由：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
				localZfwstzbl24DTO.getAjdjay(),130,0)%></span>	
		</p>
		<p class="p4">
			<span class="s2">当事人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
				localZfwstzbl24DTO.getCommc(),130,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getComfrhyz(),18,0) %></span>
			<span class="s2">性别：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblfddbrxbstr(),9,0)%></span>
			<span class="s2">年龄：</span>
			<% if (localZfwstzbl24DTO.getTzblfddbrnl()!=null && !"".equals(localZfwstzbl24DTO.getTzblfddbrnl())) {%>
			<span class="s3"><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzblfddbrnl().toString(),9,0)%></span>
			<% } else {%>
			<span class="s3"><%=StringHelper.myMakeStrLen("",3,0)%></span>
			<% } %>
			<span class="s2">联系方式：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblfddbrlxfs(),20,0) %></span>
		</p>
		<p class="p4">
			<span class="s2">地址：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzbldz(),135,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">委托代理人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlr(),15,0)%></span>
			<span class="s2">性别：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlrxbstr(),8,0)%></span>
			<span class="s2">年龄：</span>
			<% if (localZfwstzbl24DTO.getTzblwtdlrnl()!=null && !"".equals(localZfwstzbl24DTO.getTzblwtdlrnl())) {%>
			<span class="s3"><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzblwtdlrnl().toString(),8,0)%></span>
			<% } else {%>
			<span class="s3"><%=StringHelper.myMakeStrLen("",3,0)%></span>
			<% } %>
			<span class="s2">职务：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlrzw(),10,0)%></span>
			<span class="s2">联系方式：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlrlxfs(),15,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">工作单位：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlrgzdw(),40,0)%></span>
			<span class="s2">地址：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblwtdlrdz(),60,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr1(),35,0)%></span>
			<span class="s2">部门：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr1bm(),35,0)%></span>
			<span class="s2">职务：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr1zw(),22,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr2(),35,0)%></span>
			<span class="s2">部门：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr2bm(),35,0)%></span>
			<span class="s2">职务：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzblajcbr2zw(),22,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">听证主持人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzbltzzcr(),60,0)%></span>
			<span class="s2">记录人：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzbljlr(),60,0)%></span>
		</p>
		<p class="p4">
			<span class="s2">听证时间：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzkssj().substring(0,4),15,1)%></u>
			</span>
			<span class="s2">年</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzkssj().substring(5,7),10,1)%></u>
			</span>
			<span class="s2">月</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzkssj().substring(8,10),10,1)%></u>
			</span>
			<span class="s2">日</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzkssj().substring(11,13),10,1)%></u>
			</span>
			<span class="s2">时</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzkssj().substring(14,16),10,1)%></u>
			</span>
			<span class="s2">分至</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzjssj().substring(11,13),10,1)%></u>
			</span>
			<span class="s2">时</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwstzbl24DTO.getTzbltzjssj().substring(14,16),10,1)%></u>
			</span>
			<span class="s2">分</span>
		</p>
		<p class="p4">
			<span class="s2">听证方式：</span>
			<span class="s3"><%=StringHelper.myMakeStrLen(
					localZfwstzbl24DTO.getTzbltzfs(),130,0)%></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6">
			<span class="s2">记录：</span>
		</p>
		<p class="p6 l24">
			<%=localZfwstzbl24DTO.getTzbljl() %>
		</p>
	</div>
	<div id="footer">
		<p class="p6">
		<span class="s2">当事人或委托代理人：<%=localZfwstzbl24DTO.getTzbldsrqz()%>（签字）
			<%=localZfwstzbl24DTO.getTzbldsrqzrq().substring(0,4)%>年
			<%=localZfwstzbl24DTO.getTzbldsrqzrq().substring(5,7)%>月
			<%=localZfwstzbl24DTO.getTzbldsrqzrq().substring(8,10)%>日
		</span>
		</p>
		<p class="p6">
			<span class="s2">案件承办人：<%=localZfwstzbl24DTO.getTzblajcbrqz()%>（签字）
				<%=localZfwstzbl24DTO.getTzblajcbrrq().substring(0,4)%>年
				<%=localZfwstzbl24DTO.getTzblajcbrrq().substring(5,7)%>月
				<%=localZfwstzbl24DTO.getTzblajcbrrq().substring(8,10)%>日
			</span>
		</p>
		<p class="p6">
			<span class="s2">听证主持人：<%=localZfwstzbl24DTO.getTzbltzzcrqz()%>（签字）
				<%=localZfwstzbl24DTO.getTzbltzzcrqzrq().substring(0,4)%>年
				<%=localZfwstzbl24DTO.getTzbltzzcrqzrq().substring(5,7)%>月
				<%=localZfwstzbl24DTO.getTzbltzzcrqzrq().substring(8,10)%>日
			</span>
		</p>
		<p class="p6">
			<span class="s2">注：听证笔录经当事人审核无误后逐页签字，修改处签字或按指纹，
				并在笔录上注明对笔录真实性的意见。案件承办人和听证主持人在笔录上签字。</span>
		</p>
	</div>
</body>
</div>
</html>
