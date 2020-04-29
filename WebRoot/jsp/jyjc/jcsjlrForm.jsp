<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String cydjid = StringHelper.showNull2Empty(request.getParameter("cydjid"));
    String hjyjczbid = StringHelper.showNull2Empty(request.getParameter("hjyjczbid"));
    Sysuser sysuser = SysmanageUtil.getSysuser();
    String userdalei = sysuser.getUserdalei();
    String aaz001 = sysuser.getAaz001();
    String description = sysuser.getDescription();
    String v_cur_userkind=sysuser.getUserkind();
    if ("30".equals(v_cur_userkind)){//网上送检人员
        op="view";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测报告主表</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        var table;
        var selectTableDataId2='';
        var hjyjczbid = '<%=hjyjczbid%>';
        var v_shifoubz = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        var v_jcjyshbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var v_szdw = <%=SysmanageUtil.getAa10toJsonArray("SZDW")%>;
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        $(function () {
            layui.use(['form', 'layer', 'table','laydate','element'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                element = layui.element;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#jyjcrq'
                });
                var url = basePath + '/jyjc/saveHjyjczb_zm';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var formData = data.field;
//                    var jycjssxzid=$('#jycjssxzid').val();
//                    if(!jycjssxzid){
//                        layer.alert('请选择抽检实施细则！');
//                        return false;
//                    }
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                $('#hjyjczbid').val(result.id);
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                lock = true;//保存成功，打开锁
                                if ($('#hjyjczbid').val().length > 0) {
                                    $('#mxbxx').removeAttr('style');
                                    $('#mxbxx').attr('style', 'width: auto;');
                                }
                                refresh(result.id,'');
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                //明细表
                table.render({
                    elem: '#hjyjcmxb'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryHjyjcmxb_zm'
                    , where: {
                        hjyjczbid:hjyjczbid
                    }
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
                        {field: 'jcxmmc', width: 150, title: '检测项目名称', event: 'trclick2'}
                        , {field: 'bzz', width: 80, title: '标准值', event: 'trclick2'}
                        , {field: 'jcz', width: 80, title: '检测值', event: 'trclick2'}
                        , {field: 'szdw', width: 80, title: '数值单位'
                            , templet: function (d) {
                                return formatGridColData(v_szdw, d.szdw);
                            }, event: 'trclick2'}
                        , {field: 'jyjcjl', width: 120, title: '检验检测结论'
                            , templet: function (d) {
                                if(d.jyjcjl !=""){
                                    return formatGridColData(v_jyjcjl, d.jyjcjl);
                                }
                                return "";
                            }, event: 'trclick2'}
                        , {field: 'xlbz', width: 200, title: '限量标准,执行标准号', event: 'trclick2'}
                        , {field: 'jcff', width: 150, title: '检测方法', event: 'trclick2'}
                        , {field: 'aae011', width: 110, title: '经办人', event: 'trclick2'}
                        , {field: 'aae036', width: 110, title: '经办时间', event: 'trclick2'}
                    ]]

                });
                var $ = layui.$, active = {
                    //明细表
                    addHjyjcmxb: function () { // 添加
                        var hjyjczbid=$('#hjyjczbid').val();
                        var jycjssxzid=$('#jycjssxzid').val();
                        addHjyjcmxb(hjyjczbid);
                    }
                    , updateHjyjcmxb: function () { // 修改
                        if (!table.singleData2) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateHjyjcmxb(table.singleData2.hjyjczbid, table.singleData2.hjyjcmxbid);
                        }
                    }
                    , delHjyjcmxb: function () { // 删除
                        if (!table.singleData2) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delHjyjcmxb(table.singleData2.hjyjczbid,table.singleData2.hjyjcmxbid);
                        }
                    }
                    , showHjyjcmxb: function () { // 查看
                        if (!table.singleData2) {
                            layer.alert('请选择要查看的信息！');
                        } else {
                            showHjyjcmxb(table.singleData2.hjyjczbid, table.singleData2.hjyjcmxbid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                // 明细表监听工具条
                table.on('tool(hjyjcmxb)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.hjyjcmxbid) {
                            $($("#hjyjcmxb").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#hjyjcmxb").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            // 清除所有行的样式
                            table.singleData2 = data;
                            selectTableDataId2 = data.hjyjcmxbid;
                        } else { // 再次选中清除样式
                            $("#hjyjcmxb").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });
                if (hjyjczbid != "" && hjyjczbid != null) {
                    $.post(basePath + '/jyjc/queryHjyjczb_zm', {
                                hjyjczbid: hjyjczbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    $('form').form('load', mydata);
                                    form.render();
                                    if ($('#jcorgid').val().length > 0) {
                                        $('#selectjcry').removeAttr('style');
                                        $('#selectjcry').attr('style', 'width: auto;');
                                    }
                                    if ($('#jcryid').val().length > 0) {
                                        $('#selectsbxh').removeAttr('style');
                                        $('#selectsbxh').attr('style', 'width: auto;');
                                    }
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "数据获取失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json');
                    if ('<%=op%>' == 'view') {
                        $('#jcjyshwtgyy').attr('readonly', 'readonly');
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                    }
                }
            });
            intSelectData('cybgsfla', v_shifoubz);
            intSelectData('jcjylb', v_jcjylb);
            intSelectData('jcjyshbz', v_jcjyshbz);
            intSelectData('szdw', v_szdw);
            intSelectData('jyjcjl', v_jyjcjl);
            if ('add' == '<%=op%>') {
                if ("2" == '<%=userdalei%>') {
                    $('#jcorgid').val('<%=aaz001%>');
                    $('#jcorgmc').val('<%=description%>');
                }
            }
            if ($('#jcorgid').val().length > 0) {
                $('#selectjcry').removeAttr('style');
                $('#selectjcry').attr('style', 'width: auto;');
            }
            if ($('#jcryid').val().length > 0) {
                $('#selectsbxh').removeAttr('style');
                $('#selectsbxh').attr('style', 'width: auto;');
            }
            if ($('#hjyjczbid').val().length > 0) {
                $('#mxbxx').removeAttr('style');
                $('#mxbxx').attr('style', 'width: auto;');
            }
        });
/*        // 保存
        var submitForm = function () {
            var jycjssxzid=$('#jycjssxzid').val();
            if(!jycjssxzid){
                layer.alert('请选择抽检实施细则！');
                return;
            }else{
                $("#saveZbBtn").click();
            }
        };*/

        //选择商品
        function selectsp() {
            parent.sy.modalDialog({
                title: '选择商品'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true"
                }
                , content: basePath + 'pub/pub/selectjyjcypIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                sy.removeWinRet(dialogID);//不可缺少
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#jcypid").val(myrow.jcypid); //样品id
                    $("#jcypmc").val(myrow.jcypmc); //样品名称
                }
            });
        }

        //选择设备
        function selectsbxh() {
            parent.sy.modalDialog({
                title: '选择设备'
                , area: ['100%', '100%']
                , param: {
                    hviewjgztid: $('#jcorgid').val()
                }
                , content: basePath + '/tmsyjhtgl/selectJianceyiqiIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);//不可缺少
                sy.removeWinRet(dialogID);//不可缺少
                if (obj == null || obj == '') {
                    return false;
                }
                var myrow = obj.data;
                $("#sbxh").val(myrow.jcyqxh); //设备型号
                $("#sbxlh").val(myrow.jcyqxlh); //设备序列号
//                }
            });
        }

        //选择检测机构
        function selectjg() {
            parent.sy.modalDialog({
                title: '选择检测机构'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , param: {querytype: "jyjc"}
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#jcorgid").val(myrow.comid); //公司名称
                    $("#jcorgmc").val(myrow.commc); //公司代码
                    $('#selectjcry').removeAttr('style');
                    $('#selectjcry').attr('style', 'width: auto;');
                }
            });
        }
        //选择监管主体
        function myselectcom() {
            parent.sy.modalDialog({
                title: '选择监管主体'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#hviewjgztmc").val(myrow.commc); //公司名称
                    $("#hviewjgztid").val(myrow.comid); //公司代码
                    $("#jcztbzjid").val(myrow.comid); //公司代码
                }
            });
        }
        //选择检测人员
        function selectjcry() {
            parent.sy.modalDialog({
                title: '选择检测人员'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectuserIndex'
                , param: {'usercomid': $('#jcorgid').val(), 'querykind': 'comusersel'}
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data[0];
                    $("#jcryid").val(myrow.userid); //人员名称
                    $("#jcrymc").val(myrow.description); //人员代码
                    $('#selectsbxh').removeAttr('style');
                    $('#selectsbxh').attr('style', 'width: auto;');
                }
            });
        }
        function checkBzz() {
            var bzz = $('#bzz').val();
            var jcz = $('#jcz').val();

//            //结论    1是合格    2是不合格
            if (parseInt(bzz) > parseInt(jcz)) {
                $('#jyjcjl').val(1);
            }
            else {
                $('#jyjcjl').val(2);
            }
            form.render();
        }
        // 明细表新增
        function addHjyjcmxb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , content: url
                ,param:{
                    hjyjczbid:hjyjczbid
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }

        // 明细表编辑
        function updateHjyjcmxb(hjyjczbid, hjyjcmxbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid,
                    hjyjcmxbid: hjyjcmxbid,
                    op: 'edit'
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback2);
        }
        // 明细表查看
        function showHjyjcmxb(hjyjczbid, hjyjcmxbid) {
            var url = '<%=basePath%>jyjc/hjyjcmxbForm';
            parent.sy.modalDialog({
                title: '查看'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid,
                    hjyjcmxbid: hjyjcmxbid,
                    op: 'view'
                }
                , btn: ['关闭']
            });
        }

        // 明细表删除
        function delHjyjcmxb(hjyjczbid,hjyjcmxbid) {
            layer.open({
                title: '警告!'
                , icon: '2'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delHjyjcMxb', {
                                hjyjcmxbid: hjyjcmxbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData2 = '';
                                    selectTableDataId2 = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        if (table.cache.hjyjcmxb.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var hjyjczbid=$('#hjyjczbid').val();
                                        refresh(hjyjczbid, curent);
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
        //明细表子页面返回参数
        function closeModalDialogCallback2(dialogID) {
            var hjyjczbid=$('#hjyjczbid').val();
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(hjyjczbid, curent);
            } else {
                //saveOk 在第一页刷新
                refresh(hjyjczbid, '');
            }
        }
        // 刷新
        function refresh(pcyzdszmainid, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            var param={
                hjyjczbid: pcyzdszmainid
            };
            table.reload('hjyjcmxb', {
                url: basePath + '/jyjc/queryHjyjcmxb_zm'
                , where: param //设定异步数据接口的额外参数
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , done: function () {
                    table.singleData2 = '';
                    selectTableDataId2 = '';
                    layer.close(mask);
                }
            });
        }
        function selectCjssxz(){
            parent.sy.modalDialog({
                title: '选择抽检实施细则'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/jycjssxzIndex?op=select'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#jycjssxzid").val(myrow.jycjssxzid);
                }
            });
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div class="layui-table">
    <div class="layui-collapse">
        <div class="layui-colla-item" id="zbxx">
            <h2 class="layui-colla-title">主表信息</h2>
            <div class="layui-colla-content layui-show">
                <div region="center" style="overflow: hidden;" border="false">
                    <form class="layui-form" action="" lay-filter="jyjcjgForm" >
                        <input type="hidden" id="hjyjczbid" name="hjyjczbid" value="<%=hjyjczbid%>"/> <%--检验检测主表id--%>
                        <input type="hidden" id="jcypid" name="jcypid"/> <%--商品id--%>
                        <input type="hidden" id="jcztbzjid" name="jcztbzjid"/> <%--检测主体表主键id--%>
                        <input type="hidden" id="jcorgid" name="jcorgid"/> <%--机构id--%>
                        <input type="hidden" id="jcryid" name="jcryid"/> <%--人员id--%>
                        <input type="hidden" id="sjcsfs" name="sjcsfs" value="0"/> <%--0手工录入1机器录入--%>
                        <input type="hidden" id="cydjid" name="cydjid" value="<%=cydjid%>"/> <%--抽样登记ID--%>
                        <input type="hidden" id="jsbgrq" name="jsbgrq"/> <%--收到报告日期（抽样报告用）--%>
                        <input type="hidden" id="bgsdrq" name="bgsdrq"/> <%--报告送达日期（抽样报告用）--%>
                        <input type="hidden" id="jcksrq" name="jcksrq"/> <%--检测日期开始（抽样报告用）--%>
                        <input type="hidden" id="jcjsrq" name="jcjsrq"/> <%--检测日期结束（抽样报告用）--%>
                        <input type="hidden" id="cybgsfla" name="cybgsfla"/> <%--是否立案--%>
                        <input type="hidden" id="ajdjid" name="ajdjid"/> <%--案件登记id--%>
                        <input type="hidden" id="ajdjbh" name="ajdjbh"/> <%--案件登记编号m--%>
                        <input type="hidden" id="detectiondatatype" name="detectiondatatype" value="2"/> <%--抽样登记数据--%>
                        <div class="layui-container">
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">检验检测报告编号：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:60%">
                                            <input type="text" id="jyjcbgbh" name="jyjcbgbh"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">监管主体名称：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:60%">
                                            <input type="text" id="hviewjgztmc" name="hviewjgztmc" readonly
                                                   autocomplete="off" class="layui-input layui-bg-gray" lay-verify="required">
                                            <input type="hidden" id="hviewjgztid" name="hviewjgztid"/>
                                        </div>

                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="myselectcom()">选择监管主体 </a>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">商品名称：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width: 60%">
                                            <input type="text" id="jcypmc" name="jcypmc" readonly
                                                   autocomplete="off" class="layui-input layui-bg-gray">
                                        </div>
                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="selectsp()">选择商品</a>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">检测机构名称：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width: 60%">
                                            <input type="text" id="jcorgmc" name="jcorgmc" autocomplete="off"
                                                   class="layui-input layui-bg-gray" readonly>
                                        </div>
                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline" id="selectjg" >
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="selectjg()">选择机构</a>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">检测人员名称：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:60%">
                                            <input type="text" id="jcrymc" name="jcrymc" autocomplete="off"
                                                   class="layui-input layui-bg-gray" readonly>
                                        </div>
                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline" id="selectjcry" style="display:none">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="selectjcry()">选择检测人员</a>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">检测检验类别：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline">
                                            <select id="jcjylb" name="jcjylb"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">设备型号：</label>
                                    </div>
                                    <div class="layui-col-md4" >
                                        <div class="layui-input-inline" style="width: 50%">
                                            <input type="text" id="sbxh" name="sbxh" autocomplete="off"
                                                   class="layui-input layui-bg-gray" readonly>
                                        </div>
                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline" id="selectsbxh" style="display:none">
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="selectsbxh()">选择设备型号</a>
                                        </div>
                                        <%} %>
                                    </div>
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">设备序列号：</label>
                                    </div>
                                    <div class="layui-col-md4" >
                                        <div class="layui-input-inline">
                                            <input type="text" id="sbxlh" name="sbxlh" autocomplete="off"
                                                   class="layui-input layui-bg-gray" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">检验检测日期：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline">
                                            <input type="text" id="jyjcrq" name="jyjcrq" autocomplete="off"
                                                   class="layui-input layui-bg-gray" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">操作员:</label>
                                    </div>
                                    <div class="layui-col-md4" >
                                        <div class="layui-input-inline">
                                            <input type="text" id="aae011" name="aae011" autocomplete="off" readonly
                                                   class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">操作日期:</label>
                                    </div>
                                    <div class="layui-col-md4" >
                                        <div class="layui-input-inline">
                                            <input type="text" id="aae036" name="aae036" autocomplete="off" readonly
                                                   class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">抽检实施细则：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:60%;">
                                            <input type="text" id="jycjssxzid" name="jycjssxzid" autocomplete="off" readonly
                                                   class="layui-input layui-bg-gray">
                                        </div>
                                        <% if (!"view".equalsIgnoreCase(op)) {%>
                                        <div class="layui-input-inline" id="myselectcom" >
                                            <a href="javascript:void(0)" class="layui-btn"
                                               iconCls="icon-search" onclick="selectCjssxz()">选择抽检实施细则 </a>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>


                                <% if ("sh".equalsIgnoreCase(op) || "view".equalsIgnoreCase(op)) {%>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">审核标志:</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline">
                                            <select id="jcjyshbz" name="jcjyshbz"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">审核未通过原因:</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:85%;">
                                          <textarea id="jcjyshwtgyy" name="jcjyshwtgyy"
                                                    style="width:80%;height: 150px"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-row">
                                <div class="layui-form-item">
                                    <div class="layui-col-md2">
                                        <label class="layui-form-label" style="width: 120px;">复检结果：</label>
                                    </div>
                                    <div class="layui-col-md10" >
                                        <div class="layui-input-inline" style="width:85%;">
                                            <input type="text" id="fjjg" name="fjjg" autocomplete="off"
                                                   class="layui-input" >
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <%} %>
                                <% if (!"view".equalsIgnoreCase(op)) {%>
                                <div class="layui-col-md12 layui-col-md-offset4">
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button  class="layui-btn" lay-submit="" lay-filter="save" id="saveZbBtn" >保存主表信息
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <%} %>
                            </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="layui-colla-item" id="mxbxx" style="width: auto;display:none">
            <h2 class="layui-colla-title">明细表信息</h2>
            <div class="layui-colla-content layui-show">
                <div class="layui-margin-top-15">
                    <% if (!"view".equalsIgnoreCase(op)) {%>
                    <div class="layui-btn-group demoTable" id="toolbar">
                        <ck:permission biz="addHjyjcmxb">
                            <button class="layui-btn" data-type="addHjyjcmxb" data="btn_addHjyjcmxb">新增
                            </button>
                        </ck:permission>
                        <ck:permission biz="updateHjyjcmxb">
                            <button class="layui-btn" data-type="updateHjyjcmxb" data="btn_updateHjyjcmxb">编辑
                            </button>
                        </ck:permission>
                        <ck:permission biz="delHjyjcmxb">
                            <button class="layui-btn layui-btn-danger" data-type="delHjyjcmxb"
                                    data="btn_delHjyjcmxb">删除
                            </button>
                        </ck:permission>
                        <ck:permission biz="showHjyjcmxb">
                            <button class="layui-btn" data-type="showHjyjcmxb" data="btn_showHjyjcmxb">查看
                            </button>
                        </ck:permission>
                    </div>
                    <%} %>
                    <table class="layui-hide" id="hjyjcmxb" lay-filter="hjyjcmxb"></table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>