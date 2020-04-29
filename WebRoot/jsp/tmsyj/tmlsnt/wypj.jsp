<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		+ request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String t_commc = StringHelper.showNull2Empty(request.getParameter("commc"));
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
<%-- 新闻编辑器 --%>
<script src="<%=contextPath %>/jslib/ckeditor_4.7.0/ckeditor.js" type="text/javascript" charset="utf-8"></script> 
</head>
<body>
<div style="width:95%; margin-top:20px;text-align:center;">
	<div style="margin-left:20px;">
		<table style="width:100%;text-align:center;" id="pjcs"></table>
	</div>
</div>
<div style="width:95%; padding-top:20px; margin-left:20px;">		
	<div>
		<!-- <span style="font-size:14px;font-weight:bold;text-align:left;">评价标题:</span><input type='text' style="width: 500px; height: 30px;" id='title'/> -->
		<span style="background:#4fb9f1;font-size:15px;color:#FFFFFF;padding:5px;cursor:pointer;width: 80px;margin: 30px;" onclick="tjpj()">提交评价</span>
		<!-- <span style="background:#14AB4C;font-size:15px;color:#FFFFFF;padding:5px;cursor:pointer;width: 80px;" onclick="reset2()">重&nbsp;&nbsp;置</span> -->		
	</div>
	<!-- <div id="pj_info" style='padding-top:5px;'>
		<textarea class="ckeditor" id="content" name="content" style="width: 750px; height: 250px;"></textarea>
	</div> -->
	<div id="pjdiv1" style="margin:15px 15px;text-align:left;">
        <h4 style="font-size:14px;font-weight:bold;text-align:left;">企业回复</h4>
        <div id="qypj"></div>
    </div>
    <div id="pjdiv2" style="margin:15px 15px;text-align:left;">
        <h4 style="font-size:14px;font-weight:bold;text-align:left;">监管单位回复</h4>
        <div id="jgpj"></div>
    </div>
</div>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';
	var t_comid = '<%=t_comid%>';
	var t_commc = '<%=t_commc%>';

	$(function () {
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
		
        $("#pjdiv1").hide();
    	$("#pjdiv2").hide();
    	getPjcsList();		
    });     
       
    //动态获取评价参数
    function getPjcsList() {
    	$.ajax({
        	url: basePath + "api/tmsyj/getAa10List",
        	type: "post",
            dataType: 'json',
            data: { aaa100: 'pjcs', aaa102: '10001001,10002002,10002003,10003' },
            success: function(result){ 
            	if(result.code == '0'){
            		$('#pjcs').empty();  
                    $.each(result.rows, function (index, item) {                   	
	                    var html = "";
						html += "<tr class=\"pjcsItem\">";
						html += "   <td style=\"font-size:20px;color:red;\">" + item.aaa103 + "</td>";
						html += "	<td>";
						html += "		<table class=\"pjxj\" id='" + item.aaa102 + "'>";
						html += "			<tr>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td><img src='images/star_gray.png' class='tjxinxing' style='width:25px; height:25px;cursor: pointer;'/></td>";
						html += "				<td class='tjpjpl'>请选择评分</td>";
						html += "			</tr>";
						html += "		</table>";
						html += "	</td>";
	                    html += "</tr>";	                    
	                    $("#pjcs").append(html);	                    
                    });
                    $(".tjxinxing").bind("click",function() {
						var id = $(this).parent().parent().parent().parent().attr("id");//alert(id);
						var num = $("#" + id + " .tjxinxing").index(this);//alert(num);
						$("#" + id).data("num", num);
						makeStar(id,num);
					});
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    } 
    
    function tjpj(){
    	if(checkStar()=="0"){
    		return;
    	};
	    var pjcs = "";
	    var pjxj = "";	    
	    $.each($(".pjxj"), function (index, item) {
			var id = $(this).attr("id");
			pjcs += id + ",";  //alert(pjcs);
			pjxj += IsNull($("#" + id).data("num")) + ","; //alert(pjxj);  
		});
	    //获取编辑器的内容 
		/* var content = CKEDITOR.instances.content.getData();
	    if(content.length == 0){	    	
	   		alert("请输入评价内容！");
	   		return; 
	    } */ 
	    $.ajax({
        	url: basePath + "api/tmsyj/addPgzpj",
        	type: "post",
            dataType: 'json',
            data: {
                "pjcs" : pjcs, 
                "pjxj" : pjxj,
				"pjztid" : t_comid,
				"pjztmc" : t_commc,
				// "pjbt" : $("#title").val(),
				// "pjnr" : CKEDITOR.instances.content.getData(),
				"pjr" : "游客"
			},success: function(result){ 
            	if(result.code == '0'){
            		parent.layer.alert("<span style='color:blue'>评价成功！</span>");
					var index = parent.layer.getFrameIndex(window.name);
					parent.layer.close(index);	
              	}else{
                	layer.alert("<span style='color:red'>评价失败！</span>");                      
              	} 
         	}          
        });
    }
    
    function reset2(){    	
   		$("#title").val('');
    	CKEDITOR.instances.content.setData('');
    }    
</script>
</body>
</html>