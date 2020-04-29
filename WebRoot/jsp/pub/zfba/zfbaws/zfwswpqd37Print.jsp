<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.Map" %>
<%@ page import="com.askj.zfba.dto.Zfwswpqd37DTO,com.askj.zfba.service.pub.WsgldyService" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder,com.zzhdsoft.siweb.dto.PagesDTO"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	// 物品清单id
	String v_wpqdid = StringHelper.showNull2Empty(request.getParameter("wpqdid"));
	// 物品清单
	Zfwswpqd37DTO dto = new Zfwswpqd37DTO();
    if (request.getAttribute("printbean") != null) {
    	dto = (Zfwswpqd37DTO) request.getAttribute("printbean");
    }	
    String v_fjcszfwstitle = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcszfwstitle")),"UTF-8");
    
    WsgldyService v_WsgldyService = new WsgldyService();
    Zfwswpqd37DTO v_dto = new Zfwswpqd37DTO();
    PagesDTO v_pdto = new PagesDTO();
    
    v_dto.setWpqdid(v_wpqdid);
    Map v_map = v_WsgldyService.queryZfwswpqdmx(v_dto,v_pdto);
    
    List<Zfwswpqd37DTO> v_list = (List<Zfwswpqd37DTO>)v_map.get("rows");    
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
.p3{margin-right:-0.60694444in;margin-top:0.108333334in;text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.108333334in;margin-bottom:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:center;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
/* .p6{margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;} */
/* .p7{margin-left:-0.0013888889in;margin-top:0.21666667in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;} */
.p6{margin-top:0.108333334in;text-align:center;hyphenate:auto;
font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:justify;hyphenate:auto;
font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-indent:0.34583333in;margin-left:0.050694443in;margin-top:0.21666667in;text-align:left;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p9{text-indent:0.8020833in;margin-top:0.108333334in;text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p10{text-align:justify;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.td1{width:0.8090278in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td2{width:1.5569445in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td3{width:0.5in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td4{width:1.1340277in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td5{width:0.6159722in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.625in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;}
.td7{width:0.57916665in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-top:thin solid black;}
.td8{width:5.5111113in;padding-start:0.0in;padding-end:0.0in;border-bottom:thin solid black;border-left:thin solid black;border-top:thin solid black;}
.r1{keep-together:always;}
.r2{height:0.090277776in;keep-together:always;}
.t1{table-layout:fixed;border-collapse:collapse;border-spacing:0;}
</style>

<title>食品药品行政处罚文书</title>
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——物品清单");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	CreatePrintPage1();
  	LODOP.PREVIEW();
  	CreatePrintPage2();
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
// 打印第一联	
function CreatePrintPage1() {
	
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	//添加内容
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",strBodyStyle + document.getElementById("title1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "1,2,3,4,5");
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:2.3cm","BottomMargin:4.5cm", strBodyStyle + document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("265mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle + document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "1,2,3,4,5");
}
// 打印第二联
function CreatePrintPage2() {
	var strBodyStyle="<style>"+document.getElementById("sty1").innerHTML+"</style>";
	//添加内容
	LODOP.ADD_PRINT_HTM("20mm", "20mm", "RightMargin:1.8cm", "100mm",strBodyStyle + document.getElementById("title1").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "1,2,3,4,5");
	LODOP.ADD_PRINT_HTM("62mm","20mm","RightMargin:2.3cm","BottomMargin:4.5cm",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("265mm","20mm", "RightMargin:2.3cm","100mm",strBodyStyle+document.getElementById("footer").innerHTML);
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "1,2,3,4,5");
	//添加内容
	LODOP.ADD_PRINT_TEXT(526,723,8,131, "第    二    联");  
	LODOP.SET_PRINT_STYLEA(0,"FontSize",12); 
	LODOP.SET_PRINT_STYLEA(0, "PageIndex", "1,2,3,4,5");
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
	<div align="center" id="title1">
		<p class="p1">
			<span class="s1"><%if(dto.getXzjgmc() != null){ %><%=dto.getXzjgmc() %><%} %></span>
		</p>
		<p class="p2">
			<span class="s1">（<%=v_fjcszfwstitle %>）物品清单</span>
		</p>
		<p class="page">
			<span class="s2">文书文号:</span>
			<span style="border-bottom: 0px solid word-spacing;width: 400px;display: inline-block;">
			<%if(dto.getWpqdwsbh() != null){ %><%=dto.getWpqdwsbh() %><%} %></span>
			<span tdata="PageNO" format="#">第###页</span>
			<span tdata="PageCount" format="#">共###页</span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
	</div>
	<div align="center" id="page1">
		<p class="p4">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 1px solid black;width: 250px;display: inline-block;">
			<% if (dto.getWppddsr() != null) {%><%=dto.getWppddsr() %><%} %></span>
			<span class="s2">地 址：</span>
			<span style="border-bottom: 1px solid black;width: 250px;display: inline-block;">
			<% if (dto.getWppddz() != null) {%><%=dto.getWppddz() %><%} %></span>
		</p>
		<table class="t1" id="wpmx">
			<tbody>
			<tr class="r1">
				<td class="td1"><p class="p6"><span class="s2">品名</span></p></td>
				<td class="td2"><p class="p6"><span class="s2">标示生产企业</span></p>
					<p class="p6"><span class="s2">或经营单位</span></p>
				</td>
				<td class="td3"><p class="p6"><span class="s2">规格</span></p></td>
				<td class="td4"><p class="p6"><span class="s2">生产批号</span></p>
					<p class="p6"><span class="s2">或生产日期</span></p>
				</td>
				<td class="td5"><p class="p6"><span class="s2">数量</span></p></td>
				<td class="td3"><p class="p6"><span class="s2">单价</span></p></td>
				<td class="td6"><p class="p6"><span class="s2">包装</span></p></td>
				<td class="td7"><p class="p6"><span class="s2">备注</span></p></td>
			</tr>
			 <%    
			 	for (int k = 0; k < v_list.size(); k++){
			    	Zfwswpqd37DTO v_37DTO=(Zfwswpqd37DTO)v_list.get(k);
			%>
		  	<tr class='r1'>
		  			<td class='td1'><p class='p6'><%=v_37DTO.getWpmxpm()%></p></td>
		  			<td class='td2'><p class='p6'><%=v_37DTO.getWpmxbsscqy()%></p></td>
		  			<td class='td3'><p class='p6'><%=v_37DTO.getWpmxgg()%></p></td>
		  			<td class='td4'><p class='p6'><%=v_37DTO.getWpmxscpc()%></p></td>
		  			<td class='td5'><p class='p6'><%=v_37DTO.getWpmxsl()%></p></td>
		  			<td class='td6'><p class='p6'><%=v_37DTO.getWpmxdj()%></p></td>
		  			<td class='td6'><p class='p6'><%=v_37DTO.getWpmxbz()%></p></td>
		  			<td class='td7'><p class='p6'><%=v_37DTO.getWpmxbeiz()%></p></td>
		  	</tr>  			
			<%  }
			if ((v_list.size() < 18) || (v_list.size() > 18 && v_list.size() < 40)) {
				int num = v_list.size() - 18 > 0?v_list.size() - 18:v_list.size();
				for (int k = num; k < 18; k++){ %>
					<tr style="height:30px;">
			  			<td class='td1'><p class='p7'></p></td>
			  			<td class='td2'><p class='p7'></p></td>
			  			<td class='td3'><p class='p7'></p></td>
			  			<td class='td4'><p class='p7'></p></td>
			  			<td class='td5'><p class='p7'></p></td>
			  			<td class='td6'><p class='p7'></p></td>
			  			<td class='td6'><p class='p7'></p></td>
			  			<td class='td7'><p class='p7'></p></td>
			  		</tr>
			<% } }%> 
			<tr class='r1'>
				<td class='td1'><p class='p7'>其他物品</p></td>
				<td class='td7' colspan='7'><p class='p7'>
					<%if(dto.getWpqdqtwp() != null){ %>
					<%=dto.getWpqdqtwp()%><%} %></p></td>
			</tr>
			</tbody>
		</table>
		<p class="p7">
			<span class="s2">上述物品品种、数量经核对无误。</span>
		</p>
	</div>
	<div id="footer">
		<p class="p8">
			<span class="s2">当事人签字：</span>
			<span style="border-bottom: 1px solid black;width: 100px;display: inline-block;"></span>
			<span style="border-bottom: 0px solid word-spacing;width: 70px;display: inline-block;"></span>
            <span class="s2">执法人员签字：</span>
            <span style="border-bottom: 1px solid black;width: 80px;display: inline-block;"></span>
            <span class="s2">、</span>
            <span style="border-bottom: 1px solid black;width: 80px;display: inline-block;"></span>
		</p>
		<p class="p9">
			<span class="s2">
				<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">年</span>
		   		<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">月</span>
		   		<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">日</span> 
			</span>
			<span style="border-bottom: 0px solid  word-spacing;width: 200px;display: inline-block;"></span>
			<span class="s2">
				<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">年</span>
		   		<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">月</span>
		   		<span style="border-bottom: 0px solid  word-spacing;width: 40px;display: inline-block;">日</span> 
			</span>
		</p>
	 </div>
</body>
</div>
</html>
