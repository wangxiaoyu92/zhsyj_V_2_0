<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsajdczjbg9DTO,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
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

	Zfwsajdczjbg9DTO localZfwsajlydjbDTO=new Zfwsajdczjbg9DTO();
	if (request.getAttribute("printbean") != null) {
		localZfwsajlydjbDTO = (Zfwsajdczjbg9DTO)request.getAttribute("printbean");
	}	
	Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();//获取当前用户
    String aa027=vSysUser.getAaa027().substring(0, 4);    //获取当前用户的统筹区
    
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
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:3.2083333in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height:30px;}
.p6{text-align:right;}
.page{font-size:10.5pt;text-align:right;margin:0px;padding:0px;}
.s {
	text-decoration: underline;
}
</style>
<title>食品药品行政处罚文书</title>
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
     <%-- var  tcq='<%= aa027%>';  --%>
$(function(){
	/* if(tcq=='4117'){
			$('#tang').hide();
		}
	else{
			$('#zmd').hide();
		}	 */
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
	LODOP.ADD_PRINT_HTM("55mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5");   
	
}
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
		<!-- 标题第一页 -->
	<div align="center" id="title1">
		<p class="p1">
				<span class="s1">食品药品行政处罚文书</span>
				</p>
				<p class="p2">
				<span class="s1">案件调查终结报告 </span>
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
				<span class="s1">(案件调查终结报告)副页</span>
				</p>
				<p class="page">
					<span tdata="PageNO" format="#">第###页</span><span tdata="PageCount" format="#">共###页</span>
				</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	
	<div align="center" id="page1">
<!-- 		<p class="p1">
			<span class="s1">食品药品行政处罚文书</span>
			</p>
			<p class="p2">
			<span class="s1">案件调查终结报告</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;"> -->
			<p class="p3">
			<span class="s2">案由：<%=StringHelper.myMakeStrLen(localZfwsajlydjbDTO.getAjdjay(),20,0) %></span>
			</p>
			<p class="p3 l24">
				<span class="s2">当事人基本情况：
				</span></br><span class="s2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<%=localZfwsajlydjbDTO.getDczjdsrjbqk().replace("\r\n","<br/>") %></span></p>
			<p>
			</p>
			<p class="p4"></p>
			<p class="p4 l24">
			<span class="s2"></span>
			</p>
			<p class="p3 l24"><span class="s2">违法事实：</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=localZfwsajlydjbDTO.getDczjwfss().replace("\r\n","<br/>")%></span></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4 l24">
			<span class="s2">证据材料：</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=localZfwsajlydjbDTO.getDczjzjcl().replace("\r\n","<br/>") %></span></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
			<p class="p4"></p>
		<p class="p4 l24">
		<span class="s2">处罚依据：</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=localZfwsajlydjbDTO.getDczjcfyj().replace("\r\n","<br/>") %></span>
		</p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4"></p>
		<p class="p4 l24">
		<span class="s2">处罚建议:</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=localZfwsajlydjbDTO.getDczjcfjy().replace("\r\n","<br/>") %></span></p>
		<p class="p4" id="zmd"><span class="s2">违反法律法规条款：<br/>
			<%=localZfwsajlydjbDTO.getDczjwfflfgtk().replace("\r\n","<br/>") %></span>
		 </p>
		
		<p class="p5"></p>
		<p class="p6">
			<span class="s2">                                                  </span>
		</p> 
		<p class="p4"><span class="s2">违法行为等次：<br/>
			<%=localZfwsajlydjbDTO.getDczjwfflfgtk().replace("\r\n","<br/>") %></span>
		</p>
		<p class="p5"></p>
		<p class="p6">
			<span class="s2">                                                  </span>
		</p>
		<p class="p4"  id="tang"><span class="s2">应受行政处罚的依据和种类：<br/>
			<%=localZfwsajlydjbDTO.getDczjwfflfgtk().replace("\r\n","<br/>") %></span>
		</p>
		
		<p class="p5"></p>
		<p class="p6">
		<span class="s2">                                                  </span>
		</p>
		<p class="p6">
		<span class="s2">案件承办人：&nbsp;&nbsp;</span>
			<span class="s">
		<%if("".equals(localZfwsajlydjbDTO.getDczjajcbrqz())&&
		localZfwsajlydjbDTO.getDczjajcbrqz().length()==0){ %>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%}else{ %> 
		<%=localZfwsajlydjbDTO.getDczjajcbrqz() %>
		<%} %>	
		<!-- ------------------------------------------------------------------ -->
		<%if("".equals(localZfwsajlydjbDTO.getDczjajcbrqz2())&&
		localZfwsajlydjbDTO.getDczjajcbrqz2().length()==0){ %>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%}else{ %> 、
		<%=localZfwsajlydjbDTO.getDczjajcbrqz2() %>
		<%} %>	
			</span>
		</p>
		<p class="p6">
		<span class="s2">
		<%if(!"".equals(localZfwsajlydjbDTO.getDczjajcbrqzrq())&&
		localZfwsajlydjbDTO.getDczjajcbrqzrq().length()>=10){ %>
		<%=localZfwsajlydjbDTO.getDczjajcbrqzrq().substring(0,4) %>年
		<%=localZfwsajlydjbDTO.getDczjajcbrqzrq().substring(5,7)%>月
		<%=localZfwsajlydjbDTO.getDczjajcbrqzrq().substring(8,10)%>日
		<%}else{ %> &nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日<%} %>
		</span>
		</p>
		<p class="p7"></p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	    </body>
	</div>

</html>
