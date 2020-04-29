<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ contextPath +"/";
%>
<%
	String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
    String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
    
    int v_gridwidth = 800;
    int v_gridheight = 500;
    String v_gridwidths = StringHelper.showNull2Empty(request.getParameter("gridwidth"));
    String v_gridheights = StringHelper.showNull2Empty(request.getParameter("gridheight"));
    if (v_gridwidths!=null && !"".equals(v_gridwidths)){
    	v_gridwidth = Integer.parseInt(v_gridwidths);
    }
    if (v_gridheights!=null && !"".equals(v_gridheights)){
    	v_gridheight = Integer.parseInt(v_gridheights);
    }      
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>附件列表</title>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
  </head> 	
<script type="text/javascript">
	var s = new Object();   
	s.type = "";   //设为空不刷新父页面
	sy.setWinRet(s);
		
	var v_local_dmlb = "<%=v_dmlb%>";
	
	$(function(){
		$('#tabUploadFjList').datagrid({
		    title:'附件列表',
		    iconCls:'icon-ok',
		    width:<%=v_gridwidth%>,
			height:<%=v_gridheight%>,
		    pageSize:20,
		    pageList:[20,40,60],
		    nowrap:false,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:false,
		    singleSelect:true,//True 就会只允许选中一行
		    fit:true,//让DATAGRID自适应其父容器
		    fitColumns:true,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    idField: 'fjcsid', //该列是一个唯一列
		    pagination:true,//底部显示分页栏
		    rownumbers:true,//是否显示行号
		    url:'<%=basePath%>pub/pub/queryFjlist',
		    loadMsg:'数据加载中,请稍后...',   
		    //sortName:'code',
		    sortOrder:'desc',
		    remoteSort:false,
		    queryParams:{
			    fjwid:'<%=v_ajdjid%>',
			    fjcsdmlb:'<%=v_dmlb%>',
			    fjcsdlbh:'<%=v_fjcsdlbh%>'
			},
		    columns:[[
				{title:'附件类别',field:'fjcsdmlb',align:'center',width:70,hidden:'true'},
				{title:'附件类别名称',field:'fjcsdmlbmc',align:'left',width:60},
				{title:'相关表Id',field:'fjwid',align:'left',width:30,hidden:'true'},
				{title:'代码值',field:'fjcsdmz',align:'left',width:30,hidden:'true'},
				{title:'附件名称',field:'fjcsdmmc',align:'left',width:200},
				{title:'是否必传附件',field:'fjcsfjbc',align:'center',width:70,
					formatter:function(value,rec){
					 	if(value=="0"){
					    	return '<span style=color:blue>否</span>';	
					 	}else{
					 	    return '<span style=color:red>是</span>';
					 	}
				     }
				},
				{title:'已上传附件数',field:'ycfjcount',align:'left',width:70},
				{field:'opt',title:'操作',align:'center',width:200,
		              formatter:function(value,rec){   
					    var v_ret='<span style="color:blue" mce_style="color:blue">';
					    if (rec.fjcsdmlb==v_local_dmlb) {
					    	v_ret+='<a href="javascript:uploadFuJian(\''+rec.fjcsdmz+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/upload.png" align="absmiddle">上传附件</a>';
					    };
					    v_ret+='<a href="javascript:chakanFuJian(\''+rec.fjcsdmz+'\','+rec.ycfjcount+')" mce_href="#"><img src="<%=basePath%>/images/pub/view.gif" align="absmiddle">查看附件</a> </span>';
					    return v_ret;
		             }   
		        } 		
			]] 
		
		});  
	   
	
	});///////////////////////////////////////////////////////////////////////////////////
	
	
	//上传附件
	function uploadFuJian(v_fjcsdmz){
		var url = "<%=basePath%>jsp/pub/pub/pubUploadFj.jsp?ajdjid=<%=v_ajdjid%>&dmlb=<%=v_dmlb%>&fjcsdmz="+v_fjcsdmz+"&time="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : '上传附件',
			width : 950,
			height : 700,
			url : url
		});
		$('#tabUploadFjList').datagrid('reload');
	}
	
	//查看附件
	function chakanFuJian(v_fjcsdmz,v_ycfjcount){
		if (v_ycfjcount==0 || v_ycfjcount==null || v_ycfjcount=="" || v_ycfjcount.length==0){
		  alert("没有可查看的附件！");
		  return;
		}

		//浏览器版本判断，方便pubUploadFjView.jsp中查看图片查看器进行判断处理，因为改进版查看器只支持IE8以下（不包含IE8）
		var browserNameVersion = checkLowOrEqualsIE8();
		var url = "<%=contextPath %>/pub/pub/pubUploadFjViewIndex?fjwid=<%=v_ajdjid%>&fjcsdmz="+v_fjcsdmz+"&browserNameVersion="+browserNameVersion+"&time="+new Date().getMilliseconds();
		var dialog = parent.sy.modalDialog({
			title : '查看附件',
			width : 1000,
			height : 600,
			url : url
		});
	}
	
	//检测浏览器
	function checkBrowser(){
		var Sys = {};
		var ua = navigator.userAgent.toLowerCase();
		var s;
		(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
		(s = ua.match(/rv:([\d.]+)\) like gecko/)) ? Sys.ie = s[1] :
		(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
		(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
		(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
		(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
		if (Sys.ie) return 'IE@' + Sys.ie;
		if (Sys.firefox) return 'Firefox@' + Sys.firefox;
		if (Sys.chrome)  return 'Chrome@' + Sys.chrome;
		if (Sys.opera)  return 'Opera@' + Sys.opera;
		if (Sys.safari) return 'Safari@' + Sys.safari;
	}
	
	//检测浏览器是否低于等于8,是返回yes 不是返回no,如果是360浏览器兼容模式，伪造IE,也认为<=8
	function checkLowOrEqualsIE8(){
		var checkVal=checkBrowser();
		if(checkVal.indexOf("IE@") > -1){//是IE
			//判断是否低于等于8
			var ver=checkVal.substring(checkVal.indexOf('@')+1,checkVal.length);
			var ver_no_dot=ver.substring(0,ver.indexOf('.'));
			if(ver_no_dot<=8)
				return 'yes';   
			else
		    	return 'no';   		
		}else{//其他浏览器
		  return 'no';
		}
	}
	var closeWindow = function($dialog){
		parent.$("#"+sy.getDialogId()).dialog("close");
	};
</script> 
<body>
	<div class="content_wrap" style="width:<%=v_gridwidth%>px;height:<%=v_gridheight%>px;">
		<table id="tabUploadFjList" style="width:100%;height:100%"></table>
	</div>
</body>
</html>
