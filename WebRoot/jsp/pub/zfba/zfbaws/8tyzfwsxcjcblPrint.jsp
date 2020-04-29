<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxcjcbl8DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 调查人员回避
	String dcryhb = "../../images/pub/feiduihao.jpg";
	// 调查人员不回避
	String dcrybhb = "../../images/pub/feiduihao.jpg";
	// 现场检查笔录内容
	Zfwsxcjcbl8DTO dto = new Zfwsxcjcbl8DTO();
    if (request.getAttribute("printbean") != null) {
    	// 获取要打印的对象信息
    	dto = (Zfwsxcjcbl8DTO) request.getAttribute("printbean");
    	// 是否申请检查人员回避
    	if ((dto != null) && ("1".equals(dto.getXcjcsfsqhb()))) {
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
.s3{border-bottom: 1px solid  black;display: inline-block; vertical-align:bottom;}
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

function printView(){ 
	CreatePrintPage();
  	LODOP.PREVIEW();		
}
//直接打印
function printData(){		
	CreatePrintPage();
  	LODOP.PRINT();		
}

//打印维护
function printSetup() {		
	CreatePrintPage();
	LODOP.PRINT_SETUP();		
}

//打印设计
function printDesign() {		
	CreatePrintPage();
	LODOP.PRINT_DESIGN();		
}

function CreatePrintPage() { 
	/* var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:1.8cm","BottomMargin:2.2cm",
			strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
	//添加内容
  	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title1").innerHTML);  */
	/* LODOP.SET_PRINT_STYLEA(0,"PageIndex",1); 
	LODOP.SET_PRINT_STYLEA(0,"ItemType",2);
	LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);
	LODOP.ADD_PRINT_TEXT(576,728,22,121, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); */
	/* LODOP.NewPageA();//强制分页
 	LODOP.ADD_PRINT_HTM("20mm","20mm", "RightMargin:1.8cm","100mm",strBodyStyle+document.getElementById("title2").innerHTML); 
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","2,3,4,5"); 
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	//LODOP.SET_PRINT_STYLEA(0,"LinkedItem",4);
	LODOP.SET_PRINT_STYLEA(0,"Alignment",2); 
	LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
	LODOP.SET_PRINT_STYLEA(0,"Horient",1); */	 
  	LODOP = getLodop();
	var strBodyStyle = "<style>" + document.getElementById("sty1").innerHTML + "</style>";
	LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——现场检查笔录");
	LODOP.ADD_PRINT_HTM("62mm", "20mm", "RightMargin:1.8cm",
			"BottomMargin:4.3cm", strBodyStyle + document.getElementById("page1").innerHTML);
	//添加内容
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
			strBodyStyle + document.getElementById("title1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", 1);
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",
			strBodyStyle + document.getElementById("title2").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "2,3,4");
	LODOP.ADD_PRINT_HTM("255mm","20mm", "RightMargin:1.8cm","100mm",
			strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0,"PageIndex","1,2,3,4,5"); 
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
				<span class="s2"><%if (dto.getAjdjay() != null) { %>
				 <%= dto.getAjdjay() %> <%} %>
				</span>
			</p>
			<p class="p4" >
				<span class="s2">被检查单位（人）：</span>
				<span class="s2"><%if (dto.getCommc() != null) { %>
				<%=dto.getCommc() %> <%} %>
				</span>
			</p>
			<p class="p4">
				<span class="s2">检查地点：</span>
				<span class="s2"><%if (dto.getComdz() != null) { %>
				<%=dto.getComdz() %><%} %>
				</span>
			</p>
			<p class="p4">
				<span class="s2">法定代表人（负责人）：</span>
				<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;">
				<%if (dto.getComfrhyz() != null) { %>
				<%=dto.getComfrhyz() %><%} %>
				</span>
				<span class="s2">联系方式：</span>
				<span class="s2"><%if (dto.getComyddh() != null) { %>
				<%=dto.getComyddh() %><%} %>
				</span>
			</p>
			<p class="p4">
				<span class="s2">检查人：</span>
				<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;">
				<%if (dto.getXcjcjcr() != null) { %>
				<%=dto.getXcjcjcr() %><%} %>
				</span>
				<span class="s2">记录人：</span>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;">
				<%if (dto.getCxjcjlr() != null) { %>
				<%=dto.getCxjcjlr() %><%} %>
				</span>
				<span class="s2">监督检查类别：</span>
				<span class="s2">
				<%if(dto.getDcbljdjclbstr()!=null){ %><%=dto.getDcbljdjclbstr() %><%} %>
				</span>
			</p>
			<p class="p4">
				<span class="s2">检查时间：</span>
				<%if(dto.getXcjcjcsjksrq() != null && !"".equals(dto.getXcjcjcsjksrq())){ %>
				<%=dto.getXcjcjcsjksrq().substring(0, 4)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">年</span>
				<%if(dto.getXcjcjcsjksrq() != null && !"".equals(dto.getXcjcjcsjksrq())){ %>
				<%=dto.getXcjcjcsjksrq().substring(5, 7)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">月</span>
				<%if(dto.getXcjcjcsjksrq() != null && !"".equals(dto.getXcjcjcsjksrq())){ %>
				<%=dto.getXcjcjcsjksrq().substring(8, 10)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">日</span>
				<%if(dto.getXcjcjcsjksrq() != null && !"".equals(dto.getXcjcjcsjksrq())){ %>
				<%=dto.getXcjcjcsjksrq().substring(11, 13)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">时</span>
				<%if(dto.getXcjcjcsjksrq() != null && !"".equals(dto.getXcjcjcsjksrq())){ %>
				<%=dto.getXcjcjcsjksrq().substring(14, 16)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">分至</span>
				<%if(dto.getXcjcjcsjjsrq() != null && !"".equals(dto.getXcjcjcsjjsrq())){ %>
				<%=dto.getXcjcjcsjjsrq().substring(11, 13)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">时</span>
				<%if(dto.getXcjcjcsjjsrq() != null && !"".equals(dto.getXcjcjcsjjsrq())){ %>
				<%=dto.getXcjcjcsjjsrq().substring(14, 16)%><%} else {%>
				<span style="border-bottom: 0px solid  white-space;width: 30px;display: inline-block;"></span><%} %>
				<span class="s2">分</span>
				
			</p>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p44 l24">
				<span class="s2">我们是</span>
				<span class="s2">
				<%if (dto.getSpypjdgljmcqc() != null && !"".equals(dto.getSpypjdgljmcqc())) { %> 
				<%=dto.getSpypjdgljmcqc()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 180px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">的执法人员</span>
				<span class="s2">
				<%if (dto.getXcjczfry1() != null && !"".equals(dto.getXcjczfry1())) { %> 
				<%=dto.getXcjczfry1()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">、</span>
				<span class="s2">
				<%if (dto.getXcjczfry2() != null && !"".equals(dto.getXcjczfry2())) { %> 
				<%=dto.getXcjczfry2()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">，编号是：</span>
				<span class="s2">
				<%if (dto.getXcjczfryzjbh1() != null && !"".equals(dto.getXcjczfryzjbh1())) { %> 
				<%=dto.getXcjczfryzjbh1()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">、</span>
				<span class="s2">
				<%if (dto.getXcjczfryzjbh2() != null && !"".equals(dto.getXcjczfryzjbh2())) { %> 
				<%=dto.getXcjczfryzjbh2()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">，现依法向你出示，请你确认。</span>
			</p>
			<p class="p5 l24">
				<span class="s2">我们在你单位</span>
				<span class="s2">
				<%if (dto.getCxjcptrzw() != null && !"".equals(dto.getCxjcptrzw())) { %> 
				<%=dto.getCxjcptrzw()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">
				<%if (dto.getCxjcptrxm() != null && !"".equals(dto.getCxjcptrxm())) { %> 
				<%=dto.getCxjcptrxm()%><%} else { %>
				<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span><%} %>
				</span>
				<span class="s2">陪同下进行现场检查。依照法律规定，对于检查人员，有下列情形之一的，应当自行回避，你也有权申请检查人员回避：
				（1）系当事人或当事人的近亲属；（2）与本案有直接利害关系；（3）与当事人有其他关系，可能影响案件公正处理的。</span>
			</p>
			<p class="p5">
				<span class="s2">是否申请调查人员回避，
				是<img alt="" src="<%=dcryhb%>" class="duihaokuang">，
				否<img alt="" src="<%=dcrybhb%>" class="duihaokuang">；
				签字：__________
				</span>
			</p> 
			<p class="p7">
				<span class="s2">现场检查记录： </span>
			</p>
			<p class="p6 l24">
			<%if (dto.getXcjcbl() != null && !"".equals(dto.getXcjcbl())) { %> 
					<%=SysmanageUtil.replaceStrChuLast(dto.getXcjcbl())%> <%} %>
			</p>
			<p class="p6"></p>
	</div>
	<div id=footer>
		<p class="p5">
			<span class="s2">被检查人：_________________
			<!-- <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			日期：_______年_____月_____日</span> -->
		</p>
		
		<p class="p5">
			<span class="s2">检查人：_________________
			<!-- <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			日期：_______年_____月_____日</span> -->
		</p>
		<p class="p5">
			<span class="s2">见证人：_________________
			<!-- <span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			日期：_______年_____月_____日</span> -->
		</p>
		
		<p class="p5">
			<span class="s2">记录人：_________________
			<span style="border-bottom: 0px solid  white-space;width: 100px;display: inline-block;"></span>
			日期：_______年_____月_____日</span>
		</p>
	</div>
</body>
</div>
</html>
