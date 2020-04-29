<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String newsid = StringHelper.showNull2Empty(request.getParameter("newsid"));
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String catejc = StringHelper.showNull2Empty(request.getParameter("catejc"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>法律法规条款</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var catejc = '<%=catejc%>';
        //下拉框列表
        var newscate = <%=SysmanageUtil.getNewsCatetoJsonArray()%>;
        var cbt_newcate;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        var selectNodes;
        var treeselect;
        function showCate() {
            var cityObj = $("#catename");
            var cityOffset = $("#catename").offset();
            $("#cateContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            refreshZTree();
        }
        function onBodyDown(event) {
            if (!(event.target.id == "cateBtn" || event.target.id == "cateContent"
                    || $(event.target).parents("#cateContent").length > 0)) {
                hideMenu();
            }
        }
        function hideMenu() {
            $("#cateContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "cateid",
                    pIdKey: "cateparentid",
                    rootPId: 0
                },
                key: {
                    name: "catename"
                }
            },
            callback: {
                onClick: onClick
            }
        };
        function refreshZTree() { //初始化父菜单下拉框
            //初始化树
            $.post(basePath + '/newscate/queryNewcateZTree', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                } else {
                    layer.alert(result.msg);
                }
            }, 'json');
        }
        //单击节点事件
        function onClick(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#cateid").val(nodes[0].cateid);
            $("#catename").val(nodes[0].catename);
            hideMenu();
        }
        $(function () {
            initData();
            //监听提交
            $("#btn_query").click(function () {
                query();
                return false;
            })
            $("#btn_reset").click(function () {
                reset();
                return false;
            })
        });

        function initData() {
            layui.use(['table', 'form', 'layer', 'element'], function () {
                table = layui.table;
                form = layui.form;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#table'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/news/queryNews?catejc=' + catejc
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
                        {field: 'newsid', width: 150, title: '法律编号', event: 'trclick'}
                        , {field: 'newstitle', width: 300, title: '法律标题', event: 'trclick'}
                        , {field: 'newsfrom', width: 150, title: '法律来源', event: 'trclick'}
                        , {
                            field: 'cateid', width: 120, title: '所属分类'
                            , templet: function (d) {
                                return '【<a href="<%=contextPath %>/news/queryNewsList?retPageStr=fl&pageSize=20&page=1&cateid='
                                        + d.cateid + '" title="' + sy.formatGridCode(d.cateid) + '" target="_blank">'
                                        + sy.formatGridCode(newscate, d.cateid) + '</a>】';
                            }
                            , event: 'trclick'
                        }
                        , {field: 'newstjsj', width: 150, title: '添加时间', event: 'trclick'}
                        , {
                            field: 'sfyx', width: 100, title: '是否有效'
                            , templet: function (d) {
                                if (d.sfyx == "1") {
                                    return '<span style="color:blue;">有效</span>';
                                } else {
                                    return '<span style="color:red;">无效</span>';
                                }
                            }
                            , event: 'trclick'
                        }
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId = '';
                        layer.close(mask);
                    }
                });
                // 监听工具条
                table.on('tool(FlfgFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.newsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.newsid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addflfg: function () { // 添加
                        addflfg();
                    }
                    , editflfg: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的记录！');
                        } else {
                            editflfg(table.singleData.newsid);
                        }
                    }
                    , delNews: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的记录！');
                        } else {
                            delNews(table.singleData);
                        }
                    }
                    , uploadFuJian: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要操作的记录');
                        } else {
                            uploadFuJian(table.singleData.newsid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        }
        function reset() {
            $('#catename').val('');
            $('#newstitle').val('');
            refresh('', '');
        }
        function query() {
            var cateid = $('#cateid').val();
            var newstitle = $('#newstitle').val();
            var param = {
                'cateid': cateid,
                'newstitle': newstitle
            };
            refresh(param, '');
        }

        // 新增
        function addflfg() {
            sy.modalDialog({
                title: '新增'
                , area: ['100%', '100%']
                , content: basePath + '/news/addFlfg'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return
            }
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }
        // 编辑
        function editflfg(newsid) {
            sy.modalDialog({
                title: '编辑'
                , area: ['100%', '100%']
                , content: basePath + '/news/editflfg?op=edit&&newsid=' + newsid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }

        // 删除
        function delNews(singleData) {
            var newsid = singleData.newsid;
            var sfyx = singleData.sfyx;
            if (sfyx == '1') {
                layer.alert('该法律当前处于有效状态，不可删除！');
                return;
            }
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , icon: '3'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/news/delNews', {
                                newsid: newsid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    //保证不会重复删除
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.table.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
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
        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('table', {
                url: basePath + '/news/queryNews?catejc=' + catejc
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
            /*		parent.window.refresh();*/
        }
        //附件管理
        function uploadFuJian(newsid) {
            var v_ajdjid = newsid;
            var v_fjcsdlbh = "GGFWFJ";//附件参数大类编号：公共服务系统附件
            var v_dmlb = "NEWSFJ";//附件参数小类编号：法律附件
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid
                    + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            sy.modalDialog({
                title: '附件管理'
                , area: ['100%', '100%']
                , content: url
                , btn: ['关闭']
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
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">法律分类</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="catename" id="catename" onclick="showCate();"
                                               class="layui-input layui-bg-gray"
                                               readonly>
                                        <input name="cateid" id="cateid" type="hidden"/>
                                    </div>
                                    <div id="cateContent" class="cateContent"
                                         style="display:none;position:fixed;z-index:333;">
                                        <ul id="treeDemo" class="ztree" style="height:250px;width: auto;"></ul>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">法律标题</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="newstitle" name="newstitle"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
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
        <ck:permission biz="addflfg">
            <button class="layui-btn" data-type="addflfg" data="btn_addflfg">增加</button>
        </ck:permission>
        <ck:permission biz="editflfg">
            <button class="layui-btn" data-type="editflfg" data="btn_editflfg">编辑</button>
        </ck:permission>
        <ck:permission biz="delFlfgtk">
            <button class="layui-btn layui-btn-danger" data-type="delNews" data="btn_delNews">删除</button>
        </ck:permission>
        <ck:permission biz="uploadFlfgtkFj">
            <button class="layui-btn " data-type="uploadFuJian" data="btn_uploadFuJian">附件管理</button>
        </ck:permission>
    </div>
    <table class="layui-hide" id="table" lay-filter="FlfgFilter"></table>
</div>
</div>
</body>
</html>