<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>抽检任务管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <%--<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>--%>
    <script type="text/javascript">
        var v_cjjgrwjsbz = <%=SysmanageUtil.getAa10toJsonArray("CJJGRWJSBZ")%>;
        var v_jcrwzxzt = <%=SysmanageUtil.getAa10toJsonArray("JCRWZXZT")%>;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                intSelectData("jcrwzxzt", v_jcrwzxzt);
                intSelectData("cjjgrwjsbz", v_cjjgrwjsbz);
                form.render();
                table.render({
                    elem: '#cjrwTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'jyjc/queryCjrw'
                    , where: {
                        'querytype': 'jyjc'
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
                        //{field: 'jyjccjrwbid', width: 210, title: '检验检测抽检任务表id',hidden event: 'trclick'}
                       // , {field: 'comid', width: 150, title: '抽检单位id', event: 'trclick'}
                        {field: 'commc', width: 180, title: '被抽检单位名称', event: 'trclick'}
                         ,{field: 'jcrwmc', width: 180, title: '任务名称', event: 'trclick'}
                        , {field: 'jcrwms', width: 200, title: '任务描述', event: 'trclick'}
                        , {field: 'jcrwkssj', width: 140, title: '任务开始时间', event: 'trclick'}
                        , {field: 'jcrwjssj', width: 140, title: '任务结束时间', event: 'trclick'}
                        //, {field: 'cjjgcomid', width: 100, title: '承检机构id', event: 'trclick'}
                        ,{field: 'cjcommc', width: 180, title: '承检机构名称', event: 'trclick'}
                        , {field: 'cjjgrwjsbz', width: 150, title: '承检机构任务接受标志',
                            templet: function (d){
                                return sy.formatGridCode(v_cjjgrwjsbz, d.cjjgrwjsbz);
                        }, event: 'trclick'}
                        , {field: 'cjjgrwbjsyy', width: 200, title: '承检机构任务不接受原因说明', event: 'trclick'}
                        , {field: 'jcrwzxzt', width: 150, title: '任务执行状态',
                            templet: function (d){
                                return sy.formatGridCode(v_jcrwzxzt, d.jcrwzxzt);
                            },event: 'trclick'}
                        , {field: 'aae011', width: 100, title: '经办人', event: 'trclick'}
                        , {field: 'aae036', width: 140, title: '经办时间', event: 'trclick'}
                        /*, {fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}*/
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
                        if (selectTableDataId != data.jyjccjrwbid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.jyjccjrwbid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }else if(obj.event === 'handleCjrw'){
                        handleCjrw(data.jyjccjrwbid);
                    }
                });

                var $ = layui.$, active = {
                    addCjrw: function () { // 添加
                        addCjrw();
                    }
                    , updateCjrw: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的抽检任务！');
                        } else {
                            updateCjrw(table.singleData.jyjccjrwbid);
                        }
                    }
                    , delCjrw: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的抽检任务！');
                        } else {
                            delCjrw(table.singleData.jyjccjrwbid);
                        }
                    }
                    , showCjrw: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的抽检任务！');
                        } else {
                            showCjrw(table.singleData.jyjccjrwbid);
                        }
                    }, handleCjrw: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要处理的抽检任务！');
                        } else {
                            handleCjrw(table.singleData.jyjccjrwbid);
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

        function query() {
            var comid = $('#comid').val();
            var jcrwmc=$('#jcrwmc').val();
            var jyjccjrwbid=$('#jyjccjrwbid').val();
            var jcrwzxzt=$('#jcrwzxzt').val();
            var cjjgrwjsbz=$('#cjjgrwjsbz').val();
            var param = {
                'comid': comid,
                'jcrwzxzt':jcrwzxzt,
                'cjjgrwjsbz':cjjgrwjsbz,
                'jcrwmc':jcrwmc
            };
            refresh(param, '');
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
            table.reload('cjrwTable', {
                url: basePath + 'jyjc/queryCjrw'
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
        }

        // 新增抽检任务
        function addCjrw() {
            sy.modalDialog({
                title: '添加抽检任务'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/cjrwFormIndex?op=add'
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveCjrw();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var param = {
                querytype: "jyjc"
            }
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                //saveOk 在第一页刷新
                refresh(param, '');
            }
        }
        //编辑抽检任务
        function updateCjrw(jyjccjrwbid) {
            sy.modalDialog({
                title: '编辑抽检任务'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/cjrwFormIndex?op=edit&&jyjccjrwbid=' + jyjccjrwbid
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveCjrw();
                }
            }, closeModalDialogCallback);
        }
        ;

        // 删除抽检任务
        function delCjrw(jyjccjrwbid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项任务么？'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delCjrw', {
                                jyjccjrwbid: jyjccjrwbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        var param = {
                                            querytype: "jyjc"
                                        }
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.cjrwTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh(param, curent);
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

        //查看抽检任务
        function showCjrw(jyjccjrwbid) {
            sy.modalDialog({
                title: '查看抽检任务'
                , area: ['100%', '100%']
                , content: basePath + 'jyjc/cjrwFormIndex?op=view&jyjccjrwbid=' + jyjccjrwbid
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['关闭']
            });
        }
        //处理抽检任务
        function handleCjrw(jyjccjrwbid){
            sy.modalDialog({
                title: '处理抽检任务'
                , area: ['100%', '100%']
                , content: basePath + 'jsp/jyjc/handleCjrw.jsp'
                , param: {
                    jyjccjrwbid:jyjccjrwbid,
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveRwcl();
                }
            }, closeModalDialogCallback);
        }
        //选择抽检机构名称
        function myselectcom() {
            sy.modalDialog({
                title: '选择抽检单位'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comid").val(myrow.comid); //公司代码
                }
            });
        }
        /*
         //打印
         function print(){
         sy.doPrint('siweb/sysuser.cpt','')
         } 	*/
    </script>
    <style>
        .layui-form table tr td{
            padding: 5px;
        }
    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>
            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <table style="border: none">
                        <tr>
                            <td style="width: 70px;text-align: right" >抽检单位: </td>
                            <td style="width: 150px">
                                <input type="text" id="commc" name="commc" readonly height="50px" autocomplete="off" class="layui-input">
                                <input id="comid" name="comid" type="hidden">
                            </td>
                            <td style="width: 40px"><a href="javascript:void(0)" class="layui-btn layui-btn-sm"
                                   iconCls="icon-search" onclick="myselectcom()">选择</a>
                            </td>
                            <td style="width: 120px;text-align: right">抽检任务名称:</td>
                            <td style="width: 150px">
                                <input type="text" id="jcrwmc" name="jcrwmc" autocomplete="off" class="layui-input">
                            </td>
                            <td style="width: 100px;text-align: right">任务接受标志:</td>
                            <td style="width: 150px">
                                <select id="cjjgrwjsbz" name="cjjgrwjsbz"></select>
                            </td>
                            <td style="width: 200px;text-align: center">
                                <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                                    <i class="layui-icon">&#xe615;</i>搜索
                                </button>
                                <button class="layui-btn layui-btn-sm layui-btn-normal"
                                        id="btn_reset">
                                    <i class="layui-icon">&#xe621;</i>重置
                                </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addCjrw">
                <button class="layui-btn " data-type="addCjrw" data="btn_addCjrw">增加</button>
            </ck:permission>
            <ck:permission biz="updateCjrw">
                <button class="layui-btn " data-type="updateCjrw" data="btn_updateCjrw">编辑</button>
            </ck:permission>
            <ck:permission biz="delCjrw">
                <button class="layui-btn layui-btn-danger" data-type="delCjrw" data="btn_delCjrw">删除</button>
            </ck:permission>
            <ck:permission biz="showCjrw">
                <button class="layui-btn" data-type="showCjrw" data="btn_showCjrw">查看</button>
            </ck:permission>
            <ck:permission biz="handleCjrw">
                <button class="layui-btn" data-type="handleCjrw" data="btn_showCjrw">受理</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="cjrwTable" lay-filter="tableFilter"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="handleCjrw">受理</a>
        </script>
    </div>
</div>
</body>
</html>