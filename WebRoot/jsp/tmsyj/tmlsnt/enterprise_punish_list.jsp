<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String t_currlocation = StringHelper.showNull2Empty(request.getParameter("currlocation"));
	String t_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
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
</head>
<body>
<div id="top"></div>	
<div class="container" style="width:80%;margin-top:5px;min-width:1030px;">
    <div class="current-location">
		<span class="position" id="currlocation">当前位置：  </span>
	</div>
    <div class="row" style="margin-top:10px;">
        <div class="col-xs-12 col-sm-12" style="text-align:center;"> 			
			<table id="content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
				<tr>
					<td rowspan='4' align="center" valign="middle" style="height:150px;width:120px;"><img id="icon1" src="images/kong.jpg" style="height:150px;width:120px;"></td>
					<td id="fzr1">负责人：</td>
					<td rowspan='4' align="center" valign="middle" style="height:150px;width:120px;"><img id="icon2" src="images/kong.jpg" style="height:150px;width:120px;"></td>
					<td id="fzr2">负责人：</td>
				</tr>
				<tr>
					<td id="lxfs1">联系方式：</td>
					<td id="lxfs2">联系方式：</td>
				</tr>
				<tr>
					<td id="zw1">职位：</td>
					<td id="zw2">职位：</td>
				</tr>
				<tr>
					<td id="zfzh1">执法证号：</td>
					<td id="zfzh2">执法证号：</td>
				</tr>
			</table>
                     	
            <!--选项卡内容 开始-->
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:33%;" onclick="sele_show(0)">日常检查</div>
                <%--<div id="table_1" class="table_hide" style="width:33%;" onclick="sele_show(1)">专项检查</div>--%>
                <%--<div id="table_2" class="table_hide" style="width:33%;" onclick="sele_show(2)">监督抽检</div>                --%>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <ul id="rcjc_content"></ul>
	                <ul id="rcjc_page_list"></ul>
	            </div>
	            <div id="tables_1" class="tables" style="display:none;width:100%">
	                <div style="padding-left:20px;text-align:left;color:red;font-weight:bold;padding-top:15px;" id="zxjc_info"></div>
	                <ul id="zxjc_content"></ul>
	                <ul id="zxjc_page_list"></ul>
	            </div>
	            <div id="tables_2" class="tables" style="display:none;width:100%">
	                <div style="padding-left:20px;text-align:left;color:red;font-weight:bold;padding-top:15px;" id="jdcj_info"></div>
	                <ul id="jdcj_content"></ul>
	                <ul id="jdcj_page_list"></ul>
	            </div>
	    	</div>
            <!--选项卡内容  结束-->
        </div>
<!--         <div class="col-xs-4 col-sm-4" id="news"></div> -->
    </div>
</div>
<div id="foot"></div>		
<script type="text/javascript">
	var basePath = '<%=basePath%>';
	var contextPath = '<%=contextPath%>';
	var t_currlocation = '<%=t_currlocation%>';	
	var t_comid = '<%=t_comid%>';	
   	
   	var tabs = 4;
	function sele_show(bh) {
	    for (var i = 0; i <= tabs; i++) {
	        if (i == bh) {
	            $("#table_" + i + "").addClass('table_show');//添加样式，样式名为className
	            $("#table_" + i + "").removeClass('table_hide');//删除样式，样式名为className
	            $("#tables_" + i + "").css('display', 'block');
	        } else {
	            $("#table_" + i + "").addClass('table_hide');//添加样式，样式名为className
	            $("#table_" + i + "").removeClass('table_show');//删除样式，样式名为className
	            $("#tables_" + i + "").css('display', 'none');
	        }
	    } 
	}
	
	var v_pageSize = 10;
    var rcjc_options = {
        currentPage: 1,
        totalPages: 1,
        bootstrapMajorVersion: 3,
        numberOfPages: 5,
        size: "large",
        itemTexts: function (type, page, current) {
            switch (type) {
                case "first":
                    return "首页";
                case "prev":
                    return "上一页";
                case "next":
                    return "下一页";
                case "last":
                    return "尾页";
                case "page":
                    return page;
            }
        },
        tooltipTitles: function (type, page, current) {
            switch (type) {
                case "first":
                    return "首页";
                case "prev":
                    return "上一页";
                case "next":
                    return "下一页";
                case "last":
                    return "尾页";
                case "page":
                    return page + "页";
            }
        }, onPageClicked: function (e, originalEvent, type, page) {
            getJdjcResultList(page, v_pageSize);
        }
    }
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getPcompanyRcjdglryList(1, v_pageSize);                
        getJdjcResultList(1, v_pageSize);  
    });

	function getPcompanyRcjdglryList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getPcompanyRcjdglryList",
        	type: "post",
            dataType: 'json',
            data: { comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		if(result.total=='1'){
            			$('#icon1').attr('src',checkImg(result.rows[0].icon));            		
	            		$('#fzr1').html('负责人：' + result.rows[0].description);
	            		$('#zw1').html('职务：' + result.rows[0].zfryzw);
	            		$('#lxfs1').html('联系方式：' + result.rows[0].mobile);
	            		$('#zfzh1').html('执法证号：' + result.rows[0].zfryzjhm);
            		}
            		if(result.total=='2'){ 
            			$('#icon1').attr('src',checkImg(result.rows[0].icon));            		
	            		$('#fzr1').html('负责人：' + result.rows[0].description);
	            		$('#zw1').html('职务：' + result.rows[0].zfryzw);
	            		$('#lxfs1').html('联系方式：' + result.rows[0].mobile);
	            		$('#zfzh1').html('执法证号：' + result.rows[0].zfryzjhm);
	            		$('#icon2').attr('src',checkImg(result.rows[1].icon)); 
	            		$('#fzr2').html('负责人：' + result.rows[1].description);
	            		$('#zw2').html('职务：' + result.rows[1].zfryzw);            		              
	            		$('#lxfs2').html('联系方式：' + result.rows[1].mobile);
	            		$('#zfzh2').html('执法证号：' + result.rows[1].zfryzjhm);
            		}
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function getJdjcResultList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getJdjcResultList",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, comid: t_comid },
            success: function(result){ 
            	if(result.code == '0'){
            		rcjc_options.currentPage = result.currPage;
                 	rcjc_options.totalPages = result.totalPage; 
                 	$('#rcjc_content').empty();                           
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
                        if (index != result.rows.length - 1) {
                            html += "<li style=\"border-bottom:1px #999 dotted;\">";
	                    } else {
	                        html += "<li style=\"border-bottom:1px #00a0ea solid;\">";
	                    }
	                    html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
						html += " <tr>";
                     	html += "   <td><a href=\"javascript:linkToBlank('" + basePath +"api/tmsyj/getJdjcResultDetail?comid=" + IsNull(item.comid) + "&commc="+ IsNull(item.commc) + "&resultid="+ IsNull(item.resultid) + "');\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">检查计划："  + IsNull(item.plantitle) + "</a></td>";
                     	html += " </tr>";
                     	html += " <tr>";
                     	html += "   <td  style=\"font-size:14px;\">检查人员：" + IsNull(item.operateperson) + "、"+ IsNull(item.resultperson)+"</td>";
                     	html += " </tr>";
                     	html += " <tr>";
                     	html += "   <td  style=\"font-size:14px;\">检查日期：" + IsNull(item.resultdate) + "</td>";
                     	html += " </tr>";
                     	html += " <tr>";
                     	html += "   <td  style=\"font-size:14px;\">检查结果编号：" + IsNull(item.resultid) + "</td>";
                     	html += " </tr>";
						html += " <tr>";
                     	html += "   <td><a href=\"javascript:linkToBlank('enterprise_punish_info.jsp?comid=" + IsNull(item.comid) + "&commc="+ IsNull(item.commc) + "&resultid="+ IsNull(item.resultid) + "&plantitle="+ IsNull(item.plantitle) + "&operateperson="+ IsNull(item.operateperson) + "&resultdate="+ IsNull(item.resultdate) + "');\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">查看附件</a></td>";
                     	html += " </tr>";	
                        html += "</table>";
	                    html += "</li>";
		                $('#rcjc_content').append(html);
                     	if (index == result.rows.length - 1) {
                        	$('#rcjc_page_list').bootstrapPaginator(rcjc_options);
                    	}
                 	});
                    if (result.total<=0){
                        var html = "";
                        html += "<li style=\"border-bottom:1px #00a0ea solid;height:135px;\">";
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += "     <td rowspan=\"5\" width=\"140px\" style=\"padding-right:15px;\">";
                        html += "         <img src=\"images/kong.jpg\" style=\"height:120px;width:160px;\" />";
                        html += "     </td>";
                        html += "     <td  style=\"font-size:14px;\">没有查询到符合条件的记录，如有疑问请联系系统管理员！</td>";                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        html += "</li>";
                        $('#rcjc_content').append(html);
                    }
              	}else{
                	alert(result.msg);	                       
              	} 
         	}            
        });
    }
    
    
</script>
</body>
</html>