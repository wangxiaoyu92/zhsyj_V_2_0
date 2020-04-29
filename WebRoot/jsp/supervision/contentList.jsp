<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
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
    <title>检查内容管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var selectTableDataId = '';
        var isParent = true;//父菜单
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法
                autoParam: ["itemid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "itemid",
                    pIdKey: "itempid",
                    rootPId: 0
                },
                key: {
                    name: "itemname"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        var contentImpt = <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>;
        var vSysUser = <%=SysmanageUtil.getSysuser().getUserid()%>;
        var contentimptCommbox;
        $(function () {
            initSelectData();
            initData()
            refreshZTree();
            //导入功能（admin 才有）
            if (vSysUser == "0") {
                $('#impdoc').css('display', '');
            }

        });

        function initData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , page: true // 展示分页
                    , limit: 10 // 每页展示条数
                    , limits: [10, 20, 30] // 每页条数选择项
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {field: 'contentcode', title: '编号', event: 'trclick'}
                        , {field: 'content', title: '内容', event: 'trclick'}
                        , {
                            field: 'contentimpt', title: '重要性'
                            , templet: function (d) {
                                return sy.formatGridCode(contentImpt, d.contentimpt);
                            }
                            , event: 'trclick'
                        }
                        , {field: 'contentscore', title: '评级分值', event: 'trclick'}
                        , {field: 'contentsortid', title: '排序号', event: 'trclick'}
//					, {fixed: 'right', align: 'center', toolbar: '#paramgridbtn'}
                    ]]
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.contentid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.contentid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    addContent: function () { // 添加
                        if (isParent) {
                            layer.alert('请选择左侧项目树叶子节点！');
                        } else {
                            addContent();
                        }
                    }
                    , editContent: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的项目！');
                        } else {
                            editContent(table.singleData.contentid);
                        }
                    }
                    , delContent: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的项目！');
                        } else {
                            delSysrole(table.singleData.contentid);
                        }
                    }
                    , viewContent: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的项目！');
                        } else {
                            viewContent(table.singleData.contentid);
                        }
                    }
                    , importDoc: function () {
                        if (!table.singleData) {
                            layer.alert('请选择要操作的项目！');
                        } else {
                            importDoc(table.singleData.contentid);
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
            })
        }


        //初始化下拉框选项数据
        function initSelectData() {
            var typeOptions = '';
            for (var i = 0; i < contentImpt.length; i++) {
                typeOptions += '<option value=\'' + contentImpt[i].id + '\' >' + contentImpt[i].text + '</option>';
            }
            $("#contentimpt").append(typeOptions);
        }

        //初始化检查项目树
        function refreshZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            if (!responseData) {
                for (var i = 0; i < responseData.length; i++) {
                    //将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
                    array[i] = {
                        id: responseData[i].itemid,
                        name: responseData[i].itemname,
                        isParent: false,
                        itemdesc: itemdesc
                    };
                }
            }
            return zNodes;
        }

        function onClick(e, treeId, treeNode) {
            $('#queryForm').form('load', treeNode);
            var itemid = $("#itemid").val();
            isParent = treeNode.isParent;
            var childnum = $("#childnum").val();
            if (childnum == null || childnum == 0) {
                var param = {
                    'itemid': itemid
                };
                refresh(param, '');
            }
        }
    </script>
    <script type="text/javascript">
        var setting2 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/supervision/checkinfo/queryItemZTreeAsync',  //调用后台的方法
                autoParam: ["itemid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "itemid",
                    pIdKey: "itempid",
                    rootPId: 0
                },
                key: {
                    name: "itemname"
                }
            },
            callback: {
                onClick: onClick2
            }
        };

        //单击节点事件
        function onClick2(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
            var nodes = zTree.getSelectedNodes();
            $("#itempid").val(nodes[0].itempid);
            $("#itemid").val(nodes[0].itemid);
            $("#childnum").val(nodes[0].childnum);
            $("#parentname").val(nodes[0].parentname);
            $("#itemname").val(nodes[0].itemname);
            hideMenu();
        }

        function showMenu() {
            var cityObj = $("#parentname");
            var cityOffset = $("#parentname").offset();
            $("#menuContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            queryItemCombotree();
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent"
                    || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu();
            }
        }

        function queryItemCombotree() { //初始化项目树下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }

        // 查询
        function query() {
            var itemid = $("#itemid").val();
            var itemname = $("#itemname").val();
            var childnum = $("#childnum").val();
            if (itemid == null || itemid == '' || itemname == null || itemname == '' || childnum == null || childnum > 0) {
                layer.alert('请选择左侧项目树叶子节点或填写搜索条件');
                return;
            }
            var param = {
                'itemid': itemid
            };
            refresh(param, '');
        }

        // 新增项目内容
        var addContent = function () {
            var itemid = $("#itemid").val();
            sy.modalDialog({
                title: '添加'
                , area: ['100%', '100%'] //
                , content: basePath + '/supervision/checkinfo/contentForm?itemid=' + itemid
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        // 刷新
        function refresh(param, cur) {
            table.singleData = '';
            selectTableDataId = '';
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('roleTable', {
                url: basePath + '/supervision/checkinfo/queryContent'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == '') {
                return
            }
            var param = {
                'itemid': $("#itemid").val()
            };
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                //saveOk 在第一页刷新
                refresh('', '');
            }
        }
        ;
        //编辑项目内容editContent(table.singleData.contentid);
        function editContent(contentid) {
            sy.modalDialog({
                title: '修改'
                , area: ['100%', '100%'] //
                , content: basePath + '/supervision/checkinfo/contentForm?op=edit&contentid=' + contentid
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        function delSysrole(contentid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + '/supervision/checkinfo/delContent', {
                                contentid: contentid
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
                                        if (table.cache.roleTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var param = {
                                            'itemid': $("#itemid").val()
                                        };
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


        function viewContent(contentid) {
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , title: '查看'
                , content: basePath + '/supervision/checkinfo/contentForm?op=view&contentid=' + contentid
                , shade: [0.8, 'gray'] // 遮罩
                , btn: ['关闭'] //可以无限个按钮
            })

        }

        function importDoc(contentid) {
            sy.modalDialog({
                title: '模板导入'
                , area: ['100%', '100%'] //
                , content: basePath + '/supervision/checkinfo/toImportWordInfo'
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback)
        }
    </script>
</head>
<body>
<div class="layui-layout-body">
    <div class="layui-side layui-bg-gray" style="width: 250px;">
        <div class="layui-side-scroll" style="width:250px;">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="layui-body" style="margin-left: 55px; width: 80%;">
        <div class="layui-collapse">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">检查项目信息</h2>

                <div class="layui-colla-content layui-show">
                    <form class="layui-form" id="queryForm" style="height: auto">
                        <div class="layui-fluid">
                            <div class="layui-row">
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">项目名称</label>

                                        <div class="layui-input-inline" style="width: auto">
                                            <input type="text" readonly="readonly" id="itemname" name="itemname" onclick="showMenu();"
                                                    style="width:120px" autocomplete="off" class="layui-input layui-bg-gray">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">父项目名称</label>

                                        <div class="layui-input-inline"style="width: auto">
                                            <%--<div class="layui-input-block">--%>
                                            <input type="text" id="parentname" name="parentname" readonly="readonly"
                                                   onclick="showMenu();" style="width:120px" class="layui-input layui-bg-gray">
                                            <input name="itempid" id="itempid" type="hidden"/>
                                            <input type="hidden" id="itemid" name="itemid"
                                                   readonly="readonly"
                                                   class="input_readonly"/>
                                            <input type="hidden" id="childnum" name="childnum"
                                                   readonly="readonly" class="input_readonly"/>
                                            <%--</div>--%>
                                        </div>
                                        <div id="menuContent" class="layui-side layui-bg-gray"
                                             style="display:none; position:fixed;z-index:333;height: 200px">
                                            <ul id="treeDemo2" class="ztree"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 ">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label"></label>

                                        <div class="layui-input-inline" style="width: auto">
                                            <ck:permission biz="queryContent">
                                                <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                        lay-submit="" data="btn_queryContent">
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
                <ck:permission biz="addContent">
                    <button class="layui-btn" data-type="addContent" data="btn_addContent">增加</button>
                </ck:permission>
                <ck:permission biz="editContent">
                    <button class="layui-btn" data-type="editContent" data="btn_editContent">修改</button>
                </ck:permission>
                <ck:permission biz="delContent">
                    <button class="layui-btn layui-btn-danger" data-type="delContent" data="btn_delContent">删除</button>
                </ck:permission>
                <ck:permission biz="viewContent">
                    <button class="layui-btn" data-type="viewContent" data="btn_viewContent">查看</button>
                </ck:permission>
                <ck:permission biz="importDoc">
                    <button id="impdoc" class="layui-btn" data-type="importDoc" data="btn_importDoc">模板导入</button>
                </ck:permission>
            </div>
            <table class="layui-hide" id="roleTable" lay-filter="tableFilter"></table>
        </div>
    </div>
</div>
</body>
</html>