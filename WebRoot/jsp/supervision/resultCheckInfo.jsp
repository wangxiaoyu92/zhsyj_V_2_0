<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String v_resultid = StringHelper.showNull2Empty(request.getParameter("resultid"));  //计划id
    String v_resultstate = StringHelper.showNull2Empty(request.getParameter("resultstate"));  //计划id
%>
<!DOCTYPE html>
<html>
<head>
    <title>修改计划结果信息</title>
    <jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
    <script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
    <script type="text/javascript">
        var contentImpt =
        <%=SysmanageUtil.getAa10toJsonArray("CONTENTIMPT")%>
        var editor;
        $(function () {
            $.post(basePath + '/supervision/checkresult/resultMaster', {
                        resultid: $('#resultid').val()
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            if (mydata.checkresultinfo == null) {
                                var str = "<p style='text-align: center;'><span style='font-size:16px'><span style='color:#FF0000'>"
                                        + "<strong>还没有生成检查结果</strong></span></span></p>";
                                mydata.checkresultinfo = str;

                            }
                            $('form').form('load', mydata);
                            //加载ckeditor
                            editor = CKEDITOR.replace('checkresultinfo', {
                                extraPlugins: 'colordialog,table'
                            });
                            //设置只读
                            CKEDITOR.on('instanceReady', function (ev) {
                                editor = ev.editor;
                                editor.setReadOnly(true);
                            });
                        } else {
                          layer.msg('查询失败：' + result.msg);
                        }
                    }, 'json');

        });


        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            $dialog.dialog('destroy');
        };

        function InsertHTML() {
            // Get the editor instance that we want to interact with.
            var editor = CKEDITOR.instances.editor;
            var value = document.getElementById('htmlArea').value;

            // Check the active editing mode.
            if (editor.mode == 'wysiwyg') {
                // Insert HTML code.
                // http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-insertHtml
                editor.insertHtml(value);
            }
            else
                alert('You must be in WYSIWYG mode!');
        }
        function ExecuteCommand(commandName) {
            // Get the editor instance that we want to interact with.
            var editor = CKEDITOR.instances.editor1;

            // Check the active editing mode.
            if (editor.mode == 'wysiwyg') {
                // Execute the command.
                // http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-execCommand
                editor.execCommand(commandName);
            }
            else
                alert('You must be in WYSIWYG mode!');
        }
        //只读
        function toggleReadOnly() {
            // Change the read-only state of the editor.
            // http://docs.ckeditor.com/#!/api/CKEDITOR.editor-method-setReadOnly
            editor.setReadOnly();
        }

    </script>


</head>

<body>
<form id="fm" method="post">
    <div style="width: 99%;">
        <input type="hidden" name="resultid" id="resultid" value="<%=v_resultid%>">
        <input type="hidden" name="resultstate" id="resultstate" value="<%=v_resultstate%>">

        <div class="grid-width-100">
            <textarea name="checkresultinfo" id="checkresultinfo" style="width: 80%;height: 50%"></textarea>

        </div>
    </div>
</form>


</body>
</html>