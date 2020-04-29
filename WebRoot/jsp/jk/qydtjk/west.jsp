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
    Sysuser v_sysuser= (Sysuser) SysmanageUtil.getSysuser();
    String v_aaa027temp=v_sysuser.getAaa027();
    String v_aaa027sub6=v_aaa027temp.substring(0,6);
%>
<script type="text/javascript">
    // 下拉列表
    var comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
    var comhhbbz = <%=SysmanageUtil.getAa10toJsonArray("COMHHBBZ")%>;
    var comcameraflag = <%=SysmanageUtil.getAa10toJsonArray("COMSPJKBZ")%>;
    var combxbz = <%=SysmanageUtil.getAa10toJsonArray("COMBXBZ")%>;
    var v_aaa027sub6_local="<%=v_aaa027sub6%>";
    var cb_comdalei;
    var cb_comhhbbz;
    var cb_comcameraflag;
    var cb_combxbz;
    var grid;
    var table; // 数据表格
    var form; // form表单（查询条件）
    var layer; // 弹出层
    var element; //
    var selectTableDataId = '';

    //初始化下拉框选项数据
    function initSelectData() {
        var typeOptions = '';
        for (var i = 0; i < comdalei.length; i++) {
            typeOptions += '<option value=\'' + comdalei[i].id + '\' >' + comdalei[i].text + '</option>';
        }
        $("#comdalei").append(typeOptions);

        var comhhbbzOptions = '';
        for (var i = 0; i < comhhbbz.length; i++) {
            comhhbbzOptions += '<option value=\'' + comhhbbz[i].id + '\' >' + comhhbbz[i].text + '</option>';
        }
        $("#comhhbbz").append(comhhbbzOptions);

        var comcameraflagOptions = '';
        for (var i = 0; i < comcameraflag.length; i++) {
            comcameraflagOptions += '<option value=\'' + comcameraflag[i].id + '\' >' + comcameraflag[i].text + '</option>';
        }
        $("#comcameraflag").append(comcameraflagOptions);

        var combxbzOptions = '';
        for (var i = 0; i < combxbz.length; i++) {
            combxbzOptions += '<option value=\'' + combxbz[i].id + '\' >' + combxbz[i].text + '</option>';
        }
        $("#combxbz").append(combxbzOptions);

    }
    $(function () {
        initSelectData();
        initData();

    });
    function initData() {
        layui.use(['form', 'table', 'layer', 'element'], function () {
            form = layui.form;
            table = layui.table;
            layer = layui.layer;
            element = layui.element;
            table.render({
                elem: '#roleTable'
                , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                , url: basePath + '/jk/jkgl/queryQysl'
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
                    {
                        field: 'comdalei', title: '企业分类'
                        , templet: function (d) {
                        var userkind = d.id;
                        $.each(comdalei, function (i, n) {
                            if (d.comdalei == n.id) {
                                userkind = n.text;
                                return false; // 跳出本次循环
                            }
                        });
                        return userkind;
                    }
                        , event: 'trclick'
                    }
                    , {field: 'comsl', title: '企业数量', event: 'trclick'}
                    , {field: 'combxsl', title: '保险', event: 'trclick'}
                    , {field: 'comhongbsl', title: '红榜', event: 'trclick'}
                    , {field: 'comheibsl', title: '黑榜', event: 'trclick'}
                    , {field: 'comspjksl', title: '视频监控', event: 'trclick'}
                ]]
            })
            // 监听工具条
            table.on('tool(tableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'trclick') { // 选中行
                    if (selectTableDataId != data.comdalei) {
                        // 清除所有行的样式
                        $(".layui-table-body tr").each(function (k, v) {
                            $(v).removeAttr("style");
                        });
                        $(obj.tr.selector).css("background", selectTableBackGroundColor);
                        table.singleData = data;
                        selectTableDataId = data.comdalei;
                    } else { // 再次选中清除样式
                        $(obj.tr.selector).attr("style", "");
                        table.singleData = '';
                        selectTableDataId = '';
                    }
                }
            });
        })

        $('#btn-query').click(function () {
            query();
            return false;
        })
    }

    // 查询
    function query() {
        var aaa027 = $('#aaa027').val();
        var comdalei = $('#comdalei').val();
        var commc = $('#commc').val();
        var comcameraflag = $('#comcameraflag').val();
        var combxbz=null;
        var comhhbbz=null;
        if (comdalei==null || comdalei==""||comdalei.length==0){
            layer.msg("请选择企业大类");
            return;
        }

        if (v_aaa027sub6_local!="410122"){
            comhhbbz= $('#comhhbbz').val();
            combxbz = $('#combxbz').val();
        }
        var param = {
            "aaa027": aaa027,
            "comdalei": comdalei,
            "comhhbbz": comhhbbz,
            "comcameraflag": comcameraflag,
            "combxbz": combxbz,
            "commc": commc
        };
        table.reload('roleTable', {
            url: basePath + '/jk/jkgl/queryQysl'
            , where: param //设定异步数据接口的额外参数
        });
        showJk(aaa027, comdalei, comhhbbz, comcameraflag, combxbz, commc);
    }


    // 监控
    var showJk = function (aaa027, comdalei_v, comhhbbz, comcameraflag, combxbz, commc) {
        var comdalei_name = sy.formatGridCode(comdalei, comdalei_v);
        var tabTitle = "欢迎使用";
        var url = encodeURI("/jk/jkgl/qydtjkmonitorIndex?aaa027=" + aaa027 + "&comdalei=" + comdalei_v + "&comhhbbz=" + comhhbbz + "&comcameraflag=" + comcameraflag + "&combxbz=" + combxbz + "&commc=" + commc);
        addTab(tabTitle, url, 'ext-icon-monitor');
    };

    function showMenu_aaa027() {
        var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
        sy.modalDialog({
            area: ['300px', '400px']
            , type: 2
            , title: '监控'
            , content: url
        }, function (dialogID) {
            var obj = sy.getWinRet(dialogID);
            sy.removeWinRet(dialogID);
            if (obj.type == "ok") {
                $('#aaa027').val(obj.aaa027);
                $('#aaa027name').val(obj.aaa027name);
            }
        });
    }
</script>


<div class="layui-fluid">
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">查询条件</h2>

            <div class="layui-colla-content layui-show" >
                <form id="myqueryform" class="layui-form">
                    <table>
                        <tr>
                        <td style="text-align: center">
                            <font style="color: red">*</font>企业分类
                        </td>
                    </tr>
                        <tr>
                            <td>
                                <select name="comdalei" id="comdalei">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                所属地区
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="layui-input" name="aaa027name" id="aaa027name" style="width: 180px "
                                       onclick="showMenu_aaa027();" readonly="readonly" data-options="required:true"/>
                                <input name="aaa027" id="aaa027" hidden="hidden"/>

                                <div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
                                    <input id="treeDemo_aaa027" class="ztree"
                                           style="margin-top:0px;width:150px;height:450px;">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                企业名称
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="layui-input" id="commc" name="commc" style="width: 180px"/>
                            </td>
                        </tr>

                        <tr>
                            <td style="text-align: center">
                                监控标志
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select name="comcameraflag" id="comcameraflag">
                                </select>
                            </td>
                        </tr>

                        <% if (!"410122".equals(v_aaa027sub6)){%>
                        <tr>
                            <td style="text-align: center">
                                红黑榜标志
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select name="comhhbbz" id="comhhbbz">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center">
                                保险标志
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <select name="combxbz" id="combxbz" lay-verify="required" >
                                </select>
                            </td>
                        </tr>
                        <%}%>
                        <tr>
                            <td style="text-align: center">
                                <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn-query">
                                    <i class='layui-icon'>&#xe615;</i>查询
                                </button>
                                <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn_reset">
                                    <i class="layui-icon">&#xe621;</i>重置
                                </button>
                            </td>
                        </tr>
                    </table>

<%--                    <div class="layui-form-item">

                        <label class="layui-form-label">所属地区</label>

                        <div class="layui-inline">
                            <input class="layui-input" name="aaa027name" id="aaa027name" style="width: 160px "
                                   onclick="showMenu_aaa027();" readonly="readonly" data-options="required:true"/>
                            <input name="aaa027" id="aaa027" hidden="hidden"/>

                            <div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
                                <input id="treeDemo_aaa027" class="ztree"
                                       style="margin-top:0px;width:150px;height:450px;">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">企业分类</label>

                        <div class="layui-inline">
                            <select name="comdalei" id="comdalei">
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">红黑榜标志</label>

                        <div class="layui-inline">
                            <select name="comhhbbz" id="comhhbbz">
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">监控标志</label>

                        <div class="layui-inline">
                            <select name="comcameraflag" id="comcameraflag">
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">保险标志</label>

                        <div class="layui-inline">
                            <select name="combxbz" id="combxbz">
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">企业名称</label>

                        <div class="layui-inline">
                            <input class="layui-input" id="commc" name="commc" style="width: 160px"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn-query">
                            <i class='layui-icon'>&#xe615;</i>查询
                        </button>
                        <button class="layui-btn layui-btn-sm layui-btn-normal" id="btn_reset">
                            <i class="layui-icon">&#xe621;</i>重置
                        </button>
                    </div>--%>
                </form>
            </div>
        </div>
    </div>
    <div class="layui-margin-top-15">
        <table class="layui-hide" id="roleTable" lay-filter="tableFilter"></table>
    </div>
</div>


          