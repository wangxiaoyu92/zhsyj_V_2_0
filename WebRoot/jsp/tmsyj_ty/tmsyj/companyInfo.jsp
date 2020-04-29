<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = "企业二维码>>检验检测信息公示";
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>企业基本信息</title>
<script src="./js/jquery-1.12.0.min.js"></script>
<script src="./js/common.js"></script>
<style>
	/*初始化*/
	*{ margin: 0; padding: 0;list-style: none;}	
	body{ font-family:"微软雅黑",Arial,Sans-Serif;font-size: 16px;max-width: 1024px; margin: 0 auto;}
	img{ border:none; display: block;}
	/*开始*/
	.box{ width: 100%; overflow: hidden;}
	.box_img{ width: 20%; overflow: hidden; float: left;}
	.box img{ width:100%;    margin:0 auto; float: left}
	/*企业基本信息*/
	.jbxx{ width: 100%; /*margin: 10px 0 0 10px;*/ float: left; }
	.jbxx_title { font-size:20px; text-align: center; line-height: 44px; color: white; background-color: cornflowerblue;}
	.jbxx img{ width:100%; float: left; max-height: 240px;}
	.jbxx li{ border-bottom: solid 1px #ccc; overflow: hidden; padding: 0 10px;}
	.jbxx li p,span{ float:left; line-height: 34px;}
	.jbxx li p{ width:34%; color: #666;}
	.jbxx li span{ width:58%; }
	/*快捡记录*/
	.kjjl{ width: 100%; float: left;    margin: 16px 0 0 0;}
	.kjjl li{ margin-bottom: 10px;}
	.kjjl .kjjl_title{ font-size:20px; text-align: center; line-height: 44px; color: white; background-color: cornflowerblue;    margin: 0 0 10px 0;}
	.kjjl .kjjl_content{ border: solid 1px #ccc; width: 94%; margin: 0 auto; border-radius: 2%;}
	.kjjl .kjjl_content li{ padding:0 10px; overflow: hidden;}
	.kjjl .kjjl_content li p,span{ float:left; line-height: 34px; }
	.kjjl .kjjl_content li p{ width:35%; color: #666;}
	.kjjl .kjjl_content li span{ width:58%}
</style>
</head>
<body>
<div class="box">
	<div class="jbxx_title">
		企业基本信息
	</div>
	<div class="jbxx">
		<ul >
			<li style="padding: 0;">
				<img id="enterpriseIcon" src="images/kong.jpg" />
			</li>
			<li>
				<p>企业名称：</p>
				<span id="commc"></span>
			</li>
			<li>
				<p>企业法人：</p>
				<span id="comfrhyz"></span>
			</li>
			<li>
				<p>企业地址：</p>
				<span id="comdz"></span>
			</li>
			<li>
				<p>联系电话：</p>
				<span id="comgddh"></span>
			</li>
		</ul>
	</div>

	<div class="kjjl">
		<div class="kjjl_title">快检记录</div>
		<ul>
			<li>
				<ul id="kjjlIcon" class="kjjl_content">
					<li><img src="images/kong.jpg" /></li>
				</ul>
			</li>
		</ul>			
	</div>
	<div class="kjjl">
		<div class="kjjl_title">技术支持：河南安盛科技股份有限公司</div>
	</div>
</div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_comid = '<%=t_comid%>';
	
	$(function () {       
        getPcompany();
        getKjfjList(1,10);
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
						$("#comgddh").text(item.comgddh);
						$("#enterpriseIcon").attr("src",checkImg(item.icon));	
                    }   	
              	}else{
                	alert(result.msg);	                       
              	} 
         	}          
        });
    }
    
    function getKjfjList() {
    	$.ajax({
        	url: basePath + "api/tmsyj/getKjfjList",
        	type: "post",
            dataType: 'json',
            data: { hjhbid: t_jhbid, fjtype: '9' },
            success: function(result){ 
            	if(result.code == '0'){       
					$('#kjjlIcon').empty();
					$.each(result.rows, function (index, item) {
                 		var html = ""; 
		                html += "<li><img src=\"" + checkImg(item.fjpath) + "\" /></li>"; 		                                        	
                    	$('#kjjlIcon').append(html);	                	                 	
                 	});
//                  	if(result.total>0){
// 	            		var item = result.rows[0];            		                 
// 	                    $("#kjjlIcon").attr("src",checkImg(item.fjpath));
//                     }   
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
   
</script>
</body>
</html>