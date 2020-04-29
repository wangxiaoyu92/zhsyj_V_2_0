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

    String v_aaa100 = StringHelper.showNull2Empty(request.getParameter("aaa100"));  //参数类别代码
    v_aaa100 = v_aaa100.toUpperCase();

    Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userid = vSysUser.getUserid();
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测项目</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var jcyplb = <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
        var jcypgl = <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;
        var selectTableDataId = '';
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var mask;
        var loadData;
        var newData;
        var trObj;
        var updata;
        $(function () {

            layui.use(['form', 'table', 'layer', 'element'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                var element = layui.element;

                table.render({
                    elem: '#aa10'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
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
                        {field: 'aaa102', title: '代码值', event: 'trclick'}
                        , {field: 'aaa103', title: '代码名称', event: 'trclick'}
                        , {field: 'aae011', title: '经办人', event: 'trclick'}
                        , {field: 'aae036', title: '经办时间', event: 'trclick'}
                    ]]
                });
                // 监听工具条
                table.on('tool(tableFilter)', function (obj) {
                    trObj = obj;
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        if (selectTableDataId != data.aaz093) {
                            // 清除所有行的样式
                            $(".layui-table-body tr").each(function (k, v) {
                                $(v).removeAttr("style");
                            });
                            $(obj.tr.selector).css("background", "#90E2DA");
                            table.singleData = data;
                            selectTableDataId = data.aaz093;

                        }
                        /*else { // 再次选中清除样式
                         $(obj.tr.selector).attr("style", "");
                         table.singleData = '';
                         selectTableDataId = '';
                         }*/
                    }
                });
                table.on('edit(tableFilter)', function (obj) { //注：edit是固定事件名，test是table原始容器的属性 lay-filter="对应的值"
                    table.singleData = obj.data;
                    newData[newData.length - 1] = obj.data;
                });
                var $ = layui.$, active = {
                    addAa10: function () { // 添加
                        addAa10();
                    }
                    , updateAa10: function () { // 修改
                        if (!table.singleData) {
                            layer.alert('请选择要修改的信息！');
                        } else {
                            updateAa10(trObj, table.singleData);
                        }
                    }
                    , delAa10: function () { // 删除
                        if (!table.singleData) {
                            layer.alert('请选择要删除的信息！');
                        } else {
                            delAa10(selectTableDataId, table.singleData.aae011);
                        }
                    }
                    , saveAa10: function () { // 保存
                        if (!table.singleData) {
                            layer.alert('请选择要保存的信息！');
                        } else {
                            saveAa10(table.singleData);
                        }
                    }
                    , refreshAa10Map: function () { // 重新获取系统代码
                        refreshAa10Map();
                    }
                };
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

                aa10();
            });
        });
        function addAa10() {
            if (loadData === newData) {
                newData = [{
                    'aaa102': '',
                    'aaa103': '',
                    'aae011': '',
                    'aae036': ''
                }].concat(loadData);
                table.reload('aa10', {data: newData});
//                var a = $(".layui-table-body tr").length - 1;
                var i = 0;
                $(".layui-table-body tr").eq(0).find('td').each(function (k, v) {
                    i++;
                    $(v).attr('data-edit', 'text');
                    if (i > 1) {
                        return false;
                    }
                });
            } else {
                layer.alert('请保存后再添加')
            }
        }

        function saveAa10(data) {
            layer.confirm('您确定要保存这条记录吗?', function (r) {
                if (data.aaa102.length > 0 && data.aaa103.length > 0) {
                    var url;
                    var aaz093 = data.aaz093;
                    if (shiFouWeiKong(aaz093)) {
                        url = basePath + '/sysmanager/sysparam/addAa10';
                    } else {
                        url = basePath + '/sysmanager/sysparam/updateAa10';
                    }
                    $.post(url, {
                        aaz093: data.aaz093,
                        aaa100: '<%=v_aaa100%>',
                        aaa102: data.aaa102,
                        aaa103: data.aaa103,
                        aae030: data.aae030,
                        aae031: data.aae031,
                        aaz094: data.aaz094,
                        aaa104: data.aaa104,
                        aaa101: data.aaa101,
                        aaa105: data.aaa105,
                        aaa106: data.aaa106,
                        aaa107: data.aaa107,
                        aae011: data.aae011,
                        aae036: data.aae036
                    }, function (result) {
                        if (result.code == '0') {
                            layer.msg('操作成功', {time: 500}, function (index) {
                                table.singleData = '';
                                selectTableDataId = '';
                                aa10();
                                updata = '';
                                layer.close(index);
                            });
                        } else {
                            layer.alert('操作失败:' + result.msg);
                        }
                    }, 'json');
                } else {
                    layer.alert('不可提交空数据');
                }
            })

        }

        function updateAa10(trobj, data) {
            if (loadData === newData) {
                if (!updata) {
                    if ('<%=v_userid%>' === data.aae011) {
                        var i = 0;
                        trobj.tr.eq(0).find('td').each(function (k, v) {
                            i++;
                            $(v).attr('data-edit', 'text');
                            if (i > 1) {
                                return false;
                            }
                        });
                        layer.msg('已开启编辑', {time: 500});
                        updata = data;
                    } else {
                        layer.alert('不是自己添加的不允许修改');
                    }
                } else {
                    layer.alert('请保存后再修改')
                }
            } else {
                layer.alert('请保存后再修改')
            }

        }

        function delAa10(aaz093, aae011) {
            if (aaz093 != '' && aaz093 != undefined && aaz093 != null) {
                if ('<%=v_userid%>' === aae011) {
                    layer.confirm('您确定要删除这条记录吗?', function (r) {
                        if (r) {
                            $.post(basePath + '/sysmanager/sysparam/delAa10', {
                                        aaz093: aaz093
                                    },
                                    function (result) {
                                        if (result.code == '0') {
                                            layer.alert("删除成功！", function (index) {
                                                aa10(true);
                                                layer.close(index);
                                                table.singleData = '';
                                                selectTableDataId = '';
                                            });
                                        } else {
                                            layer.alert("删除失败：" + result.msg);
                                        }
                                    },
                                    'json');
                        }
                    });

                } else {
                    layer.alert('不是自己添加的不允许删除');
                }
            } else {
                newData.pop();
                loadData = newData;
                table.reload('aa10', {data: loadData});
            }
        }

        function aa10(del) {
            $.post(basePath + '/sysmanager/sysparam/queryAa10?aaa100=<%=v_aaa100%>', {},
                    function (result) {
                        if (result.code == '0') {
                            var data = [];
                            loadData = result.rows;
                            if (newData) {
                                if (del) {
                                    if (!newData[newData.length - 1].aaz093) {
                                        var data = loadData.concat(newData[newData.length - 1]);
                                    }
                                }
                            }
                            if (data.length > 0) {
                                newData = data;
                                table.reload('aa10', {data: data});
                                var a = $(".layui-table-body tr").length - 1;
                                var i = 0;
                                $(".layui-table-body tr").eq(a).find('td').each(function (k, v) {
                                    i++;
                                    $(v).attr('data-edit', 'text');
                                    if (i > 1) {
                                        return false;
                                    }
                                });
                            } else {
                                newData = loadData;
                                table.reload('aa10', {data: loadData});
                            }
                        } else {
                            layer.open({
                                title: "提示",
                                content: "数据获取失败：" + result.msg //这里content是一个普通的String
                            });
                        }
                    }, 'json');
        }
        function refreshAa10Map() {
            $.post(basePath + 'sysmanager/sysparam/refreshAa10Map', {
                        aaa100: '<%=v_aaa100%>'
                    },
                    function (result) {
                        if (result.code == '0') {
                            v_retobj = true;
                            layer.alert('重新获取系统代码 成功');
                        } else {
                            parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                        }
                        parent.$.messager.progress('close');
                    }, 'json');
        }

    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-margin-top-15">
        <div class="layui-btn-group demoTable" id="toolbar">
            <ck:permission biz="addAa10">
                <button class="layui-btn" data-type="addAa10" data="btn_addAa10">新增
                </button>
            </ck:permission>
            <ck:permission biz="updateAa10">
                <button class="layui-btn" data-type="updateAa10" data="btn_updateAa10">编辑
                </button>
            </ck:permission>
            <ck:permission biz="delAa10">
                <button class="layui-btn layui-btn-danger" data-type="delAa10"
                        data="btn_delAa10">删除
                </button>
            </ck:permission>
            <ck:permission biz="saveAa10">
                <button class="layui-btn" data-type="saveAa10" data="btn_saveAa10">保存
                </button>
            </ck:permission>
            <ck:permission biz="refreshAa10Map">
                <button class="layui-btn" data-type="refreshAa10Map" data="btn_refreshAa10Map">重新获取系统代码
                </button>
            </ck:permission>
        </div>
        <table class="layui-hide" id="aa10" lay-filter="tableFilter"></table>
    </div>
</div>
</body>
</html>