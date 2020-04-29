<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
    <title>文书模板管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var form;
        var layer;
        var table;
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#mygrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/zfba/wsmbgl/queryWsmb'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'zfwsdmz', title: '执法文书编号', event: 'trclick'}
                        , {field: 'zfwsmbmc', title: '文书模版名称', event: 'trclick'}
                        , {field: 'zfwsmbczy', title: '操作员', event: 'trclick'}
                        , {field: 'zfwsmbczsj', title: '操作时间', event: 'trclick'}
                        , {field: 'aaa027', title: '地区编码', event: 'trclick'}
                        , {field: 'aaa146', title: '行政区划', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(mygrid)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.ajzfwsid) {
                            // 清除所有行的样式
                            $($("#mygrid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#mygrid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.ajzfwsid;
                        } else { // 再次选中清除样式
                            $("#mygrid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    showWsmb: function () {//预览
                        if (!table.singleData) {
                            parent.layer.alert('请选择要查看的文书！');
                        } else {
                            showWsmb(table.singleData);
                        }
                    }
                    , wenshuguanli: function () {//编辑
                        if (!table.singleData) {
                            parent.layer.alert('请选择要修改的文书！');
                        } else {
                            wenshuguanli(table.singleData);
                        }
                    }
                };
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            })
            $('#btn_query').click(function () {
                query();
                return false;
            })
        });

        //编辑文书模板
        function wenshuguanli(data) {
            var v_dmlb = "ZFAJZFWS";
            //v_zfwsurl类似 ：pub/ajwsgl/zfwsajlydjbIndex
            var v_sys_userid = '<%=v_userid%>';
            var v_canbaocun = "1";
            if (v_sys_userid != data.zfwsuserid) {
                v_canbaocun = "0";
            }
            var url = encodeURI(encodeURI(basePath + data.zfwsurl));
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '文书管理'
                , content: url
                , param: {
                    ajdjid: data.ajdjid,
                    zfwsqtbid: data.zfwsqtbid,
                    zfwsdmz: data.zfwsdmz,
                    fjcsdmmc: data.fjcsdmmc,
                    fjcszfwstitle: data.fjcszfwstitle,
                    canbaocun: v_canbaocun,
                    time: new Date().getMilliseconds()
                }
//                , btn: ['关闭']
//                , btn1: function (index, layero) {
                //编辑按钮 只做查看作用
//                    window[layero.find('iframe')[0]['name']].mysave();
//                    layer.close(index);
//                    layer.msg('保存成功');
//                }
            }, closeModalDialogCallback);
        }

        //预览文书模板
        function showWsmb(data) {
            var obj = new Object();
            var v_dmlb = "ZFAJZFWS";
            //v_zfwsurl类似 ：pub/ajwsgl/zfwsajlydjbIndex
            var v_sys_userid = '<%=v_userid%>';
            var v_canbaocun = "1";
            if (v_sys_userid != data.zfwsuserid) {
                v_canbaocun = "0";
            }
            var url = encodeURI(encodeURI(basePath + data.zfwsurl));
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '预览'
                , content: url
                , param: {
                    ajdjid: data.ajdjid,
                    zfwsqtbid: data.zfwsqtbid,
                    zfwsdmz: data.zfwsdmz,
                    fjcsdmmc: data.fjcsdmmc,
                    fjcszfwstitle: data.fjcszfwstitle,
                    canbaocun: v_canbaocun,
                    time: new Date().getMilliseconds()
                }
                , btn: ['关闭']
            });
        }
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.reload('mygrid',
                        {
                            url: basePath + '/zfba/wsmbgl/queryWsmb'
                            , page: {
                            curr: curent //重新从第 1 页开始
                        }
                            , done: function () {
                            table.singleData = '';
                            selectTableDataId = '';
                            layer.close(mask);
                        }
                        }
                );
            }
        }
        //查询
        function query() {
            var param = {
                'zfwsdmz': $('#zfwsdmz').val(),
                'zfwsmbmc': $('#zfwsmbmc').val(),
                'zfwsmbczy': $('#zfwsmbczy').val()
            };
            table.reload('mygrid', {
                url: basePath + '/zfba/wsmbgl/queryWsmb'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param
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
                <form class="layui-form" id="fm" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">执法文书编号 :</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="zfwsdmz" name="zfwsdmz" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">文书模板名称 :</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="zfwsmbmc" name="zfwsmbmc" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">操作员 :</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="zfwsmbczy" name="zfwsmbczy" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs10 layui-col-sm6 layui-col-md-offset5">
                                <div class="layui-form-item" style="width: auto">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline"style="width: auto">
                                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
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
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="showWsmb">
                <button class="layui-btn" data-type="showWsmb" data="btn_showWsmb">预览
                </button>
            </ck:permission>
            <ck:permission biz="wenshuguanli">
                <button class="layui-btn" data-type="wenshuguanli" data="btn_wenshuguanli">编辑
                </button>
            </ck:permission>
        </div>

        <table class="layui-hide" id="mygrid" lay-filter="mygrid"></table>
    </div>
</div>
</body>
</html>