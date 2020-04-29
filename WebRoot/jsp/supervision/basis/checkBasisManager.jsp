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
    <title>检查内容管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var selectTableDataId = '';
        // 初始化异步加载树url
        var assyncUrl = basePath + 'supervision/checkinfo/queryItemZTreeAsync';
        var mask;//进度条
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: getAsyncUrl,  //调用后台的方法
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
        // 获取异步加载树url
        function getAsyncUrl(treeId, treeNode) {
            if (treeNode && treeNode.level == 3) {
                assyncUrl = basePath + '/supervision/checkbasis/queryBasisZTreeAsync?contentid=' + treeNode.itemid;
            } else {
                assyncUrl = basePath + '/supervision/checkinfo/queryItemZTreeAsync';
            }
            return assyncUrl;
        }
        // 检查方式
        var checkType = <%=SysmanageUtil.getAa10toJsonArray("CHECKTYPE")%>; // 检查方式
        <%--var flfglx = <%=SysmanageUtil.getAa10toJsonArray("FLFGLX")%>; // 法律法规类型--%>
        $(function () {
            loadCheckItemZTree();
            initSelectData();
            initGridData();

        });
        function initGridData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                table.render({
                    elem: '#grid'
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
                        {field: 'basisid', title: 'ID', event: 'trclick'}
                        , {
                            field: 'type', title: '检查方式'
                            , templet: function (d) {
                                var userkind = d.id;
                                $.each(checkType, function (i, n) {
                                    if (d.type == null || d.type == '') {
                                        userkind = '';
                                        return false;
                                    }
                                    if (d.type == n.id) {
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            }, event: 'trclick'
                        }
                        , {field: 'typedesc', title: '检查方式描述', event: 'trclick'}
                        , {field: 'guide', title: '检查指南', event: 'trclick'}
                        , {field: 'punishmeasures', title: '处罚措施', event: 'trclick'}
                        , {field: 'basisdesc', title: '检查依据描述', event: 'trclick'}
                        , {field: 'operatorname', title: '经办人', event: 'trclick'}
                        , {field: 'operatedate', title: '经办时间', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.basisid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.basisid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                var $ = layui.$, active = {
                    addCheckBasis: function () { // 添加
                        if (!$("#contentid").val()) {
                            layer.alert('请选择左侧项目树叶子节点！');
                        } else {
                            addCheckBasis();
                        }
                    }
                    , editCheckBasis: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的检查依据！');
                        } else {
                            editCheckBasis(table.singleData.basisid);
                        }
                    }
                    , delCheckBasis: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检查依据！');
                        } else {
                            delCheckBasis(table.singleData.basisid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

            });
            //查询
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        }

        // 初始化检查项目树
        function loadCheckItemZTree() {
            $.fn.zTree.init($("#basisTree"), setting);
        }
        // 用于对 Ajax 返回数据进行预处理的函数
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var array = [];
            var zNodes = eval(responseData.orgData); // 获取树节点数据
            var isLastNode = eval(responseData.isLastNode);
            if (responseData) {
                for (var i = 0; i < zNodes.length; i++) {
                    //将后台传过来的参数拼接成json格式，并放在数组中，如果有必要需要对其是否为父节点做处理
                    array[i] = {
                        itemid: zNodes[i].itemid,
                        itemname: zNodes[i].itemname,
                        itempid: zNodes[i].itempid,
                        isParent: !isLastNode
                    };
                }
            }
            return array;
        }
        // 树节点点击事件
        function onClick(e, treeId, treeNode) {
            var treeObj = $.fn.zTree.getZTreeObj("basisTree");
            var sNodes = treeObj.getSelectedNodes();
            if (sNodes.length > 0) {
                var level = sNodes[0].level;
                if (level == 4) {
                    $("#contentid").val(sNodes[0].itemid);
                    mask = layer.load(1, {shade: [0.1, '#393D49']});
                    table.reload('grid', {
                        url: basePath + 'supervision/checkbasis/queryCheckBasis'
                        , where: {'contentid': sNodes[0].itemid} //设定异步数据接口的额外参数
                        , done: function (res, curr, count) {
                            table.singleData = '';
                            selectTableDataId = '';
                            layer.close(mask);
                        }
                    })
                } else {
                    $("#contentid").val('');
                }
            }
        }
        // 初始化下拉框
        function initSelectData() {
            // 检查方式
            var checkTypeData = '';
            for (var i = 0; i < checkType.length; i++) {
                checkTypeData += '<option value=\'' + checkType[i].id + '\' >' + checkType[i].text + '</option>';
            }
            $("#checkType").append(checkTypeData);
        }

        // 查询
        function query() {
            if (!$("#contentid").val()) {
                layer.alert('请选择左侧项目树叶子节点！');
            } else {
                var contentid = $("#contentid").val();
                var checkType = $('#checkType').val();
                var basisdesc = $("#basisdesc").val();
                var param = {
                    'contentid': contentid,
                    'type': checkType,
                    'basisdesc': basisdesc
                };
                refresh(param, '');
//                mask = layer.load(1, {shade: [0.1, '#393D49']});
//                table.reload('grid', {
//                    url: basePath + 'supervision/checkbasis/queryCheckBasis'
//                    , where: param //设定异步数据接口的额外参数
//                    ,done:function (res, curr, count) {
//                        table.singleData = '';
//                        selectTableDataId = '';
//                        layer.close(mask);
//                    }
//                });
            }
        }

        // 新增检查依据
        function addCheckBasis() {
            var contentid = $("#contentid").val();
            sy.modalDialog({
                title: '新增检查依据'
                , content: basePath + 'supervision/checkbasis/checkBasisFormIndex'
                , param: {
                    contentid: contentid
                }
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == "") {
                return false;
            }
            sy.removeWinRet(dialogID);
            var contentid = $("#contentid").val();
            var checkType = $('#checkType').val();
            var basisdesc = $("#basisdesc").val();
            var param = {
                'contentid': contentid,
                'type': checkType,
                'basisdesc': basisdesc
            };
            if (obj.type == "saveOk") {
                //其他在本页刷新
//                var curent=$(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, '');
            }
//            }else {
//                //saveOk 在第一页刷新
//                refresh(param,'');
//            }
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
            table.reload('grid', {
                url: basePath + 'supervision/checkbasis/queryCheckBasis'
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
        //编辑项目内容
        function editCheckBasis(basisid) {
            var contentid = $("#contentid").val();
            sy.modalDialog({
                title: '修改检查依据'
                , content: basePath + 'supervision/checkbasis/checkBasisFormIndex'
                , param: {
                    op: 'edit',
                    contentid: contentid,
                    basisid: basisid
                }
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback)
        }
        //删除依据
        function delCheckBasis(basisid) {
            layer.open({
                title: '警告!'
                , btn: ['确定', '取消']
                , icon: '3'
                , content: '您确定要删除该条检查依据吗?'
                , btn1: function (index, layero) {
                    $.post(basePath + 'supervision/checkbasis/delCheckBasis', {
                                basisid: basisid
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
                                        if (table.cache.grid.length == 1) {
                                            curent = curent - 1;
                                        }
                                        var contentid = $("#contentid").val();
                                        var checkType = $('#checkType').val();
                                        var basisdesc = $("#basisdesc").val();
                                        var param = {
                                            'contentid': contentid,
                                            'type': checkType,
                                            'basisdesc': basisdesc
                                        };
                                        refresh(param, curent);
                                    });
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "删除失败：" + result.msg //这里content是一个普通的String
                                    });
                                }
                            }, 'json')
                }
            })
        }
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side layui-bg-black" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="basisTree" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 80%;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-fluid">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <input id="contentid" name="contentid" type="hidden">
                                    <label class="layui-form-label">检查方式</label>

                                    <div class="layui-input-inline">
                                        <select name="checkType" id="checkType"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检查依据描述</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="basisdesc" name="basisdesc" class="layui-input">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-md2 layui-col-xs8 layui-col-sm4 layui-col-md-offset5 layui-col-xs-offset2 layui-col-sm-offset4">
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
            <ck:permission biz="addCheckBasis">
                <button class="layui-btn" data-type="addCheckBasis" data="btn_addCheckBasis">增加</button>
            </ck:permission>
            <ck:permission biz="editCheckBasis">
                <button class="layui-btn" data-type="editCheckBasis" data="btn_editCheckBasis">编辑</button>
            </ck:permission>
            <ck:permission biz="delCheckBasis">
                <button class="layui-btn layui-btn-danger" data-type="delCheckBasis" data="btn_delCheckBasis">删除
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="grid" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>