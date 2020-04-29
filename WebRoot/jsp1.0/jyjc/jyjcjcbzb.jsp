<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null==basePath || "".equals(basePath)){
        basePath = request.getScheme() + "://"	+ request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
    String v_userdalei=sysuser.getUserdalei();//1非企业用户2企业用户

%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测标准</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var grid;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var v_BZSTATE=<%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
        var v_jyjcbzfenlei=<%=SysmanageUtil.getAa10toJsonArray("JYJCBZFENLEI")%>
        var v_jyjczbfenlei=<%=SysmanageUtil.getAa10toJsonArray("JYJCZBFENLEI")%>
        var v_jyjcicsfenlei=<%=SysmanageUtil.getAa10toJsonArray("JYJCICSFENLEI")%>
        $(function() {
            $('#jyjcbzstate').combobox({
                data : v_BZSTATE,
                valueField : 'id',
                textField : 'text',
                required : false,
                editable : false,
                panelHeight : 'auto'
            });
            $('#sfyx').combobox({
                data : v_SFYX,
                valueField : 'id',
                textField : 'text',
                required : false,
                editable : false,
                panelHeight : 'auto'
            });
            grid = $('#grid').datagrid({
                //title: '企业信息列表',
                //iconCls: 'icon-tip',
                toolbar: '#toolbar',
                url: basePath + 'jyjc/queryJyjcjcbzb',
                striped : true,// 奇偶行使用不同背景色
                singleSelect : false,// True只允许选中一行
                checkOnSelect : true,
                selectOnCheck : true,
                pagination : true,// 底部显示分页栏
                pageSize : 10,
                pageList : [ 10, 20, 30 ],
                rownumbers : true,// 是否显示行号
                fitColumns : false,// 列自适应宽度
                idField: 'jyjcjcbzbid', //该列是一个唯一列
                sortOrder: '',
                //onLoadSuccess: onLoadSuccess,
                columns : [ [ {
                    width : '160',
                    title : '标准编号',
                    field : 'bzbh',
                    hidden : false
                },{
                    width : '100',
                    title : '中文名称',
                    field : 'chinaname',
                    hidden : false
                },{
                    width : '100',
                    title : '英文名称',
                    field : 'engname',
                    hidden : false
                },{
                    width : '100',
                    title : '标准分类',
                    field : 'jyjcbzfenlei',
                    hidden : false,
                    formatter:function(value,row){
                        return sy.formatGridCode(v_jyjcbzfenlei,value);
                    }
                },{
                    width : '100',
                    title : '标准状态',
                    field : 'jyjcbzstate',
                    hidden : false,
                    formatter:function(value,row){
                        return sy.formatGridCode(v_BZSTATE,value);
                    }
                },{
                    width : '100',
                    title : '替代情况',
                    field : 'tdqk',
                    hidden : false
                },{
                    width : '100',
                    title : '中标分类',
                    field : 'jyjczbfenlei',
                    hidden : false,
                    formatter:function(value,row){
                        return sy.formatGridCode(v_jyjczbfenlei,value);
                    }
                },{
                    width : '100',
                    title : 'ICS分类',
                    field : 'jyjcicsfenlei',
                    hidden : false,
                    formatter:function(value,row){
                        return sy.formatGridCode(v_jyjcicsfenlei,value);
                    }
                },{
                    width : '120',
                    title : 'UDC分类',
                    field : 'jyjcudcfenlei',
                    hidden : false
                },{
                    width : '80',
                    title : '发布部门',
                    field : 'fbbm',
                    hidden : false
                },{
                    width : '120',
                    title : '发布日期',
                    field : 'fbrq',
                    hidden : true
                },{
                    width : '80',
                    title : '实施日期',
                    field : 'ssrq',
                    hidden : true
                },{
                    width : '100',
                    title : '作废日期',
                    field : 'zfrq',
                    hidden : true
                },{
                    width : '100',
                    title : '首发日期',
                    field : 'sfrq',
                    hidden : true
                },{
                    width : '150',
                    title : '复审日期',
                    field : 'fsrq',
                    hidden : true
                },{
                    width : '80',
                    title : '提出单位',
                    field : 'tcdw',
                    hidden : true
                },{
                    width : '80',
                    title : '归口单位',
                    field : 'gkdw',
                    hidden : false
                },{
                    width : '150',
                    title : '主管部门',
                    field : 'zgbm',
                    hidden : true
                },{
                    width : '100',
                    title : '起草单位',
                    field : 'qcdw',
                    hidden : true
                },{
                    width : '100',
                    title : '起草人',
                    field : 'rcr',
                    hidden : true
                },{
                    width : '200',
                    title : '标准内容',
                    field : 'bzcontent',
                    hidden : false
                },{
                    width : '200',
                    title : '操作员',
                    field : 'aae011',
                    hidden : false
                },{
                    width : '200',
                    title : '操作时间',
                    field : 'aae036',
                    hidden : false
                },{
                    width : '150',
                    title : '检验检测检测标准ID',
                    field : 'jyjcjcbzbid',
                    hidden : false,
                    checkbox:'true'
                },{
                    width : '200',
                    title : '是否有效',
                    field : 'sfyx',
                    hidden : false,
                    formatter:function(value,row){
                        return sy.formatGridCode(v_SFYX,value);
                    }
                }] ]
            });
        });
        // 查询企业信息
        function query() {
            var param = {
                'bzbh': $('#bzbh').val(),
                'chinaname': $('#chinaname').val()
            };
            grid.datagrid({
                url : basePath + 'jyjc/queryJyjcjcbzb',
                queryParams : param
            });
            grid.datagrid('clearSelections');
        }

        // 刷新
        function refresh(){
            window.location.reload();
        }

        //新增检验检测项目
        var addJyjcbz = function() {
            var dialog = parent.sy.modalDialog({
                title : '新增检验检测项目标准',
                width : 800,
                height : 650,
                url : basePath + 'jyjc/jyjcbzFormIndex',
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.saveJyjcbz(dialog, grid, parent.$);
                    }
                },{
                    text : '取消',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
                    }
                } ]
            });
        };

        //编辑诚信评定等级参数信息
        var updateJyjcbz = function(){
            var row = $('#grid').datagrid('getSelected');
            console.log(row);
            if(row){
                var dialog = parent.sy.modalDialog({
                    title:'编辑检验检测项目标准',
                    width : 800,
                    height : 650,
                    url:basePath + 'jyjc/jyjcbzFormIndex?jyjcjcbzbid='+row.jyjcjcbzbid,
                    buttons:[{
                        text : '确定',
                        handler:function(){
                            dialog.find('iframe').get(0).contentWindow.saveJyjcbz(dialog,grid,parent.$);
                        }
                    },{
                        text : '取消',
                        handler : function(){
                            dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
                        }
                    }]
                });
            }else{
                $.messager.alert('提示','请先选择要修改的检验检测项目信息！','info');
            }
        }

        // 删除检验检测项目信息
        function delJyjcbz() {
            var row = $('#grid').datagrid('getSelected');
            if (row) {
                var jyjcjcbzbid = row.jyjcjcbzbid;
                $.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
                    if (r) {
                        $.post(basePath + 'jyjc/delJyjcbz', {
                                    jyjcjcbzbid: jyjcjcbzbid
                                },
                                function(result) {
                                    if (result.code == '0') {
                                        $.messager.alert('提示','删除成功！','info',function(){
                                            $('#grid').datagrid('reload');
                                        });
                                    } else {
                                        $.messager.alert('提示', "删除失败：" + result.msg, 'error');
                                    }
                                },
                                'json');
                    }
                });
            }else{
                $.messager.alert('提示', '请先选择要删除的检验检测项目信息！', 'info');
            }
        }

        //查看检验检测项目
        var showJyjcbz = function(){
            var row = $('#grid').datagrid('getSelected');
            if(row){
                var dialog = parent.sy.modalDialog({
                    title : '查看检验检测项目',
                    width : 800,
                    height : 650,
                    url : basePath +'jyjc/jyjcbzFormIndex?op=view&jyjcjcbzbid='+row.jyjcjcbzbid,
                    buttons : [{
                        text : '关闭',
                        handler:function(){
                            dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
                        }
                    }]
                });
            }else{
                $.messager.alert('提示','请先选择要查看的信息！','info');
            }
        }
        // 关闭窗口
        var closeWindow = function($dialog, $pjq){
            $dialog.dialog('destroy');
        };
        function selectjcbz(){
            var rows=grid.datagrid('getSelections');
            sy.setWinRet(rows);
            parent.$("#"+sy.getDialogId()).dialog("close");
        }
    </script>
</head>
<body >
<div class="easyui-layout" fit="true">
    <div region="center" style="overflow: true;" border="false">
        <sicp3:groupbox title="查询条件">
            <table class="table" style="width: 99%;">
                <tr>
                    <td style="text-align:right;"><nobr>标准编号</nobr></td>
                    <td><input id="bzbh" name="bzbh" style="width: 200px" /></td>
                    <td style="text-align:right;"><nobr>名称</nobr></td>
                    <td><input id="chinaname" name="chinaname" style="width: 200px" /></td>
                    <td colspan="2" style="text-align: right">
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           iconCls="icon-search" onclick="query()"> 查 询 </a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)" class="easyui-linkbutton"
                           iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
                    </td>
                </tr>

            </table>
        </sicp3:groupbox>
        <sicp3:groupbox title="检验检测标准信息列表">
            <div id="toolbar">
                <% if (!"select".equalsIgnoreCase(op)) {%>
                <table>
                    <tr>
                        <td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcbz"
                               iconCls="icon-add" plain="true" onclick="addJyjcbz()">增加</a>
                        </td>
                        <td>
                            <div class="datagrid-btn-separator"></div>
                        </td>
                        <td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveJyjcbz"
                               iconCls="icon-edit" plain="true" onclick="updateJyjcbz()">编辑</a>
                        </td>
                        <td>
                            <div class="datagrid-btn-separator"></div>
                        </td>
                        <td>
                            <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delJyjcbz"
                               iconCls="icon-remove" plain="true" onclick="delJyjcbz()">删除</a>
                        </td>
                        <td>
                            <div class="datagrid-btn-separator"></div>
                        </td>
                        <td>
                            <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showJyjcbzFormIndex"
                               iconCls="ext-icon-report_magnify" plain="true" onclick="showJyjcbz()">查看</a>
                        </td>
                        <td>
                            <div class="datagrid-btn-separator"></div>
                        </td>
                    </tr>
                </table>
                <%}%>
            </div>
            <div id="grid" style="height:350px;overflow:auto;"></div>
        </sicp3:groupbox>
    </div>
</div>
</body>
</html>