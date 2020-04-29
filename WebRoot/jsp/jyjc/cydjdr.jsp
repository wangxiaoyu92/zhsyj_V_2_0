<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
	<title>检验检测抽样登记导入</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        var grid;
        var grid2;
        var table;
        var layer;

        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
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
                    , cols: [[
                        {
                            field: 'cybh', width: 100, title: '抽样编号', event: 'trclick'
                        }
                        ,{ field : 'bcydw', width : 100, title: '被抽样单位',event: 'trclick' }
                        ,{ field : 'bcydwdz', width : 100, title: '被抽样单位地址',event: 'trclick'}
                        ,{ field : 'scdw', width : 100, title: '生产单位',event: 'trclick' }
                        ,{ field : 'ypmc', width : 100, title: '样品名称',event: 'trclick' }
                        ,{ field : 'countcy', width : 100, title: '抽样数量',event: 'trclick' }
                        ,{ field : 'ypbh', width : 100, title: '样品批号/生产日期',event: 'trclick' }
                        ,{ field : 'cyjsr', width : 100, title: '抽样经手人',event: 'trclick' }
                        ,{ field : 'tel', width : 100, title: '被抽样单位联系电话',event: 'trclick' }
                        ,{ field : 'cysj', width : 100, title: '抽样时间',event: 'trclick' }
                        ,{ field : 'cyfl', width : 100, title: '抽样分类',event: 'trclick' }
                        ,{ field : 'bcydwfl', width : 100, title: '被抽样单位分类',event: 'trclick' }
                        ,{ field : 'aae011', width : 100, title: '经办人',event: 'trclick' }
                        ,{ field : 'aae036', width : 100, title: '经办时间',event: 'trclick'}
//					, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}
                    ]]
                });
                table.render({
                    elem: '#grid2'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参v数
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
                    , cols: [[
                        {
                            field: 'cybh', width: 100, title: '抽样编号', event: 'trclick'
                        }
                        ,{ field : 'bcydw', width : 100, title: '被抽样单位',event: 'trclick' }
                        ,{ field : 'bcydwdz', width : 100, title: '被抽样单位地址',event: 'trclick'}
                        ,{ field : 'scdw', width : 100, title: '生产单位',event: 'trclick' }
                        ,{ field : 'ypmc', width : 100, title: '样品名称',event: 'trclick' }
                        ,{ field : 'countcy', width : 100, title: '抽样数量',event: 'trclick' }
                        ,{ field : 'ypbh', width : 100, title: '样品批号/生产日期',event: 'trclick' }
                        ,{ field : 'cyjsr', width : 100, title: '抽样经手人',event: 'trclick' }
                        ,{ field : 'tel', width : 100, title: '被抽样单位联系电话',event: 'trclick' }
                        ,{ field : 'cysj', width : 100, title: '抽样时间',event: 'trclick' }
                        ,{ field : 'cyfl', width : 100, title: '抽样分类',event: 'trclick' }
                        ,{ field : 'bcydwfl', width : 100, title: '被抽样单位分类',event: 'trclick' }
                        ,{ field : 'aae011', width : 100, title: '经办人',event: 'trclick' }
                        ,{ field : 'aae036', width : 100, title: '经办时间',event: 'trclick'}
                    ]]
                });
            })
        });

        //导出excel
        var exportToExcel = function (filename) {
            var rows = grid2;
            if (rows.length > 0) {
                var errorJsonStr = $.toJSON(rows);
                $('#fm').form('submit', {
                    url: basePath + '/jyjc/exportToExcel?filename=' + filename + '&errorJsonStr=' + errorJsonStr,
                    onSubmit: function () {
                        var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                        return isValid;
                    },
                    success: function (result) {
                        //
                    }
                });
            } else {
                layer.msg('不存在需要导出的记录!');
                return;
            }
        };

        //下载模版
        var downLoadExcel = function () {
            $('#fm').form('submit',{
                url : basePath + '/jyjc/downLoadExcel',
                onSubmit: function(){
                    var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    return isValid;
                },
                success: function(result){
                    //
                }
            });
        };

        //导入上传
        var upLoadExcel = function () {
            if (!checkFile()) {
                return;
            }
            //提交一个有效并且避免重复提交的表单
            $('#fm').form('submit', {
                url: basePath + '/jyjc/upLoadExcel',
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg('操作成功');
                        grid = $.parseJSON(result.succList).rows;
                        grid2 = $.parseJSON(result.errorList).rows;
                        table.reload('grid', {data: grid});
                        table.reload('grid2', {data: grid2});
                    } else {
                        layer.msg('操作失败:' + result.msg);
                    }
                }
            });
        };

        //校验文件
        var checkFile = function () {
            var str = $('#filepath').val();
            if (str == "" || str == null) {
                layer.msg('请选择需要导入的文件!');
                return false;
            }
            if (str.substr(str.length - 4, 4) != ".xls") {
                layer.msg('上传文件格式必须为.xls!');
                $('#filepath').focus();
                $('#filepath').select();
                return false;
            }
            return true;
        }

        // 导入保存
        var saveCsdr = function () {
            var rows = grid;
            if (rows.length > 0) {
                var succJsonStr = $.toJSON(rows);
                layer.confirm('确定保存吗?', function (r) {
                    if (r) {
                        //下面的例子演示了如何提交一个有效并且避免重复提交的表单
                        $.ajax({
                            cache: true,
                            type: "POST",
                            url: basePath + '/jyjc/savejyjcdr',
                            data: {succJsonStr: succJsonStr},
                            async: false,
                            error: function (request) {
                                layer.msg('操作失败:' + request);
                            },
                            success: function (result) {
                                result = $.parseJSON(result);
                                if (result.code == '0') {
                                    layer.msg('操作成功');
                                    refresh();
                                } else {
                                    layer.msg('操作失败:' + result.msg);
                                }
                            }
                        });

                    }
                });
            } else {
                layer.msg('不存在需要保存的记录！');
                return;
            }
        };

        //刷新表单
        function refresh() {
            $('#fm').form('clear');
            grid = ''
            grid2 = ''
            table.reload('grid', {data: grid});
            table.reload('grid2', {data: grid2});
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
	</script>
</head>
<body>
<div class="layui-collapse">
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">操作区</h2>

		<div class="layui-colla-content layui-show">
			<form id="fm" method="post" target="hideWin" enctype='multipart/form-data'>
				<table class="table" style="width: 99%;">
					<th><a href="javascript:void(0);" onclick="downLoadExcel();">
						<font color="red">下载模版文件</font>
						<img src="<%=contextPath%>/images/frame/download.gif"/>
					</a>
					</th>
					<tr>
						<td style="text-align:right;">
							<nobr>选择上传文件</nobr>
						</td>
						<td><input id="filepath" name="filepath" type="file" onchange="checkFile();"
								   style="width:300px"/></td>
						<td style="text-align:right;">
							<a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm"
							   onclick="upLoadExcel();"> <i class="layui-icon">&#xe681;</i> 导 入 </a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm"
							   onclick="refresh();"> <i class="layui-icon">&#xe621;</i> 重 置 </a>
						</td>
					</tr>
					<tr>
						<input id="succJsonStr" name="succJsonStr" type="hidden"/>
						<input id="errorJsonStr" name="errorJsonStr" type="hidden"/>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<br/>

<div class="layui-collapse">
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">上传的正确数据</h2>

		<div class="layui-colla-content layui-show">
			<a href="javascript:void(0);" class="layui-btn layui-btn-sm layui-btn-normal" data="btn_saveCsdr"
			   onclick="saveCsdr();"><i class="layui-icon">&#xe621;</i>保存</a>

			<div id="grid" class="layui-hide"></div>
		</div>
	</div>
</div>
<br/>

<div class="layui-collapse">
	<div class="layui-colla-item">
		<h2 class="layui-colla-title">上传的错误数据</h2>

		<div class="layui-colla-content layui-show">
			<a href="javascript:void(0);" class="layui-btn layui-btn-sm layui-btn-normal"
			   onclick="exportToExcel('上传的错误数据');"><i class="layui-icon">&#xe621;</i>导出</a>

			<div id="grid2" class="layui-hide"></div>
			</br>
			</br>
		</div>
	</div>
</div>
</body>
</html>
