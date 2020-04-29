<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String jyjcffbzbid = StringHelper.showNull2Empty(request.getParameter("jyjcffbzbid"));
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userdalei = sysuser.getUserdalei();//1非企业用户2企业用户
    String singleSelect = StringHelper.showNull2Empty(request.getParameter("singleSelect"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检测方法管理</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId = '';
        var mygrData = [];
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var v_jyjcbzstate = <%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
        var v_sfyx = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        // 企业大类
        var mask;
        $(function () {
//            $('#jyjcbzfenlei').combotree({
//                url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjcbzstate',
//                required: true
//            });
            //如果不为空 表示 是子页面的情况
            if('<%=singleSelect%>'!=''){
                $(".demoTable").hide();
            }
            intSelectData()

            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                list();
                table.render({
                            elem: '#jcffTable'
                            , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
//                            , url: basePath + 'jyjc/queryJcffgl'
                            , where: {
                                "sfyx": "1"
                            }
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
                                {type: 'checkbox'}
//                                {field: 'jyjcffbzbid', width: 220, title: '检验检测方法标准表id', event: 'trclick'}
                                ,{field: 'jcffbzbh', width: 150, title: '检测方法标准编号', event: 'trclick'}
                                , {field: 'jcffbzmc', width: 260, title: '检测方法标准名称', event: 'trclick'}
                                , {field: 'jcffbzlb', width: 150, title: '检测方法标类别', event: 'trclick'}
                                , {field: 'fbrq', width: 170, title: '发布日期', event: 'trclick'}
                                , {
                                    field: 'jyjcbzstate', width: 100, title: '标准状态'
                                    , templet: function (d) {
                                        return formatGridColData(v_jyjcbzstate, d.jyjcbzstate);
                                    }, event: 'trclick'
                                }
                                , {field: 'ssrq', width: 100, title: '实施日期', event: 'trclick'}
                                , {field: 'bfbm', width: 200, title: '颁发部门', event: 'trclick'}
                                , {field: 'fzrq', width: 80, title: '废止日期', event: 'trclick'}
                                , {field: 'bztdqk', width: 150, title: '标准替代情况', event: 'trclick'}
                                , {field: 'bznr', width: 150, title: '标准内容', event: 'trclick'}
                                , {field: 'username', width: 100, title: '操作员姓名', event: 'trclick'}
                                , {field: 'czsj', width: 100, title: '操作时间', event: 'trclick'}
                                , {
                                    field: 'sfyx', width: 100, title: '是否有效'
                                    , templet: function (d) {
                                        return formatGridColData(v_sfyx, d.sfyx);
                                    }, event: 'trclick'
                                }
                            ]]
                            , done: function (res, curr, count) {
                                if('<%=singleSelect%>'==''){
                                    $("td[data-field='0']").hide();
                                    $("th[data-field='0']").hide();
                                }
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
                        if (selectTableDataId != data.jyjcffbzbid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jyjcffbzbid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });
                //监听复选框
                table.on('checkbox(tableFilter)', function (obj) {
                    var checkStatus = table.checkStatus('jcffTable');
                    mygrData = checkStatus.data;//获取被选中的数据
                });
                var $ = layui.$, active = {
                    addJcff: function () { // 添加
                        addJcff();
                    }
                    , updateJcff: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的检测方法！');
                        } else {
                            updateJcff(table.singleData.jyjcffbzbid);
                        }
                    }
                    , delJcff: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的检测方法！');
                        } else {
                            delJcff(table.singleData.jyjcffbzbid);
                        }
                    }
                    , showJcff: function () { // 查看
                        if (!table.singleData) {
                            layer.alert('请选择要查看的检测方法！');
                        } else {
                            showJcff(table.singleData.jyjcffbzbid);
                        }
                    }
                    , fjglJcff: function () { // 附件上传
                        if (!table.singleData) {
                            layer.alert('请选择要上传附件的检测方法！');
                        } else {
                            fjglJcff(table.singleData.jyjcffbzbid);
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

            function isNotNull(_this) {
                if (_this == "" || _this == null || _this == '') {
                    return false;
                }
                return true;
            }
        });
        function list() {
            $.post(basePath + 'jyjc/queryJcffgl', {sfyx:"1"},
                    function (result) {
                        if (result.code == '0') {
                            var jyjcffbzbid ='<%=jyjcffbzbid%>';
                            var lis=jyjcffbzbid.split(',');
                            for (var i = 0; i < result.rows.length; i++) {
                                for(var j=0;j<lis.length;j++){
                                    if (result.rows[i].jyjcffbzbid === lis[j]) {
                                        result.rows[i].LAY_CHECKED = true;
                                    }
                                }
                            }
                            table.reload('jcffTable', {data: result.rows});
                        } else {
                            layer.open({
                                title: "提示",
                                content: "查询失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
        }
        function selectjcff(){
            var rows = mygrData;
            sy.setWinRet(rows);
            parent.$("#"+sy.getDialogId()).dialog("close");
        }
        // 查询检测方法
        function query() {
            var param = {
                'jcffbzbh': $('#jcffbzbh').val(),
                'jcffbzmc': $('#jcffbzmc').val()
            };
            table.reload('jcffTable', {
                url: basePath + '/jyjc/queryJcffgl'
                , page: true
                , where: param //设定异步数据接口的额外参数
            });
            //gu20180531 refresh(param, '');
        }

        //附件管理
        function fjglJcff(jcffid) {
            var v_ajdjid = jcffid;
            var v_fjcsdlbh = "";//附件参数大类编号：执法办案附件
            var v_dmlb = "JCJGFJ";//附件参数小类编号：法律附件
            var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid=' + v_ajdjid
                    + '&dmlb=' + v_dmlb + '&fjcsdlbh=' + v_fjcsdlbh + '&time=' + new Date().getMilliseconds();
            sy.modalDialog({
                title: '附件管理'
                , area: ['100%', '100%']
                , content: url
                , btn: ['关闭']
            });
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
            table.reload('jcffTable', {
                url: basePath + '/jyjc/queryJcffgl'
                , page: {
                    curr: curr //重新从第 1 页开始
                }
                , where: param //设定异步数据接口的额外参数
                , done: function () {
                    //每次刷新过后 隐藏多选框
                    $("td[data-field='0']").hide();
                    $("th[data-field='0']").hide();
                    table.singleData = '';
                    selectTableDataId = '';
                    layer.close(mask);
                }
            });
        }

        // 新增检测方法
        function addJcff() {
            sy.modalDialog({
                title: '添加检测方法'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jcffglFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        //确定
        function queding() {
            if (mygrData != null && mygrData!= '') {
                var obj = new Object();
                obj.data = mygrData;
                obj.type = "ok";
                sy.setWinRet(obj);
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                layer.alert('请选择方法！');
            }
        }
        //查看检测方法
        function showJcff(jcffid) {
            sy.modalDialog({
                title: '查看检测方法'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jcffglFormIndex?op=view&jyjcffbzbid=' + jcffid
                , btn: ['关闭']
            });
        }
        //编辑检验检测方法
        function updateJcff(jcffid) {
            sy.modalDialog({
                title: '修改检测方法'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jcffglFormIndex?op=edit&&jyjcffbzbid=' + jcffid
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
        function delJcff(jcffid) {
            layer.open({
                title: '警告'
                , content: '你确定要删除该检测方法么？'
                , icon: 3
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delPcompany', {
                                jyjcffbzbid: jcffid
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
                                        if (table.cache.jcffTable.length == 1) {
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
        // 关闭窗口
        var closeWindow = function($dialog, $pjq){
            $dialog.dialog('destroy');
        };
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">
                <form class="layui-form" id="myqueryform" style="height: auto">
                    <div class="layui-row">
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">检测方法标准编号</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="jcffbzbh" name="jcffbzbh" placeholder="请输入检测方法编号"
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md4 layui-col-xs12 layui-col-sm6">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">检测方法名称</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="jcffbzmc" name="jcffbzmc" placeholder="请输入检测方法名称"
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
                </form>
            </div>
        </div>
    </div>
    <div id="jyjcbzfenlei" style="width: auto;height: auto"></div>
    <div class="layui-margin-top-15">
        <% if (!"select".equalsIgnoreCase(op)) {%>
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addJcff">
                <button class="layui-btn" data-type="addJcff" data="btn_addJcff">增加</button>
            </ck:permission>
            <ck:permission biz="updateJcff">
                <button class="layui-btn" data-type="updateJcff" data="btn_updateJcff">修改</button>
            </ck:permission>
            <ck:permission biz="delJcff">
                <button class="layui-btn layui-btn-danger" data-type="delJcff" data="btn_delJcff">删除</button>
            </ck:permission>
            <ck:permission biz="showJcff">
                <button class="layui-btn " data-type="showJcff" data="btn_showJcff">查看</button>
            </ck:permission>
            <ck:permission biz="fjglJcff">
                <button class="layui-btn " data-type="fjglJcff" data="btn_fjglJcff">附件管理</button>
            </ck:permission>
        </div>
        <%}%>
        <table class="layui-hide" id="jcffTable" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>