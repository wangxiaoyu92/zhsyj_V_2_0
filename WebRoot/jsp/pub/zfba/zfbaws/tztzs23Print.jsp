<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.askj.zfba.dto.Zfwstztzs23DTO"%>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	Zfwstztzs23DTO dto = new Zfwstztzs23DTO();
	if (request.getAttribute("printbean") != null) {
		dto = (Zfwstztzs23DTO) request.getAttribute("printbean");
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
.s4{font-family:仿宋_GB2312;color:black;}
.s5{text-decoration:underline;}
.p1{text-align:center;hyphenate:auto;font-family:黑体;font-size:16pt;}
.p2{text-align:center;hyphenate:auto;font-family:Times New Roman;font-size:22pt;}
.p3{margin-top:0.108333334in;text-align:end;hyphenate:auto;font-family:仿宋;font-size:10.5pt;}
.p4{text-indent:0.072916664in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-indent:0.36458334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{text-indent:-0.072916664in;margin-left:0.072916664in;text-align:start; 
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-right:0.65625in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:3.7916667in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-indent:0.29166666in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p11{text-indent:0.2777778in;margin-left:0.072916664in;text-align:start;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p12{text-indent:0.06944445in;margin-top:0.108333334in;text-align:justify;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p13{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.lh30{line-height: 24px;}
</style>
<title>食品药品行政处罚文书</title>
<meta content="X" name="author">
<!-- 引入库 -->

<jsp:include page="${path}/inc.jsp"></jsp:include>

<script language="javascript" src="<%=basePath%>lodop/LodopFuncs.js"></script>

<!-- 插入打印控件 -->

<object id="LODOP_OB"
	classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
		pluginspage="<%=basePath%>lodop/install_lodop32.exe"></embed>
</object>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var s = new Object();   
	s.type = "ok";       
	sy.setWinRet(s); 
 var LODOP; //声明为全局变量

	$(function() {
		printView();
		parent.$("#"+sy.getDialogId()).dialog("close"); 
	});

	//打印预览 
	function printView() {
	    LODOP = getLodop();
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——听证通知书");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
		CreatePrintPage();
		LODOP.PREVIEW();
	};

	//直接打印
	function printData() {
	    LODOP = getLodop();
		LODOP.PRINT_INITA(0, 0, "210mm", "297mm", "执法文书——听证通知书");
		LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
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
		var strBodyStyle = "<style>"+document.getElementById("sty1").innerHTML + "</style>";
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", 
			strBodyStyle+document.getElementById("page1").innerHTML);
		 
		LODOP .ADD_PRINT_HTM("260mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", "");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);   
		LODOP.NewPage();
		LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", 
			strBodyStyle+document.getElementById("page1").innerHTML);
		LODOP .ADD_PRINT_HTM("260mm", "20mm", "RightMargin:1.8cm", "BottomMargin:2.2cm", "");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",10);   
	}
</script>
<meta content="X" name="author">
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
			<p class="p1">
				<span class="s1"><%if (dto.getXzjgmc() != null) { %> <%=dto.getXzjgmc()%><%} %></span>
			</p>
			<p class="p2">
				<span class="s1">听证通知书</span>
			</p>
			<div align="right">
				<p class="p3">
				  <span class="s3"><%if(dto.getTztzwsbh() != null){ %>
					<%=dto.getTztzwsbh()%><%} %></span>
				</p>
			</div>
			<hr style="height:2px;border:none;border-top:2px solid #555555;" />
			<p class="p4">
				<%if (dto.getTztzdsr() != null && !"".equals(dto.getTztzdsr())) {%>
				<span><%=dto.getTztzdsr()%>&nbsp;&nbsp;</span><%} else {%>
				<span class="s3" style="border-bottom: 1px solid  black;width: 300px;display: inline-block;"><%} %>:
			</p>
			<p class="p5 lh30">
				<span>根据你（单位）</span>
				<%if(dto.getTztzsqrq() != null && !"".equals(dto.getTztzsqrq())){ %>
				<%=dto.getTztzsqrq().substring(0, 4)%><%} else {%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span>
				<%} %>
				<span>年</span>
				<%if(dto.getTztzsqrq() != null && !"".equals(dto.getTztzsqrq())){ %>
				<%=dto.getTztzsqrq().substring(5, 7)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>月</span>
				<%if(dto.getTztzsqrq() != null && !"".equals(dto.getTztzsqrq())){ %>
				<%=dto.getTztzsqrq().substring(8, 10)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 20px;display: inline-block;">
				</span><%} %>
				<span>日就</span>
				<%if(dto.getTztzsay() != null && !"".equals(dto.getTztzsay())){ %>
				<span><%=dto.getTztzsay() %>&nbsp;&nbsp;</span><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 300px;display: inline-block;"></span><%} %>
				<span>一案提出的听证要求，我局决定于</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzjxrq().substring(0, 4)%><%} else {%>
				<span style="display: inline-block;text-indent:0in;width: 30px;">
				<%=StringHelper.myMakeStrLen("", 10, 0) %></span><%} %>
				<span>年</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(5, 7)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>月</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(8, 10)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>日</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(11, 13)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>时</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(14, 16)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>分在</span>
				<%if(dto.getTztzdd() != null && !"".equals(dto.getTztzdd())){ %>
				<span><%=dto.getTztzdd() %>&nbsp;</span><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 100px;display: inline-block;"></span><%} %>
				<span>举行听证。本次听证由</span>
				<%if(dto.getTztzzcr() != null && !"".equals(dto.getTztzzcr())){ %>
				<span><%=dto.getTztzzcr() %>&nbsp;</span><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 100px;display: inline-block;"></span><%} %>
				<span>为听证主持人，</span>
				<%if(dto.getTztzjly() != null && !"".equals(dto.getTztzjly())){ %>
				<span><%=dto.getTztzjly() %>&nbsp;</span><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 100px;display: inline-block;"></span><%} %>
				<span>为记录人。请你（单位）或者委托代理人持本通知准时参加。</span>
			</p>
			<p class="p5 lh30">
				<span>如你（单位）认为主持人与本案有直接利害关系的，有权申请回避。申请主持人回避，可在听证举行前（</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzjxrq().substring(0, 4)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>年</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(5, 7)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>月</span>
				<%if(dto.getTztzjxrq() != null && !"".equals(dto.getTztzjxrq())){ %>
				<%=dto.getTztzsqrq().substring(8, 10)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>日前）向我局提出申请并说明理由。因特殊原因需申请延期举行的，应当在</span>
				<%if(dto.getTztzsyqrq() != null && !"".equals(dto.getTztzsyqrq())){ %>
				<%=dto.getTztzsyqrq().substring(0, 4)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>年</span>
				<%if(dto.getTztzsyqrq() != null && !"".equals(dto.getTztzsyqrq())){ %>
				<%=dto.getTztzsyqrq().substring(5, 7)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>月</span>
				<%if(dto.getTztzsyqrq() != null && !"".equals(dto.getTztzsyqrq())){ %>
				<%=dto.getTztzsyqrq().substring(8, 10)%><%} else{%>
				<span style="border-bottom: 0px solid white-space;width: 30px;display: inline-block;"></span><%} %>
				<span>日前向我局提出，由我局决定是否延期。若无正当理由不按时参加听证，又不事先说明理由的，视为放弃听证权利，本机关将终止听证。</span>
			</p>
			<p class="p5">
				<span>参加听证前，请你（单位）注意下列事项：</span>
			</p>
			<p class="p5 lh30">
				<span>1.当事人可亲自参加听证，也可以委托1-2名代理人参加听证。委托代理人参加听证的，
					应在听证举行前提交由当事人或当事人的法定代表人签署的授权委托书，载明委托的事项、权限和期限。
				</span>
			</p>
			<p class="p5">
				<span>2.参加听证时应携带当事人或委托代理人的身份证明原件及其复印件和有关证据材料。</span>
			</p>
			<p class="p5">
				<span>3.当事人有证人出席作证的，应通知有关证人出席作证，并事先告知本机关联系人。</span>
			</p>
			<p class="p5 lh30">
				<span>联系人：</span>
				<span style="border-bottom: 0px solid white-space;display: inline-block;width: 200px;">
				<%if(dto.getTztzlxr() != null && !"".equals(dto.getTztzlxr())){ %>
				<%=dto.getTztzlxr() %><%} %></span>
				<span>联系电话：</span>
				<span style="border-bottom: 0px solid white-space;display: inline-block;">
				<%if(dto.getTztzlxdh() != null && !"".equals(dto.getTztzlxdh())){ %>
				<%=dto.getTztzlxdh() %><%} %></span>
			</p>
			<p class="p5">
				<span>单位地址：</span>
				<%if(dto.getTztzdz() != null && !"".equals(dto.getTztzdz())){ %>
				<span><%=dto.getTztzdz() %></span><%}%>
			</p>		
			<br>
			<br>	
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
			<br>
			<br>
			<p class="p10">
				<span>听证申请人或委托代理人：</span>
				<span><%=StringHelper.myMakeStrLen("", 25, 0) %></span>    
				<span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
			   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
				</span>
			</p>
		</div>
	</body>
</div>
</html>
