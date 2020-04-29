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
    
    t_comdalei = "101101";
    t_currlocation = "企业地图>>食品生产企业";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<script src="./js/jquery-1.12.0.min.js"></script>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<script src="./js/bootstrap.min.js"></script>
<script src="./js/common.js"></script>
<script src="./js/custom.js"></script>
<link href="./css/style2.css" rel="stylesheet">
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
<div id="head" style="margin-top:10px;">
	<div class="top">
		<div class="logo">
			<a href="#"><img alt="智慧食药监logo" src="images/logo-zhsyj-tangyin.png"
				title="智慧食药监logo" align="absmiddle" id="top_logo"> </a>
		</div>
		<div class="search" style="display: block;">
			<form id="form1" method="get">
				<span>站内搜索</span> <span> <input type="text"
					id="t_commc" name="commc" class="inputs"
					placeholder="请输入企业名称"> <input type="button" id="search"
					class="btns" value="搜 索" onclick="searchEnterprise()"> </span>
			</form>
		</div>
	</div>
</div>
<!--地图容器-->
<div id="mapContainer" style="width:99%;height:99%;border:#00A1EA solid 1px;margin:10px">
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
	        var comspjkbz = mydata[i].comspjkbz;
			
			var title = "";
		    var content = [];	    
			var icon = "images/marker_red.png";			
		    if(lng>0 && lat>0){
// 		    	if(tantiao==1 && mydata.length==1){
// 		    		addMarker_tantiao(lng,lat,address,title,commc,icon);
// 		    	}else{		    	
// 		    		addMarker_tantiao_no(lng,lat,address,title,commc,icon);	
// 		    	}
		    			    	
		    	var html = "";
			    html += " <table style=\"font-size:12px;width:80%;text-align:center;\"> ";
				html += " 	  <tr> ";
				html += " 		<td colspan='4' style=\"background: #345588;height:26px;padding-left:15px;text-align:left;color:#fff\"><strong>企业基本信息</strong></td> ";
				html += " 	  </tr> ";
			    html += "     <tr> ";
			    html += "       <td colspan='3' style=\"padding:5px;width:300px;text-align:left;\">企业名称："+ mydata[i].commc +"</td> ";
			    html += "       <td rowspan='4'><img id=\"lhfjndpddj\" src=\"images/A1.png\" style=\"width:100px;\"><br></td> ";
			    html += "     </tr> ";
			    html += "     <tr> ";
			    html += "       <td colspan='3' style=\"padding:5px;text-align:left;\">企业地址："+ mydata[i].comdz +"</td> ";
			    html += "     </tr> ";
			    html += "     <tr> ";
			    html += "       <td colspan='3' style=\"padding:5px;text-align:left;\">负责人："+ mydata[i].comfrhyz +"</td> ";
			    html += "     </tr> ";
			    html += "     <tr> ";
			    html += "       <td colspan='3' style=\"padding:5px;text-align:left;\">联系电话："+ mydata[i].comyddh +"</td> ";
			    html += "     </tr> ";
			    html += "     <tr> ";
			    html += "       <td colspan='4' style=\"background: #345588;height:26px;padding-left:15px;text-align:left;color:#fff\"><strong>企业监管信息</strong></td> ";
			    html += "     </tr> ";
				html += " 	  <tr> ";
			    html += "       <td height='45'><a class=\"btn btn-xs\" style=\"background-color:#209da1;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/enterprise_person_list.jsp?currlocation="+ commc +">>主体责任透明&comid="+ comid +"');\">主体责任透明</a></td> ";
			    html += "       <td ><a class=\"btn btn-xs\" style=\"background-color:#ff6950;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/enterprise_kitchen_list.jsp?currlocation="+ commc +">>企业资质透明&comid="+ comid +"');\">生产过程透明</a></td> ";
			    html += "       <td ><a class=\"btn btn-xs\" style=\"background-color:#4fb901;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/ylcgtm_list.jsp?currlocation="+ commc +">>原料采购透明&comid="+ comid +"');\">原料采购透明</a></td> ";
			    html += "       <td ><a class=\"btn btn-xs\" style=\"background-color:#b845ac;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/cpxxtm_list.jsp?currlocation="+ commc +">>产品信息透明&comid="+ comid +"');\">产品信息透明</a></td> ";
			    html += "     </tr> ";
			    html += "     <tr> ";
			    html += "       <td height='45'><a class=\"btn btn-xs\" style=\"background-color:#4a68ae;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/xsqxtm_list.jsp?currlocation="+ commc +">>销售去向透明&comid="+ comid +"');\">销售去向透明</a></td> ";
			    html += "       <td ><a class=\"btn btn-xs\" style=\"background-color:#dda303;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/enterprise_punish_list.jsp?currlocation="+ commc +">>执法监督透明&comid="+ comid +"');\">执法监督透明</a></td> ";
			    html += "       <td ><a class=\"btn btn-xs\" style=\"background-color:#146daf;color:#fff;font-size:12px;padding:4px 6px 4px 6px;\" href=\"javascript:linkToSelf('"+contextPath+"/jsp/tmsyj/tmspsc/enterprise_review_list.jsp?currlocation="+ commc +">>公众评价透明&comid="+ comid +"');\">公众评价透明</a></td> ";
			    html += "     </tr> ";				
			    html += " </table> ";
			    content.push(html);
	    		addMarker_infowindow(lng,lat,commc,title,content,icon);	  	    	   
	    	}	    		   
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