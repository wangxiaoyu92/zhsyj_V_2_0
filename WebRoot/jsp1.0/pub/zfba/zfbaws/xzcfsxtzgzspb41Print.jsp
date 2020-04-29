<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfsxtzgzspb41DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	// 撤案审批表
	Zfwsxzcfsxtzgzspb41DTO dto = new Zfwsxzcfsxtzgzspb41DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsxzcfsxtzgzspb41DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-size:10.5pt;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p2{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p33{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:12pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:3.5729167in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:2em;}
</style>
<title>行政处罚事先（听证）告知审批表</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚事先（听证）告知审批表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
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
		<p class="p1"><span class="s1">行政处罚事先（听证）告知审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p2">
			<span class="s2">案由：<%if (dto.getSxtzgzay() != null) { %>
			<%=dto.getSxtzgzay()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">当事人：<%if (dto.getSxtzgzdsr() != null) { %><%=dto.getSxtzgzdsr() %><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">主要违法事实：</span>
		</p>
		<p class="p3 l24" style="min-height: 50px;">
			<%if(dto.getZywfss() != null && !"".equals(dto.getZywfss())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getZywfss())%></span><%} %>
		</p>
		<p class="p3">
			<span class="s3">承办人员处罚意见：    </span>
		</p>
		<p class="p3 l24" style="min-height: 50px;">
			<%if(dto.getCbrycfyj() != null && !"".equals(dto.getCbrycfyj())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getCbrycfyj())%></span><%} %>
		</p>
		<p class="p33">
			<span class="s3">承办人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">、</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<p class="p3">
			<span class="s3">承办部门审查意见：</span>
		</p>
		<p class="p3 l24" style="min-height: 30px;">
			<%if(dto.getCbbmscyj() != null && !"".equals(dto.getCbbmscyj())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getCbbmscyj())%></span><%} %>
		</p>
		<p class="p33">
			<span class="s3">承办部门负责人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span>法制机构审核意见：</span>
		</p>
		<p class="p3 l24" style="min-height: 30px;">
			<%if(dto.getFzjgshyj() != null && !"".equals(dto.getFzjgshyj())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getFzjgshyj())%></span><%} %>
		</p>
		<p class="p33">
			<span class="s3">负责人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span>审批意见：</span>
		</p>
		<p class="p3 l24" style="min-height: 30px;">
			<%if(dto.getSpyj() != null && !"".equals(dto.getSpyj())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getSpyj())%></span><%} %>
		</p>
		<p class="p33">
			<span class="s3">负责人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
</body>
</div>
</html>
