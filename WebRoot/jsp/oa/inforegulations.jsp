<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
String contextPath = request.getContextPath();
String newsid = StringHelper.showNull2Empty(request.getParameter("newsid"));
String basePath = GlobalConfig.getAppConfig("apppath");
if (null == basePath || "".equals(basePath)) {
basePath = request.getScheme() + "://" + request.getServerName() + ":"
+ request.getServerPort() + request.getContextPath() + "/";
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>信息上报数量设置管理页面</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var v_adopt = [{"id":"1","text":"局采用"},{"id":"2","text":"省市采用"}];
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var selectNodes;

        $(function () {
            initData();
            //监听提交
            $("#btn_query").click(function () {
                query();
                return false;
            })
            $("#btn_reset").click(function () {
                reset();
                return false;
            })

        });

        function initData() {
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#Inforegulationstable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/inforegulations/queryInforegulationss'
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
                    {field: 'id', width: "20.0%", title: '主键id', event: 'trclick'},
                    {field: 'orgname', width: "20.0%", title: '组织机构', event: 'trclick'},
                    {field: 'yearnumber', width: "20.0%", title: '年数量', event: 'trclick'},
                    {field: 'monthnumber', width: "20.0%", title: '月数量', event: 'trclick'},
                    {field: 'localdistinction', width: "20.0%", title: '采用部门'
                        , templet: function (d) {
                    if (d.localdistinction == "1") {
                        return '<span style="color:blue;">局采用</span>';
                    } else if (d.localdistinction == "2") {
                        return '<span style="color:red;">省市采用</span>';
                    } else {
                        return '';
                    }
                }
                        ,event: 'trclick'},

                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(InforegulationsFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.id) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.id;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                        addInforegulations: function () { // 添加
                            addInforegulations();
                        },
                        editInforegulations: function () { // 修改
                            if (!table.singleData) {
                                layer.alert('请选择要修改的信息上报数量设置！');
                            } else {
                                    editInforegulations(table.singleData);
                            }
                        },
                        viewInforegulations: function () { // 修改
                            if (!table.singleData) {
                                layer.alert('请选择要查看的信息上报数量设置！');
                            } else {
                                    viewInforegulations(table.singleData.id);
                            }
                        },
                        deleteInforegulations: function () { // 修改
                            if (!table.singleData) {
                                layer.alert('请选择要删除的信息上报数量设置！');
                            } else {
                                    deleteInforegulations(table.singleData.id);
                            }
                        },

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
            });
        }

            //增加
            function addInforegulations (){
                sy.modalDialog({
                    title: '增加信息上报数量设置'
                    , area: ['100%', '100%']
                    , content: basePath + '/inforegulations/addInforegulationsIndex'
                    , btn: ['保存', '取消']
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);

            }
            //修改
            function editInforegulations (data){
                var id=data.id;
                var orgname=data.orgname
                sy.modalDialog({
                    title: '修改信息上报数量设置'
                    , area: ['100%', '100%']
                    , content: basePath + '/inforegulations/addInforegulationsIndex?id=' + id + '&op=edit'
                    , btn: ['保存', '取消']
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);

            }
            //查看
            function viewInforegulations (id){
                sy.modalDialog({
                    title: '查看信息上报数量设置'
                    , area: ['100%', '100%']
                    , content: basePath + '/inforegulations/addInforegulationsIndex?op=view&id=' + id
                    , btn: ['保存', '取消']
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);

            }
            //删除
            function deleteInforegulations (id){
                layer.open({
                    title: '警告'
                    , content: '你确定要删除该项记录么？'
                    , icon: 3
                    , btn: ['确定', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        $.post(basePath + 'pcompany/delPcompany', {
                                    comid: comid
                                },
                                function (result) {
                                    if (result.code == '0') {
                                        //保证不会重复删除
                                        table.singleData = '';
                                        selectTableDataId = '';
                                        //本页的值
                                        var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                        layer.msg('删除成功', {time: 1000}, function () {
                                            //如果是本页最后一条数据 则返回上一页
                                            if (table.cache.Inforegulationstable.length == 1) {
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
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);

            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                refresh('', '');
            }
        }

        // 刷新
        function refresh(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('Inforegulationstable', {
                url: basePath + '/inforegulations/queryInforegulationss'
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

        function query() {
            table.singleData = '';
            selectTableDataId = '';
            var orgid = $('#orgid').val();
            var param = {
                'orgid': orgid
            };
            table.reload('Inforegulationstable', {
                url: basePath + '/inforegulations/queryInforegulationss'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

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
<div class="layui-margin-top-15">
    <div class="layui-btn-group demoTable">
                    <button class="layui-btn" data-type="addInforegulations" data="btn_addInforegulations">增加</button>
                                <button class="layui-btn" data-type="editInforegulations" data="btn_editInforegulations">修改</button>
                                <button class="layui-btn" data-type="viewInforegulations" data="btn_viewInforegulations">查看</button>
                            <button class="layui-btn layui-btn-danger" data-type="deleteInforegulations" data="btn_deleteInforegulations">删除</button>
                </div>
    <table class="layui-hide" id="Inforegulationstable" lay-filter="InforegulationsFilter"></table>
</div>

</body>
</html>

