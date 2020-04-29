<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    // 检查计划id
    String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));
%>
<!DOCTYPE html>
<html>
<head>

    <title>派发任务</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>

    <script type="text/javascript">
        var url;
        var form;
        var layer;
        var table;
        var selectTableDataId1 = '';
        var selectNodes1;
        var selectTableDataId2 = '';
        var selectNodes2;
        var comgridTableData;// 公司表
        var selectTableDataId3 = '';
        var selectNodes3;
        var rygridTableData// 人员表
        $(function () {

            // 分派任务
            layui.use(['form', 'layer', 'table'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                url = basePath + 'supervision/queryTaskList';
                table.render({
                    title: '任务列表'
                    , elem: '#taskgrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: url
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , where: {planid: '<%=v_planid%>'}
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'taskname', title: '任务名称', event: 'trclick'}
                        , {field: 'taskremark', title: '任务描述', event: 'trclick'}
                        , {field: 'tasktimest', title: '开始时间', event: 'trclick'}
                        , {field: 'tasktimeed', title: '结束时间', event: 'trclick'}
                        , {field: 'aaa011', title: '创建人', event: 'trclick'}
                        , {field: 'aae036', title: '创建时间', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(taskgr)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId1 != data.taskid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.taskid;
                            var v_taskid = data.taskid;
                            querySupervisionItem(v_taskid); // 加载检查项
                            $("#taskid").val(v_taskid);
                            $("#taskname").val(data.taskname); // 任务名称
                            $("#taskremark").val(data.taskremark); // 任务描述
                            $("#tasktimest").val(data.tasktimest); // 任务开始时间
                            $("#tasktimeed").val(data.tasktimeed); // 任务结束时间
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                            $("#taskid").val('');
                            $("#taskname").val(''); // 任务名称
                            $("#taskremark").val(''); // 任务描述
                            $("#tasktimest").val(''); // 任务开始时间
                            $("#tasktimeed").val(''); // 任务结束时间
                        }
                    }
                });
                var $ = layui.$, active = {
                    addTask: function () { // 添加任务
                        addTask();
                    }
                    , deleteTask: function () { // 删除任务
                        if (!table.singleData1) {
                            parent.layer.alert('请选择要删除的任务！');
                        } else {
                            deleteTask(table.singleData1.taskid);
                        }
                    }
                    , showTask: function () { // 查看任务
                        if (!table.singleData1) {
                            parent.layer.alert('请选择要查看的任务！');
                        } else {
                            showTask(<%=v_planid%>, table.singleData1.taskid);
                        }
                    }
                    , editTask: function () { // 编辑任务
                        if (!table.singleData1) {
                            parent.layer.alert('请选择要编辑的任务！');
                        } else {
                            editTask(<%=v_planid%>, table.singleData1.taskid);
                        }
                    }
                    , addSupervisionCom: function () { // 添加检查公司
                        if (!table.singleData1) {
                            parent.layer.alert('请选择分派任务！');
                        } else {
                            addSupervisionCom('<%=v_planid%>');
                        }
                    }
                    , addSupervisionRy: function () { // 添加检查人员
                        if (!table.singleData1) {
                            parent.layer.alert('请选择分派任务！');
                        } else {
                            addSupervisionRy();
                        }
                    }
                    , comgrid_remove: function () { // 删除检查公司\人员
                        if (!table.singleData2) {
                            parent.layer.alert('请选择要删除项！');
                        } else {
                            mydatagrid_remove(table.singleData2.comid, 'table2');
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                    , rygrid_remove: function () { // 删除检查公司\人员
                        if (!table.singleData3) {
                            parent.layer.alert('请选择要删除项！');
                        } else {
                            mydatagrid_remove(table.singleData3.userid, 'table3')
                            table.singleData3 = '';
                            selectTableDataId3 = '';
                        }
                    }
                };
                table.render({
                    title: '检查公司设置'
                    , elem: '#comgrid'
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
                        {field: 'commc', width: 200, title: '公司名称', event: 'trclick2'}
                        , {field: 'comdz', width: 203, title: '公司地址', event: 'trclick2'}
                    ]]
                });
                // 监听工具条
                table.on('tool(comgr)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.comid) {
                            // 清除所有行的样式
                            $($("#comgrid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#comgrid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData2 = data;
                            selectTableDataId2 = data.comid;
                        } else { // 再次选中清除样式
                            $("#comgrid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });

                table.render({
                    title: '计划检查人员设置'
                    , elem: '#rygrid'
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
                        {field: 'username', width: 200, title: '姓名', event: 'trclick3'}
                        , {field: 'orgname', width: 203, title: '所属部门', event: 'trclick3'}
                    ]]
                });
                // 监听工具条
                table.on('tool(rygr)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick3') { // 选中行
                        if (selectTableDataId3 != data.userid) {
                            // 清除所有行的样式
                            $($("#rygrid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#rygrid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData3 = data;
                            selectTableDataId3 = data.userid;
                        } else { // 再次选中清除样式
                            $("#rygrid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData3 = '';
                            selectTableDataId3 = '';
                        }
                    }
                });
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        })
        ;

        // 添加任务
        function addTask() {
            url = '<%=basePath%>supervision/taskFormIndex';
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增任务'
                , content: url
                , param: {
                    planid: "<%=v_planid%>"
                }
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        }
        // 查看任务
        function showTask(planid, taskid) {
            url = '<%=basePath%>supervision/taskFormIndex';
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '查看任务'
                , content: url
                , param: {
                    planid: planid,
                    taskid: taskid,
                    op: "view"
                }
                , btn: ['关闭'] //可以无限个按钮
            }, closeModalDialogCallback1);
        }

        // 编辑任务
        function editTask(planid, taskid) {
            url = '<%=basePath%>supervision/taskFormIndex';
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '编辑任务'
                , content: url
                , param: {
                    planid: planid,
                    taskid: taskid
                }
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback1);
        }

        // 删除任务
        function deleteTask(taskid) {
            url = basePath + 'supervision/deleteTask';
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要删除该任务吗'
                , btn1: function (index, layero) {
                    $.post(url, {
                                taskid: taskid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        table.singleData1 = '';
                                        selectTableDataId1 = '';
                                        table.reload('taskgrid', {url: basePath + 'supervision/queryTaskList'});
                                        table.reload('rygrid', {data: null});
                                        table.reload('comgrid', {data: null});
                                    });
                                } else {
                                    layer.msg('删除失败' + result.msg, {time: 1000});
                                }
                            },
                            'json');
                    layer.close(index);
                }

            });
        }

        // 查询检查项
        function querySupervisionItem(v_taskid) {
            var param = {
                'taskid': v_taskid
            };
            // 检查公司
            url = basePath + 'supervision/querySupervisionCompany';
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    comgridTableData = result.rows;
                    table.reload('comgrid', {data: comgridTableData});
                }
            }, 'json');

            // 检查人员
            url = basePath + 'supervision/querySupervisionPerson';
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    rygridTableData = result.rows;
                    table.reload('rygrid', {data: rygridTableData});
                }
            }, 'json');
        }

        // 添加检查人员
        function addSupervisionRy() {
            url = "<%=basePath%>jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '添加检查人员'
                , content: url
                , param: {
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback3);
        }

        // 添加检查单位
        function addSupervisionCom(planid) {
            url = "<%=basePath%>supervision/selComByPlanIndex";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '添加检查公司'
                , content: url
                , param: {
                    planid: planid,
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback2);
        }

        //任务子页面返回参数
        function closeModalDialogCallback1(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            parent.sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                table.singleData1 = '';
                selectTableDataId1 = '';
                table.reload('taskgrid', {url: basePath + 'supervision/queryTaskList'});
//                window.location.reload();
            }
        }
        //检查公司子页面返回参数
        function closeModalDialogCallback2(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                var retData = obj.data;
                var loadData = comgridTableData.concat(retData); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < retData.length; i++) {
                    for (var j = 0; j < comgridTableData.length; j++) {
                        if (retData[i].comid == comgridTableData[j].comid) {
                            loadData.remove(retData[i]); // 去除重复的数据
                        }
                    }
                }
                comgridTableData = loadData;
                table.reload('comgrid', {data: loadData});
            }
        }
        //检查人员子页面返回参数
        function closeModalDialogCallback3(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            parent.sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                var retData = obj.data;
                var loadData = rygridTableData.concat(retData); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < retData.length; i++) {
                    for (var j = 0; j < rygridTableData.length; j++) {
                        if (retData[i].userid == rygridTableData[j].userid) {
                            loadData.remove(retData[i]); // 去除重复的数据
                        }
                    }
                }
                rygridTableData = loadData;
                table.reload('rygrid', {data: loadData});
            }
        }

        //保存
        function save() {
            layer.open({
                title: '提示!'
                , btn: ['确定', '取消']
                , content: '您确定要保存修改吗?'
                , btn1: function (index, layero) {
                    url = basePath + 'supervision/saveSuperVisionItem';

                    var comgrid_rows = $.toJSON(comgridTableData);
                    var rygrid_rows = $.toJSON(rygridTableData);
                    var taskid = $('#taskid').val();
                    var planid = $('#planid').val();
                    var taskname = $('#taskname').val();
                    var taskremark = $('#taskremark').val();
                    var tasktimest = $('#tasktimest').val();
                    var tasktimeed = $('#tasktimeed').val();
                    var param = {
                        'comgrid_rows': comgrid_rows,
                        'rygrid_rows': rygrid_rows,
                        'taskid': taskid,
                        'planid': planid,
                        'taskname': taskname,
                        'taskremark': taskremark,
                        'tasktimest': tasktimest,
                        'tasktimeed': tasktimeed
                    }
                    $.post(url, param, function (result) {
                                if (result.code == '0') {
                                    layer.msg('保存成功', {time: 1000}, function () {
                                        window.location.reload();
                                    });
                                } else {
                                    layer.msg('保存失败' + result.msg);
                                }
                            },
                            'json');
                }
            })
        }

        //删除一行
        function mydatagrid_remove(data, type) {

            if (type == 'table2') {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除该企业吗?'
                    , btn1: function (index, layero) {
                        var i = comgridTableData.length;
                        for (var j = 0; j < comgridTableData.length; j++) {
                            if (data == comgridTableData[j].comid) {
                                comgridTableData.remove(comgridTableData[j]); // 去除数据
                            }
                        }
                        if (comgridTableData.length < i) {
                            layer.msg('删除成功,记得保存哦!', {time: 1000}, function () {
                                table.reload('comgrid', {data: comgridTableData});
                            })
                        } else {
                            layer.msg('删除成功', {time: 500});
                        }

                    }
                })
            } else if (type == 'table3') {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '您确定要删除该人员吗?'
                    , btn1: function (index, layero) {
                        var i = rygridTableData.length;
                        for (var j = 0; j < rygridTableData.length; j++) {
                            if (data == rygridTableData[j].userid) {
                                rygridTableData.remove(rygridTableData[j]); // 去除数据
                            }
                        }
                        if (rygridTableData.length < i) {
                            layer.msg('删除成功,记得保存哦!', {time: 1000}, function () {
                                table.reload('rygrid', {data: rygridTableData});
                            })
                        } else {
                            layer.msg('删除失败', {time: 500})
                        }

                    }
                })
            }
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <input type="hidden" id="planid" name="planid" value="<%=v_planid%>"/>
    <input type="hidden" id="taskid" name="taskid"/>
    <input type="hidden" id="taskname" name="taskname"/>
    <input type="hidden" id="taskremark" name="taskremark"/>
    <input type="hidden" id="tasktimest" name="tasktimest"/>
    <input type="hidden" id="tasktimeed" name="tasktimeed"/>

    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addTask">
                <button class="layui-btn" data-type="addTask" data="btn_addTask">添加任务</button>
            </ck:permission>
            <ck:permission biz="deleteTask">
                <button class="layui-btn layui-btn-danger" data-type="deleteTask" data="btn_deleteTask">
                    删除任务
                </button>
            </ck:permission>
            <ck:permission biz="showTask">
                <button class="layui-btn" data-type="showTask" data="btn_showTask">查看任务
                </button>
            </ck:permission>
            <ck:permission biz="editTask">
                <button class="layui-btn" data-type="editTask" data="btn_editTask">编辑任务
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="taskgrid" lay-filter="taskgr"></table>
    </div>
    <div class="layui-container">
        <div class="layui-margin-top-15">
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                        <div class="layui-input-inline" style="width: 95%">
                            <input type="hidden" id="comgrid_rows" name="comgrid_rows" value="检查企业"/>

                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="addSupervisionCom">
                                    <button class="layui-btn" data-type="addSupervisionCom"
                                            data="btn_addSupervisionCom">添加检查公司
                                    </button>
                                </ck:permission>
                                <ck:permission biz="comgrid_remove">
                                    <button class="layui-btn layui-btn-danger" data-type="comgrid_remove"
                                            data="btn_comgrid_remove">删除
                                    </button>
                                </ck:permission>
                            </div>
                            <table class="layui-hide" id="comgrid" lay-filter="comgr"></table>
                        </div>
                    </div>
                    <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                        <div class="layui-input-inline" style="width: 95%">
                            <input type="hidden" id="rygrid_rows" name="rygrid_rows" value="检查人员"/>

                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="addSupervisionRy">
                                    <button class="layui-btn" data-type="addSupervisionRy"
                                            data="btn_addSupervisionRy">添加检查人员
                                    </button>
                                </ck:permission>
                                <ck:permission biz="rygrid_remove">
                                    <button class="layui-btn layui-btn-danger" data-type="rygrid_remove"
                                            data="btn_rygrid_remove">
                                        删除
                                    </button>
                                </ck:permission>
                            </div>
                            <table class="layui-hide" id="rygrid" lay-filter="rygr"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>