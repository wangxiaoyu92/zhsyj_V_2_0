<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsdcxzcfjds29DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	Zfwsdcxzcfjds29DTO dto=new Zfwsdcxzcfjds29DTO();
	if (request.getAttribute("mybean") != null) {
		dto = (Zfwsdcxzcfjds29DTO)request.getAttribute("mybean");
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
.s3{text-decoration:underline;}
.s4{color:black;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:3.4722223in;margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-indent:0.29166666in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{margin-left:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:FZFS;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:FZFS;font-size:10.5pt;}
.p9{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:3.8194444in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:5pt;}
.p12{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.lh30{line-height: 24px;}
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——当场行政处罚决定书");
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p12'><span class='s4'>注：存档（1），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（1）。</span></p>");
	LODOP.NewPage();//强制分页
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p12'><span class='s4'>注：存档（2），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（2）。</span></p>");
	LODOP.NewPage();//强制分页
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:1.8cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("280mm","20mm","85%","100%",
		"<p class='p12'><span class='s4'>注：存档（3），必要时交<%if(dto.getQzzzrmfy() != null){%><%=dto.getQzzzrmfy()%><%}%>人民法院强制执行（3）。</span></p>");
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
			<span class="s1"><%if (dto.getXzjgmc() != null) { %>
				<%=dto.getXzjgmc() %><%} %>
			</span>
		</p>
		<p class="p2">
		<span class="s2">当场行政处罚决定书</span>
		</p>
		<div align="right">
			<p class="p3">
				<span><%if(dto.getDccfwsbh() != null){ %>
				<%=dto.getDccfwsbh()%><%} %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4">
			<span>当事人名称或姓名：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;width: 130px;display: inline-block;">
			<%if(dto.getDccfdsr() != null){ %><%=dto.getDccfdsr()%><%} %></span>
			<span>性别：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;width: 50px;display: inline-block;">
			<%if(dto.getDccffddbrxbstr() != null){ %><%=dto.getDccffddbrxbstr()%><%} %></span>
			<span>公民身份号码：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;display: inline-block;">
			<%if(dto.getGmsfhm() != null){ %><%=dto.getGmsfhm()%><%} %></span>
		</p>
		<p class="p4">
			<span>法定代表人或负责人姓名：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;width: 80px;display: inline-block;">
			<%if(dto.getDccffddbr() != null){ %><%=dto.getDccffddbr()%><%} %></span>
			<span>职务：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;width: 80px;display: inline-block;">
			<%if(dto.getDccffddbrzw() != null){ %><%=dto.getDccffddbrzw()%><%} %></span>
			<span>地址：</span>
			<span style="border-bottom: 0px solid white-space;text-indent:0in;display: inline-block;">
			<%if(dto.getDccfdz() != null){ %><%=dto.getDccfdz()%><%} %></span>
		</p>	
		<p class="p4 lh30">
			<span>你（单位）</span>
			<%if(dto.getDccfwfxw() != null && !"".equals(dto.getDccfwfxw())){ %>
			<span><%=dto.getDccfwfxw() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 200px;">
			</span><%} %>
			<span>的行为，违反了</span>
			<%if(dto.getDccfwfgd() != null && !"".equals(dto.getDccfwfgd())){ %>
			<span><%=dto.getDccfwfgd() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 200px;">
			</span><%} %>
			<span>的规定。我局执法人员当场向你（单位）告知了违法事实、
			依据和依法享有的权利。并听取了你（单位）的陈述申辩（或：对此，你（单位）未作陈述申辩），现依据</span>
			<%if(dto.getDccfyjgd() != null && !"".equals(dto.getDccfyjgd())){ %>
			<span><%=dto.getDccfyjgd() %></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;display: inline-block;width: 200px;">
			</span><%} %>
			<span>，决定对你（单位）给予以下行政处罚：</span>
		</p>	
		<p class="p5 lh30">
			<span>1.警告；2.罚款人民币</span>
			<%if(dto.getFkrmbdxqian() != null && !"".equals(dto.getFkrmbdxqian())){ %>
			<span><%=dto.getFkrmbdxqian()%></span><%} else{%>
			<span style="display: inline-block;text-indent:0in;width: 20px;text-decoration: underline;">
			<%=StringHelper.myMakeStrLen("", 5, 0) %></span><%} %>
			<span>仟</span>
			<%if(dto.getFkrmbdxbai() != null && !"".equals(dto.getFkrmbdxbai())){ %>
			<span><%=dto.getFkrmbdxbai()%></span><%} else{%>
			<span style="display: inline-block;text-indent:0in;width: 20px;text-decoration: underline;">
			<%=StringHelper.myMakeStrLen("", 5, 0) %></span><%} %>
			<span>佰</span>
			<%if(dto.getFkrmbdxshi() != null && !"".equals(dto.getFkrmbdxshi())){ %>
			<span><%=dto.getFkrmbdxshi()%></span><%} else{%>
			<span style="display: inline-block;text-indent:0in;width: 20px;text-decoration: underline;">
			<%=StringHelper.myMakeStrLen("", 5, 0) %></span><%} %>
			<span>拾</span>
			<%if(dto.getFkrmbdxyuan() != null && !"".equals(dto.getFkrmbdxyuan())){ %>
			<span><%=dto.getFkrmbdxyuan()%></span><%} else{%>
			<span style="display: inline-block;text-indent:0in;width: 20px;text-decoration: underline;">
			<%=StringHelper.myMakeStrLen("", 5, 0) %></span><%} %>
			<span>元整（大写）。  &yen;：</span>
			<%if(dto.getFkrmbxx() != null && !"".equals(dto.getFkrmbxx())){ %>
			<span><%=dto.getFkrmbxx()%></span><%} else{%>
			<span style="display: inline-block;text-indent:0in;width: 30px;text-decoration: underline;">
			<%=StringHelper.myMakeStrLen("", 30, 0) %></span><%} %>
		</p>	
		<p class="p6 lh30">
			<span>缴纳罚款方式：（1）当场收缴。    （2）自收到本决定书之日起15日内将罚款缴至</span>
			<%if(dto.getFmkjkyh() != null && !"".equals(dto.getFmkjkyh())){ %>
			<span><%=dto.getFmkjkyh()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>。账号：</span>
			<%if(dto.getYhzh() != null && !"".equals(dto.getYhzh())){ %>
			<span><%=dto.getYhzh()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>户名：</span>
			<%if(dto.getYhhm() != null && !"".equals(dto.getYhhm())){ %>
			<span><%=dto.getYhhm()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>。到期不缴纳罚款的，根据《中华人民共和国行政处罚法》第五十一条第（一）项的规定，每日按罚款数额的3%加处罚款。</span>
		</p>
		<p class="p6 lh30">
			<span>如你（单位）不服本行政处罚决定，可以自收到本决定书之日起六十日内向</span>
			<%if(dto.getSjrmzf() != null && !"".equals(dto.getSjrmzf())){ %>
			<span><%=dto.getSjrmzf()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>人民政府或者</span>
			<%if(dto.getSjspypjdglj() != null && !"".equals(dto.getSjspypjdglj())){ %>
			<span><%=dto.getSjspypjdglj()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>申请行政复议，也可以自收到本决定书之日起六个月内依法直接向</span>
			<%if(dto.getSjrmfy() != null && !"".equals(dto.getSjrmfy())){ %>
			<span><%=dto.getSjrmfy()%></span><%} else{%>
			<span style="border-bottom: 0px solid  white-space;width: 80px;display: inline-block;"></span><%} %>
			<span>人民法院提起行政诉讼。逾期不申请行政复议，也不提起行政诉讼，又不履行本处罚决定的，我局将依法申请人民法院强制执行。</span>
		</p>
		<p class="p7"></p>
		<p class="p8"></p>
		<p class="p4">
			<span>当事人：</span>
			<span style="border-bottom: 0px solid white-space;width: 200px;display: inline-block;"></span>                 
			<span>执法人员：</span>
			<span style="border-bottom: 0px solid white-space;width: 100px;display: inline-block;"></span>
			<span>、</span>
			<span style="border-bottom: 0px solid white-space;width: 100px;display: inline-block;"></span>
		</p>
		<p class="p9">
			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
		</p>
		<br><br>
		<div align="right">
			<p class="p10">
				<span class="s4"> （公    章）</span>
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>
			</p>
			<br>
			<p class="p10">
				<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>年
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>月
	   			<span style="border-bottom: 0px solid  white-space;width: 50px;display: inline-block;"></span>日
			</p>
		</div>
	</body>
</div>
</html>
