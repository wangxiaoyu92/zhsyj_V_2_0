<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="java.util.*"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>

<%
	String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
	String jklx = StringHelper.showNull2Empty(request.getParameter("jklx"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>监控企业列表</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=contextPath%>/jslib/myflashflowplayer/home/css/base.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
        var jklx = '<%=jklx%>';

        //总条数
        var pageTotal = 0;
        //显示每页的条数
        var displaySize = 10;
        //当前页
        var displayIndex = 1;
		var layer;
        $(function() {
            //初始化数据条数
            reqTOBankend(displayIndex, displaySize);
            load();
        });
        //请求后台
        function reqTOBankend(pageIndex, pageSize, commc) {
            displaySize = pageSize;
            displayIndex = pageIndex;
            $.post(basePath + '/jk/jkgl/queryJkqy',{
                    page : displayIndex,
                    rows : displaySize,
                    jkqymc : commc,
                    comdalei : <%=comdalei%>,
                    comcameraflag:1
                },
                function(result) {
                    if (result.code == '0') {
                        var data = result.rows;
                        pageTotal = result.total;
                        var str = '';
                        load(commc);
                        $("#Result li").remove(); //移除Id为Result的表格里的行，从第二行开始（这里根据页面布局不同页变）
                        for ( var i = 0; i < data.length; i++) {
                            var rowData = data[i];
                            var jkqymc = rowData.jkqymc;
                            var jkqybh = rowData.jkqybh;
                            var imgUrl = rowData.filepath;
                            var camorgid = rowData.camorgid;
                            var state = rowData.state;
                            if (imgUrl == null || imgUrl == "" || imgUrl == "null" || typeof (imgUrl) == "undefined") {
                                imgUrl = "/images/noqyimg.png";
                            }
                            str += '<li  onclick=showSpjky("' + jkqybh + '","' + camorgid + '") >';
                            str += '<A title="' + jkqymc + '" class="group-pic  "    >';
                            str += '<img class="img"  alt="" src="'+ basePath + imgUrl +'">';
                            str += '<div class="shop-txt" style="height:auto;">';
                            str += ' <p class="commc">' + jkqymc
                                + '</p>';

                            if(state=='1'){
                                str+='<span class="shop_camera"><img class="shop_camera" src="'+basePath+'/images/frame/camera-on.png"></span>';
                            }else{
                                str+='<span class="shop_camera"><img class="shop_camera" src="'+basePath+'/images/frame/camera-off.png"></span>';
                            }

                            var addr = rowData.comdz;
                            if (addr == null || addr == ""
                                || typeof (addr) == "undefined") {
                                addr = "";
                            }
                            str += '<p class="address">地址：' + addr
                                + ' </p>';
                            //str+='<div class="blank-line"></div>';
                            str += '</div></a></li>';
                        }
                        $('#Result').append(str);
                    } else {
                        parent.$.messager.alert('提示', '查询失败：'
                            + result.msg, 'error');
                    }
                }, 'json');
        }

        // 明厨亮灶视频监控
        var showSpjky = function(comid,camorgid) {
            var url = basePath + '/jsp/jk/jkyAllList.jsp?comid=' + comid + '&jklx=' + jklx + '&camorgid='+camorgid;
            sy.modalDialog({
                title : '视频监控',
                area:['100%','100%'],
                content : url
            });
        };
        // 刷新
        function refresh() {
            parent.window.refresh();
        }

        //初始化分页工具条
        function load(commc) {
            layui.use(['laypage','form','layer'],function () {
                var laypage=layui.laypage,form=layui.form,layer=layui.layer;
                laypage.render({
                    elem: 'page'
                    , limit: displaySize //每页显示数
                    , limits: [10, 20, 30] // 每页条数选择项s
                    ,count: pageTotal
                    ,curr:displayIndex
                    ,layout: ['limit', 'prev', 'page', 'next',  'skip','count']
                    ,jump: function(obj,first){
                        if (!first) {
                            reqTOBankend(obj.curr, obj.limit,commc);
                        }
                    }
                });
            })
            if (commc == null || commc == "" || typeof (commc) == "undefined") {
                commc = "";
            }

//		var str = '<input  style="width:200px;height:20px;border:1px solid #ccc;margin-left: 20px;margin-top:5px" type="text" name="commc"  id="commc" value="'+commc+'"/>'
//				//+ ' <a  class="group-pic" style="margin-left: 5px;margin-top:5px;cursor:hand"  onclick="queryjkqy()">查看</a>';
//				+ '<a style="margin-left: 5px;margin-top:5px;cursor:hand"  onclick="queryjkqy()">'
//				+ '<img src="' + basePath + '/images/chaxun.png"></a>';
//
            var str="<div class=\"layui-input-inline\">\n" +
                "\t\t\t<input type=\"text\" id=\"commc\" name=\"commc\"\n" +
                "\t\t\t\t   autocomplete=\"off\"  class=\"layui-input\" style=\"width: 140px\" placeholder=\"请输入公司名称\">\n" +
                "\t\t\t<button id=\"btn_query\" type='button' class=\"layui-btn layui-btn-primary layui-btn-sm\" style='background-color: #009688' onclick=\"queryjkqy()\"><i class=\"layui-icon\">&#xe615;</i>查询</button></div> ";
            $('.layui-laypage-count').after(str);

        }

        // 查询
        function queryjkqy() {
            var commc = $("#commc").val();
            if (commc == null || commc == '' || commc == "") {
                layer.msg('请填写查询的企业名称',{time:1000});
                return;
            }
            var param = {
                'commc' : commc
            };
            reqTOBankend(displayIndex, displaySize, commc);
            load();
        }
	</script>
</head>
<style type="text/css">
	.search-shop-box .pic-list {

	}

	.search-shop-box .pic-list ul li {
		width: 200px;
		height: auto;
		padding-left: 10px;
		padding-bottom: 10px;
		padding-top: 10px
	}

	.img {
		width: 200px;
		height: 128px;
	}

	.group-shop-mode .pic-list li .shop-txt {
		padding: 10px 5px 10px 5px;
		height: 154px;
		overflow: hidden;
		cursor: pointer;
		-ms-zoom: 1;
	}

	.group-shop-mode .pic-list li .group-pic:hover .shop-txt {
		padding: 10px 5px 10px 5px;
		border-color: red;
	}

	.pic-list li .shop-txt {
		background-color: rgb(255, 255, 255);
	}

	.search-shop-box .pic-list .shop-txt .commc {
		width: 200px;
		height: 20px;
		margin-bottom: 16px;
		font-size: 14px;
		color: black;
	}

	.search-shop-box .pic-list .shop-txt .address {
		width: 200px;
		height: 50px;
		color: rgb(153, 153, 153);
	}

	.blank-line {
		background-color: #d8d8d8;
		width: 160px;
		height: 1px;
		float: left;
	}

	.group-shop-mode .pic-list li .group-pic:hover .shop-txt .commc {
		/*padding: 13px 5px 9px;*/
		color: #148f2d;
	}
</style>

<body>
<div class="search-shop-box group-shop-mode" style="padding-top: 20px;padding-left: 50px">
	<div class="pic-list" style="width:1200px;margin-right:  5px ">
		<ul id="Result">

		</ul>
	</div>
</div>
<form class="layui-form" id="fm" method="post">
	<div id="page" style="padding-left: 110px">
	</div>

</form>
</body>
</html>
