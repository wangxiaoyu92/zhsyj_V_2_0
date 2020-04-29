<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjds28DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 行政处罚决定书
	Zfwsxzcfjds28DTO dto = new Zfwsxzcfjds28DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsxzcfjds28DTO) request.getAttribute("printbean");
    }	
%>
<html>   
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css"  id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-weight:bold;}
.s3{color:black;}
.s4{text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p55{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2.7708333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.lh30{line-height: 24px;}
</style>
<title>行政处罚决定书</title>
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
	s.type = "ok";       
	sy.setWinRet(s); 
var LODOP; //声明为全局变量

$(function(){	
	printView();
	parent.$("#"+sy.getDialogId()).dialog("close");
});

//打印预览 
function printView(){
    LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚决定书");
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%", "<p class='p9'><span class='s3'>注：存档（1），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行。</span></p>");
	LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p9'><span class='s3'>注：存档（2），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行。</span></p>");
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
			<span class="s1"><%if (dto.getZxjgmc() != null) { %>
				<%=dto.getZxjgmc() %><%} %>
			</span>
		</p>
		<p class="p2"><span class="s1">行政处罚决定书</span></p>
		<div align="right">
			<p class="p3">
				<span class="s3"><%if (dto.getCfjdwsbh() != null) { %> <%=dto.getCfjdwsbh() %><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p5"><span>当事人：</span></p>
		<p class="p55">
			<span>（个人）姓名：</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 170px;">
			<%if (dto.getCfjdbcfrzrrxm() != null) { %><%=dto.getCfjdbcfrzrrxm() %><%} %>
			</span>
			<span>公民身份（其他有效证件）号码：</span>
			<span><%if (dto.getGmsfhm() != null) { %><%=dto.getGmsfhm() %><%} %></span>
		</p>
		<p class="p55">
			<span>（单位）名称：</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 170px;">
			<%if (dto.getCfjdbcfrdwmc() != null) { %><%=dto.getCfjdbcfrdwmc() %><%} %>
			</span>
			<span>法定代表人（负责人）：</span>
			<span><%if (dto.getCfjdbcfrdwfddbr() != null) { %><%=dto.getCfjdbcfrdwfddbr() %><%} %></span>
		</p>
		<p class="p55">
			<span>住所（地址）：</span>
			<span><%if (dto.getCfjddz() != null) { %><%=dto.getCfjddz() %><%} %></span>
		</p>
		<p class="p5 lh30">
			<span>我局于</span>
			<%if(dto.getCfjdlarq() != null && !"".equals(dto.getCfjdlarq())){ %>
			<span><%=dto.getCfjdlarq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span>年</span>
			<%if(dto.getCfjdlarq() != null && !"".equals(dto.getCfjdlarq())){ %>
			<span><%=dto.getCfjdlarq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span>月</span>
			<%if(dto.getCfjdlarq() != null && !"".equals(dto.getCfjdlarq())){ %>
			<span><%=dto.getCfjdlarq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span>日对</span>
			<%if(dto.getCfjdajmc() != null && !"".equals(dto.getCfjdajmc())){ %>
			<span><%=dto.getCfjdajmc() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
			<span>立案调查。经查，你（单位）</span>
			<%if(dto.getCfjdwfss() != null && !"".equals(dto.getCfjdwfss())){ %>
			<span><%=dto.getCfjdwfss() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;"></span><%} %>
			<span>。上述行为违反了</span>
			<%if(dto.getCfjdwfgd() != null && !"".equals(dto.getCfjdwfgd())){ %>
			<span><%=dto.getCfjdwfgd() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 150px;">
			</span><%} %>
			<span>的规定。</span>
			<%if(dto.getSyzmnr() != null && !"".equals(dto.getSyzmnr())){ %>
			<span><%=dto.getSyzmnr() %>&nbsp;</span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
			<span>。根据你（单位）违法行为的事实、性质、情节、社会危害程度和相关证据，参照《</span>
			<%if(dto.getXzcfclbz() != null && !"".equals(dto.getXzcfclbz())){ %>
			<span><%=dto.getXzcfclbz() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>法（条例、办法）行政处罚裁量标准》，你（单位）的违法行为</span>
			<%if(dto.getWfxwdcstr() != null && !"".equals(dto.getWfxwdcstr())){ %>
			<span><%=dto.getWfxwdcstr() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 40px;">
			</span><%} %>
			<span>。</span>
		</p>
		<p class="p5 lh30">
			<span>根据</span>
			<%if(dto.getCfjdyjgdtk() != null && !"".equals(dto.getCfjdyjgdtk())){ %>
			<span><%=dto.getCfjdyjgdtk() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>的规定，我局决定对你（单位）作出如下行政处罚：</span>
		</p>
		<p class="lh30">
			<%if(dto.getCfjdxzcf() != null && !"".equals(dto.getCfjdxzcf())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getCfjdxzcf())%></span><%} else{%>
				<br><br><%} %>
		</p>
		<p class="p4 lh30">
			<span>你（单位）应当自收到本决定书之日起15日内将罚款缴至</span>
			<%if(dto.getCfjdjkyh() != null && !"".equals(dto.getCfjdjkyh())){ %>
			<span><%=dto.getCfjdjkyh() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>（账号：</span>
			<%if(dto.getYhzh() != null && !"".equals(dto.getYhzh())){ %>
			<span><%=dto.getYhzh() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>）。到期不缴纳罚款的，每日按罚款数额的3%加处罚款。</span>
		</p>
		<p class="p4 lh30">
			<span>你（单位）如不服本决定，可以自收到本决定书之日起六十日内向</span>
			<%if(dto.getSjrmzf() != null && !"".equals(dto.getSjrmzf())){ %>
			<span><%=dto.getSjrmzf()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>人民政府或者</span>
			<%if(dto.getSjspypjdglj() != null && !"".equals(dto.getSjspypjdglj())){ %>
			<span><%=dto.getSjspypjdglj()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>申请行政复议，或者在六个月内依法直接向</span>
			<%if(dto.getSjrmfy() != null && !"".equals(dto.getSjrmfy())){ %>
			<span><%=dto.getSjrmfy()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 100px;">
			</span><%} %>
			<span>人民法院提起行政诉讼。逾期不申请行政复议，也不提起行政诉讼，又不履行本处罚决定的，我局将依法申请人民法院强制执行。</span>
		</p>
		<br><br>
		<div align="right">
			<p class="p7">
				<span>（公    章）</span>
			</p>
			<br>
			<p class="p7">
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
			</p>
		</div>
	</div>
</body>
</div>
</html>
