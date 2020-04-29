<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
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
    <title>用户管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var selectTableDataId = '';
        var mask;
        // 用户机构管理树形配置
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'animal/queryAnimalZTreeAsync',  //调用后台的方法
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "animalhouseid",
                    pIdKey: "parenthouseid",
                    rootPId: 0
                },
                key: {
                    name: "housename"
                }
            },
            callback: {
                onClick: onClick
            }
        };

        $(function () {
            initZTree();
            initGridData(); // 初始化表格数据
        });

        //初始化【机构】树
        function initZTree() {
            $.fn.zTree.init($("#treeDemo"), setting);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = eval(responseData.animalhouseData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('userGrid', {
                url: basePath + 'animal/queryAnimalfence'
                , page: true
                , where: {'houseid': treeNode.animalhouseid} //设定异步数据接口的额外参数
                , done: function (res, curr, count) {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        // 初始化表格数据
        function initGridData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                // 用户表格
                table.render({
                    elem: '#userGrid'
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
                        {field: 'fenceno', title: '栅栏编号', event: 'trclick'}
                        , {field: 'fencename', title: '栅栏名称', event: 'trclick'}
                        , {field: 'houseno', title: '动物舍所编号', event: 'trclick'}
                        , {field: 'aae011', title: '操作员', event: 'trclick'}
                        , {field: 'aae036', title: '操作时间', event: 'trclick'}
                    ]]
                });

                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.userid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", selectTableBackGroundColor);
                            table.singleData = data;
                            selectTableDataId = data.animalfenceid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addAnimalfence: function () { // 添加
                        addAnimalfence();
                    }
                    , updateAnimalfence: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的动物栅栏！');
                        } else {
                            updateAnimalfence(table.singleData.animalfenceid);
                        }
                    }
                    , delAnimalfence: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的动物栅栏！');
                        } else {
                            delAnimalfence(table.singleData.animalfenceid);
                        }
                    }
                    , showAnimalfence: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的动物栅栏！');
                        } else {
                            showAnimalfence(table.singleData.animalfenceid);
                        }
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
            //监听提交
            $("#btn_query").bind("click", function () {
                query();
                return false;
            });
        }

        // 查询
        function query() {
            var param = {
                'fencename': $('#fencename').val(),
                'fenceno': $('#fenceno').val()
            };
            refresh(param, '');
        }

        // 刷新
        function refresh(param, cur) {
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('userGrid', {
                url: basePath + 'animal/queryAnimalfence'
                , where: param //设定异步数据接口的额外参数
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , done: function () {
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        // 新增
        function addAnimalfence() {
            sy.modalDialog({
                title: '新增动物栅栏信息'
                , content: basePath + 'animal/animalfenceFormIndex'
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }

        // 修改
        function updateAnimalfence(animalfenceid) {
            sy.modalDialog({
                title: '修改动物栅栏信息'
                , content: basePath + 'animal/animalfenceFormIndex?animalfenceid='+animalfenceid
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].saveFun();
                }
            }, closeModalDialogCallback);
        }

        function showAnimalfence(animalfenceid) {
            sy.modalDialog({
                area: ['100%', '100%']
                , title: '查看动物栅栏信息'
                , content:basePath + '/animal/animalfenceFormIndex?op=view&animalfenceid='+animalfenceid
                , btn: ['关闭']
            });
        }

        // 关闭窗口回掉函数
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            var param = {
                'fencename': $('#fencename').val(),
                'fenceno': $('#fenceno').val()
            };
            if (obj.type == "ok") {
                //其他在本页刷新
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh(param, curent);
            } else {
                //saveOk 在第一页刷新
                refresh(param, '');
            }
        }


        // 删除
        function delAnimalfence(animalfenceid) {
            layer.open({
                title : '警告'
                ,content : '你确定要删除该栅栏么？'
                ,btn : ['确定', '取消'] //可以无限个按钮
                ,btn1: function(index, layero){
                    $.post(basePath + '/animal/delAnimalfence', {
                            animalfenceid: animalfenceid
                        },
                        function(result) {
                            if (result.code == '0') {
                                layer.msg('删除成功', {time:1000},function(){
                                    table.reload('userGrid', {
                                        url : basePath + '/animal/queryAnimalfence'
                                    });
                                    table.singleData = '';
                                    selectTableDataId = '';
                                });
                            } else {
                                layer.open({
                                    title : "提示",
                                    content : "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json')
                }
            })
        }


    </script>
</head>
<body class="layui-layout-body">
<div class="layui-side layui-bg-black" style="width: 250px;">
    <div class="layui-side-scroll" style="width:100%;">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
</div>
<div class="layui-body" style="margin-left: 55px; width: 79%;">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-fluid">
                        <div class="layui-row">
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 50px">栅栏编号</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="fenceno" name="fenceno" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 50px">栅栏名称</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="fencename" name="fencename" class="layui-input">
                                    </div>
                                </div>

                            </div>
                            <div class="layui-col-md4 layui-col-xs12 layui-col-sm6 ">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline" style="width: auto">

                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                    lay-submit="" data="btn_queryContent">
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
            <ck:permission biz="showfence">
                <button class="layui-btn" data-type="showAnimalfence" data="btn_showAnimalfence">查看</button>
            </ck:permission>
            <ck:permission biz="addfence">
                <button class="layui-btn" data-type="addAnimalfence" data="btn_addAnimalfence">增加</button>
            </ck:permission>
            <ck:permission biz="updatefence">
                <button class="layui-btn" data-type="updateAnimalfence" data="btn_updateAnimalfence">编辑</button>
            </ck:permission>
            <ck:permission biz="delfence">
                <button class="layui-btn layui-btn-danger" data-type="delAnimalfence" data="btn_delAnimalfence">删除</button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="userGrid" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>