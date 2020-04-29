<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_jyjcxmid= StringHelper.showNull2Empty(request.getParameter("jcxmid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测项目</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var treeObj;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var grid;
        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "jyjcxmid",
                    pIdKey: "jcxmparentid",
                    rootPId: 0
                },
                key: {
                    name: "jcxmmc"
                }
            },
            callback: {
                onClick: onClick
            }

        };

        $(function() {
            refreshZTree();
            $('#sfyx').combobox({
                data : v_SFYX,
                valueField : 'id',
                textField : 'text',
                required : false,
                editable : false,
                panelHeight : 'auto'
            });

        });

        //初始化zTree树
        function refreshZTree(){
            //初始化机构树
            $.post(basePath + 'jyjc/queryJyjcxmZTree', {}, function(result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                    treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    addCate();
                } else {
                    $.messager.alert('提示', result.msg, 'error');
                }
            }, 'json');
            $('#jcxmparentid').combotree({
                url: basePath + 'jyjc/queryJyjcxmTree',
                required: true
            });
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            $('#fm').form('load',treeNode);//用节点数据填充form
        }

    </script>
    <script type="text/javascript">

        function refresh(){
            parent.window.refresh();
        }

        // 新增
        function addCate() {
            $('#fm').form('clear');
//            $('#aaz093').val('');
//             $('#aaa102').val('');
//             $('#aaa103').val('');
//             $('#aaa104').combotree('setValue','');
            $('#sfyx').combobox('setValue','1');
            <%--$('#jcxmid').val('<%=v_jyjcxmid%>');--%>
        }

        // 删除
        function delCate() {
            var jyjcxmid = $('#jyjcxmid').val();
            if (jyjcxmid==null || jyjcxmid=="") {
                alert('请选择要删除的分类');
                return false;
            }
            $.messager.confirm('警告', '您确定要删除该分类吗！',function(r) {
                if (r) {
                    $.post(basePath + 'jyjc/delJyjcxm2', {
                                jyjcxmid :jyjcxmid
                            },
                            function(result) {
                                if (result.code == '0') {
                                    $.messager.alert('提示','删除成功！','info',function(){
                                        //刷新左侧的树
                                        refreshZTree();
                                    });
                                } else {
                                    $.messager.alert('提示', "删除失败：" + result.msg, 'error');
                                }
                            },
                            'json');
                }
            });
        }

        // 保存
        function saveCate() {
            $.messager.progress();	// 显示进度条
            $('#fm').form('submit',{
                url: basePath + 'jyjc/saveJyjcxm2',
                onSubmit: function(){
                    var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    if(!isValid){
                        $.messager.progress('close');
                    }
                    return isValid;
                },
                success: function(result){
                    result = $.parseJSON(result);
                    if (result.code=='0'){
                        $.messager.progress('close');
                        $.messager.alert('提示','保存成功！','info',function(){
                            //刷新左侧的树
                            refreshZTree();
                        });
                    } else {
                        $.messager.progress('close');
                        $.messager.alert('提示','保存失败：'+result.msg,'error');
                    }
                }
            });
        }
        //选择检测标准
        function myselectjcbz(){
            var v_jcbzChinaname = "";
            var v_jyjcjcbzbid = "";
            var dialog = parent.sy.modalDialog({
                title : '选择检验检测项目标准',
                width : 1100,
                height : 450,
                url : basePath + 'jyjc/jyjcjcbzbIndex?op=select',
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.selectjcbz(dialog, grid, parent.$);
                    }
                },{
                    text : '取消',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
                    }
                } ]
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        if ("" == v_jyjcjcbzbid) {
                            v_jyjcjcbzbid = myrow.jyjcjcbzbid;
                            v_jcbzChinaname = myrow.chinaname;
                        } else {
                            v_jyjcjcbzbid = v_jyjcjcbzbid + "," + myrow.jyjcjcbzbid;
                            v_jcbzChinaname = v_jcbzChinaname + "," + myrow.chinaname;
                        }
                    }
                    $("#chinaname").val(v_jcbzChinaname);
                    $("#jyjcjcbzbid").val(v_jyjcjcbzbid);
                }
            });
        }
        //选择检测方法
        function myselectjcff(){
            var v_jcffbzmc = "";
            var v_jyjcjcffbzbid = "";
            var dialog = parent.sy.modalDialog({
                title : '选择检验检测方法标准',
                width : 1100,
                height : 450,
                url : basePath + 'jyjc/jcffglIndex?op=select',
                buttons : [ {
                    text : '确定',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.selectjcff(dialog, grid, parent.$);
                    }
                },{
                    text : '取消',
                    handler : function() {
                        dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
                    }
                } ]
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        if ("" == v_jyjcjcffbzbid) {
                            v_jcffbzmc = myrow.jcffbzmc;
                            v_jyjcjcffbzbid = myrow.jyjcffbzbid;
                        } else {
                            v_jcffbzmc = v_jcffbzmc + "," + myrow.jcffbzmc;
                            v_jyjcjcffbzbid = v_jyjcjcffbzbid + "," + myrow.jyjcffbzbid;
                        }
                    }
                    $("#jcffbzmc").val(v_jcffbzmc);
                    $("#jyjcffbzbid").val(v_jyjcjcffbzbid);
                }
            });
        }
    </script>
</head>
<body>
<div class="easyui-layout" fit="true">
    <div region="west" style="width:250px;overflow: hidden;" border="false">
        <ul id="treeDemo" class="ztree" ></ul>
    </div>
    <div region="center" style="overflow: hidden;" border="false">
        <sicp3:groupbox title="分类信息">
            <form id="fm" name="fm" method="post">
                <table class="table" style="width: 80%;">
                    <tr>
                        <td style="text-align:right;"><nobr>检查项目ID:</nobr></td>
                        <td><input id="jyjcxmid" name="jyjcxmid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>检查项目编号:</nobr></td>
                        <td><input id="jcxmbh" name="jcxmbh" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>检查项目名称:</nobr></td>
                        <td><input id="jcxmmc" name="jcxmmc" style="width: 200px;" class="easyui-validatebox" data-options="required:true" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>父级分类</nobr></td>
                        <td><input class="easyui-combotree" id="jcxmparentid" name="jcxmparentid" style="width: 200px;"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>是否有效</nobr></td>
                        <td><input id="sfyx" name="sfyx" style="width: 200px;" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>检验检测检测标准</nobr></td>
                        <td><input id="chinaname" name="chinaname" readonly="readonly" class="input_readonly" style="width: 200px;" />
                            <input id="jyjcjcbzbid" name="jyjcjcbzbid" hidden="true" style="width: 200px;" />
                            <input id="jyjcxmjcbzid" name="jyjcxmjcbzid" hidden="true" style="width: 200px;" />
                            <a id="btnselectjcbz" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
                               onclick="myselectjcbz()">选择检测标准 </a>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>检验检测方法标准</nobr></td>
                        <td>
                            <input id="jcffbzmc" name="jcffbzmc" readonly="readonly" class="input_readonly" style="width: 200px;" />
                            <input id="jyjcffbzbid" name="jyjcffbzbid" hidden="true" style="width: 200px;" />
                            <input id="jyjcxmjcffbz" name="jyjcxmjcffbz" hidden="true" style="width: 200px;" />
                            <a id="btnselectjcff" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"
                               onclick="myselectjcff()">选择检测方法 </a>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>标准值:</nobr></td>
                        <td><input id="jcxmbzz" name="jcxmbzz" style="width: 200px;" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>操作员:</nobr></td>
                        <td><input id="jcxmczy" name="jcxmczy" readonly="readonly" class="input_readonly" style="width: 200px;"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>操作时间:</nobr></td>
                        <td><input id="jcxmczsj" name="jcxmczsj" class="easyui-datebox" style="width: 200px;"/></td>
                    </tr>
                </table>
            </form>
            <br/>
            <div style="text-align:center">
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
                   iconCls="icon-add" onclick="addCate()">新增</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delNewsCate"
                   iconCls="icon-cancel" onclick="delCate()">删除</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveNewsCate"
                   iconCls="icon-save" onclick="saveCate()">保存 </a>
            </div>
        </sicp3:groupbox>
    </div>
</div>
</body>
</html>