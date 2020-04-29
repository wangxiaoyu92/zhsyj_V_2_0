<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwscfkywpyjtzs6DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 执法文书查封扣押物品移交通知书
	Zfwscfkywpyjtzs6DTO localWpyjtzs6DTO = new Zfwscfkywpyjtzs6DTO();
    if (request.getAttribute("printbean") != null) {
    	localWpyjtzs6DTO = (Zfwscfkywpyjtzs6DTO) request.getAttribute("printbean");
    }	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{color:black;}
.s2{font-weight:bold;color:black;}
.s3{color:black;text-decoration:underline;}
.p1{text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p3{text-align:center;hyphenate:auto;font-family:宋体;font-size:22pt;}
.p4{margin-right:0.038194444in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;margin-left:450px;}
.p5{text-indent:0.072916664in;margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2em;margin-left:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;line-height: 34px;}
.p7{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-right:0.33333334in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{margin-right:0.038194444in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:7pt;}
.p12{text-indent:0.06944445in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 34px;}
</style>

<title>查封(扣押)物品移交通知书</title>
<meta content="X" name="author">
<!-- 引入库 -->

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
    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——查封(扣押)物品移交通知书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
    for(zhu=1;zhu<3;zhu++){
	CreatePrintPage("注：抄送（当事人）<%=localWpyjtzs6DTO.getCfkyyjcsr()%>，存档（"+ zhu +"）。"); 
    } 
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
	
function CreatePrintPage(zhu) {
	//LODOP=getLodop();  
	LODOP.NEWPAGE ();
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	//LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——查封(扣押)物品移交通知书");
	//LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
    //LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
	LODOP.ADD_PRINT_HTM("205mm","150mm","85%","100%",strBodyStyle+document.getElementById("rq").innerHTML);
	LODOP.ADD_PRINT_HTM("235mm","20mm","85%","100%",strBodyStyle+document.getElementById("dip").innerHTML);
    
    LODOP.ADD_PRINT_TEXT("240mm","20mm","85%","100%",zhu);
      
	//LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
   // LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto; display: none;">
<body class="b1 b2">
	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />	
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
<p class="p1">
<span class="s1"></span>
</p>
<p class="p2">
<span class="s2">食品药品行政处罚文书</span>
</p>
<p class="p3">
<span class="s2"><%=localWpyjtzs6DTO.getCfkytitle()%></span>
</p>
<p class="p4"><%=localWpyjtzs6DTO.getWsbh()%>
</p>
<p class="p5">
<span class="s3"><%=localWpyjtzs6DTO.getSysbmmc()%></span><span class="s1">公安局：</span>
</p>
<p class="p6">
<span class="s1">因</span><span class="s3"><%=localWpyjtzs6DTO.getCfkywfxw()%></span>
<span class="s1">的违法行为涉嫌犯罪，根据《中华人民共和国行政强制法》第二十一条的规定，我局决定对查封(扣押)的  
<%=localWpyjtzs6DTO.getCfkyygwp()%>的有关物品［见<%=localWpyjtzs6DTO.getCfkyjdswsbh()%>《查封(扣押)决定书》所附《查封(扣押)物品清单》］移交给你单位。</span>
</p>
<p class="p7"></p>
<p class="p7"></p>
<p class="p7"></p>
<p class="p7"></p>
<p class="p8"></p>
<p class="p8"></p>
</div>
    <div align="right" id="rq"> 
			<p class="p9"><span class="s1">（公    章）</span></p>
			<p class="p10">
				<span class="s1">
				<%=localWpyjtzs6DTO.getCfkyyjrq().substring(0,4)%>年
				<%=localWpyjtzs6DTO.getCfkyyjrq().substring(5,7)%>月
				<%=localWpyjtzs6DTO.getCfkyyjrq().substring(8,10)%>日
				</span>
			</p>
		</div>
    <div id="dip">
		<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;">
		<p class="p11">
			<span class="s2" id="zj"></span>
		</p>
    </div>

</body>
</div>
</html>
