<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil,java.util.Map" %>
<%@ page import="com.askj.zfba.dto.Zfwsmswpclqd31DTO,com.zzhdsoft.siweb.dto.PagesDTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,com.askj.zfba.service.pub.WsgldyService"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"
			+request.getServerPort()+path+"/";
	// 案件登记id
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
	// 没收物品处理清单
	Zfwsmswpclqd31DTO localZfwsmswpclqd31DTO = new Zfwsmswpclqd31DTO();
    if (request.getAttribute("printbean") != null) {
    	localZfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO) request.getAttribute("printbean");
    }	
    
     WsgldyService v_WsgldyService=new WsgldyService();
    Zfwsmswpclqd31DTO v_dto=new Zfwsmswpclqd31DTO();
    PagesDTO v_pdto=new PagesDTO();
    
    v_dto.setAjdjid(v_ajdjid);
    Map v_map=v_WsgldyService.queryZfwsmswpclqdmx(v_dto,v_pdto);
    
    List<Zfwsmswpclqd31DTO> v_list=(List<Zfwsmswpclqd31DTO>)v_map.get("rows");  
   // Zfwsmswpclqd31DTO v_k=(Zfwsmswpclqd31DTO)v_list.get(0);
   // System.out.println(v_k.getMsmxdw());
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
.p3{text-indent:3.5416667in;margin-top:0.108333334in;text-align:end;
	hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p4{margin-top:0.21666667in;text-align:justify;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p5{text-align:start;hyphenate:auto;font-family:仿宋_GB2312;font-size:10.5pt;}
.p6{margin-top:0.108333334in;text-align:center;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p7{margin-top:0.108333334in;text-align:center;hyphenate:auto;
	font-family:仿宋_GB2312;font-size:10.5pt;}
.p8{text-align:justify;hyphenate:auto;font-family:Times New Roman;font-size:10.5pt;}
.td1{width:1.0354167in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-right:thin solid black;
		border-top:thin solid black;}
.td2{width:0.66736114in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td3{width:0.5159722in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td4{width:0.7395833in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td5{width:0.84791666in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td6{width:0.76944447in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-right:thin solid black;border-top:thin solid black;}
.td7{width:0.72986114in;padding-start:0.0in;padding-end:0.0in;
	border-bottom:thin solid black;border-left:thin solid black;
	border-top:thin solid black;}
.r1{keep-together:always;}
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
	LODOP.PRINT_INITA(0,0,"210mm","297mm","执法文书——没收物品处理清单");
	LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");//A4 纵向
	LODOP.ADD_PRINT_HTM("20mm","20mm","85%","100%",strBodyStyle+document.getElementById("page1").innerHTML);
	LODOP.ADD_PRINT_HTM("240mm","20mm","85%","100%",strBodyStyle+document.getElementById("footer").innerHTML);
}
</script>

</head>
<div style="width: 210mm; margin: 0 auto;display: none;">
<body class="b1 b2">
	<input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>" />
	<div class="Noprint">
		<a href="javascript:void(0)" id="printViewBtn" icon="icon-page-find" 
			class="easyui-linkbutton" onclick="printView();">打证预览</a>
		<a href="javascript:void(0)" id="saveBtn" icon="icon-print" 
			class="easyui-linkbutton" onclick="printData();">直接打证</a>
		<a href="javascript:void(0)" id="backBtn" icon="icon-back" 
			class="easyui-linkbutton" onclick="javascript:window.close()">关闭返回</a>
	</div>	
	<div align="center" id="page1">
		<p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
		<p class="p2"><span class="s1">没收物品处理清单</span></p>
		<div align="right">
			<p class="p3"><span class="s2"><%=localZfwsmswpclqd31DTO.getMsclwsbh() %></span>
			</p>
		</div>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p4">
			<span class="s2">根据<%=localZfwsmswpclqd31DTO.getMsclxzcfjdsbh() %>
			《行政处罚决定书》</span>
		</p>
		<p class="p5">
			<span class="s2">当事人：</span>
			<span style="border-bottom: 1px solid  black;width: 200px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMscldsr()%></span>
			地 址：<span style="border-bottom: 1px solid  black;width: 180px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMscldsrdz()%></span>
			电话：<span style="border-bottom: 1px solid  black;width: 90px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMscldsrdh() %></span>
			
		</p>
		<p class="p5">
			 执行处置单位： <span style="border-bottom: 1px solid  black;width: 160px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMsclzxczdw() %></span>
			地 址：<span style="border-bottom: 1px solid  black;width: 180px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMsclczdwdz()%></span>
			电话：<span style="border-bottom: 1px solid  black;width: 90px;display: inline-block;"><%=localZfwsmswpclqd31DTO.getMsclczdwdh() %></span>
		</p>
		<hr style="height:2px;border:none;border-top:2px solid #555555;" />
		<p class="p6">
			<span class="s1">没收物品处理情况明细表</span>
		</p>         
            
		<table class="t1" id="mswpmx">
			<tbody>

			<tr class="r1">
				<td class="td1"><p class="p6"><span class="s2">物品名称</span></p></td>
				<td class="td2"><p class="p6"><span class="s2">规格</span></p></td>
				<td class="td3"><p class="p6"><span class="s2">单位</span></p></td>
				<td class="td4"><p class="p6"><span class="s2">数量</span></p></td>
				<td class="td5"><p class="p6"><span class="s2">处理方式</span></p></td>
				<td class="td6"><p class="p6"><span class="s2">地点</span></p></td>
				<td class="td6"><p class="p6"><span class="s2">经办人</span></p></td>
				<td class="td7"><p class="p6"><span class="s2">备注</span></p></td>
			</tr>
			 <%    
			  for (int k=0;k<v_list.size();k++){
			    Zfwsmswpclqd31DTO v_Zfwsmswpclqd31DTO=(Zfwsmswpclqd31DTO)v_list.get(k);
			%>
			
		  	<tr class='r1'>
		  			<td class='td1'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxwpmc() %></p></td>
		  			<td class='td2'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxgg() %></p></td>
		  			<td class='td3'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxdw() %></p></td>
		  			<td class='td4'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxsl() %></p></td>
		  			<td class='td5'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxclfs() %></p></td>
		  			<td class='td6'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxdd() %></p></td>
		  			<td class='td6'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxjbr() %></p></td>
		  			<td class='td7'><p class='p7'><%=v_Zfwsmswpclqd31DTO.getMsmxbz()%></p></td>
		  	</tr>  			
			
			<%  }
			 %>  
			 			
			</tbody>
			</table>
		</div>
		<div id="footer">
		<p class="p5"></p>
		<p class="p5">
			<span class="s2" >特邀参加人：</span>
			<span style="border-bottom: 1px solid  black;width: 120px;display: inline-block;">
			<%=localZfwsmswpclqd31DTO.getMscltycjr() %> </span>（签字）
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span>承办人：</span><span style="border-bottom: 1px solid  black;width: 150px;display: inline-block;">
		<%=localZfwsmswpclqd31DTO.getMsclcbr()%>  &nbsp;&nbsp;  <%=localZfwsmswpclqd31DTO.getMsclcbr2()%></span>（签字）
		</p>
		<p class="p7">
			<span class="s2">
			<%if(!"".equals(localZfwsmswpclqd31DTO.getMscltycjrrq())&&localZfwsmswpclqd31DTO.getMscltycjrrq().length()>=10){ %>
				<%=localZfwsmswpclqd31DTO.getMscltycjrrq().substring(0,4)%>年
				<%=localZfwsmswpclqd31DTO.getMscltycjrrq().substring(5,7)%>月
				<%=localZfwsmswpclqd31DTO.getMscltycjrrq().substring(8,10)%>日
			<%}else{ %>
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			<%} %>	
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		     <%if(!"".equals(localZfwsmswpclqd31DTO.getMsclcbrrq())&&localZfwsmswpclqd31DTO.getMsclcbrrq().length()>=10){ %>  
		       <%=localZfwsmswpclqd31DTO.getMsclcbrrq().substring(0,4)%>年
			   <%=localZfwsmswpclqd31DTO.getMsclcbrrq().substring(5,7)%>月
			   <%=localZfwsmswpclqd31DTO.getMsclcbrrq().substring(8,10)%>日
			 <%}else{ %>
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
			 <%} %>  
			</span>
		</p> 
	</div>
</body>
</div>
</html>
