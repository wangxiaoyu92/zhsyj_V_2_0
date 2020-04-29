<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String id = StringHelper.showNull2Empty(request.getParameter("cydjid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>采集信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <script type="text/javascript">
        var selectTableDataId;
        var tableData = [];
        var table; // 数据表格
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var $;
        $(function () {
            layui.use(['form', 'table', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                layer = layui.layer;
                element = layui.element;
                $ = layui.jquery;
                if ($('#cydjid').val() != "" && $('#cydjid').val() != null) {
                    $.post(basePath + '/jyjc/queryJyjccydj', {
                        cydjid: $('#cydjid').val()
                    }, function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            $('form').form('load', mydata);

                        } else {
                            layer.msg('查询失败：' + result.msg, 'error')
                        }
                    }, 'json');
                }
                table.on('tool(tableFilter)', function (obj) {
                    var data = obj.data;
                    if (obj.event === 'trclick') { // 选中行
                        // 清除所有行的样式
                        $(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $(obj.tr.selector).css("background", "#90E2DA");
                        table.singleData = data;
                        selectTableDataId = data.jyjcbgxmid;
                    }
                });
                active = {
                    addPcom: function () { // 增
                        addPcom();
                    },
                    savePcom: function () { // 增
                        savePcom(table.singleData);
                    }
                }
                $('.demoTable .layui-btn').on('click', function () {
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });

            })
        })
        function addPcom() {
            var intHtml = "";
            intHtml += "<tr><td></td><td></td>";
            intHtml += "<td></td><td></td><td></td><td></td></tr>";
            $("#tbody").append(intHtml);
            table.init('tableFilter', {
                height: 'full-230',
            });
        }
        //保存报告
        var submitForm = function () {

            var rows = table.cache.layTable;
            if (rows.length == 0) { //若检查项目为空不让保存报告   直接关闭该页
                $dialog.dialog('destroy');
            }
            var url = basePath + 'jyjc/savejcbg';
            $('#fm').form('submit', {
                url: url,
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        layer.alert('保存成功');
                        var obj = new object();
                        obj.type = 'ok';
                        sy.setWinRet(obj);
                        closeWindow();
//                        $.messager.alert('提示','保存成功！','info',function(){
//                            $grid.datagrid('load');
//                            $dialog.dialog('destroy');
//                        });
                    } else {
                        layer.alert('保存失败：' + result.msg, 'error');
                    }
                }
            });
        };
        function savePcom(data) {
            var results = [];
            results.push(data);
            if (data != "" || data != null) {
                $.post(basePath + '/jyjc/savejcxm', {
                    cydjid: $('#cydjid').val(),
                    succJsonStr: data
                }, function (result) {
                    if (result.code == '0') {
                        layer.msg('保存成功');
                        table.reload('tbody', {data: results});
                    } else {
                        layer.msg('操作失败' + result.msg, 'error')
                    }
                    ;
                }, 'json');
            } else {
                layer.msg('没有要保存的记录');
            }
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">抽样信息</h2>

            <div class="layui-table">
                <div region="center" style="overflow: hidden;" border="false">
                    <form class="layui-form" action="" id="jyjcjgForm">
                        <input id="cydjid" name="cydjid" type="hidden" value="<%=id%>"/>
                        <input id="bcydwcomid" name="bcydwcomid" type="hidden"/>
                        <input id="scdwcomid" name="scdwcomid" type="hidden"/>

                        <div class="layui-container">
                            <div class="layui-row">
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px"><font
                                                class="myred">*</font>被抽样单位：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="bcydw" name="bcydw"
                                                   autocomplete="off" class="layui-input" lay-verify="required">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" id="bcytel"
                                               style="width: 120px">被抽样单位联系电话：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="tel" name="tel"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">被抽样单位地址：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="bcydwdz" name="bcydwdz" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">被抽样单位分类：</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="bcydwfl" name="bcydwfl" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px"><font
                                                class="myred">*</font>抽样编号:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cybh" name="cybh"
                                                   autocomplete="off" class="layui-input" lay-verify="required">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">样品名称:</label>

                                        <div class="layui-input-inline layui-form">
                                            <input type="text" id="ypmc" name="ypmc"
                                                   autocomplete="off" class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">样品批号或生产日期:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="ypbh" name="ypbh" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">抽样时间:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cysj" name="cysj" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px"><font
                                                class="myred">*</font>抽样数量:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="countcy" name="countcy" autocomplete="off"
                                                   lay-verify="required"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">生产单位:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="scdw" name="scdw" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">抽样经手人:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cyjsr" name="cyjsr" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">抽样分类:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="cyfl" name="cyfl" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item" id="hide">
                                        <label class="layui-form-label" style="width: 120px">经办时间:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="aae036" name="aae036" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" style="width: 120px">经办人:</label>

                                        <div class="layui-input-inline">
                                            <input type="text" id="aae011" name="aae011" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item" style="display: none">
                                    <div class="layui-input-block">
                                        <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">
                                            保存
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="layui-collapse">
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title">检查项目列表</h2>

                    <div class="layui-table">
                        <fieldset class="layui-elem-field site-demo-button"
                                  style="width: 100%;border: none;padding-top: 8px;">
                            <div class="layui-btn-group demoTable">
                                <ck:permission biz="addPcom">
                                    <button class="layui-btn" id="s_add" data-type="addPcom" data="btn_addPcom">增加
                                    </button>
                                </ck:permission>
                                <ck:permission biz="updatePcom">
                                    <button class="layui-btn" data-type="editPcom" data="btn_editPcom">编辑</button>
                                </ck:permission>
                                <ck:permission biz="delPcom">
                                    <button class="layui-btn layui-btn-danger" data-type="delPcom" data="btn_delPcom">
                                        删除
                                    </button>
                                </ck:permission>
                                <ck:permission biz="quxPcom">
                                    <button class="layui-btn " data-type="quxPcom" data="btn_showPcom">取消</button>
                                </ck:permission>
                                <ck:permission biz="savePcom">
                                    <button class="layui-btn " id="s_save" data-type="savePcom" data="btn_showPcom">保存
                                    </button>
                                </ck:permission>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
            <table class="layui-table" id="layTable" lay-filter="tableFilter" lay-data="{id:'jyjcbgxmid'}">
                <thead>
                <tr>
                    <th lay-data="{field:'jyjcbgxmid', width:150,event: 'trclick'}">检验检测报告项目id</th>
                    <th lay-data="{field:'jxjcxmmc', width:150,edit:'text',event: 'trclick'}">检查项目名称</th>
                    <th lay-data="{field:'bzz', width:150,edit:'text',event: 'trclick'}">标准值</th>
                    <th lay-data="{field:'dw',width:'150',edit:'text',event: 'trclick'}">单位</th>
                    <th lay-data="{field:'jyjcjg',width:'150',edit:'text',event: 'trclick'}">检验检测结果</th>
                    <th lay-data="{field:'sfhg',width:'150',edit:'text',event: 'trclick'}">是否合格</th>
                    <th lay-data="{field:'yjqk',width:'150',edit:'text',event: 'trclick'}">移交情况</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>