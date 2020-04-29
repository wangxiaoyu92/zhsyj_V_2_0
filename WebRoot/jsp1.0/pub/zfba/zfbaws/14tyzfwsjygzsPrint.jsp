<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsjyjcjyjdgzs14DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 14 检验（检测、检疫、鉴定）告知书
	Zfwsjyjcjyjdgzs14DTO dto = new Zfwsjyjcjyjdgzs14DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsjyjcjyjdgzs14DTO) request.getAttribute("printbean");
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
.s3{border-bottom: 1px solid  black;display: inline-block;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{text-indent:3.1930556in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.14583333in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.14583333in;margin-top:0.108333334in;
	text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.4375in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.33333334in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 34px;}
</style>

<title>检验（检测、检疫、鉴定）告知书</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——检验告知书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto; display: none;">
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
		<p class="p2"><span class="s1">检验（检测、检疫、鉴定）告知书</span></p>
		<div align="right">
			<p class="p3">
				<span class="s2"><%if (dto.getJygzwsbh() != null) { %>
				<%=dto.getJygzwsbh() %><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<%if (dto.getCommc() != null && !"".equals(dto.getCommc())) { %>
			<span class="s2"> <%=dto.getCommc()%>：</span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>:
			<%} %>
		</p>
		<p class="p5 l24">
			<span class="s2">我局决定对</span>
			<%if (dto.getJygzjzwsbh() != null && !"".equals(dto.getJygzjzwsbh())) { %>
			<span class="s2"> <%=dto.getJygzjzwsbh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
			<%} %>
			<%if (dto.getJygzjzwsmc() != null && !"".equals(dto.getJygzjzwsmc())) { %>
			<span class="s2"> <%=dto.getJygzjzwsmc()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
			<%} %>
			<span class="s2">所记载的物品进行检验（检测、检疫、鉴定），检验（检测、检疫、鉴定）期限自</span>
			<%if(dto.getJygzksrq() != null && !"".equals(dto.getJygzksrq())){ %>
			<%=dto.getJygzksrq().substring(0, 4)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getJygzksrq() != null && !"".equals(dto.getJygzksrq())){ %>
			<%=dto.getJygzksrq().substring(5, 7)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getJygzksrq() != null && !"".equals(dto.getJygzksrq())){ %>
			<%=dto.getJygzksrq().substring(8, 10)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日至</span>
			<%if(dto.getJygzjsrq() != null && !"".equals(dto.getJygzjsrq())){ %>
			<%=dto.getJygzjsrq().substring(0, 4)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getJygzjsrq() != null && !"".equals(dto.getJygzjsrq())){ %>
			<%=dto.getJygzjsrq().substring(5, 7)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getJygzjsrq() != null && !"".equals(dto.getJygzjsrq())){ %>
			<%=dto.getJygzjsrq().substring(8, 10)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日止。根据《中华人民共和国行政强制法》第二十五条第三款的规定，查封、扣押期间不包括检测、检验、检疫或者技术鉴定的期间。因此，我局对</span>
			<%if (dto.getJygzqzcsjdsmcjbh() != null && !"".equals(dto.getJygzqzcsjdsmcjbh())) { %>
			<span class="s2"> <%=dto.getJygzqzcsjdsmcjbh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;"></span>
			<%} %>
			<span class="s2">确定的行政强制措施期限顺延至</span>
			<%if(dto.getJygzqzcsqxsyrq() != null && !"".equals(dto.getJygzqzcsqxsyrq())){ %>
			<%=dto.getJygzqzcsqxsyrq().substring(0, 4)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getJygzqzcsqxsyrq() != null && !"".equals(dto.getJygzqzcsqxsyrq())){ %>
			<%=dto.getJygzqzcsqxsyrq().substring(5, 7)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getJygzqzcsqxsyrq() != null && !"".equals(dto.getJygzqzcsqxsyrq())){ %>
			<%=dto.getJygzqzcsqxsyrq().substring(8, 10)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日止。</span>
		</p>  
		<div align="right">
			<p class="p9">
				<span class="s2">（公   章）</span>
			</p>
			<p class="p9">
				<span class="s2">
					<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 	<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
				</span>
			</p>
			<br>
			<br>
			<br>
		</div> 
			<p class="p7">
			   <span class="s2">当事人签字：_________________</span>
			        <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 	<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			</p>
		<p class="p13"></p>
	</div>
</body>
</div>
</html>
