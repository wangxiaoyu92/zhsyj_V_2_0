<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxxdjbcwpcljds11DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Zfwsxxdjbcwpcljds11DTO dto=new Zfwsxxdjbcwpcljds11DTO();
if (request.getAttribute("mybean") != null) {
	dto = (Zfwsxxdjbcwpcljds11DTO)request.getAttribute("mybean");
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
.s3{color:black;text-decoration: underline;} 
.s33{border-bottom: 1px solid  black;display: inline-block;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-align:right;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.36458334in;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.36458334in;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height:24px;}
.p6{text-align:right;}
.p9{text-align:right;}
.p10{text-align:right;}
.l24{line-height: 25px;}
</style>
<title>先行登记保存物品处理决定书</title>
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
    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——先行登记保存物品处理决定书");
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPageA();//强制分页
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	//LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
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
		<p class="p1">
		<span class="s1">食品药品行政处罚文书</span>
		</p>
		<p class="p2">
		<span class="s1">先行登记保存物品处理决定书</span>
		</p>
		<p class="p3 tr">
		<span class="s2"> <%if (dto.getXxclwsbh() != null) { %>
		<%=dto.getXxclwsbh()%><%} %> </span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
		<%if (dto.getXxcldsr() != null && !"".equals(dto.getXxcldsr())) { %>
			<span class="s2"> <%=dto.getXxcldsr()%>：</span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 300px;display: inline-block;"></span>:
		<%} %>
		</p>
		<p class="p5 l24">
			<span class="s2">依据《中华人民共和国行政处罚法》第三十七条第二款的规定，本机关对
			<%if(dto.getXxcltzsnyr() != null && !"".equals(dto.getXxcltzsnyr())){ %>
			<%=dto.getXxcltzsnyr().substring(0, 4)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getXxcltzsnyr() != null && !"".equals(dto.getXxcltzsnyr())){ %>
			<%=dto.getXxcltzsnyr().substring(5, 7)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getXxcltzsnyr() != null && !"".equals(dto.getXxcltzsnyr())){ %>
			<%=dto.getXxcltzsnyr().substring(8, 10)%><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
	   		<%if (dto.getXxcltzswsbh() != null && !"".equals(dto.getXxcltzswsbh())) { %>
			<span class="s2"> <%=dto.getXxcltzswsbh()%></span><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span>
			<%} %>
			《先行登记保存物品通知书》中《先行登记保存物品清单》载明的物品，作出以下处理决定：</span>
		</p>
		<p class="p6 lh30" style="min-height: 50px;">
			<%if(dto.getXxclwbnr() != null){ %>
			<%=SysmanageUtil.replaceStrChuLast(dto.getXxclwbnr()) %><%} %>
		</p> 
		<p class="p7"></p>
		<p class="p8 lh30">
			<span class="s2">附件：<%if (dto.getXxclfjxx() != null) { %>
			<%=dto.getXxclfjxx()%><%} %></span>
		</p>
		<br/><br/><br/>   
		<p class="p10 tr">
		<span class="s2">（公    章）&nbsp;&nbsp;&nbsp;&nbsp;</span>
		</p>
		<br/>
		<p class="p10 tr">
		<span class="s2">
		    <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
		</span>
		</p>
		<br>
		<br>
		<br>
		  <p class="p7">
			  <span class="s2">当事人：_____________________（签字或盖章）
			  <span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span>
			  <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
	   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
			  </span>
			</p>
			<br/>
			<p class="p7">
			  <span class="s2" >执法人员:_____________________</span>
			  <span class="s2" >执法证号:_____________________</span>
			</p>
			<br/>
			<p class="p7"> 
			  <span class="s2" style="margin-left: 62px;" >_____________________</span>
			  <span class="s2" >执法证号:_____________________</span>
			</p>
			<p class="p7">
			  <span class="s2" style="margin-left: 200px;"><span>
		        <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>年
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>月
		   		 <span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span>日
		     </span> 
			</p>
	</div>
</html>
