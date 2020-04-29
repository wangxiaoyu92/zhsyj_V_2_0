<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
	String t_comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
    String t_comxiaolei = StringHelper.showNull2Empty(request.getParameter("comxiaolei"));

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/business.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<link href="./css/style.css" rel="stylesheet">
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
	String zxdcity = ((Aa01) SysmanageUtil.getAa01("ZXDCITY")).getAaa005();
%>
<script language="javascript" type="text/javascript">
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var zxdcity = '<%=zxdcity%>';
	var jdzb = "";
	var wdzb = "";
	var address = "";         
	function initMap() { 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 11);
		addBeiJing(zxdcity);
		mapObj.clearMap();  // 清除地图覆盖物		
	}	    
</script>
</head>
<body>
<div id="head_map" style="margin-top:10px;">
	<div class="top">
		<div class="logo">
			<div class="">
				<span class="position" id="currlocation">当前位置：  </span>
	
			</div>
		</div>
		<div class="search">
			<form id="form1" method="get">
				<span>站内搜索:</span> <span> <input type="text"
					id="t_commc"  class="inputs"
					placeholder="请输入企业名称"> <input type="button" id="search"
					class="btns" value="搜 索" onclick="searchEnterprise()"> </span>
			</form>
		</div>
	</div>
</div>
<!--地图容器-->
<div id="mapContainer" style="width:99%;height:90%;border:#00A1EA solid 1px;margin:10px">
     &nbsp;
</div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';
	var t_comdalei = '<%=t_comdalei%>';
    var t_comxiaolei = '<%=t_comxiaolei%>';
    var tantiao = "0";
	$(function () {
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
		initMap();
        getPcompanyList();       
    });
    
    function getPcompanyList() {
   		$.ajax({
        	url: basePath + "api/tmsyj/getPcompanyList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid, commc: t_commc, comdalei: t_comdalei, comxiaolei: t_comxiaolei, comspjkbz: '' },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
						var mydata = result.rows;
						initialize(mydata);							                    		              							
                    }   	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}          
        });
    }
    
    //地图初始化时，在地图上添加一个marker标记,鼠标点击marker可弹出自定义的信息窗体
	function initialize(mydata) { 
		//mapObj.clearMap();  // 清除地图覆盖物
	    // 向地图添加标注点
	    for (var i = 0; i < mydata.length; i++) {
		    var lng = mydata[i].comjdzb;
		    var lat = mydata[i].comwdzb;
	        var address = mydata[i].comdz;
	        var commc = mydata[i].commc;
	        var comid = mydata[i].comid;
	        var combxbz = mydata[i].combxbz;
	        var comspjkbz = mydata[i].comspjkbz;
	        var comhhbbz = mydata[i].comhhbbz;
	        var comdalei = mydata[i].comdalei;
			var title = "地图定位";
		    var content = [];	    
		    content.push("企业名称：" + commc);
		    content.push("企业地址：" + address);
			var icon = ''; 
			if(comhhbbz=='2'){
				icon = basePath + "images/frame/heidw.png";
			}else if(comhhbbz=='1'){
				icon = basePath + "images/frame/hongdw.png";
			}else{
				icon = "images/marker_red.png";
			}
		    if(lng>0 && lat>0){
		    	if(tantiao==1 && mydata.length==1){
					addMarker_tantiao_no(lng,lat,address,title,commc,icon);
		    	}else{		    	
		    		addMarker_tantiao_no(lng,lat,address,title,commc,icon);	
		    	}		    	   
	    	}	    
	    	//addMarker_infowindow(lng,lat,address,title,content,icon,flag);	   
	    }
	    mapObj.setFitView();				
	}
	
	//搜索企业
	function searchEnterprise() {
		mapObj.clearMap();  // 清除地图覆盖物
		addBeiJing(zxdcity);	
		t_commc = $("#t_commc").val();
		tantiao = '1';
		getPcompanyList();
	}	 	
</script>
</body>
</html>