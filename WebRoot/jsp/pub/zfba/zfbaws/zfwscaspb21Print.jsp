<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwscaspb21DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	// 撤案审批表
	Zfwscaspb21DTO dto = new Zfwscaspb21DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwscaspb21DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-family:Times New Roman;font-size:22pt;font-weight:bold;color:black;}
.s3{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:仿宋;font-size:10.5pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p33{margin-top:0.108333334in;text-align:right;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:2em;}
</style>
<title>撤案审批表</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——撤案审批表");
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
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s2">撤案审批表</span></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案由：<%if (dto.getAjdjay() != null) { %>
			<%=dto.getAjdjay()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">当事人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 260px;display: inline-block;">
			<%if (dto.getCaspdsr() != null) { %><%=dto.getCaspdsr() %><%} %></span>
            <span class="s3">法定代表人（负责人）：</span>
            <span style="border-bottom: 0px solid  white-space;display: inline-block;">
            <%if (dto.getCaspfddbr() != null) { %> <%=dto.getCaspfddbr()%><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">地&nbsp;&nbsp;址：</span>
			<span style="border-bottom: 0px solid  white-space;width: 265px;display: inline-block;">
			<%if (dto.getCaspdz() != null) { %><%=dto.getCaspdz() %><%} %></span>
            <span class="s3">联系方式：</span>
            <span style="border-bottom: 0px solid  white-space;display: inline-block;">
            <%if (dto.getCasplxfs() != null) { %> <%=dto.getCasplxfs() %><%} %></span>
		</p>
		<p class="p3">
			<span class="s3">案件来源：</span>
			<span style="border-bottom: 0px solid  white-space;width: 245px;display: inline-block;">
			<%if (dto.getAjdjajlystr() != null) { %><%=dto.getAjdjajlystr() %><%} %></span>					
            <span class="s3">立案时间：</span>
            <%if(dto.getCasplasj() != null && !"".equals(dto.getCasplasj())){ %>
			<span class="s3"><%=dto.getCasplasj().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s3">年</span>
			<%if(dto.getCasplasj() != null && !"".equals(dto.getCasplasj())){ %>
			<span class="s3"><%=dto.getCasplasj().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s3">月</span>
			<%if(dto.getCasplasj() != null && !"".equals(dto.getCasplasj())){ %>
			<span class="s3"><%=dto.getCasplasj().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s3">日</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
			<span class="s3">案情调查摘要：</span>
		</p>
		<p style="min-height: 40px;">
			<%if(dto.getCaspaqdczy() != null && !"".equals(dto.getCaspaqdczy())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getCaspaqdczy())%><%}%>
		</p>
		<p class="p3"><span class="s3">撤案理由：</span></p>
		<p style="min-height: 30px;">
			<%if(dto.getCaspcaly() != null && !"".equals(dto.getCaspcaly())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getCaspcaly())%><%} else{%>
				<br><br><%} %>
		</p>
		<p class="p33">
			<span class="s3">承办人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">、</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">（签字）</span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<p class="p33">
			<span class="s3">承办部门负责人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">（签字）</span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审核部门意见：</span>
		</p>
		<p style="min-height: 20px;">
			<%if(dto.getCaspshbmyj() != null && !"".equals(dto.getCaspshbmyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getCaspshbmyj())%><%}%>
		</p>
		<p class="p33">
			<span class="s3">负责人：	</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">（签字）</span>
		</p>
		<p class="p33">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s3">审批意见：</span>
		</p>
		<p style="min-height: 20px;">
			<%if(dto.getCaspspyj() != null && !"".equals(dto.getCaspspyj())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getCaspspyj())%><%} %>
		</p>
		<p class="p33">
			<span class="s3">分管负责人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			<span class="s3">（签字）</span>
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
