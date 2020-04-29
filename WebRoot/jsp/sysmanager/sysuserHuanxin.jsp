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
    <title>用户环信好友管理</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var element; //
        var selectTableDataId = '';

        $(function () {
            initGridData(); // 初始化表格数据
        });

        // 初始化表格数据
        function initGridData() {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                // 用户表格
                table.render({
                    elem: '#huanxingrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysuser/queryHuanxinSysuser?easemobflag=1'
                    , page: true // 展示分页
                    , limit: 500 // 每页展示条数
                    , limits: [500, 1000, 1500] // 每页条数选择项
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
                        {type: 'checkbox'}
                        ,{field: 'orgname', title: '机构名称', width: 200}
                        ,{field: 'userid', title: '用户ID', width: 210}
                        //, {field: 'username', title: '用户名称', width: 120}
                        , {field: 'description', title: '用户描述', width: 200}
                        , {field: 'mobile', title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', title: '手机号2', event: 'trclick'}
                        , {field: 'aaa027name', title: '统筹区', event: 'trclick'}
                    ]]
                });

                table.render({
                    elem: '#nohuanxingrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysuser/queryHuanxinSysuser?easemobflag=0'
                    , page: true // 展示分页
                    , limit: 500 // 每页展示条数
                    , limits: [500, 1000, 1500] // 每页条数选择项
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
                        {type: 'checkbox'}
                        ,{field: 'orgname', title: '机构名称', width: 200}
                        ,{field: 'userid', title: '用户ID', width: 210}
                        //, {field: 'username', title: '用户名称', width: 120}
                        , {field: 'description', title: '用户描述', width: 200}
                        , {field: 'mobile', title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', title: '手机号2', event: 'trclick'}
                        , {field: 'aaa027name', title: '统筹区', event: 'trclick'}
                    ]]
                });

                var $ = layui.$, active = {
                    delHuanxinSysuser: function () { // 删除环信用户
                        delHuanxinSysuser();
                    },
                    addHuanxinSysuser: function () { // 增加环信用户
                        addHuanxinSysuser();
                    },
                    huanxinFriendManage:function(){
                        huanxinFriendManage();
                    }

                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });

        };

        //环信好友管理
        function huanxinFriendManage(){

            var checkStatus = table.checkStatus('huanxingrid');
            var xzcount = checkStatus.data.length;//获取被选中的个数
            if (xzcount==0){
                layer.msg('请选择要添加环信好友的用户', {time: 1000}, function () {});
                return;
            };
            if (xzcount>1){
                layer.msg('只能选择一个用户', {time: 1000}, function () {});
                return;
            };
            var mygrData = checkStatus.data;//获取被选中的数据
            var prm_userid=mygrData[0].userid;
            sy.modalDialog({
                title: '环信好友管理'
                , area: ['100%', '100%']
                , content: basePath + '/sysmanager/sysuser/sysuserHuanxinFriendIndex?userid='+prm_userid
                , btn: ['关闭']
            }, null);
        };

        // 删除环信用户
        function delHuanxinSysuser() {
            var checkStatus = table.checkStatus('huanxingrid');
            var v_huanxingridData = checkStatus.data;
            if (v_huanxingridData==null || v_huanxingridData.length==0){
                layer.msg('请选择要删除的环信用户信息', {time: 1000}, function () {});
               return false;
            }
            v_huanxingridData=$.toJSON(v_huanxingridData);
            var cfmMsg = "确定要删除选择的环信用户吗?";
            //询问框
            layer.confirm(cfmMsg, {
                btn: ['确定', '取消'] //按钮
            },
            function(index){
                layer.close(index);
                $.post(basePath + 'sysmanager/sysuser/delHuanxinUserBatch', {
                        usergridstr: v_huanxingridData
                    },
                    function (result) {
                        if (result.code == '0') {
                            layer.msg('删除成功', {time: 1000}, function () {
                                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                refreshHuanxinGrid('', curent);
                                refreshNoHuanxinGrid('', '');
                            });
                        }else{
                            layer.open({
                                title: "提示",
                                content: "删除失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    },'json')
            },function(){}
            );
        }


        // 添加环信用户
        function addHuanxinSysuser() {
            var checkStatus = table.checkStatus('nohuanxingrid');

            var v_huanxingridData = checkStatus.data;
            if (v_huanxingridData==null || v_huanxingridData.length==0){
                alert("请选择要增加的环信用户信息");
                return false;
            }
            v_huanxingridData=$.toJSON(v_huanxingridData);

            var cfmMsg = "确定要增加选择的环信用户吗?";
            //询问框
            layer.confirm(cfmMsg, {
                    btn: ['确定', '取消'] //按钮
                },
                function(index){
                    layer.close(index);
                    $.post(basePath + 'sysmanager/sysuser/addHuanxinUserBatch', {
                            usergridstr: v_huanxingridData
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('增加成功', {time: 1000}, function () {
                                    var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                                    refreshHuanxinGrid('', '');
                                    refreshNoHuanxinGrid('', curent);
                                });
                            }else{
                                layer.open({
                                    title: "提示",
                                    content: "增加失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },'json')
                },function(){}
            );
        }

        // 刷新
        function refreshHuanxinGrid(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('huanxingrid', {
                url: basePath + 'sysmanager/sysuser/queryHuanxinSysuser?easemobflag=1'
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

        // 刷新
        function refreshNoHuanxinGrid(param, cur) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            //删除时 在本页面刷新
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            table.reload('nohuanxingrid', {
                url: basePath + 'sysmanager/sysuser/queryHuanxinSysuser?easemobflag=0'
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


    </script>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title lay_show">
        <li class="layui-this">环信用户</li>
        <li>非环信用户</li>
    </ul>
    <div class="layui-tab-content" style="height: 400px;">
        <div class="layui-tab-item layui-show">
            <div class="layui-btn-group demoTable">
                <ck:permission biz="delHuanxinSysuser">
                    <button class="layui-btn" data-type="delHuanxinSysuser" data="btn_delHuanxinSysuser">删除环信用户</button>
                </ck:permission>
                <ck:permission biz="huanxinFriendManage">
                    <button class="layui-btn" data-type="huanxinFriendManage" data="btn_huanxinFriendManage">环信好友管理</button>
                </ck:permission>
            </div>
            <table class="layui-hide" id="huanxingrid" lay-filter="tableFilter"></table>
        </div>
        <div class="layui-tab-item">
            <div class="layui-btn-group demoTable">
                <ck:permission biz="addHuanxinSysuser">
                    <button class="layui-btn" data-type="addHuanxinSysuser" data="btn_addHuanxinSysuser">添加为环信用户</button>
                </ck:permission>

            </div>
            <table class="layui-hide" id="nohuanxingrid" lay-filter="tableFilter"></table>
        </div>
    </div>
</div>

</body>
</html>