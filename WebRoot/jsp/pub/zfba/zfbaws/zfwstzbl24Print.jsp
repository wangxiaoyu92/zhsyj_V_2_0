<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.askj.zfba.dto.Zfwstzbl24DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 听证笔录
	Zfwstzbl24DTO dto = new Zfwstzbl24DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwstzbl24DTO) request.getAttribute("printbean");
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
.s3{text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:4.5833335in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:0.29166666in;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}

.mytext-overflow{ 
display:block;/*内联对象需加*/ 
word-break:keep-all;/* 不换行 */ 
white-space:nowrap;/* 不换行 */ 
overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */ 
text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/ 
} 

</style>

<title>听证笔录</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——听证笔录");
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:6.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
  	 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5"); 
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5"); 
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
	<!-- 标题第一页 -->
	<div align="center" id="title1">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">听证笔录</span></p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<!-- 标题除了第一页 -->
	<div align="center" id="title2">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">(听证笔录)副页</span></p>
		<p class="page">
			<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">
		<p class="p4">
			<span class="s2">案由：</span>
			<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;"> 
			<% if (dto.getAjdjay() != null) { %> <%=dto.getAjdjay()%><%} %></span>	
		</p>
		<p class="p4">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 1px solid  black;width: 535px;display: inline-block;"> 
			<% if (dto.getTzbldsr() != null) { %> <%=dto.getTzbldsr()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span style="border-bottom: 1px solid  black;width: 85px;display: inline-block;">
			<%if (dto.getTzblfddbr() != null) { %> <%=dto.getTzblfddbr()%><%} %></span>
			<span class="s2">性别：</span>
			<span style="border-bottom: 1px solid  black;width: 40px;display: inline-block;">
			<%if (dto.getTzblfddbrxbstr() != null) { %> <%=dto.getTzblfddbrxbstr()%><%} %></span>
			<span class="s2">年龄：</span>
			<span style="border-bottom: 1px solid  black;width: 40px;display: inline-block;">
			<%if (dto.getTzblfddbrnl() != null) { %> <%=dto.getTzblfddbrnl()%> <%} %></span>
			
			<span class="s2">联系方式：</span>
			<span style="border-bottom: 1px solid  black;width: 85px;display: inline-block;">
			<%if (dto.getTzblfddbrlxfs() != null) { %> <%=dto.getTzblfddbrlxfs()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">地址：</span>
			<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;">
			<%if (dto.getTzbldz() != null) { %> <%=dto.getTzbldz()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">委托代理人：</span>
			<span style="border-bottom: 1px solid  black;width: 60px;display: inline-block;">
			<%if (dto.getTzblwtdlr() != null) { %> <%=dto.getTzblwtdlr()%><%} %></span>
			<span class="s2">性别：</span>
			<span style="border-bottom: 1px solid  black;width: 30px;display: inline-block;">
			<%if (dto.getTzblwtdlrxbstr() != null) { %> <%=dto.getTzblwtdlrxbstr()%><%} %></span>
			<span class="s2">年龄：</span>
			<span style="border-bottom: 1px solid  black;width: 30px;display: inline-block;">
			<%if (dto.getTzblwtdlrnl() != null) { %> <%=dto.getTzblwtdlrnl()%><%} %></span>
			<span class="s2">职务：</span>
			<span style="border-bottom: 1px solid  black;width: 60px;display: inline-block;">
			<%if (dto.getTzblwtdlrzw() != null) { %> <%=dto.getTzblwtdlrzw()%><%} %></span>
			<span class="s2">联系方式：</span>
			<span style="border-bottom: 1px solid  black;width: 85px;display: inline-block;">
			<%if (dto.getTzblwtdlrlxfs() != null) { %> <%=dto.getTzblwtdlrlxfs()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">工作单位：</span>
			<span style="border-bottom: 1px solid  black;width: 210px;display: inline-block;">
			<%if (dto.getTzblwtdlrgzdw() != null) { %> <%=dto.getTzblwtdlrgzdw()%><%} %></span>
			<span class="s2">地址：</span>
			<span style="border-bottom: 1px solid  black;width: 260px;display: inline-block;">
			<%if (dto.getTzblwtdlrdz() != null) { %> <%=dto.getTzblwtdlrdz()%><%} %></span>
		</p>
		<p class="p4"> 
			<span class="s2">案件承办人：</span>
			<span style="border-bottom: 1px solid  black;width: 130px;display: inline-block;">
			<%if (dto.getTzblajcbr1() != null) { %> <%=dto.getTzblajcbr1()%><%} %></span>
			<span class="s2">部门：</span>
			<span style="border-bottom: 1px solid  black;width: 150px;display: inline-block;">
			<%if (dto.getTzblajcbr1bm() != null) { %> <%=dto.getTzblajcbr1bm()%><%} %></span>
			<span class="s2">职务：</span>
			<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;">
			<%if (dto.getTzblajcbr1zw() != null) { %> <%=dto.getTzblajcbr1zw()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">案件承办人：</span>
			<span style="border-bottom: 1px solid  black;width: 130px;display: inline-block;">
			<%if (dto.getTzblajcbr2() != null) { %> <%=dto.getTzblajcbr2()%><%} %></span>
			<span class="s2">部门：</span>
			<span style="border-bottom: 1px solid  black;width: 150px;display: inline-block;">
			<%if (dto.getTzblajcbr2bm() != null) { %> <%=dto.getTzblajcbr2bm()%><%} %></span>
			<span class="s2">职务：</span>
			<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;">
			<%if (dto.getTzblajcbr2zw() != null) { %> <%=dto.getTzblajcbr2zw()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">听证主持人：</span>
			<span style="border-bottom: 1px solid  black;width: 210px;display: inline-block;">
			<%if (dto.getTzbltzzcr() != null) { %> <%=dto.getTzbltzzcr()%><%} %></span>
			<span class="s2">记录人：</span>
			<span style="border-bottom: 1px solid  black;width: 210px;display: inline-block;">
			<%if (dto.getTzbljlr() != null) { %> <%=dto.getTzbljlr()%><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">听证时间：
			<%if(!"".equals(dto.getTzbltzkssj())&&dto.getTzbltzkssj().length()>=16){ %>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzkssj().substring(0,4)%></span>
			<span class="s2">年</span>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzkssj().substring(5,7)%>
			</span>
			<span class="s2">月</span>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzkssj().substring(8,10)%>
			</span>
			<span class="s2">日</span>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzkssj().substring(11,13)%>
			</span>
			<span class="s2">时</span>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzkssj().substring(14,16)%>
			</span>
			<span class="s2">分至</span>
			<%}else{ %>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>年
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>月
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>日
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>时
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>分至
			<%} %>
			<%if(!"".equals(dto.getTzbltzjssj())&&dto.getTzbltzjssj().length()>=16){ %>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzjssj().substring(11,13)%>
			</span>
			<span class="s2">时</span>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
			<%=dto.getTzbltzjssj().substring(14,16)%>
			</span>
			<span class="s2">分</span>
			<%}else{ %>
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>时
			<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;"></span>分
			<%} %>
			</span>
		</p>
		<p class="p4">
			<span class="s2">听证方式：</span>
			<span style="border-bottom: 1px solid  black;width: 500px;display: inline-block;">
			<%if (dto.getTzbltzfs() != null) { %> <%=dto.getTzbltzfs()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6">
			<span class="s2">记录：</span>
		</p>
		<p class="p6 l24">
			<%if(dto.getTzbljl() != null && !"".equals(dto.getTzbljl())){ %>
				<span><%=SysmanageUtil.replaceStrChuLast(dto.getTzbljl())%></span><%} else{%>
				<br><br><br><%} %>
		</p>
	</div>
	<div id="footer">
		<p class="p6">
		<span class="s2">当事人或委托代理人：</span>
		    <span><%=StringHelper.myMakeStrLen("", 25, 0) %></span>  
			<span style="float: right;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			</span>
		</p>
		<p class="p6">
			<span class="s2">案件承办人：</span>
		  	<span><%=StringHelper.myMakeStrLen("", 25, 0) %></span>  
			<span style="float: right;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
				</span>
		</p>
		<p class="p6">
			<span class="s2">听证主持人：</span>
	    	<span><%=StringHelper.myMakeStrLen("", 25, 0) %></span>  
		   	<span style="float: right;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			</span>
		</p>
		<p class="p6">
			<span class="s2">记录人：</span>
	    	<span><%=StringHelper.myMakeStrLen("", 25, 0) %></span>   
		   	<span style="float: right;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			</span>
		</p>
	</div>
</body>
</div>
</html>
