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
        	<!--选项卡内容 开始-->
            <div class="tab_title" style="border-bottom:1px solid #048ad3;width:100%;height:40px; line-height:40px; margin-top:10px;">
                <div id="table_0" class="table_show" style="width:50%;" onclick="sele_show(0)">预包装食品</div>
            </div>
            <div class="tab_list"> 
	            <div id="tables_0" class="tables" style="display:block;width:100%">
	                <table id="ybzsp_content" class="table table-bordered" style="border-collapse:collapse;font-size:14px;">
	                    <thead style="font-weight:bold;border-bottom:1px #999 solid;">
	                        <tr>
	                            <td>预包装食品名称</td>
<!-- 	                            <td>食品类别</td> -->
	                            <td>商标(品牌)</td>
	                            <td>进货日期</td>
	                            <td>采购量</td>
	                            <td>计量单位</td>
	                            <td>进货来源</td>
	                            <td>生产日期</td>
	                            <td>保质期</td>
	                            <td style="text-align: center;">操作</td>
	                        </tr>
	                    </thead>
	                    <tbody></tbody>
	                </table>
	                <ul id="ybzsp_page_list"></ul>
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
   	
   	var tabs = 3;
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
	
	var v_pageSize = 30;
    var ybzsp_options = {
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
            getYbzspList(page, v_pageSize);
        }
    }
	
    $(function () {                
        if (t_currlocation != '') {
            $('#currlocation').html('当前位置：' + t_currlocation);
        }
        getYbzspList(1, v_pageSize);                 
    });
    
    function getYbzspList(page,pageSize) {
    	$.ajax({
        	url: basePath + "api/tmsyj/getSpxxtmList_zm",
        	type: "post",
            dataType: 'json',
            data: { page: page, rows: pageSize, hviewjgztid: t_comid, jcypgl: "10102,10103" },
            success: function(result){ 
            	if(result.code == '0'){
            		ybzsp_options.currentPage = result.currPage;
                 	ybzsp_options.totalPages = result.totalPage;
                 	$('#ybzsp_content tbody').empty();                        
                 	$.each(result.rows, function (index, item) {
                    	var html = "";
	                    if (index != result.rows.length - 1) {
                            html += "<tr style=\"border-bottom:1px #999 dotted;\">";
                        } else {
                            html += "<tr style=\"border-bottom:1px #00a0ea solid;\">";
                        }
// 	                    html += "<td><a href=\"javascript:linkToSelf('enterprise_material_info.jsp?hviewjgztid=" + IsNull(item.hviewjgztid) +"&jcypid=" + IsNull(item.jcypid) + "');\" style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">"  + IsNull(item.jcypmc) + "</a></td>";
	                    html += "<td style=\"font-size:14px;color:#0000F0;text-decoration:none;font-weight:bold;\">"  + IsNull(item.jcypmc) + "</td>";	                    
// 	                    html += "<td>"+IsNull(item.spfenleiinfo)+"</td>";	                    
	                    html += "<td>"+IsNull(item.jcypsspp)+"</td>";
	                    html += "<td>"+IsNull(item.aae036).split(" ")[0]+"</td>";
	                    html += "<td>"+IsNull(item.jhsl)+"</td>";
	                    html += "<td>"+IsNull(item.jhjldwmc)+"</td>";
	                    html += "<td>"+IsNull(item.jhgysmc)+"</td>";
	                    html += "<td>"+IsNull(item.jhscrq).split(" ")[0]+"</td>";
	                    html += "<td>"+IsNull(item.spbzq)+"</td>";
 	                    html += "<td><a href=\"javascript:void(0);\" onclick=\"spsycx('" + item.trace + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">全程追溯</a>";
// 	                    html += "<td><a href=\"javascript:void(0);\" onclick=\"szspcx('" + item.hjhbid + "','" + item.hviewjgztid + "','" + item.jgztmc + "','" + item.jcypmc + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">查看索证索票</a></td>";	                    
	                    html += "&nbsp;&nbsp;<a href=\"javascript:linkToSelf('" + basePath + "/jsp/tmsyj/tmsyj/szspcx.jsp?hjhbid=" + IsNull(item.hjhbid) + "&comid="+ IsNull(item.hviewjgztid) + "&commc="+ IsNull(item.jgztmc) + "&jcypmc=" + IsNull(item.jcypmc) + "');\" style=\"background: #4fb9f1;color: #fff;padding: 5px 5px;border-radius: 6px;font-size:11pt;text-decoration:none;\">查看索证索票</a></td>";
	                    html += "</tr>";
                   	 	$('#ybzsp_content tbody').append(html);
                     	if (index == result.rows.length - 1) {
                        	$('#ybzsp_page_list').bootstrapPaginator(ybzsp_options);
                    	}
                 	});
              	}else{
                	alert(result.msg);	                       
              	} 
         	}           
        });
    }
    
    function spsycx(trace){
    	var url = encodeURI(trace);
		layer.open({
			type:2,			
			title: "食品溯源查询",
			area:["70%","90%"],
			shade:0,
			content: url
		});
	}
	
	function szspcx(hjhbid,hviewjgztid,jgztmc,jcypmc){
    	var url = encodeURI(basePath + "/jsp/tmsyj/tmsyj/szspcx.jsp?hjhbid=" + IsNull(hjhbid) + "&comid="+ IsNull(hviewjgztid) + "&commc="+ IsNull(jgztmc) + "&jcypmc=" + IsNull(jcypmc) ); 		
		layer.open({
			type:2,			
			title: "索证索票信息查询",
			area:["100%","100%"],
			shade:0,
			content: url
		});
	}
</script>
</body>
</html>