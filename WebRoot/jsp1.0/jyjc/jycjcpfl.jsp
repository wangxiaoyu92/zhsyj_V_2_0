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
%>
<!DOCTYPE html>
<html>
<head>
    <title>抽检实施细则产品分类</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        //定义全局变量父子关系类别
        var b_parentchildlb="choujiancpfl ";
        //定义全局变量父子关系类别名称
        var b_parentchildlbmc="抽检产品分类";
        var treeObj;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;

        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "parentchildid",
                    pIdKey: "parentid",
                    rootPId: 0
                },
                key: {
                    name: "mc"
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
            var param={
                parentchildlb:b_parentchildlb,
                parentchildlbmc:b_parentchildlbmc
            }
            //初始化机构树
            $.post(basePath + '/pub/pub/queryParentchildZTree',param, function(result) {
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
            $('#parentid').combotree({
                url: basePath + '/pub/pub/queryParentchildTree?parentchildlb='+b_parentchildlb+'&parentchildlbmc='+b_parentchildlbmc,
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
            var parentchildid = $('#parentchildid').val();
            if (parentchildid==null || parentchildid=="") {
                alert('请选择要删除的分类');
                return false;
            }
            $.messager.confirm('警告', '您确定要删除该分类吗！',function(r) {
                if (r) {
                    $.post(basePath + '/pub/pub/delParentchild', {
                                parentchildid :parentchildid
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
                url: basePath + '/pub/pub/saveParentchild?parentchildlb='+b_parentchildlb+'&parentchildlbmc='+b_parentchildlbmc,
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
                        <td style="text-align:right;"><nobr>抽检实施细则产品分类关系表ID:</nobr></td>
                        <td><input id="parentchildid" name="parentchildid" style="width: 200px;" readonly="readonly" class="input_readonly" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>父级分类</nobr></td>
                        <td><input class="easyui-combotree" id="parentid" name="parentid" style="width: 200px;" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>是否有效</nobr></td>
                        <td><input id="sfyx" name="sfyx" style="width: 200px;" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>抽检产品编号:</nobr></td>
                        <td><input id="bh" name="bh" style="width: 200px;" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>抽检产品名称:</nobr></td>
                        <td><input id="mc" name="mc" style="width: 200px;" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>操作员:</nobr></td>
                        <td><input id="username" name="username" readonly="readonly" class="input_readonly" style="width: 200px;"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right;"><nobr>操作时间:</nobr></td>
                        <td><input id="czsj" name="czsj" class="easyui-datebox" style="width: 200px;"/></td>
                    </tr>
                </table>
            </form>
            <br/>
            <div style="text-align:center">
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveParentChild"
                   iconCls="icon-add" onclick="addCate()">新增</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveParentChild"
                   iconCls="icon-cancel" onclick="delCate()">删除</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:void(0)" class="easyui-linkbutton" data="btn_saveParentChild"
                   iconCls="icon-save" onclick="saveCate()">保存 </a>
            </div>
        </sicp3:groupbox>
    </div>
</div>
</body>
</html>