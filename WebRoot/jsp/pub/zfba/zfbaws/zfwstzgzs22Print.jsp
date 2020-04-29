<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.askj.zfba.dto.Zfwstzgzs22DTO, java.util.List,com.zzhdsoft.utils.StringHelper" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwstzgzs22DTO dto = new Zfwstzgzs22DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwstzgzs22DTO)request.getAttribute("mybean");
	}	
%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css" id="sty1">
.b1{white-space-collapsing:preserve;}
.b2{margin: 1.0in 1.25in 1.0in 1.25in;}
.s1{font-weight:bold;color:black;}
.s2{font-weight:bold;}
.s3{color:black;}
.s4{color:red;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.06944445in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:0.29166666in;margin-top:0.108333334in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.lh30{line-height: 24px;}
</style>
<title>听证告知书</title>
<meta content="X" name="author">

<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>
 
 <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" 
		width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
</object>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——听证告知书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP .ADD_PRINT_HTM("260mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", "");
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPage();//强制分页
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.3cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP .ADD_PRINT_HTM("260mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", ""); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
}
</script>
</head>
<div style="width: 210mm; margin: 0 auto;display: none">
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
		<p class="p1">
			<span class="s1"><%if (dto.getXzjgmc() != null) { %> <%=dto.getXzjgmc()%><%} %></span>
		</p>
		<p class="p2">
			<span class="s2">听证告知书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span class="s3"><%if(dto.getTzgzwsbh() != null){ %>
				<%=dto.getTzgzwsbh()%><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<%if (dto.getTzgzdsr() != null && !"".equals(dto.getTzgzdsr())) {%>
			<span><%=dto.getTzgzdsr()%>&nbsp;&nbsp;</span><%} else {%>
			<span class="s3" style="border-bottom: 1px solid  black;width: 300px;display: inline-block;"><%} %>:
		</p>
		<p class="p5 lh30">
			<span>我局于</span>
			<span style="border-bottom: 0px solid white-space;display: inline-block;width: 20px;">
			<%if(dto.getTzgzslasj() != null && !"".equals(dto.getTzgzslasj())){ %>
			<%=dto.getTzgzslasj().substring(0, 4)%><%} %></span>
			<span>年</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 20px;">
			<%if(dto.getTzgzslasj() != null && !"".equals(dto.getTzgzslasj())){ %>
			<%=dto.getTzgzslasj().substring(5, 7)%><%} %></span>
			<span>月</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 20px;">
			<%if(dto.getTzgzslasj() != null && !"".equals(dto.getTzgzslasj())){ %>
			<%=dto.getTzgzslasj().substring(8, 10)%><%} %></span>
			<span>日对</span>
			<%if(dto.getTzgzsay() != null && !"".equals(dto.getTzgzsay())){ %>
			<span><%=dto.getTzgzsay() %>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
			</span><%} %>
			<span>立案调查。经查，你（单位）</span>
			<%if(dto.getTzgzwfxwms() != null && !"".equals(dto.getTzgzwfxwms())){ %>
			<span><%=dto.getTzgzwfxwms() %>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 150px;display: inline-block;">
			</span><%} %>
			<span>。上述行为涉嫌违反了</span>
			<%if(dto.getTzgzwfflfg() != null && !"".equals(dto.getTzgzwfflfg())){ %>
			<span><%=dto.getTzgzwfflfg() %>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 130px;display: inline-block;">
			</span><%} %>
			<span>的规定。</span>
			<%if(dto.getTzgzszmnr() != null && !"".equals(dto.getTzgzszmnr())){ %>
			<span><%=dto.getTzgzwfflfg() %>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 130px;display: inline-block;"></span><%} %>
		</p>
		<p class="p5 lh30">
			<span>根据你（单位）违法行为的事实、性质、情节、社会危害程度和相关证据，参照</span>
			<span>《</span>
			<%if(dto.getCzxzcfclbz() != null && !"".equals(dto.getCzxzcfclbz())){ %>
			<span><%=dto.getCzxzcfclbz() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
			</span><%} %>
			<span>法（条例、办法）行政处罚裁量标准》，你（单位）的违法行为</span>
			<%if(dto.getTzgzwfxwdcstr() != null && !"".equals(dto.getTzgzwfxwdcstr())){ %>
			<span><%=dto.getTzgzwfxwdcstr() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			</span><%} %>
			<span>。依据</span>
			<%if(dto.getTzgzcfyjyzgd() != null && !"".equals(dto.getTzgzcfyjyzgd())){ %>
			<span><%=dto.getTzgzcfyjyzgd() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;">
			</span><%} %>
			<span>的规定，我局拟对你（单位）作出</span>
			<%if(dto.getTzgzxzcf() != null && !"".equals(dto.getTzgzxzcf())){ %>
			<span><%=dto.getTzgzxzcf() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 130px;display: inline-block;">
			</span><%} %>
			<span>行政处罚。</span>
		</p>
		<p class="p5 lh30">
			<span>依据《中华人民共和国行政处罚法》第四十二条第一款规定，
			你（单位）有权要求举行听证。如你（单位）要求听证，应当自收到本告知书之日起3日内向本机关提出申请。
			逾期不申请听证的，视为你(单位)放弃听证权利。</span>
		</p>
		<br><br>
		<div align="right">
			<p class="p7">
				<span class="s3">（公    章）</span>
			</p>
			<p class="p7">
				<span class="s3">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
				   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
				   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
		   		 </span>
			</p>
		</div>
		<br><br>
		<p class="p9"></p>
		<p class="p6"></p>
		<p class="p10 lh30">
			<span>行政机关地址：</span>
			<span style="border-bottom: 0px solid  white-space;width: 230px;display: inline-block;">
			<%if (dto.getGzgzdz() != null) { %><%=dto.getGzgzdz() %><%} %></span>
			<span>邮政编码：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getGzgzyzbm() != null) { %><%=dto.getGzgzyzbm() %><%} %></span>
		</p>
		<p class="p10">
			<span>行政机关联系人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 215px;display: inline-block;">
			<%if (dto.getGzgzlxr() != null) { %><%=dto.getGzgzlxr() %><%} %></span>
			<span>联系电话：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getGzgzlxdh() != null) { %><%=dto.getGzgzlxdh() %><%} %></span>
		</p>
	</div>
</body>
</div>
</html>
