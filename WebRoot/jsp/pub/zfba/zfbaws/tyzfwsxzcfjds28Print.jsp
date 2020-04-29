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
<META http-equiv="Content-Type" content="text/html; charset=GB2312">
<style type="text/css"  id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;} 
.s2{color:black;text-decoration: underline;} 
.s4{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0in;margin-left:0.09791667in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;margin-right:0.013194445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:-0.055555556in;margin-left:0in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:-0.072916664in;margin-left:-0.054166667in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:-0.09166667in;margin-left:-0.007638889in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.28611112in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-indent:0.28055555in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-indent:0.28611112in;margin-left:0.0027777778in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{margin-left:0.10763889in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p15{text-indent:0.28611112in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p16{margin-right:0.29166666in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p17{margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p18{text-indent:0.3263889in;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:宋体;font-size:10.5pt;}
.p19{text-align:start;hyphenate:auto;font-family:宋体;font-size:10.5pt;}
.p20{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p21{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
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
	LODOP.ADD_PRINT_HTML("500mm","20mm","85%","100%","注：正文3号仿宋体字，存档（1）。");
	<%-- LODOP.NewPage();
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTML("500mm","20mm","85%","100%","必要时交<%=localZfwsxzcfjds28DTO.getQzzzrmfy() %>人民法院强制执行（2）。"); --%>
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
		<p class="p2"><span class="s1">行政处罚决定书</span></p>
		<div align="right">
			<p class="p3">
			<span class="s2"><%=localZfwsxzcfjds28DTO.getCfjdwsbh() %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4"> 
		<span>被处罚人（自然人）姓名：</span><span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"> 
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrzrrxm()%></span>
		<span>性别：</span><span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"> 
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrzrrxbstr()%></span>
		<span>年龄：</span><span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"> 
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrzrrnl() %></span> 
		</p>
		<p class="p4">
		<span>所在单位：</span><span style="border-bottom: 1px solid  black;width: 200px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrzrrszdw()%></span>
		<span>住址：</span><span style="border-bottom: 1px solid  black;width: 245px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrzrrszdwdz() %></span>
		</p>
		<p class="p4">
		<span>被处罚人（单位）名称：</span>
		<span style="border-bottom: 1px solid  black;width: 400px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwmc()%></span>
		</p>
		<p class="p4">
		<span>地址：</span>
		<span style="border-bottom: 1px solid  black;width: 510px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwdz()%></span>
		</p>
		<p class="p4">
		<span>营业执照或其他资质证明：</span>
		<span style="border-bottom: 1px solid  black;width: 165px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwyyzzstr()%></span>
		<span>编号：</span>
		<span style="border-bottom: 1px solid  black;width: 165px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwyyzzbh()%></span>
		</p>
		<p class="p4">
		<span>法定代表人或负责人：</span>  &nbsp;
		<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwfddbr()%></span>
		<span>性别：</span>
		<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwfddbrxbstr()%></span>
		<span>职务：</span>
		<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;">
		<%=localZfwsxzcfjds28DTO.getCfjdbcfrdwfddbrzw()%></span>
		</p>
		<p class="p4">
		<span>本机关于</span>
		<span class="s3">
		<%if(!"".equals(localZfwsxzcfjds28DTO.getCfjdlarq())&&localZfwsxzcfjds28DTO.getCfjdlarq().length()>=10){ %>
			<%=localZfwsxzcfjds28DTO.getCfjdlarq().substring(0,4)%>
			年<%=localZfwsxzcfjds28DTO.getCfjdlarq().substring(5,7)%>
			月<%=localZfwsxzcfjds28DTO.getCfjdlarq().substring(8,10)%>
		<%}else{ %>
		   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
		    &nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;
		<%} %>	
		</span>日对</span>
		<span class="s3"><%=localZfwsxzcfjds28DTO.getCfjdajmc() %></span>
		<span>一案立案调查。经查，你（单位）</span>
		<span class="s3">于
		<%if(!"".equals(localZfwsxzcfjds28DTO.getCfjdwfxwksrq())&&localZfwsxzcfjds28DTO.getCfjdwfxwksrq().length()>=10){ %>
		    <%=localZfwsxzcfjds28DTO.getCfjdwfxwksrq().substring(0,4)%>
			年<%=localZfwsxzcfjds28DTO.getCfjdwfxwksrq().substring(5,7)%>
			月<%=localZfwsxzcfjds28DTO.getCfjdwfxwksrq().substring(8,10)%>
			<%}else{ %>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
		    &nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;
			<%} %>   
		日 至 
		<%if(!"".equals(localZfwsxzcfjds28DTO.getCfjdwfxwjsrq())&&localZfwsxzcfjds28DTO.getCfjdwfxwjsrq().length()>=10){ %>
		    <%=localZfwsxzcfjds28DTO.getCfjdwfxwjsrq().substring(0,4)%>
			年<%=localZfwsxzcfjds28DTO.getCfjdwfxwjsrq().substring(5,7)%>
			月<%=localZfwsxzcfjds28DTO.getCfjdwfxwjsrq().substring(8,10)%>
		<%}else{ %>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
		    &nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;
		<%} %>
		日实施了 </span>
		</p>
		<p class="p10">
		<span class="s3"><%=localZfwsxzcfjds28DTO.getCfjdwfxw() %></span>
		<span>违法行为。</span>
		</p>
		<p class="p11">
		<span class="s4">违法事实：</span>
		<span><%=localZfwsxzcfjds28DTO.getCfjdwfss() %></span>
		</p>
		<p class="p11">
		<span class="s4">相关证据：</span>
		<span><%=localZfwsxzcfjds28DTO.getCfjdxgzj() %></span>
		</p>
		<p class="p7">
		<span class="s4">违法行为等次：</span>
		<span>根据你（单位）的违法事实、性质、情节、社会危害程度和相关证据，你（单位）的违法行为为轻微 
		<%=localZfwsxzcfjds28DTO.getWfxwdc() %>
		<!-- （属于一般的认定为一般、属于严重的认定为严重，属于特别严重的认定为特别严重）。 -->
		</span>
		</p>
		<p class="p12">
		<span class="s2">你（单位）的上述行为已违反了<%=localZfwsxzcfjds28DTO.getCfjdwfgd() %>（法律法规名称及条、款、项）的规定：<%=localZfwsxzcfjds28DTO.getCfjdwfgdtk() %>（法律法规具体条、款、项内容）。
		</span>
		</p>
		<p class="p13">
		<span class="s4">行政处罚依据和种类：</span>
		<span>依据<%=localZfwsxzcfjds28DTO.getCfjdyjgd() %></span>
		<span class="s2">（法律法规名称及条、款、项）</span><span>的规定：<%=localZfwsxzcfjds28DTO.getCfjdyjgdtk() %>（</span><span class="s2">法律法规具体条、款、项内容</span>
		<span>），决定对你（单位）作出如下行政处罚：</span>
		</p>
		<p class="p14">
		<span><%=localZfwsxzcfjds28DTO.getCfjdxzcf() %></span>
		</p>
		<p class="p15">
		<span class="s4">行政处罚履行方式和期限：</span>
		<span>你（单位）应当自接到本决定书之日起15日内将罚款缴至<%=localZfwsxzcfjds28DTO.getCfjdjkyh() %>银行（地址：                 ）。到期不缴纳的，每日按罚款数额的3%加处罚款。</span>
		</p>
		<p class="p15">
		<span class="s4">不服行政处罚决定申请行政复议或者提起行政诉讼的途径和期限：</span>
		<span>如不服本决定，可以自收到本决定书之日起六十日内向<%=localZfwsxzcfjds28DTO.getSjrmzf() %>人民政府或者<%=localZfwsxzcfjds28DTO.getSjspypjdglj() %>局申请行政复议，或者在三个月内直接向人民法院起诉。逾期不申请行政复议、不向人民法院起诉又不履行本处罚决定的，我局将申请人民法院强制执行。
		</span>
		</p>
		<p class="p15"></p>
		<p class="p15"></p>
		<p class="p15"></p>
		<p class="p16">
		<span class="s2">  （公    章）</span>
		</p>
		<p class="p17">
		<span class="s2">
		<%if(!"".equals(localZfwsxzcfjds28DTO.getCfjdgzrq())&&localZfwsxzcfjds28DTO.getCfjdgzrq().length()>=10){ %> 
            <%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(0,4)%>
			年<%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(5,7)%>
			月<%=localZfwsxzcfjds28DTO.getCfjdgzrq().substring(8,10)%>
		<%}else{ %>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
		    &nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;
	    <%} %>
			日</span>
		</p>
		<p class="p18"></p>
		<p class="p18"></p>
		<p class="p18"></p>
		<p class="p18">
		<span> </span>
		</p>
		<p class="p19"></p>
		<p class="p19"></p>
		<p class="p19"></p>
		<p class="p19"></p>
		<p class="p20">
		<span class="s2">注：正文3号仿宋体字，存档（1），必要时交&times;&times;&times;人民法院强制执行（1）。被处罚人（自然人）和被处罚人（单位）栏，根据案情区分制作。</span>
		</p>
		<p class="p19"></p>
		<p class="p21">
		<span> </span>
		</p>
		<p class="p21"></p>
	</div>
</body>
</div>
</html>
