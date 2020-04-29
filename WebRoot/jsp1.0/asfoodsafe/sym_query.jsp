<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="head.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sym = null==request.getParameter("sym")?"":request.getParameter("sym").toString();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>安盛食品安全溯源监管平台</title>
	<jsp:include page="inc.jsp"></jsp:include>
<link id="easyuiTheme" rel="stylesheet" href="jslib/jquery-easyui/themes/default/easyui.css" type="text/css">
<link rel="stylesheet" type="text/css" href="jslib/jquery-easyui/themes/icon.css"/>
<script type="text/javascript" src="jslib/jquery-easyui/jquery-1.7.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="jslib/jquery-easyui/themes/icon.css"/>
<script type="text/javascript" src="jslib/jquery-easyui/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="jslib/jquery-easyui/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<script type="text/javascript" src="jslib/lightbox/js/jquery.lightbox-0.5_query.js"></script>
<link rel="stylesheet" type="text/css" href="jslib/lightbox/css/jquery.lightbox-0.5.css" media="screen" />


<script type="text/javascript">
$(function(){
	//生产信息
	$('#mytab_sc').datagrid({
	    title:'产品生产信息',
	    iconCls:'icon-ok',
	    width:500,
	    height:300,
	    pageSize:10,
	    pageList:[10,15,20],
	    nowrap:true,//True 就会把数据显示在一行里
	    striped:true,//奇偶行使用不同背景色
	    collapsible:true,
	    singleSelect:true,//True 就会只允许选中一行
	    //fitColumns: true,
	    fit:true,//让DATAGRID自适应其父容器
	    fitColumns:true,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
	    pagination:false,//底部显示分页栏
	    rownumbers:false,//是否显示行号
	    //url:'producteb_showEb.action?productId=1&ppPcId=1',
	    loadMsg:'数据加载中,请稍后...',   
	    sortOrder:'desc',
	    remoteSort:false,
	    columns:[[
			{title:'操作人',field:'piCzr',align:'left',width:130},
			{title:'操作内容',field:'piCznr',align:'left',width:90},
			{title:'操作日期',field:'piCzrq',align:'center',width:90},
			{title:'备注',field:'piBz',align:'right',width:90},
			{title:'批次号',field:'piProPc',align:'center',width:120}
		]]
	   });
	
	//检疫信息
	$('#mytab_jy').datagrid({
	    title:'产品检疫信息',
	    iconCls:'icon-ok',
	    width:500,
	    height:100,
	    pageSize:5,
	    pageList:[10,15,20],
	    nowrap:true,//True 就会把数据显示在一行里
	    striped:true,//奇偶行使用不同背景色
	    collapsible:true,
	    singleSelect:true,//True 就会只允许选中一行
	    fitColumns: true,
	    fit:true,//让DATAGRID自适应其父容器
	    fitColumns:true,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
	    pagination:false,//底部显示分页栏
	    rownumbers:false,//是否显示行号
	    //url:'producteb_showEb.action?productId=1&ppPcId=1',
	    loadMsg:'数据加载中,请稍后...',   
	    sortOrder:'desc',
	    remoteSort:false,
	    columns:[[
			{title:'检测项目',field:'jcItem',align:'left',width:130},
			{title:'检测结果',field:'jcJg',align:'left',width:90},
			{title:'检测单位',field:'jcDw',align:'center',width:90},
			{title:'检测时间',field:'jcSj',align:'right',width:90},
			{title:'批次号',  field:'jcPc',align:'center',width:120}
		]]
	   });
	}
);

window.onload = function(){
queryData();
}
//查询追溯码是否存在queryData();
function queryData(){
	var query_sym='<%=sym%>';
	if(query_sym.length<=0){
		window.location.href='index.jsp';
	}
	if(query_sym.length>0){
	$.ajax({
		url:"product/symquery_query.action?symcode="+query_sym,
		type:'post',
		async:true,
		cache:false,
		timeout: 100000,
		//data:null,
		error:function(){
			 alert("服务器繁忙，请稍后再试！");
		},
		success: function(o){
		   var obj = jQuery.parseJSON(o);
		   var msg = obj.msg;
		   if(msg && msg != null && msg.length > 0){
			   alert(msg);
			   //window.location.href='index.jsp';
		   	   return;
		   }
		   $('#cdNo').val(obj.cdNo);
		   $('#cdNoLx2').val(obj.cdNoLx2);
		   $('#proSccj').val(obj.proSccj);
		   $('#proName').val(obj.proName);
		   $('#ppPc').val(obj.ppPc);
		   $('#ppScrq').val(obj.ppScrq2);
		   $('#proCdjd').val(obj.proCdjd);
		   $('#proGg').val(obj.proGg);
		   $('#proSptm').val(obj.proSptm);
		   $('#proPm').val(obj.proPm);
		   $('#proBzq').val(obj.proBzq);
		   $('#proBzgg').val(obj.proBzgg);
		   $('#proPlxx').val(obj.proPlxx);
		   $('#proCpbzh').val(obj.proCpbzh);
		   if(obj.comWeb.length>0){
		   	$('#comWeb').html("<a href=\""+obj.comWeb+"\">"+obj.comWeb+"</a>");
		   }
		   
		   
		   var proId = obj.proId;
		   var comId = obj.proComId;
		   var ppPc  = obj.ppPc;
		   
		   //条形码
		   var ncdNo = "01"+ obj.cdNo;
		   ncdNo = ncdNo.substr(0,16)+ "10"+ncdNo.substr(16,ncdNo.length);
		   var src = "<%=basePath%>servlet/barcode?type=EAN128&msg="+ncdNo+"&mw=0.5&hrfont=ean13&res=100";
		   $('#imgtxm').attr("src",src);
		   
		   //二维码
		   src = "<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?sym="+obj.cdNo;
		   $('#imgewm').attr("src",src);
		   
		   //附件图片
		   var fjdata = obj.fj;
		   if(fjdata){
		   		$('#p2').empty();

		   		for(var i = 0 ; i < fjdata.length; i ++){
			   		var pic = document.createElement("div");
			   		var content="<div id=\"gallery\" style=\"float:left;text-align:center;\">";
			   		content=content + "<a href="+fjdata[i].fjPath+" data-lightbox=\"product\"><img src='"+ fjdata[i].fjPath  +"' width=\"150px\" height=\"150px\" style=\"padding:2px;border:1px solid #ccc;\" /></a>";
			   		content=content + "<div>";
			   		pic.innerHTML=content;
			   		$('#p2')[0].appendChild(pic);
		   		}
		   }
		   
	   	  $('#mytab_sc').datagrid({url:'product/wproductinfo_view.action',queryParams:{pi_pro_pc:''+ppPc+'',pro_id:''+proId+'',page:''+1+'',rows:''+5+''},method:'post'});
	   	  $('#mytab_jy').datagrid({url:'product/wproductjc_view.action',queryParams:{pi_pro_pc:''+ppPc+'',pro_id:''+proId+'',page:''+1+'',rows:''+5+''},method:'post'});
	   	  
	   	  $('#gallery a').lightBox();
        }
	});
   }
}
</script>
  </head>
<body>
<div id="full">
	<div class="w_top">
		<img src="http://www.zzhdsoft.com/images/closeBtn.png" style=" padding-right:6px; cursor:pointer;" onclick="javascript:closediv('full')">
	</div>
	<div class="w_tit">华东食品安全溯源微信</div>
	<div class="w_pic">
		<img src="images/weixin.jpg" style=" width:124px; height:124px; padding-left:6px;">
	</div>
</div>

<div class="mainbody">
  <fieldset style="margin-top: 10px;" align="center">
  <legend>产品基本信息</legend>
	   <table style="width:99%;display:inherit;margin:0 20px 20px 0; paddings:5px;">
	   	<tr>
	   		<td style="width:21%;text-align:right;">溯源码：</td>
	   		<td style="width:28%" ><input type="text" id="cdNo" readonly="true" class="input-text-readonly"/> </td>
	   		<td style="width:21%;text-align:right;">溯源码类型：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="cdNoLx2" readonly="true" class="input-text-readonly"/></td>
	   	</tr>
	   	<tr>
	   		<td style="width:21%;text-align:right;">厂家：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proSccj" readonly="true" class="input-text-readonly"/> </td>
	   		<td style="width:21%;text-align:right;">网址：</td>
	   		<td style="width:28%" class="inputcs"><div id="comWeb" color="blue" style="width:299px;height:30px;background:#ececec;text-align:left;border:1px solid #ccc;margin-left:-7px;"/></div> </td>
	    </tr>
	    <tr>
	   	    <td style="width:21%;text-align:right;">商品：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proName" readonly="true" class="input-text-readonly"/> </td>
	   		<td style="width:21%;text-align:right;">产品标准代号：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proCpbzh" readonly="true" class="input-text-readonly"/> </td>
	   		
	    </tr>
	    <tr>
	   		<td style="width:21%;text-align:right;">批次：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="ppPc" readonly="true" class="input-text-readonly"/></td>
	   		<td style="width:21%;text-align:right;">生产日期：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="ppScrq" readonly="true" class="input-text-readonly"/></td>
	   	</tr>
	   	<tr>
	   		<td style="width:21%;text-align:right;">产地(基地)：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proCdjd" readonly="true" class="input-text-readonly"/></td>
	   		<td style="width:21%;text-align:right;">规格：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proGg" readonly="true" class="input-text-readonly"/> </td>
	   	</tr>
	   	<tr>
	   		<td style="width:21%;text-align:right;">商品条码：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proSptm" readonly="true" class="input-text-readonly"/></td>
	   		<td style="width:21%;text-align:right;">品名：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proPm" readonly="true" class="input-text-readonly"/></td>
	   	</tr>
	   	<tr>	
	   		<td style="width:21%;text-align:right;">保质期：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proBzq" readonly="true" class="input-text-readonly"/></td>
	   		<td style="width:21%;text-align:right;">包装规格：</td>
	   		<td style="width:28%" class="inputcs"><input type="text" id="proBzgg" readonly="true" class="input-text-readonly"/></td>
	   	</tr>
	   	<tr>	
	   		<td style="width:21%;text-align:right;">配料信息：</td>
	   		<td style="width:79%;" colspan="3"><input style="width:100%;" type="text" id="proPlxx" readonly="true" class="input-text-readonly"/></td>
	   	</tr>
	   </table> 
  </fieldset>
  
  <fieldset  style="margin-top: 10px;" align="center">
  <legend>产品条码信息</legend>
	   <div style="width:70%;float:left;overflow:hidden;margin-top:5px;">
	   	 <img id="imgtxm" src="" width="400px"/>
	   </div>
	   <div style="width:30%;float:left;" >
	   	 <img id="imgewm" src="" />
	   </div>
  </fieldset>
  
  <fieldset style="margin-top: 10px;" align="center">
  <legend>产品图片</legend>
      <div id="p2"></div>  
  </fieldset>		  
	   
	   <div style="height:200px;width:100%;">
	   		<div id="mytab_sc"></div>
	   </div>
	   
	   <div style="height:200px;width:100%;">
	   		<div id="mytab_jy"></div>
	   </div>
	    
	   </div>
<%@ include file="footer.jsp"%>
</body>
</html>