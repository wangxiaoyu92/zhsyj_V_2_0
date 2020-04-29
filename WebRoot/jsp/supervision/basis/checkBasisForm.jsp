<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    // 检查内容id
    String contentid = StringHelper.showNull2Empty(request.getParameter("contentid"));
    //
    String basisid = StringHelper.showNull2Empty(request.getParameter("basisid"));
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检查依据</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUi" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        var contentid = '<%=contentid%>';
        // 下拉框列表
        var checkType = <%=SysmanageUtil.getAa10toJsonArray("CHECKTYPE")%>; // 检查方式
        var v_checkType;
        var basisLegalGrid = []; // 依据法律条款表
        var singleData1 = '';
        var selectTableDataId1 = '';
        var basisProblemGrid = []; // 依据问题表
        var singleData2 = '';
        var selectTableDataId2 = '';
        var form;
        var layer;
        var table;

        $(function () {

            layui.use(['form', 'layer', 'table'], function () {
                form = layui.form;
                layer = layui.layer;
                table = layui.table;
                showcomList();//检查方式下拉列表
                loadCheckBasisInfo(); // 加载检查依据信息
                table.render({
                    elem: '#basisLegalGrid'
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
                        {field: 'contentcode', title: '编号', event: 'trclick1'}
                        , {field: 'content', title: '内容', event: 'trclick1'}
                        , {field: 'contentsortid', title: '排序号', event: 'trclick1'}
                    ]]
                });
                // 监听工具条
                table.on('tool(basisLegalGrid)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick1') { // 选中行
                        if (selectTableDataId1 != data.contentid) {
                            // 清除所有行的样式
                            $($("#basisLegalGrid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#basisLegalGrid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.contentid;
                        } else { // 再次选中清除样式
                            $("#basisLegalGrid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    }
                });
                table.render({
                    elem: '#basisProblemGrid'
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
                        {field: 'problemdesc', title: '问题描述', event: 'trclick2'}
                    ]]

                });
                // 监听工具条
                table.on('tool(basisProblemGrid)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick2') { // 选中行
                        if (selectTableDataId2 != data.contentid) {
                            // 清除所有行的样式
                            $($("#basisProblemGrid").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#basisProblemGrid").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData2 = data;
                            selectTableDataId2 = data.problemdesc;
                        } else { // 再次选中清除样式
                            $("#basisProblemGrid").next().find(obj.tr.selector).attr("style", "");
                            table.singleData2 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });
                //监听复选框
                table.on('checkbox(basisProblemGrid)', function (obj) {
                    var checkStatus = table.checkStatus('basisProblemGrid');
                    basisProblemGrid = checkStatus.data;//获取被选中的数据
                });
                var $ = layui.$, active = {
                    selectFlfg: function () {//选择
                        selectFlfg();
                    }
                    , deleteFlfg: function () {
                        if (!table.singleData1) {
                            parent.layer.alert('请选择要删除的法律法规！');
                        } else {
                            deleteFlfg(table.singleData1.contentid);
                        }
                    }
                    , addBasisPro: function () {//添加常见问题
                        addBasisPro();
                    }
                    , delBasisPro: function () {//删除常见问题
                        if (!table.singleData2) {
                            parent.layer.alert('请选择要删除的问题！');
                        } else {
                            delBasisPro(table.singleData2.problemdesc);
                        }
                    }
                    , saveBasisPro: function () {//保存
                        saveBasisPro(basisProblemGrid);
                    }
                    , cancelBasisPro: function () {//取消
                        cancelBasisPro();
                    }
                };
                //按钮监测
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

                var lock = true;// 锁住表单   这里定义一把锁
                //保存
                form.on('submit(save)', function (data) {
                    var url = basePath + 'supervision/checkbasis/saveCheckBasis';
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false;
                })
            })

        });
        //检查方式下拉列表
        function showcomList() {
            for (var i = 0; i < checkType.length; i++) {
                $("#type").append('<option value=\'' + checkType[i].id + '\' >' + checkType[i].text + '</option>');
            }
            form.render('select');
        }
        // 加载检查依据信息
        function loadCheckBasisInfo() {
            if ($('#basisid').val().length > 0) {
                $.post(basePath + 'supervision/checkbasis/queryCheckBasisObj', {
                            basisid: $('#basisid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.basisInfo;
                                $('form').form('load', mydata); // 加载依据信息
                                basisLegalGrid = result.flfgInfo;
                                basisProblemGrid = result.problemInfo;
                                table.reload('basisLegalGrid', {data: result.flfgInfo});
                                table.reload('basisProblemGrid', {data: result.problemInfo});
                                form.render();
                            } else {
                                parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
            }
        }

        // 选择法律法规
        function selectFlfg() {
            var url = basePath + "/jsp/pub/pub/selectLaw.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%']
                , type: 2
                , title: '选择法律法规'
                , content: url
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].getDataInfo();
                }
            }, closeModalDialogCallback);
        }
        // 选择法律法规回调函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                var retData = obj.data;
                var loadData = basisLegalGrid.concat(retData); // 用当前表格数据合并返回的数据
                // 选中数据与已绑定数据比较，已有的不添加
                for (var i = 0; i < retData.length; i++) {
                    for (var j = 0; j < basisLegalGrid.length; j++) {
                        if (retData[i].contentid == basisLegalGrid[j].contentid) {
                            loadData.remove(retData[i]); // 去除重复的数据
                        }
                    }
                }
                basisLegalGrid = loadData;
                table.singleData1 = '';
                selectTableDataId1 = '';
                table.reload('basisLegalGrid', {data: loadData});
            }
        }
        // 删除法律法规
        function deleteFlfg(contentid) {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条法律法规吗?'
                , btn1: function (index, layero) {
                    var i = basisLegalGrid.length;
                    for (var j = 0; j < basisLegalGrid.length; j++) {
                        if (contentid == basisLegalGrid[j].contentid) {
                            basisLegalGrid.remove(basisLegalGrid[j]); // 去除数据
                        }
                    }
                    if (basisLegalGrid.length < i) {
                        layer.msg('删除成功', {time: 1000})
                        table.singleData1 = '';
                        selectTableDataId1 = '';
                        table.reload('basisLegalGrid', {data: basisLegalGrid});
                    } else {
                        layer.msg('删除失败', {time: 1000});
                    }
                }
            })
        }
        // 添加问题
        function addBasisPro() {
            layer.prompt({title: '请输入问题'}, function (value, index, elem) {
                var data = [];
                data.push({'problemdesc': html_encode(value)});
                var loadData = basisProblemGrid.concat(data);
                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < basisProblemGrid.length; j++) {
                        if (data[i].problemdesc == basisProblemGrid[j].problemdesc) {
                            loadData.remove(data[i]); // 去除重复的数据
                        }
                    }
                }
                basisProblemGrid = loadData;
                table.singleData2 = '';
                selectTableDataId2 = '';
                table.reload('basisProblemGrid', {data: basisProblemGrid});
                layer.close(index);
            });
        }
        //阻止html对内容编译
        function html_encode(strHTML) {
            var strTem = "";
            if (strHTML.length == 0) return "";
            strTem = strHTML.replace(/&/g, "&gt;");
            strTem = strTem.replace(/</g, "&lt;");
            strTem = strTem.replace(/>/g, "&gt;");
            strTem = strTem.replace(/ /g, "&nbsp;");
            strTem = strTem.replace(/\'/g, "&#39;");
            strTem = strTem.replace(/\"/g, "&quot;");
            strTem = strTem.replace(/\n/g, "");
            return strTem;
        }

        // 删除问题
        function delBasisPro(data) {
            layer.confirm('确定要删除该条问题吗?', {title: '警告'}, function (index) {
                for (var i = 0; i < basisProblemGrid.length; i++) {
                    if (data == basisProblemGrid[i].problemdesc) {
                        basisProblemGrid.remove(basisProblemGrid[i])
                    }
                }
                table.singleData2 = '';
                selectTableDataId2 = '';
                layer.close(index);
                table.reload('basisProblemGrid', {data: basisProblemGrid});
            })
        }

        // 取消
        function cancelBasisPro() {
            layer.confirm('确定要取消所有操作吗?', {title: '警告'}, function (index) {
                $.post(basePath + 'supervision/checkbasis/queryCheckBasisObj', {
                            basisid: $('#basisid').val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.basisInfo;
                                $('form').form('load', mydata); // 加载依据信息
                                basisProblemGrid = result.problemInfo;
                                table.reload('basisProblemGrid', {data: result.problemInfo});
                                form.render();
                            } else {
                                parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
                layer.close(index);
            })
        }

        // 确定
        function saveBasisPro() {
        }

        //保存
        function submitForm() {
            // 法律法规信息
            $('#flfgInfo').val($.toJSON(basisLegalGrid));
            // 常见问题信息
            $('#problemInfo').val($.toJSON(basisProblemGrid));
            $('#save').click();
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

    </script>
</head>
<body>
<div class="layui-table">


    <form id="fm" class="layui-form" action="">
        <div class="layui-container">
            <input id="contentid" name="contentid" type="hidden" value="<%=contentid%>">
            <input id="flfgInfo" name="flfgInfo" type="hidden">
            <input id="problemInfo" name="problemInfo" type="hidden">

            <div class="layui-row">
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">检查依据ID：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <input type="text" id="basisid" name="basisid" value="<%=basisid%>" readonly
                                   autocomplete="off" class="layui-input layui-bg-gray">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">检查方式：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <select id="type" name="type"></select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md10 layui-col-xs12 layui-col-sm12 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><font color="red">*</font>检查方式描述：</label>

                        <div class="layui-input-inline" style="width: 75%">
                        <textarea style="width: 100%;height: 100px" id="typedesc"
                                  name="typedesc" lay-verify="required"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><font color="red">*</font>检查指南：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <input type="text" id="guide" name="guide" lay-verify="required"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><font color="red">*</font>处罚措施：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <input type="text" id="punishmeasures" name="punishmeasures" lay-verify="required"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md10 layui-col-xs12 layui-col-sm12 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px"><font color="red">*</font>检查依据描述：</label>

                        <div class="layui-input-inline" style="width: 75%">
                             <textarea style="width: 100%;height: 100px" id="basisdesc"
                                       name="basisdesc" lay-verify="required"></textarea>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md10 layui-col-xs12 layui-col-sm12 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">法律依据：</label>

                        <div class="layui-input-inline" style="width: 75%">
                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="selectFlfg">
                                    <input type="button" class="layui-btn" data-type="selectFlfg"
                                           data="btn_selectFlfg"
                                           value="选择">
                                </ck:permission>
                                <ck:permission biz="deleteFlfg">
                                    <input type="button" class="layui-btn layui-btn-danger" data-type="deleteFlfg"
                                           data="btn_deleteFlfg" value="删除">
                                </ck:permission>
                            </div>
                            <table class="layui-hide" id="basisLegalGrid" lay-filter="basisLegalGrid"></table>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md10 layui-col-xs12 layui-col-sm12 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">常见问题：</label>

                        <div class="layui-input-inline" style="width: 75%">
                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="addBasisPro">
                                    <input type="button" value="添加" class="layui-btn" data-type="addBasisPro"
                                           data="btn_addBasisPro">
                                </ck:permission>
                                <ck:permission biz="delBasisPro">
                                    <input type="button" value="删除" class="layui-btn layui-btn-danger"
                                           data-type="delBasisPro" data="btn_delBasisPro">
                                </ck:permission>
                                <ck:permission biz="cancelBasisPro">
                                    <input type="button" value="取消" class="layui-btn" data-type="cancelBasisPro"
                                           data="btn_cancelBasisPro">
                                </ck:permission>
                            </div>
                            <table class="layui-hide" id="basisProblemGrid" lay-filter="basisProblemGrid"></table>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6 layui-col-md-offset1">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">经办人：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <input type="text" id="operatorname" name="operatorname" readonly
                                   autocomplete="off" class="layui-input layui-bg-gray">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md5 layui-col-xs12 layui-col-sm6">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 100px">经办时间：</label>

                        <div class="layui-input-inline" style="width: 50%">
                            <input type="text" id="operatedate" name="operatedate" readonly
                                   autocomplete="off" class="layui-input layui-bg-gray">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="save" id="save">保存
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>
