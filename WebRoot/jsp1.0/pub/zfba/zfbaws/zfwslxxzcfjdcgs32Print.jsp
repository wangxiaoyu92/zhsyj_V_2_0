<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwslxxzcfjdcgs32DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwslxxzcfjdcgs32DTO dto = new Zfwslxxzcfjdcgs32DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwslxxzcfjdcgs32DTO)request.getAttribute("mybean");
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
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p3{text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.tr{text-align: right;}
.lh24{line-height: 24px;}
</style>
<title>履行行政处罚决定催告书</title>
<meta content="X" name="author">

<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——履行行政处罚决定催告书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 	
	CreatePrintPage();
  	LODOP.PREVIEW();		
};

//直接打印
function printData(){
    LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——履行行政处罚决定催告书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 		
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
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%","注：存档（1）");
	LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%","注：交当事人（2）");
	LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%","注：必要时交 <%if (dto.getQzzzrmfy() != null) {%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（3）");
	
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none">
	<body class="b1 b2">
	<div class="Noprint">
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<div align="center" id="page1">
		<p class="p1"><span class="s1"><%if (dto.getXzjgmc() != null) { %>
				<%=dto.getXzjgmc() %><%} %></span></p>
		<p class="p2">
		<span class="s1">履行行政处罚决定催告书</span>
		</p>
		<p class="p3 tr">
		<span class="s2"><%if (dto.getLxcgwsbh() != null) { %>
		<%=dto.getLxcgwsbh() %><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
		<%if (dto.getLxcgdsr() != null && !"".equals(dto.getLxcgdsr())) { %>
			<%=dto.getLxcgdsr() %> <%} else {%>
		<span class="s2" style="border-bottom: 0px solid  white-space;display: inline-block;width: 300px;"></span><%} %>：
		</p>
		<p class="p5 lh24">
			<span class="s2">我局于</span>
			<%if(dto.getLxcgxzcfjdsrq() != null && !"".equals(dto.getLxcgxzcfjdsrq())){ %>
			<span class="s2"><%=dto.getLxcgxzcfjdsrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getLxcgxzcfjdsrq() != null && !"".equals(dto.getLxcgxzcfjdsrq())){ %>
			<span class="s2"><%=dto.getLxcgxzcfjdsrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getLxcgxzcfjdsrq() != null && !"".equals(dto.getLxcgxzcfjdsrq())){ %>
			<span class="s2"><%=dto.getLxcgxzcfjdsrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日向你（单位）送达了</span>
			<%if (dto.getLxcgxzcfjdsbh() != null && !"".equals(dto.getLxcgxzcfjdsbh())) { %>
			<span class="s2"><%=dto.getLxcgxzcfjdsbh() %></span>
			 <%} else {%>
			 <span style="border-bottom: 0px solid  white-space;display: inline-block;  width:150px;"></span><%} %>
			<span class="s2">《行政处罚决定书》，决定对你（单位）进行如下行政处罚：</span>
			<%if (dto.getLxcgxzcfnr() != null && !"".equals(dto.getLxcgxzcfnr())) { %>
			<span class="s2"><%=dto.getLxcgxzcfnr()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;  width:150px;"></span><%} %>
			<span class="s2">并要求你（单位）</span>
			<%if(dto.getLxcgjfkjzrq() != null && !"".equals(dto.getLxcgjfkjzrq())){ %>
			<span class="s2"><%=dto.getLxcgjfkjzrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getLxcgjfkjzrq() != null && !"".equals(dto.getLxcgjfkjzrq())){ %>
			<span class="s2"><%=dto.getLxcgjfkjzrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getLxcgjfkjzrq() != null && !"".equals(dto.getLxcgjfkjzrq())){ %>
			<span class="s2"><%=dto.getLxcgjfkjzrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日前到</span>
			<%if (dto.getFmkjkyh() != null && !"".equals(dto.getFmkjkyh())) { %>
			<span class="s2"><%=dto.getFmkjkyh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;  width:100px;"></span><%} %>
			<span class="s2">银行缴纳罚没款。由于你（单位）至今未(全部)履行处罚决定，根据《中华人民共和国行政处罚法》第五十一条第一项的规定，我局决定自</span>
			<%if(dto.getLxcgjcfksrq() != null && !"".equals(dto.getLxcgjcfksrq())){ %>
			<span class="s2"><%=dto.getLxcgjcfksrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getLxcgjcfksrq() != null && !"".equals(dto.getLxcgjcfksrq())){ %>
			<span class="s2"><%=dto.getLxcgjcfksrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getLxcgjcfksrq() != null && !"".equals(dto.getLxcgjcfksrq())){ %>
			<span class="s2"><%=dto.getLxcgjcfksrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日起每日按罚款额3%加处罚款。请接到本催告书后10个工作日内到</span>
			<%if (dto.getLxcgxjfkyh() != null && !"".equals(dto.getLxcgxjfkyh())) { %>
			<span class="s2"><%=dto.getLxcgxjfkyh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;  width:100px;"></span><%} %>
			<span class="s2">银行缴清应缴罚没款及加处罚款</span>
			<%if (dto.getLxcgjcfk() != null && !"".equals(dto.getLxcgjcfk())) { %>
			<span class="s2"><%=dto.getLxcgjcfk()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;  width:100px;"></span><%} %>
			<span class="s2">。逾期我局将根据《中华人民共和国行政强制法》第五十三条、五十四条的规定，依法向人民法院申请强制执行。</span>
		</p>
		<p class="p6"> 
			<span class="s2">如你（单位）对我局作出的履行行政处罚决定催告不服，可于</span>
			<%if(dto.getLxcgcssbrq() != null && !"".equals(dto.getLxcgcssbrq())){ %>
			<span class="s2"><%=dto.getLxcgcssbrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getLxcgcssbrq() != null && !"".equals(dto.getLxcgcssbrq())){ %>
			<span class="s2"><%=dto.getLxcgcssbrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getLxcgcssbrq() != null && !"".equals(dto.getLxcgcssbrq())){ %>
			<span class="s2"><%=dto.getLxcgcssbrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日前进行陈述和申辩。</span> 
		</p> 
		<br><br><br><br><br><br>
		<p class="p8 tr">
			<span class="s2" style="margin-right: 80px"> （公    章）</span>
		</p> 
		<br><br>
		<p class="p8 tr" style="margin-right: 30px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
	   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日 
		</p> 
		<br><br><br><br>
		<p class="p6"> 
			<span class="s2">当事人：</span>
			<span class="s2" style="border-bottom: 1px solid  black;display: inline-block;width: 150px;"></span>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>年
	   		<span style="border-bottom: 0px solid  white-space;width: 60px;display: inline-block;"></span>月
	   		<span style="border-bottom: 0px solid  white-space;width: 60px;display: inline-block;"></span>日 
		</p> 
	  </div>
	  </body>
	</div>
</html>
