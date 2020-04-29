<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsft13DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.askj.zfba.service.pub.WsgldyService"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwsft13DTO dto=new Zfwsft13DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwsft13DTO)request.getAttribute("mybean");
}	
	//封条地区换行
	String fdq = StringHelper.showNull2Empty(dto.getSpypjdgljmc());
	String[] str =  fdq.split("");
	String fdqbr = "";
	for (String string : str) {
		fdqbr += string+"<br/>";
	}
 	WsgldyService aws  = new WsgldyService();	
	//封条日期格式转换
	String rq = dto.getFtyzrq();
	String ftrq =  aws.caseDateForFtrq(rq); 
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
<title>封条</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——封条");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
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
</body>
</div>
</html>
