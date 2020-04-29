<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfqzzxsqs33DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 行政处罚强制执行申请书
	Zfwsxzcfqzzxsqs33DTO dto = new Zfwsxzcfqzzxsqs33DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwsxzcfqzzxsqs33DTO) request.getAttribute("printbean");
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
.s3{font-family:仿宋_GB2312;color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-align:end;hyphenate:auto;font-family:仿宋;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.21875in;margin-left:0.14305556in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.21166666in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.36458334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{margin-top:0.034722224in;text-align:start;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{margin-right:0.072916664in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{margin-right:0.29166666in;text-align:end;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p14{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p15{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p16{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 30px;text-indent:0.29166666in;}
</style>

<title>行政处罚强制执行申请书</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚强制执行申请书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向	
	CreatePrintPage();
  	LODOP.PREVIEW();		
};

//直接打印
function printData(){
    LODOP=getLodop();  
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——行政处罚强制执行申请书");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向		
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%","注：存档（1）");
    LODOP.NewPage();
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%","注：存档（2）");
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
		<p class="p1"><span class="s1"><%if (dto.getXzjgmc() != null) { %>
				<%=dto.getXzjgmc() %><%} %></span></p>
		<p class="p2"><span class="s1">行政处罚强制执行申请书</span></p>
		<div align="right">
			<p class="p3"><span class="s3">
			<%if (dto.getQzsqwsbh() != null) { %> <%=dto.getQzsqwsbh() %><%} %>                               
			</span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">申请人：</span> 
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqsqr() != null) { %> <%=dto.getQzsqsqr()%><%} %></span> 
		</p>
		<p class="p4">
			<span class="s2">地址：</span> 
			<span style="border-bottom: 0px solid  white-space;width: 200px;display: inline-block;">
			<%if (dto.getQzsqsqrdz() != null) { %> <%=dto.getQzsqsqrdz()%><%} %></span>
			<span class="s2">联系人：</span> 
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
			<%if (dto.getQzsqsqrlxr() != null) { %> <%=dto.getQzsqsqrlxr()%><%} %></span>
			<span class="s2">联系方式：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqsqrlxfs() != null) { %> <%=dto.getQzsqsqrlxfs()%><%} %></span>
			
		</p>
		<p class="p4">
			<span class="s2">法定代表人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 230px;display: inline-block;">
			<%if (dto.getQzsqsqrfddbr() != null) { %> <%=dto.getQzsqsqrfddbr() %><%} %></span>
			<span>职务：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqsqrfddbrzw() != null) { %> <%=dto.getQzsqsqrfddbrzw() %><%} %></span>
		</p>
		<p class="p4">
			<span class="s2">委托代理人：</span>
			<span style="border-bottom: 0px solid  white-space;width: 230px;display: inline-block;">
			<%if (dto.getQzsqwtdlr() != null) { %> <%=dto.getQzsqwtdlr() %><%} %></span>
			<span class="s2">职务：</span>  
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqwtdlrzw() != null) { %> <%=dto.getQzsqwtdlrzw()%><%} %></span>
			
		</p>
		<p class="p4">
			<span class="s2">被申请人：</span>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqbsqr() != null) { %> <%=dto.getQzsqbsqr()%><%} %></span> 
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span> 
			<span style="border-bottom: 0px solid  white-space;width: 120px;display: inline-block;">
			<%if (dto.getQzsqbsqrfddbr() != null) { %> <%=dto.getQzsqbsqrfddbr()%><%} %></span>
			<span class="s2">职务：</span>
			<span style="border-bottom: 0px solid  white-space;width: 90px;display: inline-block;">
			<%if (dto.getQzsqbsqrzw() != null) { %> <%=dto.getQzsqbsqrzw()%><%} %></span>
       		<span class="s2">联系电话：</span>
       		<span style="border-bottom: 0px solid  white-space;display: inline-block;">
       		<%if (dto.getQzsqbsqrlxdh() != null) { %> <%=dto.getQzsqbsqrlxdh()%><%} %></span>
			 
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2" style="border-bottom: 0px solid  white-space;display: inline-block;">
			<%if (dto.getQzsqrmfymc() != null) { %> <%=dto.getQzsqrmfymc()%><%} else { %>
			<span style="border-bottom: 0px solid  white-space;width: 120px;display: inline-block;"></span> <%} %>人民法院：
			</span>
		</p>
		<p class="p5">
			<span class="s2 l24">申请人
			<%if (dto.getQzsqsqr() != null && !"".equals(dto.getQzsqsqr())) { %> 
			<span><%=dto.getQzsqsqr()%></span>
			<%} else { %><span style="border-bottom: 0px;display: inline-block;width: 50px;"></span><%} %>于
			<%if(dto.getQzsqsqrzcxzcfrq() != null && !"".equals(dto.getQzsqsqrzcxzcfrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrzcxzcfrq().substring(0, 4)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">年</span>
			<%if(dto.getQzsqsqrzcxzcfrq() != null && !"".equals(dto.getQzsqsqrzcxzcfrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrzcxzcfrq().substring(5, 7)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">月</span>
			<%if(dto.getQzsqsqrzcxzcfrq() != null && !"".equals(dto.getQzsqsqrzcxzcfrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrzcxzcfrq().substring(8, 10)%></span><%} else {%>
			<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
			<span class="s2">日</span>
			对被申请人
			<%if (dto.getQzsqbsqr() != null && !"".equals(dto.getQzsqbsqr())) { %> 
			<span><%=dto.getQzsqbsqr()%></span>
			<%} else { %><span style="border-bottom: 0px solid  white-space;display: inline-block;width: 50px;"></span><%} %>
			作出
			<%if (dto.getQzsqxzcfjdbh() != null && !"".equals(dto.getQzsqxzcfjdbh())) { %> 
			<span><%=dto.getQzsqxzcfjdbh()%></span>
			<%} else { %><span style="border-bottom: 0px solid  white-space;display: inline-block;width: 150px;"></span><%} %>
			行政处罚决定，并已于
			<%if(dto.getQzsqsdbsqrrq() != null && !"".equals(dto.getQzsqsdbsqrrq())){ %>
			<span class="s2"><%=dto.getQzsqsdbsqrrq().substring(0,4)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>年
			<%if(dto.getQzsqsdbsqrrq() != null && !"".equals(dto.getQzsqsdbsqrrq())){ %>
			<span class="s2"><%=dto.getQzsqsdbsqrrq().substring(5,7)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>月
			<%if(dto.getQzsqsdbsqrrq() != null && !"".equals(dto.getQzsqsdbsqrrq())){ %>
			<span class="s2"><%=dto.getQzsqsdbsqrrq().substring(8,10)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>日
			依法送达被申请人。
            </span>
		</p>
		<p class="p6">
			<span class="s2 l24">被申请人在法定期限内未履行该决定。申请人依据《中华人民共和国行政强制法》规定，于
			<%if(dto.getQzsqsqrcgrq() != null && !"".equals(dto.getQzsqsqrcgrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrcgrq().substring(0,4)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>年
			<%if(dto.getQzsqsqrcgrq() != null && !"".equals(dto.getQzsqsqrcgrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrcgrq().substring(5,7)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>月
			<%if(dto.getQzsqsqrcgrq() != null && !"".equals(dto.getQzsqsqrcgrq())){ %>
			<span class="s2"><%=dto.getQzsqsqrcgrq().substring(8,10)%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 30px;"></span><%} %>日
           	催告当事人履行行政处罚决定，被申请人逾期仍未履行。</span>
		</p>
		<p class="p6">
			<span class="s2 l24">根据《中华人民共和国行政处罚法》第五十一条第三项的规定，特申请贵院对下列行政处罚决定予以强制执行： </span>
		</p>
		<p class="p7"><span class="s2 l24"><%if(dto.getQzsqqzzznr() != null && !"".equals(dto.getQzsqqzzznr())){ %>
				<%=SysmanageUtil.replaceStrChuLast(dto.getQzsqqzzznr())%></span><%} else{%>
				<br><br><br><%} %></span></p>
		<br><br><br>				
		<div align="right">
			<p class="p11">
				<span class="s2"> 行政机关负责人：<%=StringHelper.myMakeStrLen("", 20, 0) %></span>
			</p>
			<p class="p12">
				<span class="s2" style="margin-right: 80px">（公    章）</span>
			</p>
			<p class="p13"  style="margin-right: 50px">
				<span class="s2">
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
				</span>
			</p>
		</div>
	</div>
</body>
</div>
</html>
