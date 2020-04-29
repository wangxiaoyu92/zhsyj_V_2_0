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


%>
<!DOCTYPE html>
<html>
<head>

    <title>量化分级统计</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">
        // 企业大类
        var v_niandulist = <%=SysmanageUtil.getcheckyearlist()%>;
        //量化分级年度评定等级
        var v_LHFJNDPDDJ = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;

        var v_bndsfpddj = [{"id": "", "text": "==请选择=="}, {"id": 0, "text": "否"}, {"id": 1, "text": "是"}];

        var form;
        var table;
        var layer;
        var selectNodes;
        var selectTableDataId = '';
        var url;
        var mask;//进度条
        $(function () {
            initSelectData();
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
                    elem: '#mygrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/lhfj/queryLhfjtj'
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
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
                        {field: 'checkyear', width: 80, title: '年度', event: 'trclick'}
                        , {field: 'commc', width: 180, title: '企业名称', event: 'trclick'}
                        , {field: 'comdz', width: 180, title: '企业地址', event: 'trclick'}
                        , {field: 'comdaleistr', width: 80, title: '企业大类', event: 'trclick'}
                        , {
                            field: 'sndpddj', width: 120, title: '上年度评定等级'
                            , templet: function (d) {
                                var userkind = d.id;
                                if (d.sndpddj == undefined) {
                                    userkind = "";
                                } else {
                                    $.each(v_LHFJNDPDDJ, function (i, n) {
                                        if (d.sndpddj == n.id) {
                                            userkind = n.text;
                                            return false; // 跳出本次循环
                                        }
                                    });
                                }
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'bndpddj', width: 120, title: '本年度评定等级'
                            , templet: function (d) {
                                var userkind = d.id;
                                if (d.bndpddj == undefined) {
                                    userkind = "";
                                } else {
                                    $.each(v_LHFJNDPDDJ, function (i, n) {
                                        if (d.bndpddj == n.id) {
                                            userkind = n.text;
                                            return false; // 跳出本次循环
                                        }
                                    });
                                }
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {
                            field: 'bndsfpddj', width: 140, title: '本年度是否评定等级'
                            , templet: function (d) {
                                var userkind = d.id;
                                $.each(v_bndsfpddj, function (i, n) {
                                    if (d.bndsfpddj == n.id) {
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            }
                            , event: 'trclick'
                        }

                        , {
                            field: 'bndpddjyp', width: 140, title: '本年度评定等级预判'
                            , templet: function (d) {
                                var userkind = d.id;
                                $.each(v_LHFJNDPDDJ, function (i, n) {
                                    if (d.bndpddjyp == n.id) {
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {field: 'checkoverndavgscoresum', width: 140, title: '检查完成的年度总分', event: 'trclick'}
                        , {field: 'checkoverndavgscore', width: 150, title: '检查完成的年度平均分', event: 'trclick'}
                        , {field: 'checkcountsum', width: 100, title: '检查总次数', event: 'trclick'}
                        , {field: 'checkovercount', width: 80, title: '完成次数', event: 'trclick'}
                        , {field: 'checknoovercount', width: 100, title: '未完成次数', event: 'trclick'}
                        , {field: 'checkfhcount', width: 80, title: '符合次数', event: 'trclick'}
                        , {field: 'checkbfhcount', width: 100, title: '不符合次数', event: 'trclick'}
                        , {field: 'checkxqzgcount', width: 110, title: '限期整改次数', event: 'trclick'}
                        , {field: 'lhfjpdndyjccs', width: 240, title: '根据年度等级判断本年度应检查次数', event: 'trclick'}
                        , {field: 'hyjccs', width: 180, title: '根据等级判定还应检查次数', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
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
                            $(obj.tr.selector).css("background", "#90E2DA");
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
                    viewCheckDetail: function () { // 查看的明细
                        if (!table.singleData) {
                            layer.alert('请先选择要查看的信息！');
                        } else {
                            viewCheckDetail(table.singleData);
                        }
                    }
                    , autoCreateNddja: function () { // 自动量化
                        if (!table.singleData) {
                            layer.alert('请先选择要自动生成的信息！');
                        } else {
                            autoCreateNddj(table.singleData, "0");
                        }
                    }
                    , handCreateNddj: function () { // 手动量化
                        if (!table.singleData) {
                            layer.alert('请先选择要手动生成的信息！');
                        } else {
                            autoCreateNddj(table.singleData, "1");
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
        }
        //初始化下拉框选项数据
        function initSelectData() {
            var typeOptions = '';
            for (var i = 0; i < v_niandulist.length; i++) {
                typeOptions += '<option value=\'' + v_niandulist[i].id + '\' >' + v_niandulist[i].text + '</option>';
            }
            $("#checkyear").append(typeOptions);
//
            var Options = '';
            for (var i = 0; i < v_bndsfpddj.length; i++) {
                Options += '<option value=\'' + v_bndsfpddj[i].id + '\' >' + v_bndsfpddj[i].text + '</option>';
            }
            $("#bndsfpddj").append(Options);
        }

        //查询方法
        function query() {
            var param = {
                'comid': $('#comid').val(),
                'commc': $('#commc').val(),
                'checkyear': $('#checkyear').val(),
                'checkcountsumstart': $('#checkcountsumstart').val(),
                'checkcountsumend': $('#checkcountsumend').val(),

                'checkovercountstart': $('#checkovercountstart').val(),
                'checkovercountend': $('#checkovercountend').val(),

                'checknoovercountstart': $('#checknoovercountstart').val(),
                'checknoovercountend': $('#checknoovercountend').val(),

                'checkfhcountstart': $('#checkfhcountstart').val(),
                'checkfhcountend': $('#checkfhcountend').val(),

                'checkbfhcountstart': $('#checkbfhcountstart').val(),
                'checkbfhcountend': $('#checkbfhcountend').val(),

                'checkxqzgcountstart': $('#checkxqzgcountstart').val(),
                'checkxqzgcountend': $('#checkxqzgcountend').val(),

                'lhfjpdndyjccsstart': $('#lhfjpdndyjccsstart').val(),
                'lhfjpdndyjccsend': $('#lhfjpdndyjccsend').val(),

                'hyjccsstart': $('#hyjccsstart').val(),
                'hyjccsend': $('#hyjccsend').val(),
                'bndsfpddj': $('#bndsfpddj').val()
            };
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('mygrid', {
                url: basePath + '/lhfj/queryLhfjtj'
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
                if (obj == null || obj == '') {
                    return
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称s
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }

        function refresh() {
            parent.window.refresh();
        }

        //查看结果明细
        function viewCheckDetail(singleData) {
            var row = singleData;
            var v_dokind = "lhfjtj";
            sy.modalDialog({
                title: '查看检查结果',
                param: {
                    dokind: v_dokind,
                    checkyear: row.checkyear,
                    comid: row.comid
                }
                , area: ['100%', '100%']
                , content: basePath + 'jsp/supervision/lhfj/lhfjcx.jsp'
                , btn: ['关闭'] //可以无限个按钮
            }, function (dialogID) {
                sy.removeWinRet(dialogID);//不可缺少
            });
        }
        ;
        /**
         * 自动生成年度等级
         */
        function autoCreateNddj(singleData, a) {//评定结果生产方式0自动1手动
            var prm_pdjgscfs = a;
            layer.confirm('确定要生成所选单位的年度等级信息吗?', function (index) {
                var v_lhfjndpddj = '';
                var v_sfcxsc = '';//0不重新生成1重新生成
                var v_url = basePath + "jsp/supervision/lhfj/lhfjqueren.jsp";
                sy.modalDialog({
                    title: '选择结果',
                    param: {
                        caozuokind: prm_pdjgscfs,
                        time: new Date().getMilliseconds()
                    }
                    , area: ['100%', '100%']
                    , content: v_url
                }, function (dialogID) {
                    var obj = sy.getWinRet(dialogID);
                    if (obj != null) {
                        v_lhfjndpddj = obj.lhfjndpddj;
                        v_sfcxsc = obj.sfcxsc;
                        $("#myLhfjtjGridchecked").val("[" + $.toJSON(singleData) + "]");
                        url = basePath + "/lhfj/saveCreateNddj?pdjgscfs=" + prm_pdjgscfs +
                        "&lhfjndpddj=" + v_lhfjndpddj + "&sfcxsc=" + v_sfcxsc +
                        "&time=" + new Date().getMilliseconds();
                        var formData = {'myLhfjtjGridchecked': $("#myLhfjtjGridchecked").val()};
                        $.post(url, formData, function (result) {
                            result = $.parseJSON(result);
                            if (result.code == '0') {
                                layer.msg('生成成功', {time: 500}, function () {
                                    query();
                                });
                            } else {
                                layer.open({
                                    title: '提示'
                                    , content: '生成失败' + result.msg
                                });
                            }
                        });
                        sy.removeWinRet(dialogID);//不可缺少
                    } else {
                        return false;
                    }
                });
                layer.close(index);
            });
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryfm" style="width: 100%">
                    <div class="layui-container">
                        <input type="hidden" id="myLhfjtjGridchecked" name="myLhfjtjGridchecked">

                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label" style="width: 110px">年度</label>

                                        <div class="layui-input-inline">
                                            <select name="checkyear" id="checkyear"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label" style="width: 110px">本年度是否评定等级</label>

                                        <div class="layui-input-inline">
                                            <select name="bndsfpddj" id="bndsfpddj"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <div class="layui-inline">
                                        <label class="layui-form-label" style="width: 110px">企业名称：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="commc" name="commc"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="layui-input-inline" style="width: auto">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                            <input type="hidden" id="comid" name="comid"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">检查总次数</label>

                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checkcountsumstart"
                                                   name="checkcountsumstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width:20%">
                                            <input lay-verify="number" id="checkcountsumend"
                                                   name="checkcountsumend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">完成次数</label>

                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checkovercountstart"
                                                   name="checkovercountstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checkovercountend"
                                                   name="checkovercountend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">未完成次数</label>

                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checknoovercountstart"
                                                   name="checknoovercountstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checknoovercountend"
                                                   name="checknoovercountend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">符合次数</label>

                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checkfhcountstart"
                                                   name="checkfhcountstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%">
                                            <input lay-verify="number" id="checkfhcountend"
                                                   name="checkfhcountend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">不符合次数</label>

                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="checkbfhcountstart"
                                                   name="checkbfhcountstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="checkbfhcountend"
                                                   name="checkbfhcountend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">限期整改次数</label>

                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="checkxqzgcountstart"
                                                   name="checkxqzgcountstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="checkxqzgcountend"
                                                   name="checkxqzgcountend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">本年度应检次数</label>

                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="lhfjpdndyjccsstart"
                                                   name="lhfjpdndyjccsstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="lhfjpdndyjccsend"
                                                   name="lhfjpdndyjccsend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 84px">还应检查次数</label>

                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="hyjccsstart" name="hyjccsstart"
                                                   class="layui-input"/>
                                        </div>
                                        <div class="layui-form-mid">~</div>
                                        <div class="layui-input-inline" style="width: 20%;">
                                            <input lay-verify="number" id="hyjccsend" name="hyjccsend"
                                                   class="layui-input"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs6 layui-col-sm6">
                                <div class="layui-form-item">
                                    <div class="layui-input-inline" style="width: auto">
                                        <label class="layui-form-label" style="width: 40px"></label>
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
                        <div class="layui-form-item" style="display: none">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit="" lay-filter="save" id="saveLhfjBtn">
                                    保存
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="viewCheckDetail">
                <button class="layui-btn" data-type="viewCheckDetail" data="btn_viewCheckDetail">查看明细</button>
            </ck:permission>
            <ck:permission biz="autoCreateNddja">
                <button class="layui-btn" data-type="autoCreateNddja" data="btn_autoCreateNddja">自动生成年度等级</button>
            </ck:permission>
            <ck:permission biz="handCreateNddj">
                <button class="layui-btn" data-type="handCreateNddj" data="btn_handCreateNddj">手动生成年度等级</button>
            </ck:permission>
        </div>
    </div>
    <table class="layui-hide" id="mygrid" lay-filter="paramgridfilter"></table>
</div>
</body>
</html>