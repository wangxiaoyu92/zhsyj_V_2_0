<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwssxfzajysspb4DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
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

Zfwssxfzajysspb4DTO localZfwsajlydjbDTO=new Zfwssxfzajysspb4DTO();
if (request.getAttribute("printbean") != null) {
	localZfwsajlydjbDTO = (Zfwssxfzajysspb4DTO)request.getAttribute("printbean");
	if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("1")){
		 ajly= "监督检查";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("2")){
		ajly= "投诉/举报";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("3")){
		 ajly= "上级交办";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("4")){
		 ajly= "下级申请";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("5")){
		ajly= "监督检查";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("6")){
		ajly= "移送";
	}else if (localZfwsajlydjbDTO!=null && localZfwsajlydjbDTO.getAjdjajly().equals("7")){
		ajly= "其他";
	}
}	

%>
<%
String v_duihao="☑";
String v_kong="□";
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{color:black;}
.s3{font-family:仿宋_GB2312;color:black;}
.s4{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0in;margin-right:0.072916664in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-right:0.072916664in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0in;margin-right:0.072916664in;margin-top:0.108333334in;text-align:right;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:1.75in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.p11{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:15pt;clear:both;}
.s22{clear:both;text-align: right;}
.s44{text-indent:2em;}
.l24{line-height: 34px;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
</style>
<title>涉嫌犯罪案件移送审批表</title>
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
/* 	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向 */
	LODOP.ADD_PRINT_HTM("55mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5");   
	
	
	/* LODOP.SET_PRINT_STYLEA(0,"PageUnIndex","Last");	
	LODOP.ADD_PRINT_TEXT(100,33,200,20,"仅在首页才输出的内容"); */
/* 	LODOP.NEWPAGE ();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page2").innerHTML); */
	/* <h2 tdata="PageNO" format="#">我是标题！ 第####页 <span id="count" tdata="PageCount" format="#">###</span></h2> */
}
</script> 
</head>
	<div style="width: 210mm; margin: 0 auto;display: none">
	    <body class="b1 b2">
	    <%-- <input id="zfwslydjid" name="zfwslydjid" type="hidden" value="<%=v_zfwslydjid %>" /> --%>
	<div class="Noprint"> 
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>
	<!-- 标题第一页 -->
	<div align="center" id="title1">
		<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
				</p>
				<p class="p2">
				<span class="s1">涉嫌犯罪案件移送审批表 </span>
				</p>
				<p class="page">
					<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
				</p>
					
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<!-- 标题除了第一页 -->
	<div align="center" id="title2">
		<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
				</p>
				<p class="p2">
				<span class="s1">(涉嫌犯罪案件移送审批表)副页</span>
				</p>
				<p class="page">
					<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
				</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>

	
	
	<div align="center" id="page1">
			
			<p class="p3">
			<span class="s2">案    由：<span style="border-bottom: 1px solid  black;width: 550px;display: inline-block;"><%=localZfwsajlydjbDTO.getAjdjay()%>
			                       </span>
			</span>
			</p>
			<p class="p4">
				<span class="s2">
				    案件来源：<span style="border-bottom: 1px solid  black;width: 530px;display: inline-block;"><%=ajly %>
				         </span>
				</span>
			</p>
			<p class="p4">
			<span class="s2">受移送机关：<span style="border-bottom: 1px solid  black;width: 520px;display: inline-block;"><%=localZfwsajlydjbDTO.getSysjg()%>
			                          </span>
			</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4" >
			<span class="s2">主要案情及移送原因：</span>
			</p>
			<p class="p4">
				<span class="s44 l24"><%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO.getZyaqjysyy(),0,0) %></span>
			</p>
			<p class="p4"></p>
			<p class="p4">
			<span class="s2">附件：涉嫌犯罪案件情况调查报告。</span>
			</p>
			<p class="p5">
				<span class="s22">经办人： </span>
				<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;text-align: left;"> 
				  <%=localZfwsajlydjbDTO.getJbr() %> 
		         </span>
			</p>
			
			<p class="p5">
				  <span class="s2 s22">
			 <%if(!"".equals(localZfwsajlydjbDTO.getJbrqzrq())&&
			      localZfwsajlydjbDTO.getJbrqzrq().length()>=10) {%>
				<%=localZfwsajlydjbDTO.getJbrqzrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getJbrqzrq().substring(5,7)%>月<%=localZfwsajlydjbDTO.getJbrqzrq().substring(8,10)%>日
			<%}else{ %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日<%} %>
			</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p8">
			<span class="s2">承办部门意见：</span>
			</p>
			<p class="p4">
				<span class="s44 l24"><%=localZfwsajlydjbDTO.getCbbmyj()%></span>
			</p>
			<p class="p9">
			<span class="s2 s22">负责人：</span>
			<span style="border-bottom: 1px solid  black;width: 85px;display: inline-block;text-align: left;">  
			     <%=localZfwsajlydjbDTO.getCbbmfzr()%> 
		         </span>
			</p>
			<p class="p5"> 
			<span class="s2 s22">
			  <%if(!"".equals(localZfwsajlydjbDTO.getCbbmfzrqzrq())&&
			       localZfwsajlydjbDTO.getCbbmfzrqzrq().length()>=10) {%>
			 <%=localZfwsajlydjbDTO.getCbbmfzrqzrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getCbbmfzrqzrq().substring(5,7) %>月<%=localZfwsajlydjbDTO.getCbbmfzrqzrq().substring(8,10)%>日
			   <%}else{ %>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日<%} %>
			</span>
			</p>
			<p class="p5"></p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;clear:both;"/>
			<p class="p4">
			<span class="s2">审批意见：</span>
			</p>
			<p class="p4">
				<span class="s44 l24"><%=localZfwsajlydjbDTO.getSpyj()%></span>
			</p>
			<p class="p4"></p>
			<p class="p4">
			<span class="s2"></span>
			</p>
			<p class="p9">
			<span class="s2 ">负责人：</span>
			<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;text-align: left;"> 
			    <%=localZfwsajlydjbDTO.getSpfzr()%>
			</span>
			</p>
			<p class="p5">
			<span class="s2 s22"> 
			 <%if(!"".equals(localZfwsajlydjbDTO.getSpfzrqzrq())&&
			       localZfwsajlydjbDTO.getSpfzrqzrq().length()>=10) {%>
			<%=localZfwsajlydjbDTO.getSpfzrqzrq().substring(0,4)%>年<%=localZfwsajlydjbDTO.getSpfzrqzrq().substring(5,7)%>月<%=localZfwsajlydjbDTO.getSpfzrqzrq().substring(8,10)%>日
			<%}else{ %>&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日<%} %>
	         </span>
			</p>
			<p class="p10">
			<span class="s3"> </span>
			</p>
			<p class="p11">
				
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
		
    </body>
	</div>
	

</html>
