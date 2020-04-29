<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>审批企业导入</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var importGrid; // 导入数据表格
        var errorDataGrid; // 错误数据表格
        var table;
        var layer;

        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#importGrid'
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
                        {field: 'orderno', width: 220, title: '序号', event: 'trclick'}
                        , {field: 'comqyxz', width: 100, title: '经济性质', event: 'trclick'}
                        , {field: 'commc', width: 200, title: '经营者姓名', event: 'trclick'}
                        , {field: 'comyyzzh', width: 150, title: '营业执照号', event: 'trclick'}
                        , {field: 'comfrhyz', width: 170, title: '法定代表人/业主', event: 'trclick'}
                        , {field: 'frhyzzs', width: 150, title: '住所', event: 'trclick'}
                        , {field: 'comdz', width: 100, title: '经营场所', event: 'trclick'}
                        , {field: 'comzmj', width: 200, title: '经营面积', event: 'trclick'}
                        , {field: 'comxkzztyt', width: 200, title: '主体业态', event: 'trclick'}
                        , {field: 'comxkfw', width: 80, title: '经营项目', event: 'trclick'}
                        , {field: 'comdmlx', width: 80, title: '经营类别', event: 'trclick'}
                        , {field: 'comxkzbh', width: 150, title: '许可证号', event: 'trclick'}
                        , {field: 'orgname', width: 150, title: '监管机构', event: 'trclick'}
                        , {field: 'comrcjdglry', width: 100, title: '监管人员', event: 'trclick'}
                        , {field: 'comxkyxqq', width: 100, title: '发证日期', event: 'trclick'}
                        , {field: 'comxkyxqz', width: 100, title: '有效期至', event: 'trclick'}
                        , {field: 'xkzorg', width: 100, title: '发证机关', event: 'trclick'}
                        , {field: 'comyddh', width: 100, title: '联系电话', event: 'trclick'}
                        , {field: 'comslrq', width: 100, title: '受理日期', event: 'trclick'}
                    ]]
                });
                table.render({
                    elem: '#errorDataGrid'
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
                        {field: 'orderno', width: 220, title: '序号', event: 'trclick'}
                        , {field: 'comqyxz', width: 100, title: '经济性质', event: 'trclick'}
                        , {field: 'commc', width: 200, title: '经营者姓名', event: 'trclick'}
                        , {field: 'comyyzzh', width: 150, title: '营业执照号', event: 'trclick'}
                        , {field: 'comfrhyz', width: 170, title: '法定代表人/业主', event: 'trclick'}
                        , {field: 'frhyzzs', width: 150, title: '住所', event: 'trclick'}
                        , {field: 'comdz', width: 100, title: '经营场所', event: 'trclick'}
                        , {field: 'comzmj', width: 200, title: '经营面积', event: 'trclick'}
                        , {field: 'comxkzztyt', width: 200, title: '主体业态', event: 'trclick'}
                        , {field: 'comxkfw', width: 80, title: '经营项目', event: 'trclick'}
                        , {field: 'comdmlx', width: 80, title: '经营类别', event: 'trclick'}
                        , {field: 'comxkzbh', width: 150, title: '许可证号', event: 'trclick'}
                        , {field: 'orgname', width: 150, title: '监管机构', event: 'trclick'}
                        , {field: 'comrcjdglry', width: 100, title: '监管人员', event: 'trclick'}
                        , {field: 'comxkyxqq', width: 100, title: '发证日期', event: 'trclick'}
                        , {field: 'comxkyxqz', width: 100, title: '有效期至', event: 'trclick'}
                        , {field: 'xkzorg', width: 100, title: '发证机关', event: 'trclick'}
                        , {field: 'comyddh', width: 100, title: '联系电话', event: 'trclick'}
                        , {field: 'comslrq', width: 100, title: '受理日期', event: 'trclick'}
                    ]]
                });
            })
            /*importGrid = $('#importGrid').datagrid({
             toolbar : '#toolbar',
             striped : true,// 奇偶行使用不同背景色
             nowrap : true,// True数据长度超出列宽时将会自动截取
             singleSelect : false,// True只允许选中一行
             checkOnSelect : false,
             selectOnCheck : false,
             pagination : false,// 底部显示分页栏
             pageSize : 10,
             pageList : [ 10, 20, 30 ],
             rownumbers : true,// 是否显示行号
             fitColumns : false,// 列自适应宽度
             idField: 'orderno', //该列是一个唯一列
             sortOrder: 'asc',
             columns : [ [{
             width : '80',
             title : '序号',
             field : 'orderno',
             hidden : false
             },{
             width : '200',
             title : '经济性质',
             field : 'comqyxz',
             hidden : false
             },{
             width : '200',
             title : '经营者姓名',
             field : 'commc',
             hidden : false
             },{
             width : '100',
             title : '营业执照号',
             field : 'comyyzzh',
             hidden : false
             },{
             width : '120',
             title : '法定代表人/业主',
             field : 'comfrhyz',
             hidden : false
             },{
             width : '150',
             title : '住所',
             field : 'frhyzzs',
             hidden : false
             },{
             width : '200',
             title : '经营场所',
             field : 'comdz',
             hidden : false
             },{
             width : '90',
             title : '经营面积',
             field : 'comzmj',
             hidden : false
             },{
             width : '150',
             title : '主体业态',
             field : 'comxkzztyt',
             hidden : false
             },{
             width : '100',
             title : '经营项目',
             field : 'comxkfw',
             hidden : false
             },{
             width : '150',
             title : '经营类别',
             field : 'comdmlx',
             hidden : false
             },{
             width : '100',
             title : '许可证号',
             field : 'comxkzbh',
             hidden : false
             },{
             width : '150',
             title : '监管机构',
             field : 'orgname',
             hidden : false
             },{
             width : '150',
             title : '监管人员',
             field : 'comrcjdglry',
             hidden : false
             },{
             width : '100',
             title : '发证日期',
             field : 'comxkyxqq',
             hidden : false
             },{
             width : '100',
             title : '有效期至',
             field : 'comxkyxqz',
             hidden : false
             },{
             width : '100',
             title : '发证机关',
             field : 'xkzorg',
             hidden : false
             },{
             width : '100',
             title : '联系电话',
             field : 'comyddh',
             hidden : false
             },{
             width : '100',
             title : '受理日期',
             field : 'comslrq',
             hidden : false
             }] ]
             });*/

            /*errorDataGrid = $('#errorDataGrid').datagrid({
             toolbar : '#toolbar2',
             striped : true,// 奇偶行使用不同背景色
             nowrap : false,// True数据长度超出列宽时将会自动截取
             singleSelect : false,// True只允许选中一行
             checkOnSelect : false,
             selectOnCheck : false,
             pagination : false,// 底部显示分页栏
             pageSize : 10,
             pageList : [ 10, 20, 30 ],
             rownumbers : true,// 是否显示行号
             fitColumns : false,// 列自适应宽度
             idField: 'orderno', //该列是一个唯一列
             sortOrder: 'asc',
             columns : [[{
             width : '80',
             title : '序号',
             field : 'orderno',
             hidden : false
             },{
             width : '200',
             title : '经济性质',
             field : 'comqyxz',
             hidden : false
             },{
             width : '200',
             title : '经营者姓名',
             field : 'commc',
             hidden : false
             },{
             width : '100',
             title : '营业执照号',
             field : 'comyyzzh',
             hidden : false
             },{
             width : '120',
             title : '法定代表人/业主',
             field : 'comfrhyz',
             hidden : false
             },{
             width : '150',
             title : '住所',
             field : 'frhyzzs',
             hidden : false
             },{
             width : '200',
             title : '经营场所',
             field : 'comdz',
             hidden : false
             },{
             width : '90',
             title : '经营面积',
             field : 'comzmj',
             hidden : false
             },{
             width : '150',
             title : '主体业态',
             field : 'comxkzztyt',
             hidden : false
             },{
             width : '100',
             title : '经营项目',
             field : 'comxkfw',
             hidden : false
             },{
             width : '150',
             title : '经营类别',
             field : 'comdmlx',
             hidden : false
             },{
             width : '100',
             title : '许可证号',
             field : 'comxkzbh',
             hidden : false
             },{
             width : '150',
             title : '监管机构',
             field : 'orgname',
             hidden : false
             },{
             width : '150',
             title : '监管人员',
             field : 'comrcjdglry',
             hidden : false
             },{
             width : '100',
             title : '发证日期',
             field : 'comxkyxqq',
             hidden : false
             },{
             width : '100',
             title : '有效期至',
             field : 'comxkyxqz',
             hidden : false
             },{
             width : '100',
             title : '发证机关',
             field : 'xkzorg',
             hidden : false
             },{
             width : '100',
             title : '联系电话',
             field : 'comyddh',
             hidden : false
             },{
             width : '100',
             title : '受理日期',
             field : 'comslrq',
             hidden : false
             },{
             width : '200',
             title : '错误信息',
             field : 'message',
             hidden : false
             }] ]
             });*/

            /*var pager = errorDataGrid.datagrid('getPager');// 得到datagrid的pager对象
             pager.pagination({
             showPageList:false,
             buttons:[{
             iconCls:'icon-excel',
             handler:function(){
             exportToExcel('上传的错误数据');
             }
             }]
             }); */
        });

        // 错误数据导出到excel
        function exportApproveToExcel(filename) {
            var rows = errorDataGrid;
            if (rows.length > 0) {
                var errorJsonStr = $.toJSON(rows);
                $('#fm').form('submit', {
                    url: basePath + '/pcompany/exportApproveToExcel?filename=' + filename + '&errorJsonStr=' + errorJsonStr,
                    onSubmit: function () {
                        // 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                        var isValid = $(this).form('validate');
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
        }

        // 下载模版
        function downLoadExcel() {
            $('#fm').form('submit', {
                url: basePath + '/pcompany/downLoadApproveExcel',
                onSubmit: function () {
                    var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    return isValid;
                },
                success: function (result) {
                    //
                }
            });
        }

        // 导入上传
        function upLoadApproveComExcel() {
            if (!checkFile()) {
                return;
            }
            //提交一个有效并且避免重复提交的表单
            $('#fm').form('submit', {
                url: basePath + '/pcompany/upLoadApproveComExcel',
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.msg('操作成功');
                        importGrid = $.parseJSON(result.succList).rows;
                        errorDataGrid = $.parseJSON(result.errorList).rows;
                        table.reload('importGrid', {data: importGrid});
                        table.reload('errorDataGrid', {data: errorDataGrid});
                    } else {
                        layer.msg('操作失败:' + result.msg);
                    }
                }
            });
        }

        //校验文件
        function checkFile() {
            var str = $('#filepath').val();
            if (str == "" || str == null) {
                layer.msg('请选择需要导入的文件!');
                return false;
            }
            if (str.substr(str.length - 4, 4) != ".xls") {
                $.messager.alert('提示', '上传文件格式必须为.xls!', 'error');
                $('#filepath').focus();
                $('#filepath').select();
                return false;
            }
            return true;
        }

        // 导入保存
        function saveApprovePcompanydr() {
            var rows = importGrid;
            if (rows.length > 0) {
                var succJsonStr = $.toJSON(rows);
                layer.confirm('确定保存吗?', function (r) {
                    if (r) {
                        //下面的例子演示了如何提交一个有效并且避免重复提交的表单
                        $.ajax({
                            cache: true,
                            type: "POST",
                            url: basePath + '/pcompany/saveApprovePcompanydr',
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
        }

        // 重置刷新
        function refresh() {
            $('#fm').form('clear');
            importGrid = ''
            errorDataGrid = ''
            table.reload('importGrid', {data: importGrid});
            table.reload('errorDataGrid', {data: errorDataGrid});
        }

        // 关闭窗口
        function closeWindow($dialog, $grid, $pjq) {
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
                    <th><a href="javascript:void(0);" onclick="downLoadExcel()">
                        <font color="red">下载模版文件</font>
                        <img src="<%=contextPath%>/images/frame/download.gif"/>
                    </a>
                    </th>
                    <tr>
                        <td style="text-align:right;">
                            <nobr>选择上传文件</nobr>
                        </td>
                        <td><input id="filepath" name="filepath" type="file"
                                   onchange="checkFile()" style="width:300px"/></td>
                        <td style="text-align:right;">
                            <a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm"
                               onclick="upLoadApproveComExcel();"> <i class="layui-icon">&#xe681;</i> 导 入 </a>
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
               onclick="saveApprovePcompanydr();"><i class="layui-icon">&#xe621;</i>保存</a>
            <div id="importGrid" class="layui-hide"></div>
        </div>
    </div>
</div>
<br/>

<div class="layui-collapse">
    <div class="layui-colla-item">
        <h2 class="layui-colla-title">上传的错误数据</h2>

        <div class="layui-colla-content layui-show">
            <a href="javascript:void(0);" class="layui-btn layui-btn-sm layui-btn-normal"
               onclick="exportApproveToExcel('上传的错误数据');"><i class="layui-icon">&#xe621;</i>导出</a>
            <div id="errorDataGrid" class="layui-hide"></div>
        </div>
    </div>
</div>
</body>
</html>
