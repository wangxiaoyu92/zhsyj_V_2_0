<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String cdNo= null==request.getParameter("cdNo")?"169579431000560000010000000012":request.getParameter("cdNo").toString();
//String cpname= null==request.getParameter("cpname")?"新疆沙棘":new String(request.getParameter("cpname").getBytes("ISO-8859-1"),"utf-8");
String ncdNo="";
if(!"".equals(cdNo)){
	//条形码
	ncdNo="01"+ cdNo;
	ncdNo=ncdNo.substring(0,16);
	ncdNo+="10";
	ncdNo+=cdNo.substring(14,cdNo.length());
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>安盛食品安全溯源监管产品标签打印测试</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jslib/jquery-easyui/jquery-1.7.2.min.js"></script>
<style media=print>
.Hidden{display:none;margin:0 auto;}
.PageNext{page-break-after: always;}
</style>
</head>
<!-- 插入打印控件 -->
<OBJECT ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255" codebase="print/jatoolsPrinter.cab#version=8,6,1,0"></OBJECT>  
<script> 
function doPrint(how) {
	myDoc = {
		documents: document,         		
		copyrights: '杰创软件拥有版权  www.jatools.com'    
	};
	if(how=='打印预览')
  		jatoolsPrinter.printPreview(myDoc ); // 打印预览
 	else if(how=='打印...')
 	    jatoolsPrinter.print(myDoc ,true);   // 打印前弹出打印设置对话框
   else 
 	   jatoolsPrinter.print(myDoc ,false);   // 不弹出对话框打印，直接打印
}

window.onload = function(){
	var cdNo = "<%=cdNo%>";
	if(cdNo.length==0){
		window.location.href='index.jsp';
	}
}
</script>
<body>
<div id="page1" style="clear:both;text-align:left;margin:0 auto;padding:0;width:307px;height:205px;background:url(images/sybq_bg.jpg) no-repeat;">
	<table width="100%" height="100%" align="left" style="border-collapse:collapse;" border="1">
	<tr>
		<td width="195px" height="140px" align="center" valign="middle">
		<span id="spmc" style="font-weight:800;font-size:20px;"></span>
		</td>
		<td align="left">
		<img src="<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo=<%=cdNo%>" />
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="top"><img src="<%=basePath%>servlet/barcode?type=EAN128&msg=<%=ncdNo %>&mw=0.5&hrfont=ean13&res=100" width="307px"></td>
	</tr>
	</table>
</div>
      <input type="button" value="打印预览" onClick="doPrint('打印预览')">
      <input type="hidden" value="打印..." onClick="doPrint('打印...')">
      <input type="button" value="直接打印" onClick="doPrint('直接打印')"><br><br>
<font color=red>如果你是在本地测试，请将http://localhost加入到可信站点</font><br/>
</body>
</html>