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

        var v_userkind = <%=SysmanageUtil.getAa10toJsonArray("USERKIND")%>; // 用户类别

        var v_lockstate = <%=SysmanageUtil.getAa10toJsonArray("LOCKSTATE")%>; // 用户锁定状态
        var mask;
        // 用户机构管理树形配置
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'sysmanager/sysorg/querySysorgZTreeAsync',  //调用后台的方法
                autoParam: ["orgid"], //向后台传递的参数
                otherParam: {}, //额外的参数
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "orgid",
                    pIdKey: "parent",
                    rootPId: 0
                },
                key: {
                    name: "orgname"
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
            var zNodes = eval(responseData.orgData);//获取后台传递的数据
            return zNodes;
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('userGrid', {
                url: basePath + 'sysmanager/sysuser/querySysuser'
                , page: true
                , where: {'orgid': treeNode.orgid} //设定异步数据接口的额外参数
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
                        {field: 'userid', title: '用户ID', event: 'trclick'}
                        , {field: 'username', title: '用户名称', event: 'trclick'}
                        , {field: 'description', title: '用户描述', event: 'trclick'}
                        , {
                            field: 'userkind', title: '用户类别'
                            , templet: function (d) {
                                var userkind = d.id;
                                $.each(v_userkind, function (i, n) {
                                    if (d.userkind == n.id) {
                                        userkind = n.text;
                                        return false; // 跳出本次循环
                                    }
                                });
                                return userkind;
                            }
                            , event: 'trclick'
                        }
                        , {field: 'mobile', title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', title: '手机号2', event: 'trclick'}
                        , {
                            field: 'lockstate', title: '账户锁定状态'
                            , templet: function (d) {
                                if (d.lockstate == "1") {
                                    return '<span style="color:red;">锁定</span>';
                                } else if (d.lockstate == "0") {
                                    return '正常';
                                } else {
                                    return '';
                                }
                            }
                            , event: 'trclick'
                        }
                        , {field: 'aaa027name', title: '统筹区', event: 'trclick'}
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
                            selectTableDataId = data.userid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    addSysuser: function () { // 添加
                        addSysuser();
                    }
                    , updateSysuser: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的用户！');
                        } else {
                            updateSysuser(table.singleData.userid);
                        }
                    }
                    , delSysuser: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的用户！');
                        } else {
                            delSysuser(table.singleData.userid);
                        }
                    }
                    , authorizeUser: function () { // 用户授权
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            authorizeUser(table.singleData.userid);
                        }
                    }
                    , lockSysuser: function () { // 封锁
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            lockSysuser(table.singleData);
                        }
                    }
                    , unlockSysuser: function () { // 解锁
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            unlockSysuser(table.singleData);
                        }
                    }
                    , resetPasswd: function () { // 重置密码
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            resetPasswd(table.singleData);
                        }
                    }
                    , sysuserQmsc: function () { // 签名上传
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            qianmingsc(table.singleData);
                        }
                    }
                    , qiandaodbd: function () { // 签到点绑定
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            qiandaodbd(table.singleData);
                        }
                    }
/*                    , zhucehuanxin: function () { // 注册环信用户
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            zhucehuanxin(table.singleData);
                        }
                    }, zhuxiaohuanxin: function () { // 注销环信用户
                        if (!table.singleData) {
                            layer.alert('请选择要操作的用户！');
                        } else {
                            zhuxiaohuanxin(table.singleData);
                        }
                    }*/
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
            // 初始化下拉框数据
            intSelectData('userkind', v_userkind); // 用户类别
            intSelectData('lockstate', v_lockstate); // 用户类别
        }

        // 查询
        function query() {
            var param = {
                'username': $('#username').val(),
                'userkind': $('#userkind').val(),
                'lockstate': $('#lockstate').val()
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
                url: basePath + 'sysmanager/sysuser/querySysuser'
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
            /*		parent.window.refresh();*/
        }

        // 新增
        function addSysuser() {
            sy.modalDialog({
                title: '新增用户'
                , content: basePath + 'sysmanager/sysuser/sysuserFormIndex'
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
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            var param = {
                'username': $('#username').val(),
                'userkind': $('#userkind').val(),
                'lockstate': $('#lockstate').val()
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

        // 编辑
        function updateSysuser(userid) {
            if (userid == '0' || userid == '1' || userid == '2' || userid == '3' || userid == '4') {
                layer.msg('该用户是系统预置标准用户，不可修改！', {icon: 5});
                return;
            }
            sy.modalDialog({
                title: '修改用户'
                , content: basePath + 'sysmanager/sysuser/sysuserFormIndex?op=edit&&userid=' + userid
                , area: ['100%', '100%']
                , btn: ['保存', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }


        // 删除
        function delSysuser(userid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该用户吗？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'sysmanager/sysuser/delSysuser', {
                                userid: userid
                            },
                            function (result) {
                                if (userid == '0' || userid == '1' || userid == '2' || userid == '3' || userid == '4') {
                                    layer.msg('该用户是系统预置标准用户，不可删除！', {icon: 5});
                                    return;
                                }
                                $.post(basePath + 'sysmanager/sysuser/delSysuser', {
                                            userid: userid
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
                                                    if (table.cache.userGrid.length == 1) {
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
                            })
                }
            });
        }

        // 用户授权
        function authorizeUser(userid) {
            sy.modalDialog({
                title: '用户授权'
                , content: basePath + 'sysmanager/sysuser/sysuserGrantFrom'
                , param: {
                    userid: userid
                }
                , area: ['100%', '100%']
            }, closeModalDialogCallback);
        }

        // 封锁用户
        function lockSysuser(user) {
            var lockstate = user.lockstate;
            if (lockstate == '1') {
                layer.msg('该用户的账户已锁定！', {icon: 5});
                return;
            }
            sy.modalDialog({
                title: '用户封锁'
                , content: basePath + 'jsp/sysmanager/lockUserForm.jsp'
                , param: {'userid': user.userid, 'username': user.username}
                , area: ['100%', '100%']
                , btn: ['确认', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 解锁用户
        function unlockSysuser(user) {
            var lockstate = user.lockstate;
            if (lockstate == '0') {
                layer.msg('该用户的账户状态正常！', {icon: 1});
                return;
            }
            layer.confirm('您确定要解锁该用户吗?', {icon: 3, title: '警告'}, function (index) {
                $.ajax({
                    url: basePath + 'sysmanager/sysuser/unlockSysuser',
                    type: 'post',
                    async: true,
                    cache: false,
                    timeout: 100000,
                    data: 'userid=' + user.userid,
                    dataType: 'json',
                    error: function () {
                        layer.msg('服务器繁忙，请稍后再试！', {icon: 5});
                    },
                    success: function (result) {
                        if (result.code == '0') {
                            layer.msg('解锁用户成功!', {time: 1000}, function () {
                                table.reload('userGrid', {url: basePath + 'sysmanager/sysuser/querySysuser'});
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "解锁用户失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }
                });
                layer.close(index);
            });
        }

        // 重置密码
        function resetPasswd(user) {
            layer.confirm('您确定要重置该用户密码吗?', {icon: 3, title: '警告'}, function (index) {
                $.ajax({
                    url: basePath + 'sysmanager/sysuser/resetPasswd',
                    type: 'post',
                    async: true,
                    cache: false,
                    timeout: 100000,
                    data: 'userid=' + user.userid,
                    dataType: 'json',
                    error: function () {
                        layer.msg('服务器繁忙，请稍后再试！', {icon: 5});
                    },
                    success: function (result) {
                        if (result.code == '0') {
                            layer.open({
                                title: "提示",
                                content: "重置密码成功!"
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "重置密码失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }
                });
                layer.close(index);
            });
        }

        // 签名上传
        function qianmingsc(user) {
            sy.modalDialog({
                title: '签名上传'
                , content: basePath + "/pub/pub/uploadFjViewIndex?folderName=dzqm&fjwid=" + user.userid
                , area: ['100%', '100%']
                , btn: ['关闭']
            });
        }

        //签到点绑定
        function qiandaodbd(user) {
            sy.modalDialog({
                title: '签到点绑定'
                , content: basePath + 'sysmanager/sysuser/QianDaodbdIndex?userid=' + user.userid
                , area: ['100%', '100%']
                , btn: ['确认', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        //注册环信用户
/*        function zhucehuanxin(user) {
            if (user.easemobflag =="1"){
                layer.msg('已经是环信用户，不能再次注册', {icon: 5});
                return;
            }
            //operatetype 1注册，2注销
            layer.confirm('您确定要 注册环信用户 吗?', {icon: 3, title: '警告'}, function (index) {
                $.ajax({
                    url: basePath + 'sysmanager/sysuser/zhucehuanxin?',
                    type: 'post',
                    async: true,
                    cache: false,
                    timeout: 100000,
                    data: 'userid=' + user.userid+'&passwd='+user.passwd,
                    dataType: 'json',
                    error: function () {
                        layer.msg('服务器繁忙，请稍后再试！', {icon: 5});
                    },
                    success: function (result) {
                        if (result.code == '0') {
                            layer.open({
                                title: "提示",
                                content: "注册环信用户 成功!"
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "注册环信用户 失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }
                });
                layer.close(index);
            });
        }*/


        //注销环信用户
/*        function zhuxiaohuanxin(user) {
            if (user.easemobflag =="0"){
                layer.msg('不是环信用户，不能注销', {icon: 5});
                return;
            }
            //operatetype 1注册，2注销
            layer.confirm('您确定要 注销该环信用户 吗?', {icon: 3, title: '警告'}, function (index) {
                $.ajax({
                    url: basePath + 'sysmanager/sysuser/zhuxiaohuanxin?',
                    type: 'post',
                    async: true,
                    cache: false,
                    timeout: 100000,
                    data: 'userid=' + user.userid+'&passwd='+user.passwd,
                    dataType: 'json',
                    error: function () {
                        layer.msg('服务器繁忙，请稍后再试！', {icon: 5});
                    },
                    success: function (result) {
                        if (result.code == '0') {
                            layer.open({
                                title: "提示",
                                content: "注册环信用户 成功!"
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "注册环信用户 失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }
                });
                layer.close(index);
            });
        }*/

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
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 120px">用户名称/账号/电话</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="username" name="username" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">用户类别</label>

                                    <div class="layui-input-inline">
                                        <select name="userkind" id="userkind"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 120px">账户锁定状态</label>

                                    <div class="layui-input-inline">
                                        <select name="lockstate" id="lockstate"></select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12 ">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>

                                    <div class="layui-input-inline">
                                        <%--<ck:permission biz="querySysuser">--%>
                                            <button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal"
                                                    lay-submit="">
                                                <i class="layui-icon">&#xe615;</i>搜索
                                            </button>
                                        <%--</ck:permission>--%>
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
            <ck:permission biz="addSysuser">
                <button class="layui-btn" data-type="addSysuser" data="btn_addSysuser">增加</button>
            </ck:permission>
            <ck:permission biz="updateSysuser">
                <button class="layui-btn" data-type="updateSysuser" data="btn_updateSysuser">编辑</button>
            </ck:permission>
            <ck:permission biz="delSysuser">
                <button class="layui-btn layui-btn-danger" data-type="delSysuser" data="btn_delSysuser">删除</button>
            </ck:permission>
            <ck:permission biz="authorizeUser">
                <button class="layui-btn" data-type="authorizeUser" data="btn_authorizeUser">用户授权</button>
            </ck:permission>
            <ck:permission biz="lockSysuser">
                <button class="layui-btn" data-type="lockSysuser" data="btn_lockSysuser">封锁</button>
            </ck:permission>
            <ck:permission biz="unlockSysuser">
                <button class="layui-btn" data-type="unlockSysuser" data="btn_unlockSysuser">解锁</button>
            </ck:permission>
            <ck:permission biz="resetPasswd">
                <button class="layui-btn" data-type="resetPasswd" data="btn_resetPasswd">重置密码</button>
            </ck:permission>
            <ck:permission biz="sysuserQmsc">
                <button class="layui-btn" data-type="sysuserQmsc" data="btn_sysuserQmsc">签名上传</button>
            </ck:permission>
            <ck:permission biz="qiandaodbd">
                <button class="layui-btn" data-type="qiandaodbd" data="btn_qiandaodbd">签到点绑定</button>
            </ck:permission>
<%--            <ck:permission biz="qiandaodbd">
                <button class="layui-btn" data-type="zhucehuanxin" data="btn_zhucehuanxin">注册环信</button>
            </ck:permission>
            <ck:permission biz="qiandaodbd">
                <button class="layui-btn" data-type="zhuxiaohuanxin" data="btn_zhuxiaohuanxin">注销环信</button>
            </ck:permission>
            <ck:permission biz="qiandaodbd">
                <button class="layui-btn" data-type="qiandaodbd" data="btn_qiandaodbd">环信好友</button>
            </ck:permission>--%>
        </div>
        <table class="layui-hide" id="userGrid" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>