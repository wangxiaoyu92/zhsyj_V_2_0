<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsft13DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.askj.zfba.service.pub.WsgldyService"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int page_number=1;
String ajly ="";

String v_jdjc="../../images/pub/feiduihao.jpg";
String v_tsjb="../../images/pub/feiduihao.jpg";
String v_sjjb="../../images/pub/feiduihao.jpg";
String v_xjbq="../../images/pub/feiduihao.jpg";
String v_jdcy="../../images/pub/feiduihao.jpg";
String v_ys="../../images/pub/feiduihao.jpg";
String v_qt="../../images/pub/feiduihao.jpg";

Zfwsft13DTO localZfwsajlydjbDTO=new Zfwsft13DTO();
if (request.getAttribute("mybean") != null) {
	localZfwsajlydjbDTO = (Zfwsft13DTO)request.getAttribute("mybean");
}	
	//封条地区换行
	String fdq = localZfwsajlydjbDTO.getSpypjdgljmc();
	String[] str =  fdq.split("");
	String fdqbr = "";
	for (String string : str) {
		fdqbr += string+"<br/>";
	}
 	WsgldyService aws  = new WsgldyService();	
	//封条日期格式转换
	String rq = localZfwsajlydjbDTO.getFtyzrq();
	String ftrq =  aws.caseDateForFtrq(rq); 
%>
<%
String v_duihao="☑";
String v_kong="□";
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
#ft{
	width:175px;
	height:550px;
	background-color: white;
	border:1px solid black;
	margin-left:220px;
}
#f1{
	float:right;padding:20px;
}
#f2{
	float:right;padding-top:250px;
}
#f2 span{
	font:bold 15px/15px 新宋体;
}
#f1 span{
	font:bold 30px/30px 新宋体;
}
.date{
	font-size:12px;
}
</style>
<title>当场行政处罚决定书</title>
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
	
})

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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——案件来源登记表");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
}
/* 	function makeft(){
		dq();
		//nf();
	}
	
	//地区
	function dq(){
		var dq = "汤阴县";
		var arr =  dq.split("");
		var str ="" ;
		for(var i =0;i<arr.length;i++){
			str= str + arr[i] +"<br/>";
		}
		$("#dq").html(str);
	}
	//年份
	function nf(){
		var nf = $("#ftyzrq").val();
		var arr = nf.split("-");
		arry = arr[0].split("");
		arrm = arr[1].split("");
		arrd = arr[2].split("");
 		$("#year").html(word(arry[0])+"<br/>"+word(arry[1])+"<br/>"+word(arry[2])+"<br/>"+word(arry[3]));
		$("#moth").html("<br/>"+word(arrm[0])+"<br/>"+word(arrm[1]));
		$("#day").html("<br/>"+word(arrd[0])+"<br/>"+word(arrd[1])); 
	}
	//中文数字
	function word(n){
		switch(n)
		{
		case "1":
		  	n =	"一"; 
		  break;
		case "2":
		 	n =	"二";
		  break;
		case "3":
		 	n =	"三";
		  break;
		case "4":
		 	n =	"四";
		  break;
		case "5":
		 	n =	"五";
		  break;
		case "6":
		 		n ="六";
		  break;
		case "7":
		 		n ="七";
		  break;
		case "8":
		 		n ="八";
		  break;
		case "9":
		 		n ="九";
		  break;
		case "0":
		 		n ="零";
		  break;
		}
		return n;
	} */
</script>

</head>
	<div style="width: 210mm; margin: 0 auto;display: none">
	    <body class="b1 b2">
	    <%-- <input id="zfwslydjid" name="zfwslydjid" type="hidden" value="<%=v_zfwslydjid %>" /> --%>
	<div class="Noprint">
		<!-- 
	    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
		<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
		-->
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<div align="center" id="page<%=page_number %>">
		<div id="ft">
			<div id="f1">
				<span><%=fdqbr %>食<br />品<br />药<br />品<br />监<br />督<br />管<br />理<br />局<br />
				<br /> 封<br> </span>
				<p>（印章）</p>
			</div>
			<div id="f2">
				<span><%=ftrq %></span>
			</div>
		</div>
	</div>
</html>
