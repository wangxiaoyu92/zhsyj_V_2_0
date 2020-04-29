<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
    String jyjcjcbzbid = StringHelper.showNull2Empty(request.getParameter("jyjcjcbzbid"));
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userdalei = sysuser.getUserdalei();//1非企业用户2企业用户
    String singleSelect = StringHelper.showNull2Empty(request.getParameter("singleSelect"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测标准</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var form;
        var table;
        var mask;
        var element;
        var layer;
        var selectTableDataId = "";
        var mygrData = [];
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var v_BZSTATE =<%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
        var v_jyjcbzfenlei =<%=SysmanageUtil.getAa10toJsonArray("JYJCBZFENLEI")%>;
        var v_jyjczbfenlei =<%=SysmanageUtil.getAa10toJsonArray("JYJCZBFENLEI")%>;
        var v_jyjcicsfenlei = <%=SysmanageUtil.getAa10toJsonArray("JYJCICSFENLEI")%>
            $(function () {
                //如果不为空 表示 是子页面的情况
                if('<%=singleSelect%>'!=''){
                    $(".demoTable").hide();
                }
                layui.use(['form', 'table', 'element','layer'], function () {
                    form = layui.form, table = layui.table, element = layui.element;
                    layer=layui.layer;
                    list();
                    table.render({
                        elem: '#cbzbTable'
//                        , url: basePath + 'jyjc/queryJyjcjcbzb'
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
                            ,{field: 'jyjcjcbzbid', width: 100, title: '检验检测检测标准ID', event: 'trclick'}
                            , {field: 'bzbh', width: 160, title: '标准编号', event: 'trclick'}
                            , {field: 'chinaname', width: 220, title: '中文名称', event: 'trclick'}
                            , {field: 'engname', width: 100, title: '英文名称', event: 'trclick'}
                            , {
                                field: 'jyjcbzfenlei',
                                width: 100,
                                title: '标准分类',
                                event: 'trclick',
                                templet: function (d) {
                                    return sy.formatGridCode(v_jyjcbzfenlei, d.jyjcbzfenlei);
                                }
                            }
                            , {
                                field: 'jyjcbzstate',
                                width: 100,
                                title: '标准状态',
                                event: 'trclick',
                                templet: function (d) {
                                    return sy.formatGridCode(v_BZSTATE, d.jyjcbzstate);
                                }
                            }
                            , {field: 'tdqk', width: 100, title: '替代情况', event: 'trclick'}
                            , {
                                field: 'jyjczbfenlei',
                                width: 100,
                                title: '中标分类',
                                event: 'trclick',
                                templet: function (d) {
                                    return sy.formatGridCode(v_jyjczbfenlei, d.jyjczbfenlei);
                                }
                            }
                            , {
                                field: 'jyjcicsfenlei',
                                width: 100,
                                title: 'ICS分类',
                                event: 'trclick',
                                templet: function (d) {
                                    return sy.formatGridCode(v_jyjcicsfenlei, d.jyjcicsfenlei);
                                }
                            }
                            , {field: 'jyjcudcfenlei', width: 100, title: 'UDC分类', event: 'trclick'}
                            , {field: 'fbbm', width: 100, title: '发布部门', event: 'trclick'}
                            , {field: 'gkdw', width: 100, title: '归口单位', event: 'trclick'}
                            , {field: 'bzcontent', width: 100, title: '标准内容', event: 'trclick'}
                            , {field: 'aae011', width: 100, title: '操作员', event: 'trclick'}
                            , {field: 'aae036', width: 100, title: '操作时间', event: 'trclick'}
                            , {
                                field: 'sfyx', width: 100, title: '是否有效', event: 'trclick',
                                templet: function (d) {
                                    return sy.formatGridCode(v_SFYX, d.sfyx);
                                }
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
                    })
                    table.on("tool(tableFilter)", function (obj) {
                        var data = obj.data;
                        if (obj.event === "trclick") {
                            if (selectTableDataId != data.jyjcjcbzbid) {
                                $(".layui-table-body tr").each(function (k, v) {
                                    $(v).removeAttr("style");
                                });
                                $(obj.tr.selector).css("background", "#90E2DA");
                                table.singleData = data;
                                selectTableDataId = data.jyjcjcbzbid;
                            } else {
                                $(obj.tr.selector).attr("style", "");
                                table.singleData = "";
                                selectTableDataId = "";
                            }
                        }
                    })
                    //监听复选框
//                    table.on('checkbox(tableFilter)', function (obj) {
//                        var checkStatus = table.checkStatus('cbzbTable');
//                        alert(checkStatus.data);
//                        mygrData = checkStatus.data;//获取被选中的数据
//                    });
                    // 监听工具条
                    var $ = layui.$, active = {
                        addPcom: function () { // 添加
                            addPcom();
                        }
                        , updatePcom: function () { // 修改
                            if (!table.singleData) {
                                layer.alert('请先选择要修改的检验检测标准信息！');
                            } else {
                                updatePcom(table.singleData.jyjcjcbzbid);
                            }
                        }
                        , delPcom: function () { // 删除
                            if (!table.singleData) {
                                layer.alert('请先选择要删除的检验检测标准信息！');
                            } else {
                                delPcom(table.singleData.jyjcjcbzbid);
                            }
                        }
                        , showPcom: function () { // 显示
                            if (!table.singleData) {
                                layer.alert('请先选择要查看的检验检测标准信息！');
                            } else {
                                showPcom(table.singleData.jyjcjcbzbid);
                            }
                        }
                    }
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
                $('#btn_reset').click(function(){
                    list();
                    return false;
                })
            });
        function list(param) {
            $('#bzbh').val('');
            $('#chinaname').val('');

            $.post(basePath + 'jyjc/queryJyjcjcbzb', param,
                    function (result) {
                        if (result.code == '0') {
                            var jyjcjcbzbid ='<%=jyjcjcbzbid%>';
                            var lis=jyjcjcbzbid.split(',');
                            for (var i = 0; i < result.rows.length; i++) {
                                for(var j=0;j<lis.length;j++){
                                    if (result.rows[i].jyjcjcbzbid === lis[j]) {
                                        result.rows[i].LAY_CHECKED = true;
                                    }
                                }
                            }
                            table.reload('cbzbTable', {data: result.rows});
                            return false;
                        } else {
                            layer.open({
                                title: "提示",
                                content: "查询失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
        }
        // 查询企业信息
        function query() {
            var param = {
                'bzbh': $('#bzbh').val(),
                'chinaname': $('#chinaname').val()
            };
            list(param);
        }

        //确定
        function queding() {
            var checkStatus = table.checkStatus('cbzbTable');
            mygrData = checkStatus.data;//获取被选中的数据
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
        // 刷新
        function refresh(param,cur) {
            if (cur == "") {
                curr = 1;
            } else {
                curr = cur;
            }
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('cbzbTable', {
                url: basePath + 'jyjc/queryJyjcjcbzb'
                , page: {
                    curr: cur//重新从第 1 页开始
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

        //新增检验检测项目
        var addPcom = function () {
            sy.modalDialog({
                title: '新增检验检测项目标准',
                area: ['100%', '100%'],
                content: basePath + 'jyjc/jyjcbzFormIndex'
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        };

        //编辑诚信评定等级参数信息
        var updatePcom = function (jyjcjcbzbid) {
            sy.modalDialog({
                title: '编辑检验检测项目标准',
                area: ['100%', '100%'],
                content: basePath + 'jyjc/jyjcbzFormIndex?jyjcjcbzbid=' + jyjcjcbzbid
                , btn: ['保存', '取消']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }

        // 删除检验检测项目信息
        function delPcom(jyjcjcbzbid) {
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项信息么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJyjcbz', {
                            jyjcjcbzbid: jyjcjcbzbid
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
                                    if (table.cache.cbzbTable.length == 1) {
                                        curent = curent - 1;
                                    }
                                    refresh('', curent);
                                });
                                //如果删除本页的最后一条数据时 则查询上一页的数据而不是让他在本页无数据的状态

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

        //查看检验检测项目
        var showPcom = function (jyjcjcbzbid) {
            sy.modalDialog({
                title: '查看检验检测项目',
                area:['100%','100%'],
                content: basePath + 'jyjc/jyjcbzFormIndex?op=view&jyjcjcbzbid=' + jyjcjcbzbid,
                btn:['关闭']
            });
        }
        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
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


    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>
            <div class="layui-colla-content layui-show" >

                <form class="layui-form" id="myf" name="myf" action="">
                    <div class="layui-form-item">
                        <div class="lay-table">
                            <div class="lay-row">
                                <div class="layui-col_md1">
                                    <label class="layui-form-label">标准编号</label>
                                </div>
                                <div class="layui-col_md2">
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="bzbh" name="bzbh"/>
                                    </div>
                                </div>
                                <div class="layui-col_md1">
                                    <label class="layui-form-label" >名称</label>
                                </div>
                                <div class="layui-col_md2">
                                    <div class="layui-input-inline">
                                        <input type="text" class="layui-input" id="chinaname" name="chinaname"/>
                                    </div>
                                </div>
                                <div class="layui-col_md6">
                                    <div class="layui-input-inline" style="width: 300px;">
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
    <div class="layui-btn-group demoTable" style="padding-top: 10px">
        <ck:permission biz="addPcom">
            <button class="layui-btn" data-type="addPcom" data="btn_addPcom">增加</button>
        </ck:permission>
        <ck:permission biz="updatePcom">
            <button class="layui-btn" data-type="updatePcom" data="btn_updatePcom">修改</button>
        </ck:permission>
        <ck:permission biz="delPcom">
            <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">删除</button>
        </ck:permission>
        <ck:permission biz="showPcom">
            <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
        </ck:permission>
    </div>
    <table class="layui-table" id="cbzbTable" lay-filter="tableFilter">
        <input type="hidden" id="fbrq" name="fbrq">
        <input type="hidden" id="ssrq" name="ssrq">
        <input type="hidden" id="zfrq" name="zfrq">
        <input type="hidden" id="sfrq" name="sfrq">
        <input type="hidden" id="fsrq" name="fsrq">
        <input type="hidden" id="tcdw" name="tcdw">
        <input type="hidden" id="zgbm" name="zgbm">
        <input type="hidden" id="qcdw" name="qcdw">
        <input type="hidden" id="rcr" name="rcr">
    </table>
</div>
</body>
</html>