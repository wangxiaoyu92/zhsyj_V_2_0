<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjds28DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 案件登记id	
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 行政处罚决定书
	Zfwsxzcfjds28DTO localZfwsxzcfjds28DTO = new Zfwsxzcfjds28DTO();
    if (request.getAttribute("printbean") != null) {
    	localZfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO) request.getAttribute("printbean");
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
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;
	font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.072916664in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.28055555in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-left:0.072916664in;margin-right:0.8611111in;margin-top:0.108333334in;
	text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:-0.072916664in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-right:0.29166666in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{margin-top:0.108333334in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p15{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p16{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:0.29166666in;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
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
	//var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
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
	//LODOP=getLodop();  
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	//LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚决定书");
	// LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	// LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("260mm","20mm","85%","100%","注：正文3号仿宋体字，存档（1）。");
	LODOP.NewPage();
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("260mm","20mm","85%","100%","注：必要时交<%=localZfwsxzcfjds28DTO.getQzzzrmfy() %>人民法院强制执行（2）。");
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
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
	<div align="center" id="page1">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">行政处罚决定书</span></p>
		<div align="right">
			<p class="p3">
			<span class="s2"><%=localZfwsxzcfjds28DTO.getCfjdwsbh() %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">当事人：<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjddsr()%></span>
		</p>
		<p class="p4">
			<span class="s2">地址（住址）：<span style="border-bottom: 1px solid  black;width: 300px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjddz()%></span>
			邮编：<span class="s3" style="border-bottom: 1px solid  black;width: 155px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdyb()%></span></span>
		</p>
		<p class="p4">
			<span class="s2">营业执照或其他资质证明：<span style="border-bottom: 1px solid  black;width: 230px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdyyzzstr()%></span>
			编号：<span class="s3" style="border-bottom: 1px solid  black;width: 155px;display: inline-block;"">
			<%=localZfwsxzcfjds28DTO.getCfjdyyzzbh()%></span>
			</span>
		</p>
		<p class="p4">
			<span class="s2">组织机构代码（身份证）号：<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdzzjgdm()%></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdfddbr()%></span>
			性别：<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdfddbrxbstr()%></span>
			职务：<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
			<%=localZfwsxzcfjds28DTO.getCfjdfddbrzw()%></span>
			</span>
		</p>
		<p class="p4">
			<span class="s2">违法事实：</span>
		</p>
		<p class="p4 l24">
			<span class="s2"><%=localZfwsxzcfjds28DTO.getCfjdwfss()%></span>
		</p>
		<p class="p5"></p>
		<p class="p6">
			<span class="s2">相关证据：</span>
		</p>
		<p class="p6 l24">
			<span class="s2"><%=localZfwsxzcfjds28DTO.getCfjdxgzj() %></span>
		</p>
		<p class="p7"><span class="s2">  </span></p>
		<p class="p8 l24">
			<span class="s2">你（单位）的上述行为已违反了<%=localZfwsxzcfjds28DTO.getCfjdwfgd() %>
			（法律法规名称及条、款、项）的规定：
			<%=localZfwsxzcfjds28DTO.getCfjdwfgdtk() %>
			（法律法规具体条、款、项内容）。</span>
		</p>
		<p class="p9">
			<span class="s2">行政处罚依据和种类：</span>
		</p>
		<p class="p10 l24">
			<span class="s2">依据
			<%=localZfwsxzcfjds28DTO.getCfjdyjgd() %>
			（法律法规名称及条、款、项）的规定：
			<%=localZfwsxzcfjds28DTO.getCfjdyjgdtk() %>
			（法律法规具体条、款、项内容）。</span>
		</p>
		<p class="p7 l24">
			<span class="s2">本局决定对你（单位）给予以下行政处罚：
			<%=localZfwsxzcfjds28DTO.getCfjdxzcf() %>
			</span>
		</p>
		<p class="p11 l24">
			<span class="s2">请在接到本处罚决定书之日起15日内将罚没款缴到
			<%=localZfwsxzcfjds28DTO.getCfjdjkyh() %>
			银行。逾期不缴纳罚没款的，根据《中华人民共和国行政处罚法》第五十一条第一项的规定，
			每日按罚款数额的3%加处罚款，并将依法申请<%=localZfwsxzcfjds28DTO.getQzzzrmfy() %>人民法院强制执行。</span>
		</p>
		<p class="p11 l24">
			<span class="s2">如不服本处罚决定，可在接到本处罚决定书之日起60日内向
			<%=localZfwsxzcfjds28DTO.getSjspypjdglj() %>
			（上一级）食品药品监督管理局或者<%=localZfwsxzcfjds28DTO.getSjrmzf() %>
			人民政府申请行政复议，也可以于3个月内依法向<%=localZfwsxzcfjds28DTO.getSjrmfy() %>
			人民法院提起行政诉讼。</span>
		</p>
		<div align="right">
			<p class="p12">
			<span class="s2">（公    章）</span>
			</p>
			<p class="p13">
				<span class="s2">
				<%if(localZfwsxzcfjds28DTO.getCfjdgzrq()!=null&&localZfwsxzcfjds28DTO.getCfjdgzrq().length()>=10){ %>
					<%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(0,4)%>年
					<%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(5,7)%>月
					<%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(8,10)%>日
				<%} %>	
				</span>
			</p>
		</div> 
			<%-- <span class="s2">注：正文3号仿宋体字，存档（1），必要时交<%=localZfwsxzcfjds28DTO.getQzzzrmfy() %>人民法院强制执行（1）。</span> --%>
		</p>
		<p class="p16"></p>
	</div>
</body>
</div>
</html>
