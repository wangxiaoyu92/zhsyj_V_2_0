<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
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
    <title>新闻管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        var newscate = <%=SysmanageUtil.getNewsCatetoJsonArray()%>;
        var form;
        var table;
        var layer;
        var selectTableDataId = '';
        var mask;
        $(function () {
            initData();
            $("#btn_query").click(function () {//查询
                query();
                return false;
            });
        });

        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#newsTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/news/queryNews'
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
                        {field: 'newsid', width: 150, title: '新闻编号', event: 'trclick'}
                        , {
                            field: 'newstitle', width: 410, title: '新闻标题'
                            , templet: function (d) {
                                return '<a href="<%=contextPath%>/news/queryNewsDetail?newsid='
                                        + d.newsid + '" title="' + d.newstitle + '" target="_blank">'
                                        + '<span style="color:blue;">' + d.newstitle + '</span></a>'
                            }
                            , event: 'trclick'
                        }
                        , {field: 'newsfrom', width: 150, title: '新闻来源', event: 'trclick'}
                        , {
                            field: 'newsispicture', width: 100, title: '是否图片新闻'
                            , templet: function (d) {
                                if (d.newsispicture == "1") {
                                    return '<span style="color:blue;">是</span>';
                                } else {
                                    return '<span style="color:red;">否</span>';
                                }
                            }, event: 'trclick'
                        }
                        , {
                            field: 'cateid', width: 120, title: '所属分类'
                            , templet: function (d) {
                                return '【<a href="<%=contextPath %>/news/queryNewsList?retPageStr=fl&pageSize=20&page=1&cateid='
                                        + d.cateid + '" title="' + sy.formatGridCode(newscate, d.cateid) + '" target="_blank">'
                                        + '<span style="color:blue;">' + sy.formatGridCode(newscate, d.cateid) + '</span></a>】';
                            }, event: 'trclick'
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
                        if (selectTableDataId != data.newsid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
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
                    addnews: function () { // 添加
                        addNews();
                    }
                    , editnews: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的新闻！');
                        } else {
                            editNews(table.singleData.newsid);
                        }
                    }
                    , delNews: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的新闻！');
                        } else {
                            delNews(table.singleData.newsid, table.singleData.sfyx);
                        }
                    }
                    , uploadFuJian: function () { // 附件管理
                        if (!table.singleData) {
                            layer.alert('请选择要操作的新闻！');
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

        //查询
        function query() {
            var cateid = $("#cateid").val();
            var newstitle = $("#newstitle").val();
            var param = {
                'cateid': cateid,
                'newstitle': newstitle
            };
            refresh(param, '');
        }

        // 新增
        function addNews() {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增'
                , content: basePath + '/news/addnews'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 编辑
        function editNews(newsid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '修改'
                , content: basePath + '/news/editnews?op=edit&&newsid=' + newsid
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
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
            table.reload('newsTable', {
                url: basePath + '/news/queryNews'
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
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == '') {
                return false;
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
        // 删除
        function delNews(newsid, sfyx) {
// gu20180724           if (sfyx == '1') {
//                layer.msg('该新闻当前处于有效状态，不可删除！');
//                return;
//            }
            layer.open({
                title: '警告'
                , content: '确定要删除该角色记录吗？这将删除对应的新闻、附件，且不可恢复！'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/news/delNews', {
                                newsid: newsid
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId = '';
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        if (table.cache.newsTable.length == 1) {
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
        //附件管理
        function uploadFuJian(newsid) {
            var v_ajdjid = newsid;
            var v_fjcsdlbh = "GGFWFJ";//附件参数大类编号：公共服务系统附件
            var v_dmlb = "NEWSFJ";//附件参数小类编号：新闻附件
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid
                    + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '附件管理'
                , content: [url, 'no']
                ,btn:['关闭']
            }, closeModalDialogCallback);
        }
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
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" style="height: auto">
                <form id="myqueryform" class="layui-form">
                    <div class="layui-container">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">新闻分类</label>

                                    <div class="layui-input-inline">
                                        <input type="text" name="catename" id="catename" onclick="showCate();" readonly
                                               class="layui-input layui-bg-gray">
                                        <input name="cateid" id="cateid" type="hidden"/>
                                    </div>
                                    <div id="cateContent" class="cateContent"
                                         style="display:none;position:fixed;z-index:333;">
                                        <ul id="treeDemo" class="ztree" style="height:250px;width: auto"></ul>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <label class="layui-form-label">新闻标题</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="newstitle" name="newstitle"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs4 layui-col-sm4">
                                    <div class="layui-input-inline">
                                        <ck:permission biz="queryNews">
                                            <button id="btn_query"
                                                    class="layui-btn layui-btn-sm layui-btn-normal">
                                                <i class="layui-icon">&#xe615;</i>搜索
                                            </button>
                                        </ck:permission>
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
            <ck:permission biz="addnews">
                <button class="layui-btn" data-type="addnews" data="btn_addnews">增加</button>
            </ck:permission>
            <ck:permission biz="editnews">
                <button class="layui-btn" data-type="editnews" data="btn_editnews">修改</button>
            </ck:permission>
            <ck:permission biz="delNews">
                <button class="layui-btn layui-btn-danger" data-type="delNews" data="btn_delNews">删除
                </button>
            </ck:permission>
            <ck:permission biz="uploadFuJian">
                <button class="layui-btn" data-type="uploadFuJian" data="btn_uploadFuJian">附件管理</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="newsTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>