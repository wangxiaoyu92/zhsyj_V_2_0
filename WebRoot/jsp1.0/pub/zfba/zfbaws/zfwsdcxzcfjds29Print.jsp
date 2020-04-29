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
.s2{color:black;}
.s3{color:black;text-decoration: underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:2.6388888in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:宋体;font-size:12pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.p5{line-height: 24px;}
.tr{text-align: right;}
.lh{line-height: 24px;}
.ti{text-indent: 0.308333334in;}
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
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.NewPageA();//强制分页
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
	LODOP.NewPageA();//强制分页
	
	LODOP.ADD_PRINT_HTM("20mm","20mm","RightMargin:2.2cm","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm", "RightMargin:2.2cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,10,131, "第    三    联");  
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
		<span class="s1">当场行政处罚决定书</span>
		</p>
		<p class="p3 tr">
			<span class="s2"><%if(dto.getDccfwsbh() != null){ %>
			<%=dto.getDccfwsbh()%><%} %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;">
		<p class="p4 ">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 1px solid  black;width: 560px;display: inline-block;">
			<%if(dto.getDccfdsr() != null){ %><%=dto.getDccfdsr()%><%} %></span>
		</p>
		<p class="p4">
		<span class="s2">营业执照或其他资质证明：</span>
		<span style="border-bottom: 1px solid  black;width: 250px;display: inline-block;">
		<%if(dto.getDccfyyzzstr() != null){ %><%=dto.getDccfyyzzstr()%><%} %></span>                        
		<span class="s2">编号：</span>
		<span style="border-bottom: 1px solid  black;width: 150px;display: inline-block;">
		<%if(dto.getDccfyyzzbh() != null){ %><%=dto.getDccfyyzzbh()%><%} %></span>
		</p>
		<p class="p4">
		<span class="s2">组织机构代码（身份证）号：</span>
		<span style="border-bottom: 1px solid  black;width: 435px;display: inline-block;">
		<%if(dto.getDccfzzjgdm() != null){ %><%=dto.getDccfzzjgdm()%><%} %></span>
		</p>
		<p class="p4">
		<span class="s2">法定代表人（负责人）：</span>
		<span style="border-bottom: 1px solid  black;width: 180px;display: inline-block;">
		<%if(dto.getDccffddbr() != null){ %><%=dto.getDccffddbr()%><%} %></span>          
		<span class="s2">性别：</span>
		<span style="border-bottom: 1px solid  black;width: 50px;display: inline-block;">
		<%if(dto.getDccffddbrxbstr() != null){ %><%=dto.getDccffddbrxbstr()%><%} %></span>
        <span class="s2">职务：</span>
        <span style="border-bottom: 1px solid  black;width: 130px;display: inline-block;">
        <%if(dto.getDccffddbrzw() != null){ %><%=dto.getDccffddbrzw()%><%} %></span>
		</p>
		<p class="p4">
		<span class="s2">地址（住址）：</span>
		<span style="border-bottom: 1px solid  black;width: 230px;display: inline-block;">
		<%if(dto.getDccfdz() != null){ %><%=dto.getDccfdz()%><%} %></span>
		<span class="s2">邮编：</span>
		<span style="border-bottom: 1px solid  black;width: 80px;display: inline-block;">
		<%if(dto.getDccfyb() != null){ %><%=dto.getDccfyb()%><%} %></span>    
		<span class="s2 lh">电话：</span>
		<span style="border-bottom: 1px solid  black;width: 110px;display: inline-block;">
		<%if(dto.getDccfdh() != null){ %><%=dto.getDccfdh()%><%} %></span>
		</p>
		<p class="p4 lh ti">
		<span class="s2">你（单位）</span>
		<%if(dto.getDccfwfxw() != null && !"".equals(dto.getDccfwfxw())){ %>
		<span class="s3"><%=dto.getDccfwfxw()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else { %>
		<span style="border-bottom: 1px solid  black;width: 510px;display: inline-block;"></span><%} %>
		<span class="s2">的违法行为，违反了</span>
		<%if(dto.getDccfwfgd() != null && !"".equals(dto.getDccfwfgd())){ %>
		<span class="s3"><%=dto.getDccfwfgd()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span style="border-bottom: 1px solid  black;width: 420px;display: inline-block;"></span><%} %>
		<span class="s2">的规定。依据</span>
		<%if(dto.getDccfyjgd() != null && !"".equals(dto.getDccfyjgd())){ %>
		<span class="s3"><%=dto.getDccfyjgd()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span style="border-bottom: 1px solid  black;width: 350px;display: inline-block;"></span><%} %>
		<span class="s2">的规定，决定对你（单位）给予以下行政处罚：</span>
		<span class="s2"><%if(dto.getDccfxzcf1() != null && !"".equals(dto.getDccfxzcf1())){ %>
		<%=SysmanageUtil.replaceStrChuLast(dto.getDccfxzcf1())%><%} else{%>
		<br><br><br><br><br><%} %>
		</span>
		</p>
		<p class="p4"></p>
		<p class="p5 ti">
		<span class="s2">罚款按以下方式缴纳：</span>
		</p>
		<p class="p5 ti">
		<span class="s2 ">1.符合《中华人民共和国行政处罚法》第四十七条规定情形的，可以当场缴纳。</span>
		</p>
		<p class="p4 lh ti">
		<span class="s2">2.自即日起15日内将罚款交到</span>
		<%if(dto.getFmkjkyh() != null && !"".equals(dto.getFmkjkyh())){ %>
		<span class="s3"><%=dto.getFmkjkyh()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
		<span class="s2">银行，逾期不缴纳罚款的，根据《中华人民共和国行政处罚法》第五十一条第（一）项的规定，
		每日按罚款数额的3%加处罚款，并依法申请人民法院强制执行。</span>
		</p>
		<p class="p5 ti">
		<span class="s2">如不服本处罚决定，可在接到本处罚决定书之日起60日内向</span>
		<%if(dto.getSjspypjdglj() != null && !"".equals(dto.getSjspypjdglj())){ %>
		<span class="s3"><%=dto.getSjspypjdglj()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
		<span class="s2">食品药品监督管理局或者</span>
		<%if(dto.getSjrmzf() != null && !"".equals(dto.getSjrmzf())){ %>
		<span class="s3"><%=dto.getSjrmzf()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
		<span class="s2">人民政府申请行政复议，也可以于6个月内依法向</span>
		<%if(dto.getSjrmfy() != null && !"".equals(dto.getSjrmfy())){ %>
		<span class="s3"><%=dto.getSjrmfy()%>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
		<span class="s3" style="display: inline-block;text-indent:0in;">
		<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
		<span class="s2">人民法院提起行政诉讼。</span>
		</p>
		<p class="p5 ti">
		<span class="s2">处罚地点:</span>
		<span class="s2"><%if(dto.getDccfdd() != null){ %>
		<%=dto.getDccfdd()%><%} %></span>
		</p>
		<p class="p5 ti">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"></span> 
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>                  
		 	<span class="s2">执法人员：</span>
		 	<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"></span>   
		 	<span class="s2">、</span>
		 	<span style="border-bottom: 1px solid  black;width: 100px;display: inline-block;"></span>   
		</p>
		<p class="p6  ti">
			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>年
   			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>月
   			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>日
		</p>
		<p class="p4">
		</p>
		<p class="p4 tr"></p>
		<br/><br/><br/>
		<p class="p7"></p>
		<p class="p8">
		</p>
		<p class="p9"></p>
	</div>
	<div id="footer">
		<p class="p4 tr">
		<span class="s2"> （公    章）</span>
		</p>
		<br/>
		<p class="p6 tr">
			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>年
   			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>月
   			<span class="s3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>日
		</p>
		<p class="p8">
			<span class="s2">注：必要时交</span>
			<%if(dto.getQzzzrmfy() != null && !"".equals(dto.getQzzzrmfy())){ %>
			<span class="s3"><%=dto.getQzzzrmfy() %>&nbsp;&nbsp;&nbsp;&nbsp;</span><%} else{%>
			<span class="s3" style="display: inline-block;text-indent:0in;">
			<%=StringHelper.myMakeStrLen("", 40, 0) %></span><%} %>
			<span class="s2">人民法院强制执行。</span>
		</p>
	</div>
	</body></div>
</html>
