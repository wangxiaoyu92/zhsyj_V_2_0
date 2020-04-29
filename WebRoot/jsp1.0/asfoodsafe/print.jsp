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
</head>
<!-- 插入打印控件 -->
<OBJECT ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255" codebase="print/jatoolsPrinter.cab#version=8,6,1,0" style="width:0;height:0;"></OBJECT>  
<script> 
function doPrint(how) {
	myDoc = {
	    enableScreenOnlyClass:true, // 使所有使用 screen-only 样式类的对象，只在预览、显示时可见，打印时隐藏
		settings: {//32*19  1行3列
            paperWidth:960,// 以1/10=0.1毫米为单位,先测量出票据的实际高度，比如120mm(宽)*100mm(高);那么宽度应是paperWidth:1200, 
            paperHeight:190,// 以1/10=0.1毫米为单位 
            orientation:1, // 指定打打印方向为横向, 1/2 = 纵向/横向
            topMargin:10, leftMargin:20, bottomMargin:10, rightMargin:20// 设置上下左距页边距为10毫米，注意，单位是 1/10=0.1毫米,边距可设，不设则取打印机默认值
        },
		marginIgnored:true,   // 强制上、下、左、右边距为零
		//fitToPage  :true,   //必要时缩放打印
		documents: document,  
		//copies: 2,  //份数       		
		copyrights: '杰创软件拥有版权  www.jatools.com'    
	};
	if(how=='打印预览')
  		jatoolsPrinter.printPreview(myDoc ); // 打印预览
 	else if(how=='打印设置')
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
<!-- 
  <div id="page1" style="position:relative;widht:32mm;height:19mm;background:url(images/sybq_bg32.jpg) no-repeat;">
<img src="images/sybq_bg2.jpg" style="position:absolute;" class='screen-only'>
<div style="position:absolute;width:100%;height:100%;left:100"><img src="<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo=<%=cdNo%>" width="45"/></div>
</div>
 -->
<div id="page1" style="margin:0 auto;float:left;padding:0;width:96mm;height:19mm;">
	<table border="0" cellspacing="7mm" >
	<tr >
		<td style="width:30mm;background:url(images/sybq_bg2.jpg) no-repeat;" align="right">
			<img src="<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo=<%=cdNo%>" width="45"/>
		</td>
		<td style="width:30mm;background:url(images/sybq_bg2.jpg) no-repeat;" align="right">
			<img src="<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo=<%=cdNo%>" width="45" />
		</td>
		<td style="width:32mm;background:url(images/sybq_bg2.jpg) no-repeat;" align="right">
			<img src="<%=basePath%>servlet/qrcode?msg=<%=basePath%>query.jsp?cdNo=<%=cdNo%>" width="45" />
		</td>
	</tr>
	</table>
</div>
      <input type="button" value="打印预览" onClick="doPrint('打印预览')">
      <input type="hidden" value="打印设置" onClick="doPrint('打印设置')">
      <input type="button" value="直接打印" onClick="doPrint('直接打印')">
      <!-- <font color=red>如果你是在本地测试，请将http://localhost加入到可信站点</font><br/> -->
</body>
</html>