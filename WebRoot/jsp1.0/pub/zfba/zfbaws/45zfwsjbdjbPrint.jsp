<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.zfwsjbdjb45DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder"%>
<% String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath() + "/";
	 }
	zfwsjbdjb45DTO dto= new zfwsjbdjb45DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (zfwsjbdjb45DTO) request.getAttribute("printbean");
	} 
%> 
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.p1{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:12pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.p3{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10pt;}
.s1{font-weight:bold;}
.s2{font-size:18pt;font-weight:bold;}
.s3{font:bold;}
.s4{text-align:right; font-size:18pt;font-weight:bold;}
.s5{text-align: right; margin-right: 30px;} 
.in{width: 270px;}
.s22 {
border-bottom:1px solid black;
display: inline-block;
vertical-align:bottom;
color: black;
width: 200;
}

</style>
<meta content="X" name="author">

<jsp:include page="${path}/inc.jsp"></jsp:include>

<script language="javascript" src="<%=basePath%>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
		pluginspage="<%=basePath%>lodop/install_lodop32.exe"></embed>
</object>
<style>
.Noprint{text-align:center;} 
</style>
<script type="text/javascript">
var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s)
var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close");    
	});
	//打印预览 
	function printView() {
		LODOP=getLodop();
	    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——举报登记表");
		LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 
		CreatePrintPage();
	  	LODOP.PREVIEW();
	};

	//直接打印
	function printData() {
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
		LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		//LODOP.ADD_PRINT_HTML("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
		//添加内容
		//LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
		//LODOP.SET_PRINT_STYLE("FontSize",12); 
		LODOP.NewPage();
		//强制分页		
		var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
		LODOP.ADD_PRINT_HTML("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
		//LODOP.ADD_PRINT_HTML("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
		//添加内容
		//LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
		//LODOP.SET_PRINT_STYLE("FontSize",12);
	} 
</script>
<title>中华人民共和国药品监督行政执法文书</title>
</head>  
       <div style="width: 210mm; margin: 0 auto;display: none">
	   <body class="b1 b2">
		 <div class="Noprint">
					<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find"
						class="easyui-linkbutton" onclick="printView();">打证预览</a> <a
						href="javascript:void(0)" id="saveBtn" icon="icon-print"
						class="easyui-linkbutton" onclick="printData();">直接打证</a> <a
						href="javascript:void(0)" id="backBtn" icon="icon-back"
						class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
		</div>
		<div align="center" id="page1">
		<p class="p2">
		   <span class="s1">中华人民共和国药品监督行政执法文书</span>
		</p> 
		<p class="p2">
		   <span class="s2">举  报  登  记  表</span> 
		</p>
		<p class="s5">
		    <span class="s5"><%=dto.getJbdjbh()%></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p3">
		<span>举报人：</span><span class="s22"><%=dto.getJbdjjbr()%>&nbsp; &nbsp; </span>
		<span> 联系方式：</span><span class="s22"><%=dto.getJbdjlxfs()%></span>
		</p>
		<p class="p3">
		<span>举报形式：</span><span class="s22"><%=dto.getJbdjjbxs()%> </span>
		<span>时    间：</span>
			<span class="s22">
			<%if(dto.getJbdjjbsj().length()>=10 && dto.getJbdjjbsj()!=null){ %>
			<%=dto.getJbdjjbsj().substring(0,4)%>年
			<%=dto.getJbdjjbsj().substring(5,7)%>月
			<%=dto.getJbdjjbsj().substring(8,10)%>日  
			<%}else{ %>
			&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
			<%} %>  
			</span>
		</p>
		<p class="p3">
		<span>举报内容：</span>
		</p>
		<p class="p3">
		<%=dto.getJbdjjbnr()%> 
		</p> 
		<p class="s5">
		<span>记录人：_________________</span> 
		</p>
		<p class="p3">
		<span> </span>
		</p>
		<p class="s5">
		   <span>&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;&nbsp; 日</span>
		 </p> 
		<p class="p3">
		<span>处理意见：</span>
		</p> 
		<p class="p3">
		<%=dto.getJbdjclyj()%> 
		</p>
		<p class="s5">
		<span>负责人：_______________</span> 
		</p>  
		<p class="s5">
		<span>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</span> 
		</p>
		<p class="p3"></p>
   
   <hr style="height:2px;border:none;border-top:2px solid #555555;" /> 
  </div>	 	
</body>
</div>
</html>