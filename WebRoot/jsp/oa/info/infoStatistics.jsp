<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>信息报送统计</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style>


		.layui-table-cell {
			height: auto;
			line-height: 28px;
			padding: 0 15px;
			position: relative;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: normal;
			box-sizing: border-box;
		}
	</style>
	<script type="text/javascript">
        var selectTableDataId = '';
        var grid;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                var th1 = [
                    //fixed:"left"
                    {field: 'orgname', width: 140, title: '科室',align: 'center',rowspan:3, event: 'trclick'}
                    , {  width: 260, title: '规定信息数量',align: 'center',colspan:2, event: 'trclick'}
                    , {  width: 260, title: '上报信息数量',align: 'center',colspan:2, event: 'trclick'}
                    , {  width: 260, title: '局采用信息数量',align: 'center',colspan:2, event: 'trclick'}
                    , {  width: 260, title: '省、市采用数量',align: 'center',colspan:2, event: 'trclick'}
                ];
                var th2 = [
                    {field: 'yearnumber', width: 130, title: '年规定数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'monthnumber', width: 130, title: '月规定数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'ljsb', width: 130, title: '累计上报数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'benyue', width: 130, title: '本月上报数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'juliang', width: 130, title: '累计上报数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'yueliang', width: 130, title: '本月上报数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'shengliang', width: 130, title: '累计上报数量',align: 'center',rowspan:2,event: 'trclick'}
                    , {field: 'yueshengliang', width: 130, title: '本月上报数量',align: 'center',rowspan:2,event: 'trclick'}
                ];

                table.render({
                    elem: '#workTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/work/task/queryinfoStatistics'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [th1,th2]
                    ,done:function(data,curr,count){
                        console.log("res"+res);
                        console.log("curr"+curr);
                        var res = data.rows;
                    }
                });

//				 // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.orgname) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.orgname;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    daoJcgzhb: function () { // 导出
                        daoJcgzhb();
                    }
                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });


            });


        });
        function query() {
            table.singleData = '';
            selectTableDataId = '';
            var orgname = $('#orgname').val();
            var param = {
                'orgname': orgname
            };
            table.reload('workTable', {
                url: basePath + '/work/task/queryinfoStatistics'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
            });
        }
        function daoJcgzhb() {
            var myDate = new Date();
            var a=myDate.getMonth()+1;
            var orgname = $('#orgname').val();
            layer.msg('正在导出请稍候', {time: 1000
            });
            $.ajax({
                type:'POST',
                url:basePath + '/work/task/exportToExcel',
                dataType:'json',
                data:{orgname:orgname},
                async:false,
                success:function(result){
                    window.open(basePath+'/jsp/oa/moban/'+'中牟市食品药品监督管理局'+ a+'月份信息报送统计-览表.xls');
                }
            });


        }




        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择单位'
                , area: ['900px', '470px']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: ""
                }
                , content: basePath + 'work/task/departmentIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if(obj==null||obj==''){
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#orgname").val(myrow.orgname); //科室名称
                    $("#orgid").val(myrow.orgid); //科室代码
                }
            });
        }


	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">
		<div class="layui-colla-item">
			<h2 class="layui-colla-title">搜索条件</h2>
			<div class="layui-colla-content layui-show">
				<form class="layui-form" id="myqueryform" style="height: 90px">
					<div class="layui-form-item" style="text-align:left ">
						<label class="layui-form-label">科室:</label>
						<div class="layui-input-inline">
							<input type="text" id="orgname" name="orgname" readonly
								   autocomplete="off" class="layui-input">
							<input id="orgid" name="orgid" type="hidden">
						</div>
						<div class="layui-input-inline" style="width: 110px">
							<a href="javascript:void(0)" class="layui-btn"
							   iconCls="icon-search" onclick="myselectcom()">选择单位 </a>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" style="width: 190px"></label>
						<div class="layui-input-inline" style="margin-top: -45px;margin-left: 260px">
							<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
								<i class="layui-icon">&#xe615;</i>搜索
							</button>
							<button class="layui-btn layui-btn-sm layui-btn-normal"
									id="btn_reset">
								<i class="layui-icon">&#xe621;</i>重置
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 15px;">
		<div class="layui-btn-group demoTable">
			<button class="layui-btn layui-btn-danger" data-type="daoJcgzhb" data="btn_daoJcgzhb">导出</button>
		</div>
	</fieldset>
	<table class="layui-hide" id="workTable" lay-filter="tableFilter"></table>
</div>
</div>
</body>
</html>
