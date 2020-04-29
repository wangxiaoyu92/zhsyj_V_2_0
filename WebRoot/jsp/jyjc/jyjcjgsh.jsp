<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
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
    <title>检验检测审核</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        //检测检验类别
        var v_jcjylb = <%=SysmanageUtil.getAa10toJsonArray("JCJYLB")%>;
        // 检验检测结论
        var v_jyjcjl = <%=SysmanageUtil.getAa10toJsonArray("JYJCJL")%>;
        //检测检验审核标志
        var v_shbz = <%=SysmanageUtil.getAa10toJsonArray("JCJYSHBZ")%>;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;//进度条
        $(function () {
            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;
                mask = layer.load(1, {shade: [0.1, '#393D49']});
                table.render({
                    elem: '#jyjgiTable'
//                ,method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'jyjc/queryJyjcjg'
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
//                        { field : 'jcypid', width : 100, title: '检测样品ID' ,event: 'trclick'}
                        {
                            field: 'jcjylb', width: 100, title: '检测检验类别', event: 'trclick'
                            , templet: function (d) {
                            return sy.formatGridCode(v_jcjylb, d.jcjylb);
                        }
                        }
                        , {field: 'jcypmc', width: 100, title: '检测样品名称', event: 'trclick'}
                        , {field: 'commc', width: 100, title: '受检单位名称', event: 'trclick'}
                        , {field: 'jcxmmc', width: 100, title: '检测项目名称', event: 'trclick'}
                        , {field: 'jcxmbzz', width: 100, title: '标准值', event: 'trclick'}
                        , {field: 'imphl', width: 100, title: '结果值', event: 'trclick'}
                        , {field: 'fjjg', width: 100, title: '复检结果', event: 'trclick'}
                        , {
                            field: 'impjcjg', width: 100, title: '结论', event: 'trclick',
                            templet: function (d) {
                                return sy.formatGridCode(v_jyjcjl, d.impjcjg);
                            }
                        }
                        , {field: 'impjcsj', width: 100, title: '检测日期', event: 'trclick'}
                        , {field: 'impjcry', width: 100, title: '检验员', event: 'trclick'}
                        , {field: 'jcjycljg', width: 100, title: '处理结果', event: 'trclick'}
                        , {
                            field: 'jcjyshbz', width: 100, title: '审核标志', event: 'trclick',
                            templet: function (d) {
                                return sy.formatGridCode(v_shbz, d.jcjyshbz);
                            }
                        }
//					, {fixed: 'right', width : 200, align: 'center', toolbar: '#paramgridbtn'}
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
                        if (selectTableDataId != data.jcjgid) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.jcjgid;
                        } else { // 再次选中清除样式
                            $(obj.tr.selector).attr("style", "");
                            table.singleData = '';
                            selectTableDataId = '';
                        }
                    }
                });

                var $ = layui.$, active = {
                    Jyjcjgsh: function () { // 审核处理
                        if (!table.singleData) {
                            layer.alert('请先选择要审核的检验检测结果信息！');
                        } else {
                            Jyjcjgsh(table.singleData.jcjgid);
                        }
                    }
                    , showPcom: function () { // 显示
                        if (!table.singleData) {
                            layer.alert('请选择要查看的检验检测样品！');
                        } else {
                            showPcom(table.singleData.jcjgid);
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
        });
        function Jyjcjgsh(jcjgid) {
            sy.modalDialog({
                title: '审核处理'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjcjgshFormIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , param: {
                    jcjgid: jcjgid
                }
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            }, closeModalDialogCallback);
        }
        //查看信息
        function showPcom(jcjgid) {
            sy.modalDialog({
                title: '查看检验检测样品'
                , area: ['100%', '100%']
                , content: basePath + '/jyjc/jyjcjgshFormIndex'
                , param: {
                    op: 'view',
                    jcjgid: jcjgid
                }
                , btn: ['关闭']
            });
        }
        // 查询检验检测样品
        function query() {
            var param = {
                'comid': $('#comid').val(),
                'impjcry': $('#impjcry').val()
            };
            refresh(param, '');
        }
        //从单位信息表中读取
        function myselectcom() {
            sy.modalDialog({
                title: '选择企业'
                , area: ['100%', '100%']
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    comjyjcbz: "1"
                }
                , content: basePath + 'pub/pub/selectcomIndex'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return false;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    $("#commc").val(myrow.commc); //公司名称
                    $("#comdm").val(myrow.comdm); //公司代码
                    $("#comid").val(myrow.comid);//公司id
                }
            });
        }

        // 刷新
        function refresh(param, curent) {
            //刷新的时候显示进度条
            mask = layer.load(1, {shade: [0.1, '#393D49']});
            table.reload('jyjgiTable', {
                url: basePath + 'jyjc/queryJyjcjg'
                , page: {
                    curr: curent //重新从第 1 页开始
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


        function closeModalDialogCallback(dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj == null || obj == "") {
                return;
            }
            if (obj.type == "ok") {
                var curent = $(".layui-laypage-skip input[class='layui-input']").val();
                refresh('', curent);
            }
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">搜索条件</h2>

            <div class="layui-colla-content layui-show">

                <form class="layui-form" id="myqueryform" style="height:auto">
                    <div class="layui-container">
                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业编号:</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="comdm" name="comdm"
                                               autocomplete="off" readonly class="layui-input layui-bg-gray">
                                    </div>
                                    <div class="layui-input-inline" style="width: auto">
                                        <a href="javascript:void(0)" class="layui-btn"
                                           iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">企业名称：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="commc" name="commc" placeholder="请选择企业" readonly
                                               autocomplete="off" class="layui-input layui-bg-gray">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">检验员：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="impjcry" name="impjcry" placeholder="请输入检验员名称"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label"></label>
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
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable">
            <ck:permission biz="addPcom">
                <button class="layui-btn" data-type="Jyjcjgsh" data="btn_addPcom">审核处理</button>
            </ck:permission>
            <ck:permission biz="showPcom">
                <button class="layui-btn " data-type="showPcom" data="btn_showPcom">查看</button>
            </ck:permission>
        </div>

        <table class="layui-hide" id="jyjgiTable" lay-filter="tableFilter">
            <input type="hidden" id="jcjgid" name="jcjgid">
            <input type="hidden" id="comid" name="comid">
        </table>
    </div>
</div>
</body>
</html>