<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.lbs.util.StringUtils" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String id = StringHelper.showNull2Empty(request.getParameter("cydjid"));
    String jcbgrz = StringHelper.showNull2Empty(request.getParameter("jcbgrz"));
    String v_operatetype = StringHelper.showNull2Empty(request.getParameter("operatetype"));
    if (StringUtils.isEmpty(v_operatetype)){
        v_operatetype="aa";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测报告</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">

        var v_aae140 = <%=SysmanageUtil.getAa10toJsonArray("AAE140")%>;
        var v_jcjyshbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var v_shifoubz = <%=SysmanageUtil.getAa10toJsonArray("SHIFOUBZ")%>;
        var v_szdw = <%=SysmanageUtil.getAa10toJsonArray("SZDW")%>;
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var table;
        var layer;
        var mask;
        var cydjid = '<%=id%>';
        $(function () {
            layui.use(['table', 'layer', 'element'], function () {
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                //主表
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#hjyjczb'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/jyjc/queryHjyjczb_zm'
                    , where: {
                        'cydjid': cydjid,
                        detectiondatatype: 1
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
                        {field: 'hviewjgztmc', width: 180, title: '监管主体名称', event: 'trclick1'}
                        , {field: 'jyjcbgbh', width: 150, title: '检验检测报告编号', event: 'trclick1'}
                        , {field: 'jcorgmc', width: 180, title: '检测机构名称', event: 'trclick1'}
                        , {field: 'jcrymc', width: 150, title: '检测人员名称', event: 'trclick1'}
                        , {
                            field: 'jcjyshbz', width: 100, title: '审核标志见'
                            , templet: function (d) {
                                return formatGridColData(v_jcjyshbz, d.jcjyshbz);
                            }, event: 'trclick1'
                        }
                        , {field: 'jsbgrq', width: 110, title: '收到报告日期', event: 'trclick1'}
                        , {field: 'bgsdrq', width: 110, title: '报告送达日期', event: 'trclick1'}
                        , {field: 'jcksrq', width: 110, title: '检测开始日期', event: 'trclick1'}
                        , {field: 'jcjsrq', width: 110, title: '检测结束日期', event: 'trclick1'}
                        , {
                            field: 'cybgsfla', width: 80, title: '是否立案',
                            templet: function (d) {
                                return formatGridColData(v_shifoubz, d.cybgsfla);
                            }, event: 'trclick1'
                        }
                        , {field: 'ajdjbh', width: 150, title: '案件登记编号', event: 'trclick1'}
                        , {fixed: 'right', width:100, align:'center', toolbar: '#barDemo'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData1 = '';
                        selectTableDataId1 = '';
                        layer.close(mask);
                    }
                });

                // 主表监听工具条
                table.on('tool(hjyjczb)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick1') { // 选中行
                        if (selectTableDataId1 != data.hjyjczbid) {
                            // 清除所有行的样式
                            $($("#hjyjczb").next()).find(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $("#hjyjczb").next().find(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData1 = data;
                            selectTableDataId1 = data.hjyjczbid;
                        } else { // 再次选中清除样式
                            $("#hjyjczb").next().find(obj.tr.selector).attr("style", "");
                            table.singleData1 = '';
                            selectTableDataId1 = '';
                        }
                    }else if(obj.event === 'openMxb'){
                        openMxb(data.hjyjczbid);
                    }
                });
                var $ = layui.$, active = {
                    //主表
                    addHjyjczb: function () { // 添加
                        addHjyjczb();
                    }
                    , updateHjyjczb: function () { // 修改
                        if (!table.singleData1) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }
                    , delHjyjczb: function () { // 删除
                        if (!table.singleData1) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delHjyjczb(table.singleData1.hjyjczbid);
                        }
                    }
                    , showHjyjczb: function () { // 查看
                        if (!table.singleData1) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            showHjyjczb(table.singleData1.hjyjczbid);
                        }
                    },auditHjyjczb: function () { // 审核
                        if (!table.singleData1) {
                            layer.alert('请选择要审核的信息！');
                        } else {
                            auditHjyjczb(table.singleData1.hjyjczbid);
                        }
                    },hjyjczbFj: function () { // 附件上传
                        if (!table.singleData1) {
                            layer.alert('请选择要上传附件的信息！');
                        } else {
                            hjyjczbFj(table.singleData1.hjyjczbid);
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

        //检测图片上传
        function hjyjczbFj(hjyjczbid){
            parent.sy.modalDialog({
                title:'附件上传'
                ,area:['100%','100%']
                ,content: basePath +"pub/pub/uploadFjViewIndex?folderName=jchhgzm&fjtype=9&fjwid="+hjyjczbid
                ,btn:['关闭']
            })
        }

        //查询
        function query(){
            var jcypmc = $('#jcypmc').val();
            var jcorgmc = $('#jcorgmc').val();
            var param = {
                'jcypmc': jcypmc,
                'jcorgmc': jcorgmc,
                'cydjid': cydjid,
                detectiondatatype: 1
            };
            refresh(param, '');
        }

        //检测明细
        function openMxb(hjyjczbid){
            var url = '<%=basePath%>jsp/jyjc/hjyjcmxb.jsp';
            parent.sy.modalDialog({
                title: '检测明细'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                }
                , btn: ['关闭']
            });
        }

        // 主表新增
        var addHjyjczb = function () {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm?op=add';
            parent.sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%']
                , param: {
                    'cydjid': cydjid,
                    'jcbgrz':'<%=jcbgrz%>'
                }
                , content: url
                , btn: ['关闭']
            }, closeModalDialogCallback1);
        };

        // 主表编辑
        function updateHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm?op=edit';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , cydjid: cydjid
                }
                , btn: ['关闭']
            }, closeModalDialogCallback1);
        }

        // 主表审核
        function auditHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm?op=audit';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , cydjid: cydjid
                }
                , btn: ['关闭']
            }, closeModalDialogCallback1);
        }

        // 主表查看
        function showHjyjczb(hjyjczbid) {
            var url = '<%=basePath%>jyjc/hjyjczbForm_zm?op=view';
            parent.sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    hjyjczbid: hjyjczbid
                    , 'cydjid': cydjid
                    , 'op': 'view'
                }
                , btn: ['关闭']
            });
        }

        // 主表删除
        function delHjyjczb(hjyjczbid) {
            layer.open({
                title: '警告!'
                , icon: '3'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条记录吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + '/jyjc/delHjyjczb_zm', {
                                hjyjczbid: hjyjczbid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData1 = '';
                                    selectTableDataId1 = '';
                                    var param = {
                                        'cydjid': cydjid,
                                        detectiondatatype: 1
                                    }
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.hjyjczb.length == 1) {
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
        //主表子页面返回参数
        function closeModalDialogCallback1(dialogID) {
            var param = {
                'cydjid': cydjid,
                detectiondatatype: 1
            }
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                refresh(param, '');
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
            table.reload('hjyjczb', {
                url: basePath + '/jyjc/queryHjyjczb_zm'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData1 = '';
                    selectTableDataId1 = '';
                    layer.close(mask);
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <% if (!"chouyangdengji".equals(v_operatetype)){
        %>
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <table>
                        <tr>
                            <td style="width: 80px;text-align: right">商品名称:</td>
                            <td>
                                <input type="text" id="jcypmc" name="jcypmc"autocomplete="off"  class="layui-input">
                            </td>
                            <td style="width: 120px;text-align: right">检测机构名称：</td>
                            <td>
                                <input type="text" id="jcorgmc" name="jcorgmc" autocomplete="off" class="layui-input">
                            </td>
                            <td style="width: 200px;text-align: center">
                                <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                        lay-submit="">
                                    <i class="layui-icon">&#xe615;</i>搜索
                                </button>
                                <button class="layui-btn layui-btn-sm layui-btn-normal"
                                        id="btn_reset">
                                    <i class="layui-icon">&#xe621;</i>重置
                                </button>
                            </td>
                        </tr>
                    </table>
<%--                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">商品名称:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="jcypmc" name="jcypmc"
                                               autocomplete="off"  class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 120px">检测机构名称：</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="jcorgmc" name="jcorgmc"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12  layui-col-sm12">
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
                    </div>--%>
                </form>
            </div>
        </div>
        <%}%>
        <div class="layui-colla-item">
                <div class="layui-margin-top-15">
                    <div class="layui-btn-group demoTable" id="maintoolbar">
                        <ck:permission biz="addHjyjczbJcbg">
                            <button class="layui-btn" data-type="addHjyjczb" data="btn_addHjyjczb">新增
                            </button>
                        </ck:permission>
                        <ck:permission biz="updateHjyjczb">
                            <button class="layui-btn" data-type="updateHjyjczb" data="btn_updateHjyjczb">编辑
                            </button>
                        </ck:permission>
                        <ck:permission biz="delJcbgHjyjczb">
                            <button class="layui-btn layui-btn-danger" data-type="delHjyjczb" data="btn_delHjyjczb">删除
                            </button>
                        </ck:permission>
                        <ck:permission biz="showHjyjczb">
                            <button class="layui-btn" data-type="showHjyjczb" data="btn_showHjyjczb">查看
                            </button>
                        </ck:permission>
                        <ck:permission biz="auditHjyjczb">
                            <button class="layui-btn" data-type="auditHjyjczb" data="btn_auditHjyjczb">审核
                            </button>
                        </ck:permission>
                        <ck:permission biz="hjyjczbFj">
                            <button class="layui-btn" data-type="hjyjczbFj" data="btn_hjyjczbFj">检测图片上传
                            </button>
                        </ck:permission>
                    </div>
                    <table class="layui-hide" id="hjyjczb" lay-filter="hjyjczb"></table>
                    <script type="text/html" id="barDemo">
                        <a class="layui-btn layui-btn-xs" lay-event="openMxb">检测明细</a>
                    </script>
                </div>
        </div>
    </div>
</div>
</body>
</html>