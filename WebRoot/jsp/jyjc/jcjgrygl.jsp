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
    <title>检测人员信息管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <%--<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>--%>
    <script type="text/javascript">
        var selectTableDataId = '';
        //下拉框列表
        //证件类型
        var ryzjlx = <%=SysmanageUtil.getAa10toJsonArray("RYZJLX")%>;
        //人员性别
        var ryxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        //人员民族
        var rymz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
        //人员学历
        var ryxueli = <%=SysmanageUtil.getAa10toJsonArray("RYXUELI")%>;

        var cb_ryzjlx;
        var cb_ryxb;
        var cb_ryxueli;
        var cb_rymz;
        var grid;
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;

        $(function () {
            var param;
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#JyjcryTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'pcomry/queryPcomry'
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
                        {field: 'ryid', width: 210, title: '人员ID', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '检测名称', event: 'trclick'}
                        , {field: 'ryxm', width: 100, title: '人员姓名', event: 'trclick'}
                        , {field: 'comryusername', width: 120, title: '人员登录系统账号', event: 'trclick'}
                        , {
                            field: 'ryzjlx', width: 150, title: '证件类型'
                            , templet: function (d) {
                                return sy.formatGridCode(ryzjlx, d.ryzjlx);
                            }, event: 'trclick'
                        }
                        , {field: 'ryzwgwinfo', width: 110, title: '职务岗位', event: 'trclick'}
                        , {field: 'ryzjh', width: 150, title: '证件号码', event: 'trclick'}
                        , {field: 'rylxdh', width: 100, title: '联系人电话', event: 'trclick'}
                        , {
                            field: 'rymz', width: 100, title: '人员民族'
                            , templet: function (d) {
                                return sy.formatGridCode(rymz, d.rymz);
                            }, event: 'trclick'
                        }
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
                        if (selectTableDataId != data.ryid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.ryid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addJyjcry: function () { // 添加
                        addJyjcry();
                    }
                    , updateJyjcry: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的人员信息！');
                        } else {
                            updateJyjcry(table.singleData.ryid);
                        }
                    }
                    , delJyjcry: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的人员信息！');
                        } else {
                            delJyjcry(table.singleData.ryid);
                        }
                    }
                    , showJyjcry: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的人员信息！');
                        } else {
                            showJyjcry(table.singleData.ryid);
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

//        //确定
//        function queding() {
//            if (table.singleData != null && table.singleData != '') {
//                var obj = new Object();
//                obj.data = table.singleData;
//                obj.type = "ok";
//                sy.setWinRet(obj);
//                parent.layer.close(parent.layer.getFrameIndex(window.name));
//            } else {
//                layer.alert('请选择' + mc + '信息！');
//            }
//        }

        function query() {
            var ryxm = $('#ryxm').val();
            var ryzjh = $('#ryzjh').val();
            var commc = $('#commc').val();
            var param = {
                'ryxm': ryxm,
                'ryzjh': ryzjh,
                'commc': commc
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
            table.reload('JyjcryTable', {
                url: basePath + 'pcomry/queryPcomry'
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

        // 新增人员信息
        function addJyjcry() {
            sy.modalDialog({
                title: '添加人员信息'
                , area: ['100%', '100%']
                , content: basePath + '/pcomry/pcomryFormIndex'
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].savePcomry();
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
        //编辑人员信息
        function updateJyjcry(ryid) {
            sy.modalDialog({
                title: '编辑人员信息'
                , area: ['100%', '100%']
                , content: basePath + 'pcomry/pcomryFormIndex?op=edit&&ryid=' + ryid
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].savePcomry();
                }
            }, closeModalDialogCallback);
        }
        ;

        // 删除
        function delJyjcry(ryid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'pcomry/delPcomry', {
                                ryid: ryid
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
                                        if (table.cache.JyjcryTable.length == 1) {
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

        //查看人员信息
        function showJyjcry(ryid) {
            sy.modalDialog({
                title: '查看人员信息'
                , area: ['100%', '100%']
                , content: basePath + '/pcomry/pcomryFormIndex?op=view&ryid=' + ryid
                , param: {
                    querytype: "jyjc"
                }
                , btn: ['关闭']
            });
        }
        ;
        //选择检测机构名称
        function myselectcom() {
            sy.modalDialog({
                title: '选择检测机构'
                , area: ['100%', '100%']
                , content: basePath + 'pub/pub/selectcomIndex'
                , param: {querytype: "jyjc"}
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
                    $("#comdm").val(myrow.comdm); //公司代码
                }
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
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检测名称:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" readonly
                                               autocomplete="off" class="layui-input">
                                        <input id="comdm" name="comdm" type="hidden">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择检测机构 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">人员姓名:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="ryxm" name="ryxm" placeholder="请输入人员姓名"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">证件号码:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="ryzjh" name="ryzjh" placeholder="请输入证件号码"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
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
            <ck:permission biz="addJyjcry">
                <button class="layui-btn" data-type="addJyjcry" data="btn_addJyjcry">增加</button>
            </ck:permission>
            <ck:permission biz="updateJyjcry">
                <button class="layui-btn" data-type="updateJyjcry" data="btn_updateJyjcry">编辑</button>
            </ck:permission>
            <ck:permission biz="delJyjcry">
                <button class="layui-btn layui-btn-danger" data-type="delJyjcry" data="btn_delJyjcry">删除</button>
            </ck:permission>
            <ck:permission biz="showJyjcry">
                <button class="layui-btn " data-type="showJyjcry" data="btn_showJyjcry">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="JyjcryTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>