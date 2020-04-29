<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String v_dokind = StringHelper.showNull2Empty(request.getParameter("dokind"));
    String v_checkyear = StringHelper.showNull2Empty(request.getParameter("checkyear"));
    String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>量化分级查询</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        // 年度
        var v_niandulist = <%=SysmanageUtil.getcheckyearlist()%>;
        //日常检查结果判定
        var v_RESULTDECISION = <%=SysmanageUtil.getAa10toJsonArray("RESULTDECISION")%>;
        //日常检查结果判定
        var v_RESULTSTATE = <%=SysmanageUtil.getAa10toJsonArray("RESULTSTATE")%>;
        //量化分级动态评定等级
        var v_LHFJDTPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJDTPDDJ")%>;
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;//进度条
        $(function () {
            initData();
//            initSelectData();
        });

        function initData() {
            layui.use(['form', 'table', 'layer', 'laydate', 'element'], function () {
                form = layui.form;
                var laydate = layui.laydate;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                var url = '';
                var v_local_dokind = "<%=v_dokind%>";
                if (v_local_dokind != null && v_local_dokind == "lhfjtj") {
                    url = basePath + 'lhfj/queryLhfjcx';
                }
                intSelectData('checkyear', v_niandulist);
                form.render();
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                var v_comid = "<%=v_comid%>";
                var v_checkyear = "<%=v_checkyear%>";
                var param = {
                    'comid': v_comid,
                    'checkyear': v_checkyear
                };
                console.log(param)
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'lhfj/queryLhfjcx'
                    , where: param
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
                        {field: 'comid', title: '企业id', event: 'trclick'}
                        , {field: 'commc', title: '企业名称', event: 'trclick'}
                        , {field: 'comdz', title: '企业地址', event: 'trclick'}
                        , {field: 'plantitle', title: '计划名称', event: 'trclick'}
                        , {field: 'planchecktype', width: 110, title: '计划检查类别', event: 'trclick'}
                        , {
                            field: 'resultdecision', title: '结果判定'
                            , templet: function (d) {
                                var userkind = d.id;
                                if (d.resultdecision == undefined) {
                                    userkind = "";
                                } else {
                                    $.each(v_RESULTDECISION, function (i, n) {
                                        if (d.resultdecision == n.id) {
                                            userkind = n.text;
                                            return false; // 跳出本次循环
                                        }
                                    });
                                }
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {field: 'resulttng', width: 130, title: '结果不符合项说明', event: 'trclick'}
                        , {field: 'resultremark', title: '结果备注', event: 'trclick'}
                        , {field: 'resultscore', title: '结果得分', event: 'trclick'}
                        , {
                            field: 'resultstate', width: 110, title: '结果完成状态'
                            , templet: function (d) {
                                var userkind = d.id;
                                if (d.resultstate == undefined) {
                                    userkind = "";
                                } else {
                                    $.each(v_RESULTSTATE, function (i, n) {
                                        if (d.resultstate == n.id) {
                                            userkind = n.text;
                                            return false; // 跳出本次循环
                                        }
                                    });
                                }
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {field: 'operateperson', width: 100, title: '项目经办人', event: 'trclick'}
                        , {field: 'operatedate', width: 110, title: '项目经办日期', event: 'trclick'}
                        , {field: 'resultperson', width: 100, title: '结果检查人', event: 'trclick'}
                        , {field: 'resultdate', width: 110, title: '结果检查日期', event: 'trclick'}
                        , {field: 'location', title: '地理位置', event: 'trclick'}
                        , {field: 'lxr', title: '联系人', event: 'trclick'}
                        , {field: 'lxdh', title: '联系电话', event: 'trclick'}
                        , {field: 'checkavgscore', width: 100, title: '检查平均分', event: 'trclick'}
                        , {
                            field: 'lhfjdtpddj', width: 160, title: '量化分级动态评定等级'
                            , templet: function (d) {
                                var userkind = d.id;
                                if (d.lhfjdtpddj == undefined) {
                                    userkind = "";
                                } else {
                                    $.each(v_LHFJDTPDDJ, function (i, n) {
                                        if (d.lhfjdtpddj == n.id) {
                                            userkind = n.text;
                                            return false; // 跳出本次循环
                                        }
                                    });
                                }
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {field: 'jcnrcount', width: 100, title: '检查内容数', event: 'trclick'}
                        , {field: 'ywcjcnrcount', width: 130, title: '已完成检查内容数', event: 'trclick'}
                        , {field: 'impjcnrcount', width: 130, title: '关键检查内容数', event: 'trclick'}
                        , {field: 'fhjcnrcount', width: 130, title: '符合检查内容数', event: 'trclick'}
                        , {field: 'bfhjcnrcount', width: 130, title: '不符合检查内容数', event: 'trclick'}
                        , {field: 'hlqxjcnrcount', width: 140, title: '合理缺项检查内容数', event: 'trclick'}
                        , {field: 'impbfhjcnrcount', width: 150, title: '关键不符合检查内容数', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                laydate.render({
                    elem: '#plandate'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#operatedatestart').val(val[0]);
                        $('#operatedateend').val(val[1]);
                    }
                });
                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.comid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.comid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    viewResult: function () { // 查看结果明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的量级分化信息！');
                        } else {
                            viewResult(table.singleData);
                        }
                    }
                    , viewResultinfo: function () { // 查看信息结果
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的量级分化信息！');
                        } else {
                            viewResultinfo(table.singleData);
                        }
                    }
                    , uploadFuJian: function () { // 附件管理
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的量级分化信息！');
                        } else {
                            uploadFuJian(table.singleData);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        }


        function myShowTjQuery() {
            var v_comid = "<%=v_comid%>";
            var v_checkyear = "<%=v_checkyear%>";

            var param = {
                'comid': v_comid,
                'checkyear': v_checkyear
            };
            table.reload('table', {
                url: basePath + 'lhfj/queryLhfjcx'
                , where: param //设定异步数据接口的额外参数
            });
        }

        function query() {
            var param = {
                'comid': $('#comid').val(),
                'planid': $('#planid').val(),
                'checkyear': $('#checkyear').val(),
                'operatedatestart': $('#operatedatestart').val(),
                'operatedateend': $('#operatedateend').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/lhfj/queryLhfjcx'
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        //从单位信息表中读取
        function myselectcom() {
            var url = basePath + 'pub/pub/selectcomIndex';
            sy.modalDialog({
                title: '选择企业',
                param: {
                    singleSelect: "true"
                }
                , area: ['100%', '100%']
                , content: url
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == "") {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称s
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }


        //选择重大活动检查计划
        function myselectCheckplan() {
            var url = basePath + 'jsp/pub/pub/selectCheckPlan.jsp';
            sy.modalDialog({
                title: '选择计划',
                param: {
                    singleSelect: "true"
                }
                , area: ['100%', '100%']
                , content: url
                , btn: ["确定", "取消"]
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].viewResult();
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                console.log(v_retStr)
                if (v_retStr == null || v_retStr == '') {
                    return false;
                }
                if (v_retStr.type == 'ok') {
                    $("#planid").val(v_retStr.data.planid);
                    $("#plantitle").val(v_retStr.data.plantitle);
                }

            });
        }

        //查看结果明细
        function viewResult(singleData) {
            var row = singleData;
            if (row) {
                if (row.resultstate == "1") {//未检查完毕
                    sy.modalDialog({
                        title: '查看检查结果',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype
                        }
                        , area: ['100%', '100%']
                        , content: basePath + '/supervision/checkresult/resultdetail'
                        , btn: ['保存', '取消'] //可以无限个按钮
                        , btn1: function (index, layero) {
                            window[layero.find('iframe')[0]['name']].submitForm();
                        }
                    });
                }//固化
                else {
                    sy.modalDialog({
                        title: '查看检查结果',
                        param: {
                            resultid: row.resultid,
                            resultstate: row.resultstate,
                            planchecktype: row.planchecktype
                        }
                        , area: ['100%', '100%']
                        , content: basePath + '/supervision/checkresult/viewResult'
                        , btn: ['关闭'] //可以无限个按钮
                    });
                }
            }
        }
        ;

        //附件管理
        function uploadFuJian(singleData) {
            var row = singleData;
            var url = basePath + 'pub/pub/pubUploadFjListIndex';
            sy.modalDialog({
                title: '附件管理',
                param: {
                    ajdjid: row.resultid,
                    dmlb: "SPJGFJ",//附件参数小类编号
                    fjcsdlbh: "SYJGFJ",
                    time: new Date().getMilliseconds()
                }
                , area: ['100%', '100%']
                , content: url
                ,btn:['关闭']
            }, function (dialogID) {
                sy.removeWinRet(dialogID);//不可缺少
            });
        }

        //查看结果信息
        function viewResultinfo(singleData) {
            var row = singleData;
            //除未完成
            if (row.resultstate = "4") {//结果固化
                sy.modalDialog({
                    title: '查看检查结果'
                    , area: ['100%', '100%'],
                    content: basePath + 'supervision/checkresult/viewResultinfo?resultid=' + row.resultid + '&resultstate=' + row.resultstate + '&planchecktype=' + row.planchecktype
                    , btn: ['关闭'] //可以无限个按钮
                });
            } else if (row.resultstate = "5") {//完毕
                sy.modalDialog({
                    title: '查看检查结果'
                    ,
                    area: ['100%', '100%']
                    ,
                    content: basePath + 'supervision/checkresult/viewResultinfo?resultid=' + row.resultid + '&resultstate=' + row.resultstate + '&planchecktype=' + row.planchecktype
                    ,
                    btn: ['关闭'] //可以无限个按钮
                });
            } else {
                layer.alert('还没有核查完毕无法查看核查结果信息！');
            }
        }
        ;


    </script>
</head>
<body>
<% if (!"lhfjtj".equalsIgnoreCase(v_dokind)) { %>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md5 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label">年度:</label>

                                        <div class="layui-input-inline">
                                            <select name="checkyear" id="checkyear"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md7 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label">企业名称：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="commc" name="commc"
                                                   autocomplete="off" class="layui-input" readonly>
                                        </div>
                                        <div class="layui-input-inline" style="width: auto">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                            <input type="hidden" id="comid" name="comid"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md5 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label">操作时间</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="plandate"
                                                   class="layui-input">
                                        </div>
                                        <input type="text" name="operatedatestart" id="operatedatestart"
                                               hidden="hidden">
                                        <input type="text" name="operatedateend" id="operatedateend"
                                               hidden="hidden">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md7 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label">检查计划</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="plantitle" name="plantitle" class="layui-input"
                                                   readonly>
                                        </div>
                                        <div class="layui-input-inline">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="myselectCheckplan()">选择检查计划 </a>
                                            <input type="hidden" id="planid" name="planid"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline">
                                        <button id="btn_query"
                                                class="layui-btn layui-btn-sm layui-btn-normal">
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
    <%} %>
    <fieldset class="layui-elem-field site-demo-button" style="width: 100%;border: none;padding-top: 15px;">

        <div class="layui-btn-group demoTable">
            <ck:permission biz="viewResult">
                <button class="layui-btn" data-type="viewResult" data="btn_viewResult">查看结果明细</button>
            </ck:permission>
            <ck:permission biz="uploadLhfjFuJian">
                <button class="layui-btn" data-type="uploadFuJian" data="btn_uploadFuJian">附件管理</button>
            </ck:permission>
            <ck:permission biz="viewResultinfo">
                <button class="layui-btn" data-type="viewResultinfo" data="btn_viewResultinfo">查看结果信息</button>
            </ck:permission>
        </div>

    </fieldset>
    <table class="layui-hide" id="table" lay-filter="paramgridfilter"></table>
</div>
</body>
</html>