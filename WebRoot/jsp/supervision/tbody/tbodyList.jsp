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
    <title>表格样式设置</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var grid;
        var form;
        var table;
        var layer;
        var selectNodes;
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            initData();
        });
        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/supervision/checkTbodyinfo/getTbodyinfoList'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }, response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'tbodytype', title: '表格类别', event: 'trclick'}
                        , {
                            field: 'tbodycode', title: '计划类别'
                            , templet: function (d) {
                                if (d.tbodycode == "0") {
                                    return '<span style="color:blue">量化</span>';
                                } else if (d.tbodycode == "1") {
                                    return '<span style="color:blue">日常</span>';
                                }
                                else {
                                    return '<span style="color:blue">日常</span>';
                                }
                            }, event: 'trclick'
                        }
                        , {
                            field: '', title: '表尾信息',
                            templet: function (d) {
                                return "<a  onclick='viewTbdoy(" + d.tbodyid + ")'>111</a>";
//                                return null;
                            },
                            event: 'trclick'
                        }
                    ]]
                    ,done:function (res, curr, count) {
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.tbodyid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.tbodyid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    saveTbdoyinfo: function () { // 添加
                        saveTbdoyinfo();
                    }
                    , editTbdoyinfo: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的项目内容信息！');
                        } else {
                            editTbdoyinfo(table.singleData);
                        }
                    }
                    , viewTbdoyinfo: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的项目内容信息！');
                        } else {
                            viewTbdoyinfo(table.singleData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            })
        }

        // 新增项目内容
        function saveTbdoyinfo() {
            sy.modalDialog({
                title: '新增项目内容'
                , area: ['100%', '100%']
                , content: basePath + '/supervision/checkTbodyinfo/tosaveTbodyInfo'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        //编辑项目内容
        function editTbdoyinfo(singleData) {
            var row = singleData;
            if (row) {
                sy.modalDialog({
                    title: '编辑项目内容'
                    , area: ['100%', '100%']
                    , content: basePath + '/supervision/checkTbodyinfo/tosaveTbodyInfo?op=edit&tbodyid=' + row.tbodyid
                    , btn: ['保存', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].submitForm();
                    }
                }, closeModalDialogCallback);
            }
        }

        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                table.singleData = '';
                selectTableDataId = '';
                //其他在本页刷新
                var curent=$(".layui-laypage-skip input[class='layui-input']").val();
                //刷新的时候显示进度条
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('roleTable', {url: basePath + '/supervision/checkTbodyinfo/getTbodyinfoList', page: {
                    curr: curent
                },done:function () {
                    layer.close(mask);
                }});
            }else{
                table.singleData = '';
                selectTableDataId = '';
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('roleTable', {url: basePath + '/supervision/checkTbodyinfo/getTbodyinfoList', page: {
                    curr: 1 //重新从第 1 页开始
                },done:function () {
                    layer.close(mask);
                }});
            }
        }

        //查看
        function viewTbdoyinfo(singleData) {
            var row = singleData;
            if (row) {
                sy.modalDialog({
                    title: '查看项目内容'
                    , area: ['100%', '100%']
                    , content: basePath + '/supervision/checkTbodyinfo/tosaveTbodyInfo?op=view&tbodyid=' + row.tbodyid
                    , btn: ['关闭'] //可以无限个按钮

                });
            }
        }

        //查看表格各种信息
        function viewTbdoy(value) {
            sy.modalDialog({
                title: '查看项目内容'
                , area: ['100%', '100%']
                , content: basePath + '/supervision/checkTbodyinfo/toTbodyInfo?op=view&tbodyid=' + value
                , btn: ['关闭'] //可以无限个按钮
            });
        }
        ;
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="saveTbdoyinfo">
                <button class="layui-btn" data-type="saveTbdoyinfo" data="btn_saveTbdoyinfo">增加</button>
            </ck:permission>
            <ck:permission biz="editTbdoyinfo">
                <button class="layui-btn" data-type="editTbdoyinfo" data="btn_editTbdoyinfo">编辑</button>
            </ck:permission>
            <ck:permission biz="viewTbdoyinfo">
                <button class="layui-btn" data-type="viewTbdoyinfo" data="btn_viewTbdoyinfo">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>