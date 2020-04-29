<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_qtbid = StringHelper.showNull2Empty(request.getParameter("qtbid"));
    String v_fsxtbz = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fsxtbz")), "utf-8");//发送者系统级备注
    String v_opkind = StringHelper.showNull2Empty(request.getParameter("opkind"));//操作类型1报请2已阅
%>
<!DOCTYPE html>
<html>
<head>

    <title>待办事项</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var layer; // 弹出层
        var selectTableDataId = '';
        var selectNodes;
        var fsTableData;//报请表
        $(function () {
            layui.use(['table', 'layer'], function () {
                table = layui.table;
                layer = layui.layer;
                table.render({
                    elem: '#table'
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
                        {field: 'jsorgname', width: 250, title: '接收人所属机构名称', event: 'trclick'}
                        , {field: 'jsusername', width: 150, title: '接收人姓名', event: 'trclick'}
                        , {field: 'jssj', width: 200, title: '接收人已阅时间', event: 'trclick'}
                        , {field: 'jsclyj', width: 200, title: '接收人已阅回复', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(fsFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.jsuserid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jsuserid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                querySupervisionItem();
                var $ = layui.$, active = {
                    myselectAjdjXgry: function () {//添加文书
                        myselectAjdjXgry();
                    }
                    , mydatagrid_remove: function () {
                        mydatagrid_remove(table.singleData.jsuserid);
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });

            if ($('#qtbid').val().length > 0) {
                $.post(basePath + '/pub/pub/queryJieshourenDTO', {
                            qtbid: $('#qtbid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查询失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        }, 'json');
            }

            if ('<%=v_opkind%>' == '2') {
                $('form :input').addClass('input_readonly');
                $('form :input').attr('readonly', 'readonly');
                $('.Wdate').attr('disabled', true);
            }
            $("#fsnr").focus();
        });
        function querySupervisionItem() {
            var url = basePath + '/pub/pub/queryJieshouren';
            var param = {
                qtbid: '<%=v_qtbid%>'
            }
            $.post(url, param, function (result) {
                if (result.code == '0') {
                    fsTableData = result.rows;
                    table.reload('table', {data: fsTableData});
                }
            }, 'json');
        }
        //从单位信息表中读取
        function myselectAjdjXgry() {
            var url = basePath + "jsp/pub/pub/selectuser.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '选择接收人'
                , content: url
                , param: {
                    singleSelect: "false",
                    a: new Date().getMilliseconds()
                }
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var retData = obj.data;
                var a = [];
                for (var i = 0; i < retData.length; i++) {
                    a.push({
                        'jsuserid': retData[i].userid,
                        'jsusername': retData[i].username,
                        'jsorgid': retData[i].orgid,
                        'jsorgname': retData[i].orgname
                    });
                }
                var loadData = fsTableData.concat(a); // 用当前表格数据合并返回的数据
                /*console.log(loadData);*/
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < a.length; i++) {
                    for (var j = 0; j < fsTableData.length; j++) {
                        if (a[i].jsuserid == fsTableData[j].jsuserid) {
                            loadData.remove(a[i]); // 去除重复的数据
                        }
                    }
                }
                fsTableData = loadData;
                table.reload('table', {data: loadData});
            }
        }

        //删除一行
        function mydatagrid_remove(jsuserid) {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要删除该记录吗?'
                , btn1: function (index, layero) {
                    var i = fsTableData.length;
                    for (var j = 0; j < fsTableData.length; j++) {
                        if (jsuserid == fsTableData[j].jsuserid) {
                            fsTableData.remove(fsTableData[j]); // 去除数据
                        }
                    }
                    if (fsTableData.length < i) {
                        layer.msg('删除成功', {time: 500}, function () {
                            table.reload('table', {data: fsTableData});
                            table.singleData = '';
                            selectTableDataId = '';
                        })
                    } else {
                        layer.msg('删除成功', {time: 500});
                    }

                }
            })
        }

        /**
         * 保存
         */
        function mysave() {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要保存修改吗?'
                , btn1: function (index, layero) {
                    var url = basePath + '/pub/pub/saveJieshouren';
                    if (fsTableData.length < 1 || fsTableData == "") {
                        layer.alert('请选择接收人');
                        return false;
                    }
                    var jieshouren_table_rows = $.toJSON(fsTableData);
                    var qtbid = $('#qtbid').val();
                    var fsxtbz = $('#fsxtbz').val();
                    var fsnr = $('#fsnr').val();
                    var fsusername = $('#fsusername').val();
                    var fssj = $('#fssj').val();
                    var pdbsxid = $('#pdbsxid').val();
                    var param = {
                        jieshouren_table_rows: jieshouren_table_rows,
                        qtbid: qtbid,
                        fsxtbz: fsxtbz,
                        fsnr: fsnr,
                        fsusername: fsusername,
                        fssj: fssj,
                        pdbsxid: pdbsxid
                    }
                    $.post(url, param, function (result) {
                                if (result.code == '0') {
                                    layer.msg('成功', {time: 1000}, function () {
                                        /*table.reload('table', {data: fsTableData});*/
                                        window.location.reload();
                                    });
                                } else {
                                    layer.msg('失败' + result.msg);
                                }
                            },
                            'json');
                }
            })
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-table">
        <form class="layui-form" id="myform">
            <input type="hidden" id="jieshouren_table_rows" name="jieshouren_table_rows" value="接收人"/>
            <input type="hidden" id="qtbid" name="qtbid" value="<%=v_qtbid%>"/>
            <input type="hidden" id="pdbsxid" name="pdbsxid"/>
            <input type="hidden" id="fsxtbz" name="fsxtbz" value="<%=v_fsxtbz%>"/>

            <div class="layui-form-item" style="text-align:left ">
                <label class="layui-form-label">报请人:</label>

                <div class="layui-input-inline">
                    <input type="text" id="fsusername" name="fsusername" readonly
                           autocomplete="off" class="layui-input layui-bg-gray">
                </div>
                <label class="layui-form-label">报请时间:</label>

                <div class="layui-input-inline">
                    <input type="text" id="fssj" name="fssj" readonly
                           autocomplete="off" class="layui-input layui-bg-gray">
                </div>
            </div>
            <div class="layui-form-item" style="text-align:left ">
                <label class="layui-form-label">报请内容:</label>

                <div height="100px" class="layui-input-inline" style="width: 650px">
                    <textarea class="layui-textarea" id="fsnr" name="fsnr"></textarea>
                </div>
            </div>
        </form>
        <div class="layui-btn-group demoTable">
            <ck:permission biz="myselectAjdjXgry">
                <button class="layui-btn" data-type="myselectAjdjXgry"
                        data="btn_myselectAjdjXgry">选择接收人
                </button>
            </ck:permission>
            <ck:permission biz="mydatagrid_remove">
                <button class="layui-btn layui-btn-danger" data-type="mydatagrid_remove"
                        data="btn_mydatagrid_remove">删除
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="table" lay-filter="fsFilter"></table>
    </div>
</div>
</body>
</html>