<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cdNo = null==request.getParameter("cdNo")?"":request.getParameter("cdNo").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>安盛食品安全溯源监管平台查询中心</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jslib/jquery-easyui/jquery-1.7.2.min.js"></script>
<style type="text/css" >
.tdtitle{text-align:right;background:#ddd;font-weight:bold;font-size:14px;}
.input_txt{text-align:left;float:left;border:none;width:100%;font-size:14px;}
</style>
<script>
window.onload = function(){
	var cdNo = "<%=cdNo%>";
	if(cdNo.length==0){
		window.location.href='index.jsp';
	}
	if(cdNo && cdNo != null && cdNo.length > 0){
		$('#query_zsm').val(cdNo);
		queryData();
	}
}

//查询追溯码是否存在
function queryData(){
	var query_zsm = "<%=cdNo%>";
	if(query_zsm.length<=0){
		alert('请输入溯源码！');
		$('#query_zsm').focus();
		return false;
	}
	if(query_zsm.length>0){
  		$.ajax({
			url:"product/symquery_query.action?symcode="+query_zsm,
			type:'post',
			async:true,
			cache:false,
			timeout: 100000,
			//data:null, //formData,
			error:function(){
				 alert("服务器繁忙，请稍后再试！");
			},
			success: function(o){
			   var obj = jQuery.parseJSON(o);
			   var msg = obj.msg;
			   if(msg && msg != null && msg.length > 0){
				   alert(msg);
				   window.location.href='index.jsp';
			   	   return;
			   }
			  
			   $('#cdNo').val(obj.cdNo);
			   $('#spno').val(obj.cdNo);
			   $('#cdNoLx2').val(obj.cdNoLx2);
			   $('#proSccj').val(obj.proSccj);
			   $('#proName').val(obj.proName);
			   $('#spmc').html(obj.proName);
			   $('#ppPc').val(obj.ppPc);
			   $('#ppScrq').val(obj.ppScrq2);
			   $('#proCdjd').val(obj.proCdjd);
			   $('#proGg').val(obj.proGg);
			   $('#proSptm').val(obj.proSptm);
			   $('#proPm').val(obj.proPm);
			   $('#proBzq').val(obj.proBzq);
			   $('#proBzgg').val(obj.proBzgg);
			   $('#proPlxx').val(obj.proPlxx);
			   
			   //处理图片
			   //条形码
			   var ncdNo = "01"+ obj.cdNo;
			   ncdNo = ncdNo.substr(0,16)+ "10"+ncdNo.substr(16,ncdNo.length)
			   var src = "<%=basePath%>servlet/barcode?type=EAN128&msg="+ncdNo+"&mw=0.5&hrfont=ean13&res=100";
			   $('#imgtxm').attr("src",src);
			   //二维码
			   src = "servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo="+obj.cdNo;
			   $('#imgewm').attr("src",src);
			   
			   $('#queryResult').show();
			   $('#page1').show();
			   $('#printBtn').show();
	        }
		});   
  	}
}
function doPagePrint(){
var cpno=$('#spno').val();
var cpname=$('#spmc').html();
window.open('print.jsp?cdNo='+cpno+'&cpname='+cpname);
}
</script>
<body>
<div class="headbg"></div>
<div class="loginmain_query2" ><img src="images/logo.jpg"></div>

<div id="queryResult" style="width:100%;align:center;text-align:center;">
	<h1><font style="font-weight:bold;font-size:18px;">溯源码【<%=cdNo %>】查询结果</font></h1>
	<table align="center" border="1" cellpadding="0" cellspacing="0" bordercolor="#cccccc" style="border-collapse:collapse;">
	<tr height=25px>
   		<td width="10%" class="tdtitle">溯源码：</td>
   		<td width="38%"><input type="text" id="cdNo" readonly="true" class="input_txt"/> </td>
   		<td class="tdtitle">溯源码类型：</td>
   		<td width="38%"><input type="text" id="cdNoLx2" readonly="true" class="input_txt"/></td>
   	</tr>
   	<tr height=25px>
   		<td class="tdtitle">厂家：</td>
   		<td class="inputcs"><input type="text" id="proSccj" readonly="true" class="input_txt"/> </td>
   		<td class="tdtitle">商品：</td>
   		<td class="inputcs"><input type="text" id="proName" readonly="true" class="input_txt"/> </td>
    </tr>
    <tr height=25px>
   		<td class="tdtitle">批次：</td>
   		<td class="inputcs"><input type="text" id="ppPc" readonly="true" class="input_txt"/></td>
   		<td class="tdtitle">生产日期：</td>
   		<td class="inputcs"><input type="text" id="ppScrq" readonly="true" class="input_txt"/></td>
   	</tr>
   	<tr height=25px>
   		<td class="tdtitle">产地/基地：</td>
   		<td  class="inputcs"><input type="text" id="proCdjd" readonly="true" class="input_txt"/></td>
   		<td class="tdtitle">规格：</td>
   		<td class="inputcs"><input type="text" id="proGg" readonly="true" class="input_txt"/> </td>
   	</tr>
   	<tr height=25px>
   		<td class="tdtitle">商品条码：</td>
   		<td class="inputcs"><input type="text" id="proSptm" readonly="true" class="input_txt"/></td>
   		<td class="tdtitle">品名：</td>
   		<td  class="inputcs"><input type="text" id="proPm" readonly="true" class="input_txt"/></td>
   	</tr>
   	<tr height=25px>	
   		<td class="tdtitle">保质期：</td>
   		<td  class="inputcs"><input type="text" id="proBzq" readonly="true" class="input_txt"/></td>
   		<td class="tdtitle">包装规格：</td>
   		<td ><input type="text" id="proBzgg" readonly="true" class="input_txt"/></td>
   	</tr>
   	<tr height=25px>	
   		<td class="tdtitle">配料信息：</td>
   		<td colspan="3" align="left"><textarea id="proPlxx" style="width:100%;font-color:#000;"></textarea></td>
   	</tr>
</table>
</div>

<div id="page1" style="clear:both;text-align:center;margin:0 auto;padding-top:40px;width:420px;height:260px;background:url(images/sybj_bg.jpg) no-repeat;">
	<table width="420px" height="195px" align="center" style="border-collapse:collapse;" border="0">
	<tr>
		<td width="240px" align="center">
		<span id="spmc" style="font-weight:800;font-size:20px;"></span>
		<span id="spno" style="display:none"></span>
		</td>
		<td align="center">
		<img id="imgewm" src="" alt="" >
		</td>
	</tr>
	<tr>
		<td colspan="2"><img id="imgtxm" src="" width="400px"></td>
	</tr>
	</table>
</div>

<div id="printBtn" style="clear:both;text-align:center;margin:0 auto;">
<input type="button" value="打印" onClick="doPagePrint()">
</div>
		
<%@ include file="footer.jsp"%>
</body>
</html>