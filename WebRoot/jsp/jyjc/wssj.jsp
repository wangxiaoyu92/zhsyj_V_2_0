<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String userkind = sysuser.getUserkind();

%>
<!DOCTYPE html>
<html>
<head>
<title>检验机构管理</title>
<jsp:include page="${contextPath}/inc.jsp">
    <jsp:param name="isLayUI" value="false"/>
</jsp:include>
<script type="text/javascript">
    var selectTableDataId = '';
    var table; // 数据表格
    var form; // form表单（查询条件）
    var layer; // 弹出层
    // 企业大类
    var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
    var mask;
    $(function () {
        layui.use(['form', 'table', 'layer', 'element'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            var element = layui.element;
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.render({
                        elem: '#wssjTable'
                        , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                        , url: basePath + 'jyjc/queryWssj'
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
                            {field: 'commc', width: 120, title: '单位名称', event: 'trclick'}
                            , {field: 'lxr', width: 100, title: '联系人', event: 'trclick'}
                            , {field: 'lxdh', width: 150, title: '联系电话', event: 'trclick'}
                            , {field: 'sqjcwp', width: 150, title: '申请检测物品', event: 'trclick'}
                            , {field: 'sqyy', width: 150, title: '申请原因', event: 'trclick'}
                            , {field: 'sqczyname', width: 100, title: '申请操作员姓名', event: 'trclick'}
                            , {field: 'sqsj', width: 140, title: '申请时间', event: 'trclick'}
                            , {field: 'shbz', width: 100, title: '审核标志', event: 'trclick',
                                templet: function (d) {
                                    if(sy.formatGridCode(v_shbz, d.shbz)){
                                        return sy.formatGridCode(v_shbz, d.shbz);
                                    }else{
                                        return '未审'
                                    }

                                }
                            }
                            , {field: 'shwtgyy', width: 150, title: '审核未通过原因', event: 'trclick'}
                            , {field: 'shczyname', width: 100, title: '审核操作员姓名', event: 'trclick'}
                            , {field: 'shsj', width: 140, title: '审核时间', event: 'trclick'}
                            , {field: 'jcorgmc', width: 150, title: '检测机构名称', event: 'trclick'}
                            , {fixed: 'right', width:180, align:'center', toolbar: '#barDemo'}
                        ]]
                        , done: function (res, curr, count) {
                           //gu20180603 if("30" =='<%=userkind%>'){
                            //    $("td[data-field='12']").hide();
                            //    $("th[data-field='12']").hide();
                           // };
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                        }
                    }
            );
            // 监听工具条
            table.on('tool(tableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'trclick') { // 选中行
                    if (selectTableDataId != data.jyjcwssjid) {
                        // 清除所有行的样式
                        $(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $(obj.tr.selector).css("background", "#90E2DA");
                        table.singleData = data;
                        selectTableDataId = data.jyjcwssjid;
                    } else { // 再次选中清除样式
                        $(obj.tr.selector).attr("style", "");
                        table.singleData = '';
                        selectTableDataId = '';
                    }
                }else if(obj.event === 'lrsj'){
                    lrsj(data.jyjcwssjid);
                }else if(obj.event === 'wssjsh'){
                    wssjsh(data.jyjcwssjid);
                }
            });

            var $ = layui.$, active = {
                addWssj: function () { // 添加
                    addWssj();
                }
                , updateWssj: function () { // 修改
                    if (!table.singleData) {
                        layer.alert('请选择要修改的信息！');
                    } else {
                        updateWssj(table.singleData.jyjcwssjid);
                    }
                }
                , delWssj: function () { // 删除
                    if (!table.singleData) {
                        layer.alert('请选择要删除的信息！');
                    } else {
                        delWssj(table.singleData.jyjcwssjid);
                    }
                }
                , showWssj: function () { // 显示
                    if (!table.singleData) {
                        layer.alert('请选择要查看的信息！');
                    } else {
                        showWssj(table.singleData.jyjcwssjid);
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
    function wssjsh(jyjcwssjid){
        sy.modalDialog({
            title: '审核'
            , area: ['100%', '100%']
            , content: basePath + '/jyjc/wssjFormIndex?op=sh&jyjcwssjid='+jyjcwssjid
            , btn: ['保存', '取消']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, closeModalDialogCallback);
    }
    function lrsj(jyjcwssjid){
        var url = '<%=basePath%>jsp/jyjc/jcsjlr.jsp';
        sy.modalDialog({
            title: '检测数据录入'
            , area: ['100%', '100%']
            , content: url
            , param: {
                cydjid: jyjcwssjid,
                useparent:1
            }
            , btn: ['关闭']
        });
    }
    //        查询机构信息
    function query() {
        var param = {
            'commc': $('#commc').val()
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
        table.reload('wssjTable', {
            url: basePath + 'jyjc/queryWssj'
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

    // 新增机构
    function addWssj() {
        sy.modalDialog({
            title: '添加'
            , area: ['100%', '100%']
            , content: basePath + '/jyjc/wssjFormIndex?op=add'
            , btn: ['保存', '取消']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, closeModalDialogCallback);
    }

    //查看机构信息
    function showWssj(jyjcwssjid) {
        sy.modalDialog({
            title: '查看'
            , area: ['100%', '100%']
            , content: basePath + '/jyjc/wssjFormIndex?op=view&jyjcwssjid=' + jyjcwssjid
            , btn: ['关闭']
        });
    }
    //编辑机构信息
    function updateWssj(jyjcwssjid) {
        sy.modalDialog({
            title: '修改'
            , area: ['100%', '100%']
            , content: basePath + '/jyjc/wssjFormIndex?op=edit&&jyjcwssjid=' + jyjcwssjid
            , btn: ['保存', '取消']
            , btn1: function (index, layero) {
                window[layero.find('iframe')[0]['name']].submitForm();
            }
        }, closeModalDialogCallback);
    }
    function closeModalDialogCallback(dialogID) {
        var obj = sy.getWinRet(dialogID);
        sy.removeWinRet(dialogID);
        if (obj == null || obj == '') {
            return;
        }
        if (obj.type == "ok") {
            var curent = $(".layui-laypage-skip input[class='layui-input']").val();
            refresh('', curent);
        } else {
            refresh('', '');
        }
    }
    // 删除
    function delWssj(jyjcwssjid) {
        layer.open({
            title: '警告'
            , content: '你确定要删除该项记录么？'
            , icon: 3
            , btn: ['确定', '取消'] //可以无限个按钮
            , btn1: function (index, layero) {
                $.post(basePath + 'jyjc/delWssj', {
                            jyjcwssjid: jyjcwssjid
                        },
                        function (result) {
                            if (result.code == '0') {
                                //保证不会重复删除
                                table.singleData = '';
                                selectTableDataId = '';
                                //本页的值
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                layer.msg('删除成功', {time: 1000}, function () {
                                    var param ={'querytype': "jyjc"};
                                    //如果是本页最后一条数据 则返回上一页
                                    if (table.cache.wssjTable.length == 1) {
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
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">单位名称</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" placeholder="请输入机构名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 ">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

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
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <%if (!"6".equals(sysuser.getUserkind())&&!"7".equals(sysuser.getUserkind())
                    &&!"8".equals(sysuser.getUserkind())) {%>
            <ck:permission biz="addWssj">
                <button class="layui-btn" data-type="addWssj" data="btn_addWssj">增加</button>
            </ck:permission>
            <ck:permission biz="updateWssj">
                <button class="layui-btn" data-type="updateWssj" data="btn_updateWssj">修改</button>
            </ck:permission>
            <ck:permission biz="delWssj">
                <button class="layui-btn layui-btn-danger" data-type="delWssj" data="btn_delWssj">删除</button>
            </ck:permission>
            <%} %>
            <ck:permission biz="showWssj">
                <button class="layui-btn " data-type="showWssj" data="btn_showWssj">查看</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="wssjTable" lay-filter="tableFilter"></table>
        <script type="text/html" id="barDemo">

            <a class="layui-btn layui-btn-xs" lay-event="lrsj">检测数据</a>

            <% if (!"20".equals(sysuser.getUserkind())&&!"21".equals(sysuser.getUserkind())
                    &&!"30".equals(sysuser.getUserkind())&&!"6".equals(sysuser.getUserkind())&&!"7".equals(sysuser.getUserkind())&&!"8".equals(sysuser.getUserkind())) {%>
            <a class="layui-btn layui-btn-xs" lay-event="wssjsh">审核</a>
            <%}%>
        </script>
    </div>
</div>
</body>
</html>