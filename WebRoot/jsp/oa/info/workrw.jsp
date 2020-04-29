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
	<title>信息管理</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
	<script type="text/javascript">

        // 是否采纳
        var v_adopt = [{"id":"1","text":"否"},{"id":"2","text":"是"}];
        var grid;
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;
        $(function() {

            layui.use(['form', 'table', 'layer', 'element'], function () {
                orm = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    ,url: basePath + '/work/task/queryW1'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数queryZxpdjg
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
                        {field: 'content', width: 250, title: '工作任务内容', event: 'trclick'}
                        , {field: 'time', width: 250, title: '工作任务时间', event: 'trclick'}
                        , {field: 'cyry', width: 250, title: '任务处理人', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                })
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.infoid) {
                            var adopt = data.adopt;
                            if(adopt=="2"){
                                $("#linkInfo").removeClass('layui-btn-disabled').removeAttr("disabled");
                                $("#adoptInfofj").removeClass('layui-btn-disabled').removeAttr("disabled");
							}else if(adopt=="1"){
                                $("#linkInfo").addClass('layui-btn-disabled').attr("disabled", "true");
                                $("#adoptInfofj").addClass('layui-btn-disabled').attr("disabled", "true");

                            }

                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.infoid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    addInfo: function () { // 添加
                        addInfo();
                    }
                    , showInfo: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的工作上报信息！');
                        } else {
                            showInfo(table.singleData.worksbid);
                        }
                    }
                    , upInfo: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的工作上报信息！');
                        } else {
                            upInfo(table.singleData.worksbid);
                        }
                    }
                    , delInfo: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要删除的工作上报信息！');
                        } else {
                            delInfo(table.singleData.worksbid);
                        }
                    }

                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                //监听提交
                $("#btn_query").bind("click", function () {
                    query();
                    return false;
                });
            })
        });
	</script>
	<script type="text/javascript">


        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('grid', {
                url: basePath + '/work/task/queryW'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
			/*    parent.window.refresh();*/
        }
        function addInfo () {

            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增'
                , content: basePath + 'work/task/worksbForm?op=add'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }



        // 编辑
        function upInfo(infoid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑'
                , content: basePath + 'work/task/worksbeditForm?worksbid=' + infoid + '&op=edit'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }



        // 删除
        function delInfo(infoid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'work/task/delW', {
                            worksbid: infoid
                        },
                        function (result) {
                            if (result.code == '0') {
                                table.singleData = '';
                                selectTableDataId = '';
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.grid.length == 1) {
                                        curent = curent - 1;
                                    }
                                    refresh('', curent);
                                });
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });

        }
        // 查看
        function showInfo(infoid) {
            var url = basePath + 'workflow/wfywlclogIndex';
            var dialog = sy.modalDialog({
                title : '查看日志',
                param : {
                    ywbh : infoid,
                    time : new Date().getMilliseconds()
                },
                area:[ '1000px','550px'],
                content : url
            },function(dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj != null && "ok"==obj){
                    $("#grid").datagrid("reload");
                }
                sy.removeWinRet(dialogID);//不可缺少
            });
        }

        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('grid', {
                    url: basePath + '/work/task/queryW'
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
            }
        }


        // 上传图片附件
        function uploadFjView(infoid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    folderName: "info",
                    fjwid: infoid,
                    fjtype:'66'
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }

        function  adoptInfofj (infoid) {
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    folderName: "adoptInfo",
                    fjwid: infoid,
					fjtype:'67'
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }
	</script>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-collapse">

	<div class="layui-margin-top-15">
		<div class="layui-btn-group demoTable">

			<ck:permission biz="showInfo">
				<button class="layui-btn" data-type="showInfo" data="btn_showInfo">查看日志</button>
			</ck:permission>

		</div>
		<table class="layui-hide" id="grid" lay-filter="tableFilter">
		</table>
	</div>
</div>

</body>
</html>