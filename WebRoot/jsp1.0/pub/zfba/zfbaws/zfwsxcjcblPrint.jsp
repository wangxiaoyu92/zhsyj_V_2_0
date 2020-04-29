<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxcjcbl8DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 调查人员回避
	String dcryhb = "../../images/pub/feiduihao.jpg";
	// 调查人员不回避
	String dcrybhb = "../../images/pub/feiduihao.jpg";
	// 现场检查笔录内容
	Zfwsxcjcbl8DTO localZfwsxcjcbl8DTO = new Zfwsxcjcbl8DTO();
    if (request.getAttribute("printbean") != null) {
    	// 获取要打印的对象信息
    	localZfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO) request.getAttribute("printbean");
    	// 是否申请检查人员回避
    	if ((localZfwsxcjcbl8DTO != null) && ("1".equals(localZfwsxcjcbl8DTO.getXcjcsfsqhb()))) {
    		dcryhb = "../../images/pub/duihao.jpg";
    	} else {
    		dcrybhb = "../../images/pub/duihao.jpg";
    	} 
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
.s3{color:black;text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{text-indent:4.375in;margin-top:0.108333334in;text-align:right;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p44{text-indent:0.29166666in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.29166666in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;text-indent:0.29166666in;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{text-indent:-3.4368055in;margin-left:3.4368055in;margin-top:0.108333334in;
	text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.l24{line-height: 25px;}
</style>

<title>现场检查笔录</title>
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
 /*function printView(){ 
	CreatePrintPage(); 
  	LODOP.PREVIEW();		
};*/
/**
 function printView(){
  LODOP=getLodop();  
  LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——现场检查笔录");
  LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
   for(i=1;i<3;i++){
	CreatePrintPage("第"+i+"联");
	}
  	LODOP.PREVIEW();		
};*/ 
function printView(){ 
    LODOP=getLodop();
    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——现场检查笔录");
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
/*	
 function CreatePrintPage(dnl) {
	//LODOP=getLodop(); 
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	//LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——现场检查笔录");
	// LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	// LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);  
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5");   
	LODOP.ADD_PRINT_TEXT(526,703,27,121,dnl);
	//LODOP.SET_PRINT_STYLEA(0,"Vorient",2);
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);  
	LODOP.NewPageA();//强制分页 
	} */
function CreatePrintPage() { 
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
	
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1);
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5");
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);
	LODOP.ADD_PRINT_TEXT(526,703,22,121, "第   一    联"); 
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	 
	LODOP.NewPageA();//强制分页
	
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex",1); 
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5"); 
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	//LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);
	LODOP.ADD_PRINT_TEXT(526,703,22,121, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12);
	LODOP.SET_PRINT_STYLEA(0,"Alignment",2);
	LODOP.ADD_PRINT_HTM(1,600,300,100,"总页号：<font color='#0000ff' format='ChineseNum'><span tdata='pageNO'>第##页</span>/<span tdata='pageCount'>共##页</span></font>");

		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"Horient",1);	 
	
	 
} /**
function CreatePrintPage() { 
LODOP=getLodop();
    LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——现场检查笔录");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	for(i=1;i<3;i++){  
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",strBodyStyle+document.getElementById("page1").innerHTML);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex%2+1",1);
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex%2+1","2,3,4,5");
	LODOP.ADD_PRINT_TEXT(526,703,27,121, "第   一    联");
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	 alert(i) 
	 LODOP.NewPageA();//强制分页
	}
	}*/
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
    <body class="b1 b2">
		<div class="Noprint">
			<!-- 
		    <a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
		    	class="easyui-linkbutton" onclick=" printSetup();">打印维护</a>
			<a href="javascript:void(0)" id="pagesetBtn" icon="icon-page-set" 
				class="easyui-linkbutton" onclick=" printDesign();">打印设计</a>
			-->
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
			<p class="p2"><span class="s1">现场检查笔录 </span></p>
			<p class="p3">
			<span tdata="PageNO" format="#" class="s2">第###页</span><span tdata="PageCount" format="#">共###页</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
		<!-- 标题除了第一页 -->
		<div align="center" id="title2">
			<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
			<p class="p2"><span class="s1">(现场检查笔录)副页</span></p>
			<p class="p3">
				<span tdata="PageNO" format="#" class="s2">第###页</span><span tdata="PageCount" format="#">共###页</span>
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		</div>
		<div align="center" id="page1">
		<p class="p4">
			<span class="s2">检查事由：</span>
			<span>
				<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getAjdjay(),130,0)%></u>
			</span>
		</p>
		<p class="p4">
			<span class="s2">被检查单位（人）：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getCommc(),130,0)%></u>
			</span>
		</p>
		<p class="p4">
			<span class="s2">检查地点：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getComdz(),130,0)%></u>
			</span>
		</p>
		<p class="p4">
			<span class="s2">法定代表人（负责人）：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getComfrhyz(),45,0)%></u>
			</span>
			<span class="s2">联系方式：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getComyddh(),45,0)%></u>
			</span>
		</p>
		<p class="p4">
			<span class="s2">检查人：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcr(),25,0)%></u>
			</span>
			<span class="s2">记录人：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getCxjcjlr(),25,0)%></u>
			</span>
			<span class="s2">监督检查类别：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getDcbljdjclbstr(),25,0)%></u>
			</span>
		</p>
		<p class="p4">
			<span class="s2">检查时间：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjksrq().substring(0,4),20,1) %></u>
			</span>
			<span class="s2">年</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjksrq().substring(5,7),10,1)%></u>
			</span>
			<span class="s2">月</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjksrq().substring(8,10),10,1)%></u>
			</span>
			<span class="s2">日</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjksrq().substring(11,13),10,1)%></u>
			</span>
			<span class="s2">时</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjksrq().substring(14,16),10,1)%></u>
			</span>
			<span class="s2">分至</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjjsrq().substring(11,13),10,1)%></u>
			</span>
			<span class="s2">时</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjcsjjsrq().substring(14,16),10,1)%></u>
			</span>
			<span class="s2">分</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p44 l24">
			<span class="s2">我们是</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getSpypjdgljmcqc(),30,0)%></u>
			</span>
			<span class="s2">的执法人员</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfry1(),10,0)%></u>
			</span>
			<span class="s2">、</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfry2(),10,0)%></u>
			</span>
			<span class="s2">，执法证件名称、编号是：</span>
			<span class="s3">
				<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getZfzjmc(),20,0)%></u>,
				<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfryzjbh1(),15,0)%></u>、
				<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfryzjbh2(),15,0)%></u>
			</span>
			<span class="s2">。</span>
		</p>
		<p class="p5 l24">
			<span class="s2">我们在你单位</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getCxjcptrzw(),18,0)%></u>
			</span>
			<span class="s2">（职务）</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getCxjcptrxm(),10,0) %></u>
			</span>
			<span class="s2">（姓名）陪同下进行现场检查。依照法律规定，对于检查人员，有下列情形之一的，应当自行回避，你也有权申请检查人员回避：
			（1）系当事人或当事人的近亲属；（2）与本案有直接利害关系；（3）与当事人有其他关系，可能影响案件公正处理的。</span>
		</p>
		<p class="p5">
			<span class="s2">是否申请调查人员回避，
			是<img alt="" src="<%=dcryhb%>" class="duihaokuang">，
			否<img alt="" src="<%=dcrybhb%>" class="duihaokuang">；
			签字：
			</span>
			<span class="s3">
				<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcsfsqhbqz(),30,0) %></u>
			</span>
		</p>
		<p class="p5">
			<span class="s2">现场检查记录： </span>
		</p>
		<p class="p6 l24"><%=localZfwsxcjcbl8DTO.getXcjcbl()%></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p6"></p>
		<p class="p7">
			<span class="s2">被检查人：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcbjcr(),40,0)%></u>
			</span>
			<span class="s2">职务：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcbjcrzw(),20,0)%></u>
			</span>
			<span class="s2">&nbsp;&nbsp;</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcbjcrqzrq().substring(0,4),10,1) %></u>
			</span>
			<span class="s2">年</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcbjcrqzrq().substring(5,7),10,1) %></u>
			</span>
			<span class="s2">月</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcbjcrqzrq().substring(8,10),10,1) %></u>
			</span>
			<span class="s2">日</span>
		</p>
		<p class="p7">
			<span class="s2">见证人：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjzr(),20,0) %></u>
			</span>
			<span class="s2">身份证号码：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjzrsfzh(),25,0) %></u>
			</span>
			<span class="s2">&nbsp;&nbsp;</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjzrqzrq().substring(0,4),10,1) %></u>
			</span>
			<span class="s2">年</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjzrqzrq().substring(5,7),10,1) %></u>
			</span>
			<span class="s2">月</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjcjzrqzrq().substring(8,10),10,1) %></u>
			</span>
			<span class="s2">日</span>
		</p>
		<p class="p7">
			<span class="s2">执法人员：</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfry(),75,0) %></u>
			</span>
			<span class="s2">&nbsp;&nbsp;</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfryqzrq().substring(0,4),10,1) %></u>
			</span>
			<span class="s2">年</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfryqzrq().substring(5,7),10,1) %></u>
			</span>
			<span class="s2">月</span>
			<span class="s3">
			<u><%=StringHelper.myMakeStrLen(localZfwsxcjcbl8DTO.getXcjczfryqzrq().substring(8,10),10,1) %></u>
			</span>
			<span class="s2">日</span>
		</p>
		<p class="p8"></p>
	</div>
    </body>
</div>
</html>
