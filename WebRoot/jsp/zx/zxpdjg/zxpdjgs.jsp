<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }

    String djcshh = StringHelper.showNull2Empty(request.getParameter("djcshh"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>诚信评定结果</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        //红黑榜等级
        var djcshh = <%=SysmanageUtil.getAa10toJsonArray("DJCSHH")%>;
        var v_djcshh='<%=djcshh%>';
        //生成方式
        var pdjgscfs =<%=SysmanageUtil.getAa10toJsonArray("PDJGSCFS")%>
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        $(function () {
//            intSelectData('djcshh', djcshh);
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#zxpdjgTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'zx/zxpdjg/queryZxpdjgs?djcshh='+v_djcshh
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
                        {field: 'comid', width: 150, title: '企业ID', event: 'trclick'}
                        , {field: 'commc', width: 150, title: '企业名称', event: 'trclick'}
                        , {field: 'niandu', width: 150, title: '年度', event: 'trclick'}
                        , {field: 'pdjgdf', width: 150, title: '得分', event: 'trclick'}
                        , {field: 'djcsbm', width: 150, title: '等级编码', event: 'trclick'}
                        ,{field: 'djcshh',  title: '等级红黑'
                            ,templet : function(d){
                            return formatGridColData(djcshh, d.djcshh);
                        }
                            ,event: 'trclick'}
                        , {field: 'czyxm', width: 150, title: '操作员姓名', event: 'trclick'}
                        , {field: 'czsj', width: 150, title: '操作时间', event: 'trclick'}
                        , {
                            field: 'pdjgscfs', width: 150, title: '产生方式', event: 'trclick'
                            , templet: function (d) {
                                return formatGridColData(pdjgscfs, d.pdjgscfs);
                            }
                        }
                        , {field: 'beizhu', width: 150, title: '备注', event: 'trclick'}
                    ]]
                });

                form.render();
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
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
                    add: function () { // 添加
                        add();
                    }
                    , edit: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的企业评定信息！');
                        } else {
                            edit(table.singleData.pdjgid);
                        }
                    }
                    , del: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的企业评定信息！');
                        } else {
                            del(table.singleData.pdjgid);
                        }
                    }
                    , show: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的企业评定信息！');
                        } else {
                            show(table.singleData.pdjgid);
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
                $("#btn_reset").click(function () {
                    reset();
                    return false;
                })
            });
        })
        //页面加载完成自动生成年度信息
        $(function () {
            var year = new Date().getFullYear();
            for (var i = year; i > 2010; i--) {
                var temp = '<option value=' + (i) + '>' + i + '</option>';
                //设置value的值和列表参数
                var $time = $(temp);
                $("#niandu").append($time);
            }
        });
        //查询企业诚信评定结果
        function query() {
            var param = {
                'commc': $('#commc').val(),
                'niandu': $('#niandu').val(),
                'djcshh':v_djcshh
            };
            table.reload('zxpdjgTable', {
                url: basePath + 'zx/zxpdjg/queryZxpdjgs'
                ,where: param //设定异步数据接口的额外参数
            })
        }
        function reset(){
            $('#commc').val('');
            $('#niandu').val('');
            query();
        }


        function add() {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增'
                , content: basePath + '/zx/zxpdjg/zxpdjgsFormIndex?djcshh='+v_djcshh
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function del(pdjgid) {
            layer.confirm('您确定要删除该条信息吗！', function (index) {
                $.post(basePath + 'zx/zxpdjg/delZxpdjg', {
                        pdjgid: pdjgid
                    },
                    function (result) {
                        if (result.code == '0') {
                            parent.layer.msg('删除成功', {time: 1000}, function () {
                                reset();
                            });
                        } else {
                            layer.msg('删除失败' + result.msg);
                        }
                    },
                    'json');
                layer.close(index);
            });
        }
        function edit(pdjgid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '编辑'
                , content: basePath + '/zx/zxpdjg/zxpdjgsFormIndex?pdjgid=' + pdjgid + '&op=edit'+ '&djcshh='+v_djcshh
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        function show(pdjgid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看'
                , content: basePath + '/zx/zxpdjg/zxpdjgsFormIndex?pdjgid=' + pdjgid + '&op=view'+ '&djcshh='+v_djcshh
                , btn: ['关闭'] //可以无限个按钮
            })
        }
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return;
            }
            if (obj.type == "ok") {
                reset();
            }
        }


    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>
            <div class="layui-colla-content layui-show" style="height: 80px">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 120px">企业名称</label>

                        <div class="layui-input-inline">
                            <input type="text" id="commc" name="commc"
                                   autocomplete="off" class="layui-input">
                        </div>
                        <%--<label class="layui-form-label" style="width:120px;">企业红黑</label>--%>
                        <%--<div class="layui-input-inline">--%>
                            <%--<select name="djcshh" id="djcshh"></select>--%>
                        <%--</div>--%>
                        <label class="layui-form-label" style="width: 120px">年度</label>
                        <div class="layui-input-inline">
                            <select name="niandu" id="niandu">
                                <option value="">==请选择==</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-input-inline" style="text-align: left">
                        <label class="layui-form-label" style="width: 470px"></label>
                        <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button class="layui-btn layui-btn-sm layui-btn-normal"
                                id="btn_reset">
                            <i class="layui-icon">&#xe621;</i>重置
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="add">
                <button class="layui-btn" data-type="add" data="btn_add">增加</button>
            </ck:permission>
            <ck:permission biz="edit">
                <button class="layui-btn" data-type="edit" data="btn_edit">修改</button>
            </ck:permission>
            <ck:permission biz="del">
                <button class="layui-btn layui-btn-danger" data-type="del" data="btn_del">删除
                </button>
            </ck:permission>
            <ck:permission biz="show">
                <button class="layui-btn" data-type="show" data="btn_show">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="zxpdjgTable" lay-filter="tableFilter">
            <input type="hidden" id="pdjgid" name="pdjgid"/>
        </table>
    </div>
</div>
</body>
</html>