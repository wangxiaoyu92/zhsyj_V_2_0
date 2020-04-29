<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.Aa01"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "食品生产企业>>食品安全信息公示";
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
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
<link href="./css/bootstrap-combined.min.css" rel="stylesheet">
<script src="./js/bootstrap-paginator.js"></script>
<link href="./css/style.css" rel="stylesheet">
<script src="./js/layer.js"></script>
<link href="./css/layer.css" rel="stylesheet">
<script src="./js/jquery.imagezoom.js"></script>
<link href="./css/imagezoom.css" rel="stylesheet">
<script src="./js/MSClass.js"></script>
<jsp:include page="${contextPath}/inc_map.jsp"></jsp:include>
<%	
	String zxdjdzb = ((Aa01) SysmanageUtil.getAa01("ZXDJDZB")).getAaa005();
	String zxdwdzb = ((Aa01) SysmanageUtil.getAa01("ZXDWDZB")).getAaa005();
%>
<script language="javascript" type="text/javascript">
	var zxdjdzb = '<%=zxdjdzb%>';
	var zxdwdzb = '<%=zxdwdzb%>';
	var jdzb = "";
	var wdzb = "";
	var address = "";         
	function initMap() { 
		mapInit("mapContainer", zxdjdzb,zxdwdzb, 10);
		mapObj.clearMap();  // 清除地图覆盖物		
	}	    
</script>
</head>
<body>
<div id="top"></div>	
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
	<div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
	<div class="row" style="margin-top:10px;">
		<div class="col-xs-8 col-sm-8" style="text-align:left;">
			<div class="leftcontent">
			<div class="container">			
				<div class="enterprise-image">
		            <img id="enterpriseIcon" src="images/kong.jpg" />
		        </div>
		        <div class="enterpriseInfo">
					<p>
						企业名称：<span id="commc"></span>
					</p>
					<p>
						负责人：<span id="comfrhyz"></span>
					</p>
					<p>
						地址：<span id="comdz"></span>
					</p>
					<p>
						联系电话：<span id="comyddh"></span>
					</p>
					<p>
		    			<span style="background:#4fb9f1;font-size:15px;color:#FFFFFF;padding:5px;cursor:pointer;" onclick="wypj()">我要评价</span>
		    			<span style="background:#14AB4C;font-size:15px;color:#FFFFFF;padding:5px;cursor:pointer;" onclick="wyts()">我要投诉</span>
		    		</p>
				</div>
		   	</div>			    
			<div style="height:200px;margin-bottom:10px;margin-top:10px;">
				<div id="DynamicLevel"
					style="width:50%;float:left;background:url(images/jdgldj1.jpg);background-size:100% 100%;height:200px;">
					<img id="lhfjndpddj"  src="images/1-A.png"
						style="width:202px;height:100px;margin-top:15%;margin-left:60px;">
				</div>
				<div
					style="width:50%;float:left;background:url(images/jdgldj2.jpg);background-size:100% 100%;height:200px;"></div>
			</div>	 	
		   	<div id="transparent" style="padding-bottom:10px;">
				<div class="enterprise-transparent">
					<a href="javascript:linkToSelf('enterprise_person_list.jsp?currlocation=<%=t_commc %>>>企业资质透明&comid=<%=t_comid %>');"
						style="background: #df83ff;" id="rytm">企业资质透明</a>
					<a href="javascript:linkToSelf('enterprise_kitchen_list.jsp?currlocation=<%=t_commc %>>>生产过程透明&comid=<%=t_comid %>');"
						style="background: #4fb901;" id="cftm">生产过程透明</a>
					<a href="javascript:linkToSelf('ylcgtm_list.jsp?currlocation=<%=t_commc %>>>原料采购透明&comid=<%=t_comid %>');"
						style="background: #ff6950;" id="cgtm">原料采购透明</a><a href="javascript:linkToSelf('cpxxtm_list.jsp?currlocation=<%=t_commc %>>>产品信息透明&comid=<%=t_comid %>');"
						style="background: #b845ac;" id="jctm">产品信息透明</a>
				</div>
				<div class="enterprise-transparent">
					<a href="javascript:linkToSelf('xsqxtm_list.jsp?currlocation=<%=t_commc %>>>销售去向透明&comid=<%=t_comid %>');"
						style="background: #d21323;" id="sptm">销售去向透明</a>
					<a href="javascript:linkToSelf('enterprise_punish_list.jsp?currlocation=<%=t_commc %>>>执法监管透明&comid=<%=t_comid %>');"
						style="background: #ff65ac;" id="zftm">执法监管透明</a>
					<a href="javascript:void(0);" onclick="lsdj();" 						
						style="background: #4fb9f1;" id="grade_all">量化分级透明</a><a href="javascript:linkToSelf('enterprise_review_list.jsp?currlocation=<%=t_commc %>>>公众评价透明&comid=<%=t_comid %>');"
						style="background: #f3395f;" id="gztm">公众评价透明</a>
				</div>
			</div>
			<div class="enterpriseProfile" style="margin-top:10px;">
				<div class="header">
					<span style="">企业简介</span>
				</div>
				<div class="content" id="enterpriseProfile"></div>
			</div>
			<div class="enterpriseProfile" style="margin-top:10px;">
				<div class="header">
					<span style="">图片展示</span>
				</div>
				<div class="content" id="enterpriseFj">					
			        <div class="marquee">
			        	<ul id="marqueeDiv"></ul>
			        </div>			        				
				</div>
			</div>
			</div>
		</div>	    
		<div class="col-xs-4 col-sm-4" id="news2">			
			<div style="font-size:20px;font-weight:bold;padding:0px;text-align:left;">企业二维码</div>
			<div style="width:200px;height:200px;" id="qrcode_div">
		    	<img id="qrcode" name="qrcode" style="widows: 200px;height: 200px;"/>
		   	</div>
		   	<!--地图容器-->
		    <div id="mapContainer" style="width:340px;height:200px;border:#00A1EA solid 1px;margin-top:3px;">
		         &nbsp;
		    </div>				
		</div>		
	</div>
</div>
<div id="foot"></div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';
	var t_comxiaolei = '<%=t_comxiaolei%>'; 

	$(function () {
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        initMap();
        getPcompany();
        getFjList(1,10);
    });

    function getPcompany() {
   		$.ajax({
        	url: basePath + "api/tmsyj/getPcompanyList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total>0){
	            		var item = result.rows[0];            		                 
	                    $("#commc").text(item.commc);
						$("#comfrhyz").text(item.comfrhyz);
						$("#comdz").text(item.comdz);
						$("#comyddh").text(item.comyddh);
						$("#enterpriseProfile").html(item.comjianjie);
						$("#enterpriseIcon").attr("src",checkImg(item.icon));
						$("#qrcode").attr("src",checkImg(item.qrcode));
						$("#lhfjndpddj").attr("src","images/2-B.png");
						if(item.lhfjndpddj=="A"){						
							$("#lhfjndpddj").attr("src","images/1-A.png");
						}
						if(item.lhfjndpddj=="B"){						
							$("#lhfjndpddj").attr("src","images/2-B.png");
						}
						if(item.lhfjndpddj=="C"){						
							$("#lhfjndpddj").attr("src","images/3-C.png");
						}
						if(item.lhfjndpddj=="D"){						
							$("#lhfjndpddj").attr("src","images/4-D.png");
						}
						jdzb = item.comjdzb;
						wdzb = item.comwdzb;
						address = item.comdz;
        				addMarker_tantiao(jdzb,wdzb,address,"",t_commc,"images/marker_red.png");	
                    }   	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}          
        });
    }
    
    function getFjList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getFjList",
        	type: "post",
            dataType: 'json',
            data: { fjwid: t_comid, fjtype: '1' },
            success: function(result){ 
            	if(result.code == '0'){       
                 	$.each(result.rows, function (index, item) {
                 		var fjpath = basePath + item.fjpath;     
                    	var html = "";             	
                    	html += "<li><a onclick='showPic(\""+fjpath+"\")' ><img src='"+fjpath+"'></a></li>";
        				//滚动图片
        				$('#marqueeDiv').append(html);                 	                 	
                 	});
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function showPic(url){
		layer.open({
	        type: 1,
	        title: "图片预览",
	        area:["70%","90%"],
	        shadeClose: true, //点击遮罩关闭
	        content: "<img style='width:100%;height:100%;' src="+url+"></img>"
	  }); 
	}        
	
    function wypj(){
        var url = encodeURI("wypj.jsp?comid="+t_comid+"&commc="+t_commc); 
		layer.open({
			type:2,			
			title: t_commc + ">>公众评价",
			area:["70%","90%"],
			shade:0,
			content: url
		});
	}
	
	function wyts(){
		window.open("http://42.236.64.232/");
	} 
		
	function lsdj(){		
		layer.open({
			type:2,			
			title: t_commc + ">>历史等级透明",
			area:["70%","90%"],
			shade:0,
			content:"lsdj.jsp?comid="+t_comid
		});
	}        
</script>
<script type="text/javascript">
	/*********跑马灯效果***************/
	var marqueeDivControl=new Marquee("marqueeDiv");
	marqueeDivControl.Direction="left";
	marqueeDivControl.Step=1;
	marqueeDivControl.Width=1020;
	marqueeDivControl.Height=233;
	marqueeDivControl.Timer=20;
	marqueeDivControl.ScrollStep=1;				
	marqueeDivControl.Start();
	marqueeDivControl.BakStep=marqueeDivControl.Step;	
</script>
</body>
</html>