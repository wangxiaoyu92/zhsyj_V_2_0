<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsfzjgshyjs47DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 法制机构审核意见书
	Zfwsfzjgshyjs47DTO dto = new Zfwsfzjgshyjs47DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsfzjgshyjs47DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.2479167in 1.0in 1.2479167in;}
.s1{font-family:宋体;font-weight:bold;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p3{text-indent:-0.14583333in;margin-left:0.14583333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.14583333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.21875in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.21875in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.td1{width:0.95416665in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td2{width:5.029861in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td3{width:1.9159722in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td4{width:1.4006945in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td5{width:1.7131945in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.9423611in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td7{width:4.0875in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td8{width:5.029861in;padding-start:0.075in;padding-end:0.075in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;}
.r1{height:0.27986112in;keep-together:always;}
.r2{height:0.28680557in;keep-together:always;}
.r3{height:0.5729167in;keep-together:always;}
.r4{height:2.5819445in;keep-together:always;}
.r5{height:0.34861112in;}
.r6{height:0.27847221in;}
.r7{height:0.10069445in;}
.r8{height:1.5791667in;keep-together:always;}
.r9{height:1.6055555in;keep-together:always;}
.r10{height:0.24166666in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;}
</style>
<meta content="Administrator" name="author">

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
	LODOP=getLodop();
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——法制机构审核意见书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
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
	  
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
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
		<p class="p1">
			<span>河南省食品药品行政处罚案件法制机构</span><span class="s1">审核意见书</span>
		</p>
		<table class="t1">
			<tbody>
				<tr class="r1">
					<td class="td1">
						<p class="p2">
							<span>案    由</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p3"><%if (dto.getShyjsay() != null) { %><%=dto.getShyjsay()%><%} %></p>
					</td>
				</tr>
				<tr class="r2">
					<td class="td1">
						<p class="p2">
							<span>立 案 号</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p3"><%if (dto.getShyjslah() != null) { %><%=dto.getShyjslah()%><%} %></p>
					</td>
				</tr>
				<tr class="r2">
					<td class="td1">
						<p class="p2">
							<span>当 事 人</span>
						</p>
					</td>
					<td class="td3" colspan="2">
						<p class="p4"><%if (dto.getShyjsdsr() != null) { %><%=dto.getShyjsdsr()%><%} %></p>
					</td>
					<td class="td4">
						<p class="p2">
							<span>承办人</span>
						</p>
					</td>
					<td class="td5">
						<p class="p4"><%if (dto.getShyjscbr() != null) { %><%=dto.getShyjscbr()%><%} %></p>
					</td>
				</tr>
				<tr class="r3">
					<td class="td1">
						<p class="p2">
							<span>送审机构</span>
						</p>
					</td>
					<td class="td3" colspan="2">
						<p class="p4"><%if (dto.getShyjsssjg() != null) { %><%=dto.getShyjsssjg()%><%} %></p>
					</td>
					<td class="td4">
						<p class="p2">
							<span>送审时间</span>
						</p>
					</td>
					<td class="td5">
						<p class="p4"><%if (dto.getShyjssssj() != null) { %><%=dto.getShyjssssj()%><%} %></p>
					</td>
				</tr>
				<tr class="r4">
					<td class="td1">
						<p class="p2"></p>
						<p class="p2"></p>
						<p class="p5">
							<span>合议意见</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p2"><%if(dto.getShyjshyyj() != null && !"".equals(dto.getShyjshyyj())){ %>
							<%=SysmanageUtil.replaceStrChuLast(dto.getShyjshyyj())%><%} %></p>
					</td>
				</tr>
				<tr class="r5">
					<td class="td1" rowspan="5">
						<p class="p6"><span>审</span></p>
						<p class="p6"><span>核</span></p>
						<p class="p6"><span>内</span></p>
						<p class="p6"><span>容</span></p>
					</td>
					<td class="td6">
						<p class="p2">
							<span>事实</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><%if (dto.getShyjsshss() != null) { %><%=dto.getShyjsshss()%><%} %></p>
					</td>
				</tr>
				<tr class="r6">
					<td class="td6">
						<p class="p2">
							<span>证据</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><%if (dto.getShyjsshzj() != null) { %><%=dto.getShyjsshzj()%><%} %></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>依据</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><%if (dto.getShyjsshyj() != null) { %><%=dto.getShyjsshyj()%><%} %></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>程序</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><%if (dto.getShyjsshcx() != null) { %><%=dto.getShyjsshcx()%><%} %></p>
					</td>
				</tr>
				<tr class="r7">
					<td class="td6">
						<p class="p2">
							<span>处理</span>
						</p>
					</td>
					<td class="td7" colspan="3">
						<p class="p2"><%if (dto.getShyjsshcl() != null) { %><%=dto.getShyjsshcl()%><%} %></p>
					</td>
				</tr>
				<tr class="r8">
					<td class="td1">
						<p class="p6"><span>法  制</span></p>
						<p class="p7"></p>
						<p class="p6"><span>机  构</span></p>
						<p class="p7"></p>
						<p class="p6"><span>意  见</span></p>
					</td>
					<td class="td8" colspan="4">
						<p class="p2"><%if(dto.getShyjsfzjgyj() != null && !"".equals(dto.getShyjsfzjgyj())){ %>
							<%=SysmanageUtil.replaceStrChuLast(dto.getShyjsfzjgyj())%><%} %></p>
					</td>
				</tr>
				<tr class="r9">
					<td class="td1">
						<p class="p6"><span>领  导</span></p>
						<p class="p6"></p>
						<p class="p6"><span>审  批</span></p>
						<p class="p6"></p>
						<p class="p6"><span>意  见</span></p>
					</td>
					<td class="td2" colspan="4">
						<p class="p2"><%if(dto.getShyjsldspyj() != null && !"".equals(dto.getShyjsldspyj())){ %>
							<%=SysmanageUtil.replaceStrChuLast(dto.getShyjsldspyj())%><%} %></p>
					</td>
				</tr>
				<tr class="r10">
					<td class="td1">
						<p class="p6">
							<span>备  注</span>
						</p>
					</td>
					<td class="td2" colspan="4">
						<p class="p2">
							<span>此文书一式二联，第一联交办案机构。</span>
						</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</div>
</html>
