<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    //String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //String v_dmlb = StringHelper.showNull2Empty(request.getParameter("dmlb"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>案件登记</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var zfwsTableData;
        var selectTableDataId;
        var editIndex = undefined;
        var table; // 数据表格
        var layer; // 弹出层
        var mask;
        $(function () {
            layui.use(['table', 'layer'], function () {
                table = layui.table;
                layer = layui.layer;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    /*,url : basePath + '/pub/wsgldy/queryAjwsParamlistOrder'*/
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
                        {field: 'fjcsdmmc', title: '执法文书名称', event: 'trclick'}
                        , {field: 'fjcspx', title: '排序值（越小越靠前）', edit: 'text', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                querySupervisionItem();
                // 监听工具条
                table.on('tool(ZfbawsFilter)', function (obj) {
                    var data = obj.data;
                    myData = data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.fjcsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.fjcsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                //监听单元格编辑
                table.on('edit(ZfbawsFilter)', function (obj) {
                    editValue(obj);
                });
            });

        });
        //此方法用来获取生成的表格中的数据
        function querySupervisionItem() {
            var url = basePath + '/pub/wsgldy/queryAjwsParamlistOrder'
            $.post(url, function (result) {
                if (result.code == '0') {
                    zfwsTableData = result.rows;
                    table.reload('table', {data: zfwsTableData});
                }
            }, 'json');
        }
        //通过编辑框监听事件获取修改后的值,然后将页面修改后的值替换表格中的值
        function editValue(obj) {
            var value = obj.value //得到修改后的值
                    , data = obj.data //得到所在行所有键值
                    , field = obj.field; //得到字段
            for (var i = 0; i < zfwsTableData.length; i++) {
                if (zfwsTableData[i].fjcsid == data.fjcsid) {
                    zfwsTableData[i].fjcspx = obj.value;
                }
            }
        }
        function queding() {
            var url = basePath + '/pub/wsgldy/saveZfwsOrder';
            var v_mygrid_rows = $.toJSON(zfwsTableData);
            var formData = {
                ajzfwsorderlist: v_mygrid_rows
            };
            $.post(url, formData, function (result) {
                result = $.parseJSON(result);
                if (result.code == '0') {
                    layer.msg('保存成功', {time: 500}, function () {
                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                        window.parent.location.reload(); //刷新父页面
                    });
                } else {
                    layer.open({
                        title: '提示'
                        , content: '保存失败' + result.msg
                    });
                }
            });
        }


        function endEditing() {
            if (editIndex == undefined) {
                return true
            }
            if (mygrid.datagrid('validateRow', editIndex)) {
                mygrid.datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function myonClickRow(index) {
            if (editIndex != index) {
                if (endEditing()) {
                    mygrid.datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    mygrid.datagrid('selectRow', editIndex);
                }
            }
        }
        function append() {
            if (endEditing()) {
                mygrid.datagrid('appendRow', {status: 'P'});
                editIndex = v_mygrid.datagrid('getRows').length - 1;
                mygrid.datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
            }
        }
        function removeit() {
            if (editIndex == undefined) {
                return
            }
            mygrid.datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
            editIndex = undefined;
        }
        function accept() {
            if (endEditing()) {
                mygrid.datagrid('acceptChanges');
            }
        }
        function reject() {
            mygrid.datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges() {
            var rows = v_mygrid.datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }

    </script>

</head>
<body>
<div class="layui-fluid">
    <div class="layui-colla-content layui-show">
        <input type="hidden" id="ajzfwsorderlist" name="ajzfwsorderlist" value="选择的数据"/>

        <div style="text-align:center; width:100%;height:100%;margin:0px;">
            <div class="layui-input-inline" style="width: 100px">
                <a href="javascript:void(0)" class="layui-btn"
                   iconCls="icon-search" onclick="queding()">保存 </a>
            </div>
        </div>
    </div>
    <table class="layui-hide" id="table" lay-filter="ZfbawsFilter"></table>
</div>
</body>
</html>