<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<%
	 String aaa102 = StringHelper.showNull2Empty(request.getParameter("aaa102"));
 %>
<!DOCTYPE html>
<html>
<head>
<title>企业人员信息</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var singleSelect = sy.getUrlParam("singleSelect");
var v_singleSelect = (singleSelect=="true");

var form;
var table;
var layer;
var selectTableDataId = '';
$(function() {
    initData();

    $('#btn_query').click(function () {
        query();
        return false;
    })
})

	function initData() {
        layui.use(['form', 'table', 'layer'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.render({
                elem: '#roleTable'
                ,url : basePath + 'pcomry/queryPcomry'
                , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , page: true // 展示分页
                , limit: 10 // 每页展示条数
                , limits: [10, 20, 30] // 每页条数选择项
                ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
                , request: {
                    pageName: 'page' //页码的参数名称，默认：page
                    , limitName: 'rows' //每页数据量的参数名，默认：limit
                }
                , response: {
                    countName: 'total' //数据总数的字段名称，默认：count
                    , dataName: 'rows' //数据列表的字段名称，默认：data
                }
                ,cols: [[
                    { field : 'ryid', width : 210, title: '人员ID',event: 'trclick'}
                    ,{ field : 'commc', width : 150, title : '企业名称',event: 'trclick' }
                    ,{ field : 'ryxm', width : 100, title: '人员姓名',event: 'trclick' }
                    ,{ field : 'comryusername', width : 120, title : '人员登录系统账号',event: 'trclick'}
                    ,{ field : 'ryzjlx', width : 80, title : '证件类型',event: 'trclick'}
                    ,{ field : 'ryzwgwinfo', width : 110, title : '职务岗位',event: 'trclick'}
                    ,{ field : 'ryzjh', width : 150, title : '证件号码',event: 'trclick'}
                    ,{ field : 'rylxdh', width : 100, title : '联系人电话',event: 'trclick'}
                    ,{ field : 'rymz', width : 100, title : '人员民族',event: 'trclick'}
					/*	, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}*/
                ]]
                ,done:function (res, curr, count) {
                    layer.close(mask);
                }
			});
            // 监听工具条
            table.on('tool(paramgridfilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'trclick') { // 选中行
                    if (selectTableDataId != data.ryid) {
                        // 清除所有行的样式
                        $($("#roleTable").next()).find(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $("#roleTable").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                        table.singleData = data;
                        selectTableDataId = data.ryid;
                    } else { // 再次选中清除样式
                        $("#roleTable").next().find(obj.tr.selector).attr("style", "");
                        table.singleData = '';
                        selectTableDataId = '';
                    }
                }
            });
        })
	}


//确定
function queding() {
    if (table.singleData != null && table.singleData != '') {
        var obj = new Object();
        obj.data = table.singleData;
        obj.type = "ok";
        sy.setWinRet(obj);
        parent.layer.close(parent.layer.getFrameIndex(window.name));
    } else {
        layer.alert('请选择人员！');
    }
}

    //重置
    function reset() {
        table.singleData = '';
        selectTableDataId = '';
        $('#ryid').val('');
        $('#ryxm').val('');
        //刷新的时候显示进度条
        mask = layer.load(1, {shade: [0.1, '#393D49']});
        var param = {
            'ryid':'',
            'ryxm':''
        };
        table.reload('roleTable', {
            url: basePath + 'pcomry/queryPcomry'
            , where: param //设定异步数据接口的额外参数
            ,done:function () {
                layer.close(mask);
            }
        });
    }



    //查询
    function query() {
        table.singleData = '';
        selectTableDataId = '';
        var param = {
            'ryid': $('#ryid').val(),
            'ryxm': $('#ryxm').val()
        };
        //刷新的时候显示进度条
        mask = layer.load(1, {shade: [0.1, '#393D49']});
        table.reload('roleTable', {
            url: basePath + 'pcomry/queryPcomry'
            , page: true
            , where: param //设定异步数据接口的额外参数
            ,done:function () {
                layer.close(mask);
            }
        });
    }

   

</script>
</head>
<body>
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">查询条件</h2>
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myqueryform" style="height: 80px">
					<div class="layui-form-item">
						<label class="layui-form-label" >人员编号</label>
						<div class="layui-input-inline">
							<input type="text" id="ryid" name="ryid"
								   autocomplete="off" class="layui-input" >
						</div>
						<label class="layui-form-label" >人员名称</label>
						<div class="layui-input-inline">
							<input type="text" id="ryxm" name="ryxm"
								   autocomplete="off" class="layui-input" >
						</div>
					</div>

                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 280px"></label>

                        <div class="layui-input-inline">
                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                <i class="layui-icon">&#xe615;</i>搜索
                            </button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal" id="reset">
                                <i class="layui-icon">&#xe621;</i>重置
                            </button>
                        </div>
                    </div>
				</form>
			</div>
		</div>
		<table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
	</div>
</body>
</html>