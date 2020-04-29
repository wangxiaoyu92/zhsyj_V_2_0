<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    <title>检查项和企业关系管理</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <style type="text/css">
        /**treeselect*/
        .layui-form-select .layui-tree {
            display: none;
            position: absolute;
            left: 0;
            top: 42px;
            padding: 5px 0;
            z-index: 999;
            min-width: 100%;
            border: 1px solid #d2d2d2;
            max-height: 300px;
            overflow-y: auto;
            background-color: #fff;
            border-radius: 2px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .12);
            box-sizing: border-box;
        }

        .layui-form-selected .layui-tree {
            display: block;
        }
    </style>
    <script type="text/javascript">
        var form;
        var table;
        var layer;
        var selectTableDataId1 = '';
        var selectTableDataId2 = '';
        var aaa102value;
        var aaa102Options = '';
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#roleTable'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + '/supervision/checkinfo/getcheckAndTypeList'
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
                        {field: 'aaa100', width: 150, title: '编码', event: 'trclick'}
                        , {field: 'aaa103', width: 200, title: '类别', event: 'trclick'}
                        , {field: 'itemname', width: 350, title: '内容', event: 'trclick'}
                    ]]
                    , done: function (res, curr, count) {
                        table.singleData = '';
                        selectTableDataId1 = '';
                        selectTableDataId2 = '';
                        layer.close(mask);
                    }
                });

                // 监听工具条
                table.on('tool(paramgridfilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId1 != data.itemtype || selectTableDataId2 != data.basetype) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId1 = data.itemtype;
                            selectTableDataId2 = data.basetype;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId1 = '';
                            selectTableDataId2 = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    saveCheckAndtype: function () { // 添加
                        saveCheckAndtype();
                    }
                    , editCheckAndtype: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            editCheckAndtype(table.singleData.basetype, table.singleData.itemtype);
                        }
                    }
                    , delContent: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delContent(table.singleData.basetype, table.singleData.itemtype);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
                form.on('radio(comdalei)', function (data) {//单选框点击事件
                    var val = data.value
                    showcomList(val);
                    form.render('select');//重新渲染form表单
                });

            });
            $("#btn_query").click(function () {//查询
                query();
                return false;
            })
            //初始化类别下拉列表
            showcomList('comdalei');
        })

        //类别下拉列表
        function showcomList(val) {
            if ("comdalei" == val) {
                aaa102value =<%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
                aaa102Options = '';
                for (var i = 0; i < aaa102value.length; i++) {
                    aaa102Options += '<option value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                }
                $("#aaa102").html(aaa102Options);

            } else if ("comxiaolei" == val) {
                aaa102value =<%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>;
                aaa102Options = '';
                for (var i = 0; i < aaa102value.length; i++) {
                    aaa102Options += '<option value=\'' + aaa102value[i].id + '\' >' + aaa102value[i].text + '</option>';
                }
                $("#aaa102").html(aaa102Options);
            }
        }
    </script>
    <script type="text/javascript">
        // 查询
        function query() {
            var itemid = $("#itemid").val();
            var aaa100 = $("#aaa100").val();
            var aaa102 = $("#aaa102").val();
            var param = {
                'itemid': itemid,
                'aaa102': aaa102,
                'aaa100': aaa100
            };
            refresh(param, '');
        }

        // 新增项目内容
        var saveCheckAndtype = function () {
            var url = basePath + '/supervision/checkinfo/addCheckAndTypejsp';
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增项目内容'
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };
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
            table.reload('roleTable', {
                url: basePath + '/supervision/checkinfo/getcheckAndTypeList'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    table.singleData = '';
                    selectTableDataId1 = '';
                    selectTableDataId2 = '';
                    layer.close(mask);
                }
            });
            /*		parent.window.refresh();*/
        }
        //子页面返回参数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == "") {
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
        //编辑项目内容
        var editCheckAndtype = function (basetype, itemtype) {
            var url = basePath + '/supervision/checkinfo/addCheckAndTypejsp?op=edit&basetype='
                    + basetype + '&itemtype=' + itemtype;
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '新增项目内容'
                , content: url
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };

        //删除
        function delContent(basetype, itemtype) {
            layer.open({
                title: '警告!'
                , icon: '3'
                , btn: ['确定', '取消']
                , content: '您确定要删除该条信息吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + '/supervision/checkinfo/delCheckAndType', {
                                basetype: basetype,
                                itemtype: itemtype
                            },
                            function (result) {
                                if (result.code == '0') {
                                    table.singleData = '';
                                    selectTableDataId1 = '';
                                    selectTableDataId2 = '';
                                    //本页的值
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    layer.msg('删除成功', {time: 1000}, function () {
                                        //如果是本页最后一条数据 则返回上一页
                                        if (table.cache.roleTable.length == 1) {
                                            curent = curent - 1;
                                        }
                                        refresh('', curent);
                                    });
                                } else {
                                    layer.msg('删除失败' + result.msg);
                                }
                            },
                            'json');
                }
            });
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
            $("#itemid").val(nodes[0].itemid);
            $("#itemname").val(nodes[0].itemname);
            hideMenu();
        }
        function showMenu() {
            var cityObj = $("#itemname");
            var cityOffset = $("#itemname").offset();
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
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="fm" style="height: auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: auto">企业类型</label>

                                    <div class="layui-input-inline" style="width: auto">
                                        <input type="radio" name="comdalei" lay-filter="comdalei" value="comdalei"
                                               title="企业大类"
                                               checked>
                                        <input type="radio" name="comdalei" lay-filter="comdalei" value="comxiaolei"
                                               title="企业小类">
                                        <input type="hidden" name="aaa100" id="aaa100"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 40px">类别</label>

                                    <div class="layui-input-inline">
                                        <select type="text" name="aaa102" id="aaa102"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 40px">计划项</label>

                                    <div class="layui-input-inline">
                                        <input name="itemname" id="itemname" onclick="showMenu();"
                                               class="layui-input layui-bg-gray" readonly>
                                        <input name="itemid" id="itemid" type="hidden"/>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 layui-col-md-offset4">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 40px"></label>
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
                                <div id="menuContent" class="menuContent"
                                     style="display:none;position:fixed;z-index:333;">
                                    <ul id="treeDemo2" class="ztree" style="height:250px;width: auto;"></ul>
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
            <ck:permission biz="saveCheckAndtype">
                <button class="layui-btn" data-type="saveCheckAndtype" data="btn_saveCheckAndtype">增加
                </button>
            </ck:permission>
            <ck:permission biz="editCheckAndtype">
                <button class="layui-btn" data-type="editCheckAndtype" data="btn_editCheckAndtype">修改
                </button>
            </ck:permission>
            <ck:permission biz="deleteCheckAndtype">
                <button class="layui-btn layui-btn-danger" data-type="delContent" data="btn_delContent">删除
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="roleTable" lay-filter="paramgridfilter"></table>
    </div>
</div>
</body>
</html>