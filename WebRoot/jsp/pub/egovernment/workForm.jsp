<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node_trans" %>
<%@ page import="java.util.List,com.zzhdsoft.siweb.service.workflow.WorkflowService,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    // 案件登记id
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ywbh"));
    String v_ywlcid = StringHelper.showNull2Empty(request.getParameter("ywlcid"));
    String v_psbh = StringHelper.showNull2Empty(request.getParameter("psbh"));
    String v_transfrom = StringHelper.showNull2Empty(request.getParameter("nodeid"));
    String v_nodename = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("nodename")), "UTF-8");
    String v_nodeid = StringHelper.showNull2Empty(request.getParameter("nodeid"));
    String v_fjcsdmlb = StringHelper.showNull2Empty(request.getParameter("fjcsdmlb"));
    String v_fjcsdlbh = StringHelper.showNull2Empty(request.getParameter("fjcsdlbh"));
    String v_ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));

    //获取分支节点流向值
    WorkflowService v_WorkflowService = new WorkflowService();
    List<Wf_node_trans> v_listWf_node_trans = (List<Wf_node_trans>) v_WorkflowService.queryWfnodeTransList(v_psbh, v_transfrom);

    String v_nextchecked = "";
    int v_transCount = 0;
    if (v_listWf_node_trans != null) {
        v_transCount = v_listWf_node_trans.size();
        if (v_transCount == 1) {
            v_nextchecked = "checked='checked'";
        }

    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>工作上报流程办理：<%=v_nodename %>
    </title>
    <!--收文公共页面-->
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>

    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);

        function gongwen() {
            document.getElementById("ajslcommonframe").src = '<%=basePath%>work/task/worksbeditForm?op=view&worksbid=' + '<%=v_ajdjid%>';
        }

        //提交流程
        function tijiaoliucheng() {

            var v_transname = "";
            var cyryid="";
            v_transname = $('#xuanzeliuxiang input[name="transname"]:checked ').val();
            if (v_transname == undefined) {
                alert("请选择办理流向");
                return false;
            }
            if(v_transname == '提交处理意见'){
                cyryid = $("#userid").val();
            }else{
                cyryid = "";
            }

                var cfmMsg = "确定要提交流程吗?";
                var v_transyy = $("#transyy").val();

                var v_transval = "七日内做出决定";
                var v_shifouTongguo = "1";
                var v_url2 = encodeURI(encodeURI("<%=basePath%>workflow/doWfgongwenprocess?ywlcid=<%=v_ywlcid%>&transval=" + v_transval + "&shifouTongguo=" + v_shifouTongguo + "&ywlcuserid=" + cyryid + "&transname=" + v_transname + "&transyy=" + v_transyy + "&time=" + new Date().getMilliseconds()));
                $.messager.confirm('确认', cfmMsg, function (r) {
                    if (r) {


                                    $.ajax({
                                        url: v_url2,
                                        type: 'post',
                                        async: true,
                                        cache: false,
                                        timeout: 100000,
                                        //data:formData,
                                        success: function (result) {
                                            result = $.parseJSON(result);
                                            if (result.code == '0') {
                                                layer.confirm('提示! 提交流程成功！', {
                                                    btn: ['确定'] //按钮
                                                }, function () {
                                                    window.parent.location.reload();
                                                    var index = parent.layer.getFrameIndex(window.name);
                                                    parent.layer.close(index);
                                                });
                                            } else {
                                                parent.$.messager.alert();
                                                layer.alert('提示!-提交流程失败：' + result.msg);
                                            }
                                        }

                                    });
                    }

                });



        }

        function closeWindow() {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        }

    </script>


    <script type="text/javascript">
        var form;
        var layer;
        var laydate;
        $(function () {
            /*gongwen();*/
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                var myDate = new Date();
                laydate.render({
                    elem: '#time',
                    type:'datetime'
                });
            $.post(basePath + '/work/task/queryWDTO', {
                    worksbid: '<%=v_ajdjid%>'
                },
                function (result) {
                    if (result.code == '0') {

                        $('#sysUserForm').form('load', result.data);
                        form.render();
                    }
                }, 'json');

                $('form :input').addClass('input_readonly');
                $('form :input').attr('readonly', 'readonly');

            })
   });





    </script>
    <style>
        .layui-table td {
            border-color: #ff0000;
        }

        .font_main {
            color: #ff0000;
            font-size: 15pt;
        }

        .font_main_title {
            color: #ff0000;
            font-size: 20pt;
        }

        .margin_main_line {
            margin-left: 10%;
        }

        .margin_main_line2 {
            margin-left: 20%;
        }

        .margin_main_line_1 {
            margin-left: 35%;
        }
    </style>
</head>
<body>
<%--<iframe name="ajslcommonframe" id="ajslcommonframe" src="" width="100%" height="350px;" scrolling="no"
        frameborder="0"></iframe>--%>
<form id="sysUserForm" class="layui-form" action="">

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>工作上报内容:</label>
        <div class="layui-input-block">
            <textarea style="width: 600px" id="content" name="content" class="layui-textarea" required
                      lay-verify="required"></textarea>
        </div>
    </div>



    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px"><span style="color: red;">*</span>向谁上报:</label>
        <div class="layui-input-inline">
            <input type="text" id="cyry" name="cyry"
                   autocomplete="off" class="layui-input" style="width: 300px;" readonly="readonly">
            <input id="fzr" name="fzr" type="hidden"/>
        </div>
        <div class="layui-input-inline" style="padding-left:80px">
            &nbsp;
            <a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
               iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
            &nbsp;&nbsp;
            <a href="javascript:void(0)" class="layui-btn" id="remove"
               iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
        </div>
    </div>
    <div class="layui-form-item">

        <label class="layui-form-label" style="width: 100px">上报时间:</label>

        <div class="layui-input-inline" >
            <input type="text" id="time" name="time"
                   autocomplete="off" class="layui-input">

        </div>
    </div>
    <div class="layui-form-item">

        <label class="layui-form-label" style="width: 100px">上报人:</label>

        <div class="layui-input-inline" >
            <input type="text" id="name" name="name"
                   readonly class="layui-input">
            <input type="hidden" id="userid" name="userid"
                   class="layui-input">

        </div>
    </div>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
            </button>
        </div>
    </div>





</form>
<div style="text-align: center;">
    <sicp3:groupbox title="">
        <table width="100%" height="60px;">
            <tr>
                <td width="15%" align="right">请选择下一节点流向：</td>
                <td width="88%" align="left">
                    <div id="xuanzeliuxiang">
                        <%for (Wf_node_trans v_Wf_node_trans : v_listWf_node_trans) {%>
                        <input type="radio" name="transname" <%=v_nextchecked%> id="transname"
                               value="<%=v_Wf_node_trans.getTransname() %>"
                               style="cursor: pointer;"/><%=v_Wf_node_trans.getTransname() %>&nbsp;&nbsp;&nbsp;&nbsp;
                        <%} %>
                    </div>
                </td>
            </tr>

            <tr>
                <td align="right">
                    处理意见：
                </td>
                <td align="left">
                        <%--<textarea class="easyui-validatebox" id="transyy" name="transyy" style="width: 600px;"
                                  rows="8" data-options="required:false,validType:'length[0,200]'"></textarea>--%>
                    <textarea class="layui-textarea" id="transyy" name="transyy"></textarea>
                </td>
            </tr>

        </table>

    </sicp3:groupbox>
</div>
<div style="text-align: center;height: 100px">
    <br>
    <%--<a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="tijiaoliucheng()"
       data-options="iconCls:'icon-save'">提交流程</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton" onclick="closeWindow()"
       data-options="iconCls:'icon-back'">关闭</a>--%>
    <button class="layui-btn" id="saveBtn" onclick="tijiaoliucheng()">提交流程</button>
    <button class="layui-btn" id="BtnFanhui" onclick="closeWindow()">关闭</button>

</div>



</body>
</html>



