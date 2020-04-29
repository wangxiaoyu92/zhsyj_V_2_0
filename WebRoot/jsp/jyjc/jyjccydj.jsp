<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
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
    <title>检验检测抽样登记</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jyjccydjTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryJyjccydj'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项jyjc
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'}
                        {
                            field: 'cybh', width: 100, title: '抽样编号', event: 'trclick'
                        }
                        , {field: 'bcydw', width: 100, title: '被抽样单位', event: 'trclick'}
                        , {field: 'bcydwdz', width: 100, title: '被抽样单位地址', event: 'trclick'}
                        , {field: 'scdw', width: 100, title: '生产单位', event: 'trclick'}
                        , {field: 'ypmc', width: 100, title: '样品名称', event: 'trclick'}
                        , {field: 'countcy', width: 100, title: '抽样数量', event: 'trclick'}
                        , {field: 'ypbh', width: 100, title: '样品批号/生产日期', event: 'trclick'}
                        , {field: 'cyjsr', width: 100, title: '抽样经手人', event: 'trclick'}
                        , {field: 'tel', width: 100, title: '被抽样单位联系电话', event: 'trclick'}
                        , {field: 'cysj', width: 100, title: '抽样时间', event: 'trclick'}
                        , {field: 'cyfl', width: 100, title: '抽样分类', event: 'trclick'}
                        , {field: 'bcydwfl', width: 100, title: '被抽样单位分类', event: 'trclick'}
                        , {field: 'aae011', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'aae036', width: 100, title: '经办时间', event: 'trclick'}
//					, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.cydjid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.cydjid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                    var $ = layui.$, active = {
                    addPcom: function () { // 增
                        addPcom();
                    }
                    , delPcom: function () { // 删
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检验检测样品！');
                        } else {
                            delPcom(table.singleData.cydjid);
                        }
                    }
                    , editPcom: function () { // 改
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的消息！');
                        } else {
                            editPcom(table.singleData.cydjid);
                        }
                    }
                    , showPcom: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的消息！');
                        } else {
                            showPcom(table.singleData.cydjid);
                        }
                    }
                    , ImPcom: function () { // 导入
                        imPcom();
                    }
                    , jcbgPcom: function () { // 报告管理
                        if (!table.singleData) {
                            layer.alert('请先选择要修改的消息！');
                        } else {
                            jcbgPcom(table.singleData.cydjid);
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
            });
        });
        // 新增企业
        function addPcom() {
            sy.modalDialog({
                title: '采集信息'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydjFormIndex'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 删除
        function delPcom(cydjid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/deljyjccydj', {
                                id: cydjid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.jyjccydjTable.length == 1) {
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
        //改
        function editPcom(cydjid) {
            sy.modalDialog({
                title: '编辑信息'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydjFormIndex'
                , param: {
                    op: "edit",
                    cydjid: cydjid
                }
                , btn: ['保存', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        //查看信息
        function showPcom(cydjid) {
            sy.modalDialog({
                title: '查看检验检测项目'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccydjFormIndex'
                , param: {
                    op: 'view',
                    cydjid: cydjid
                }
                , btn: ['关闭']
            });
        }
        //导入
        function imPcom() {
            sy.modalDialog({
                title: '抽样导入'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/cydjdrIndex'
                , btn: ['关闭'] //可以无限个按钮
            });
        }
        //编辑项目和报告信息
        function jcbgPcom(cydjid) {
            sy.modalDialog({
                title: '编辑项目和报告信息'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjccyxmhbgIndex?op=xmhbg'
                , param: {
                    "cydjid": cydjid
                }
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 查询检验检测样品
        function query() {
            var bcydw = $('#bcydw').val();
            var cybh = $('#cybh').val();
            var param = {
                'bcydw': bcydw,
                'cybh': cybh
            };
            refresh(param, '');
        }
        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: "1"
                }
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#bcydw").val(myrow.comdm); //公司名称
                    $("#comid").val(myrow.comid);//公司id
                }
            });
        }
        // 刷新
        function refresh(param, cur) {
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jyjccydjTable', {
                url: basePath + 'jyjc/queryJyjccydj'
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
            /*		parent.window.refresh();*/
        }


        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="bcydw" name="bcydw"
                                               autocomplete="off" readonly class="layui-input">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">抽样编号：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="cybh" name="cybh"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm8 layui-col-md-offset4 layui-col-xs-offset0 layui-col-sm-offset2">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                lay-submit="">
                                            <i class="layui-icon">&#xe615;</i>搜索
                                        </button>
                                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                                id="btn_reset">
                                            <i class="layui-icon">&#xe621;</i>重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 8px;">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addPcom">
                <button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
            </ck:permission>
            <ck:permission biz="updatePcom">
                <button class="layui-btn" data-type="editPcom" data="btn_editPcom">编辑</button>
            </ck:permission>
            <ck:permission biz="delPcom">
                <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
            </ck:permission>
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
            <ck:permission biz="ImPcom">
                <button class="layui-btn" data-type="ImPcom" data="btn_ImPcom">信息导入</button>
            </ck:permission>
            <ck:permission biz="jcbgPcom">
                <button class="layui-btn" data-type="jcbgPcom" data="btn_jcbgPcom">检测项目和报告管理</button>
            </ck:permission>
        </div>
    </fieldset>
    <table class="layui-hide" id="jyjccydjTable" lay-filter="tableFilter">
        <input type="hidden" id="cydjid" name="cydjid">
        <input type="hidden" id="bcydwcomid" name="bcydwcomid">
        <input type="hidden" id="scdwcomid" name="scdwcomid">
    </table>
</div>
</body>
</html>