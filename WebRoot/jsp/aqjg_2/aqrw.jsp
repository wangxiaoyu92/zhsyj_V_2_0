<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>安全检查</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayui" value="false"/>
    </jsp:include>
    <script type="text/javascript">

        var selectTaskid;
        var selectPlanid;
        var selectComid;
        var form;
        var layer;
        var table;
        var mask;

        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#grid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + "/aqgl/queryjcrw"
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
                        {field: 'plantitle', width: 220, title: '计划标题', event: 'trclick'}
                        , {field: 'commc', width: 200, title: '企业名称', event: 'trclick'}
                        , {field: 'taskname', width: 150, title: '任务名称', event: 'trclick'}
                        , {field: 'taskremark', width: 170, title: '任务描述', event: 'trclick'}
                        , {field: 'aaa011', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'tasktimest', width: 200, title: '任务开始时间', event: 'trclick'}
                        , {field: 'tasktimeed', width: 200, title: '任务结束时间', event: 'trclick'}
                        , {field: 'datetime', width: 80, title: '经办时间', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTaskid = selectPlanid = selectComid = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(grid)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTaskid != data.taskid || selectPlanid != data.planid || selectComid != data.comid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");

                            table.singleData = data;
                            selectTaskid = data.taskid;
                            selectPlanid = data.planid;
                            selectComid = data.comid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTaskid = selectPlanid = selectComid = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    zxjc: function () {
                        if (!table.singleData) {
                            layer.alert('请先选择相应的企业！');
                        } else {
                            checkhis(table.singleData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        });
        /*grid=$("#grid").datagrid({
         // title:'采集信息查询',
         url: basePath +"/aqgl/queryjcrw",
         iconCls:'icon-ok',
         height:450,
         pageSize:10,
         pageList:[10,20,30],
         nowrap:true,//True 就会把数据显示在一行里
         striped:true,//奇偶行使用不同背景色
         collapsible:true,
         singleSelect:true,//True 就会只允许选中一行
         fit:false,//让DATAGRID自适应其父容器
         fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
         pagination:true,//底部显示分页栏
         rownumbers:true,//是否显示行号
         loadMsg:'数据加载中,请稍后...',
         columns:[[
         {
         title:'任务id',
         field:'taskid',
         align:'left',
         width:100,
         hidden : true
         },{
         title:'计划id',
         field:'planid',
         align:'left',
         width:100,
         hidden : true
         },{
         title:'统筹区',
         field:'aaa027',
         align:'left',
         width:100,
         hidden : true
         },{
         title:'AAZ093',
         field:'aaz093',
         align:'left',
         width:100,
         hidden : true
         },{
         title:'企业id',
         field:'comid',
         align:'left',
         width:100 ,
         hidden : true
         },{ title:'企业类型',
         field:'comdalei',
         align:'left',
         width:100,
         hidden :true
         },{
         title:'计划标题',
         field:'plantitle',
         align:'left',
         width:200
         },{
         title:'计划类型',
         field:'plantype',
         align:'left',
         width:100,
         hidden : true
         },{
         title:'企业名称',
         field:'commc',
         align:'left',
         width:200
         },{
         title:'任务名称',
         field:'taskname',
         align:'left',
         width:150
         },{
         title:'任务描述',
         field:'taskremark',
         align:'left',
         width:150
         },{
         title:'经办人',
         field:'aaa011',
         align:'left',
         width:100
         },{
         title:'任务开始时间',
         field:'tasktimest',
         align:'left',
         width:100
         },{
         title:'任务结束时间',
         field:'tasktimeed',
         align:'left',
         width:100
         },{
         title:'经办时间',
         field:'datetime',
         align:'left',
         width:100
         }
         ]]
         });
         })*/
        //新增检查
        var checkterm = function (row) {
            if (row) {
                sy.modalDialog({
                    title: '现场检查',
                    area: ['100%', '100%'],
                    content: basePath + '/aqgl/jcxIndex?planid=' + row.planid + '&comid=' + row.comid + '&comdalei=' + row.comdalei + '&aaa027=' + row.aaa027 + '&aaz093=' + row.aaz093,
                    btn: ['确定', '取消'],
                    btn1: function () {

                    }
                });
            } else {
                layer.alert('请先选择要查看的信息！');
            }
        };
        //检查历史
        var checkhis = function (row) {
            sy.modalDialog({
                title: '现场检查',
                type: 2,
                area: ['100%', '100%'],
                param: {
                    'planid': row.planid,
                    'comid': row.comid,
                    'comdalei': row.comdalei,
                    'aaa027': row.aaa027,
                    'aaz093': row.aaz093
                },
                content: basePath + '/aqgl/jclsIndex',
                btn: ['关闭']
            });
        };
    </script>
</head>

<body>

<%--<div id="toolbar">
    <sicp3:groupbox title="任务列表">
        <table>
            <tr>
                <!-- <td><a href="javascript:void(0)" class="easyui-linkbutton"
                    data="btn_aqrwIndex" iconCls="icon-add" plain="true"
                    onclick=" checkterm()">检查</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td> -->
                <td><a href="javascript:void(0)" class="easyui-linkbutton"
                       data="btn_aqrwIndex" iconCls="icon-edit" plain="true"
                       onclick="checkhis()">执行检查</a></td>
                <td>
                    <div class="datagrid-btn-separator"></div>
                </td>

            </tr>
        </table>
    </sicp3:groupbox>
</div>--%>
<div class="layui-margin-top-15">
    <div class="layui-btn-group demoTable">
        <ck:permission biz="zxjc">
            <button class="layui-btn" data-type="zxjc" data="btn_zxjc">执行检查</button>
        </ck:permission>
    </div>
    <div class="layui-hide" id="grid" lay-filter="grid"></div>
</div>

</body>
</html>
