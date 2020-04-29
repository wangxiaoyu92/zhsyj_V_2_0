<%@ taglib prefix="sicp3" uri="http://xart.bjlbs.com.cn/tags/tags-xart" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String resultid = StringHelper.showNull2Empty(request.getParameter("resultid"));
    String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
    String planid = StringHelper.showNull2Empty(request.getParameter("planid"));
    String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));
    String v_mark = StringHelper.showNull2Empty(request.getParameter("mark"));
%>
<!DOCTYPE HTML>
<html>
<head>
    <style type="text/css">
        #hid {
            visibility: hidden;
        }
    </style>
    <title>检查结果</title>
    <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0
               pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
    </object>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "ok";   //设为空不刷新父页面
        sy.setWinRet(s);
        var grid;
        $(function () {
            $.post(basePath + '/common/sjb/getResultinfo', {//  getoldPlanList
                        resultid: $('#resultid').val()
                    },
                    function (result) {
                        if (result.code == '0') {
                            var res = result.data;
                            $("#bz").append("<h3>" + res.label1 + "</h3> <p>" +
                            res.label1_01 + "</p><p>" + res.label1_02 + "</p><p>" + res.label1_03 + "</p>" +
                            "<h3>" + res.label2 + "</h3><p>" + res.label2_01 +
                            "<h3>" + res.label3 + "</h3><input name='resultdecision' type='radio' value='101' />" +
                            res.label3_01 + "<input name='resultdecision' type='radio' value='102'/>" +
                            res.label3_02 + "<input name='resultdecision' type='radio' value='103'/>" + res.label3_03);
                        }
                    }, 'json');
        });
        function queding() {
            var resultid = $("#resultid").val();
            var comid = $("#comid").val();
            var url = basePath + "/aqgl/updateResultinfo?resultstate=" + '5';
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                    }
                    return isValid;
                },
                success: function (result) {
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        $.messager.confirm(' ', '数据已经保存您是否继续，继续将不能在修改数据?', function (r) {
                            if (r) {
                                $.post(basePath + '/aqgl/updateResultByid', {// updateResultByid
                                            resultid: $('#resultid').val(),
                                            resultstate: '4'
                                        },
                                        function (result) {
                                            if (result.code == '0') {
                                                var url = basePath + '/common/sjb/getResultHtmlByresultId?'
                                                        + 'resultid=' + resultid
                                                        + '&comid=' + $('#comid').val()
                                                        + '&planid=' + $('#planid').val();
                                                $("#url").val("");
                                                $("#url").val(url);
                                                if ('<%=v_mark%>' === 'qyjc') {
                                                    parent.sy.modalDialog({
                                                        area: ['100%', '100%'],
                                                        content: url,
                                                        btn: ['打印', '关闭'],
                                                        btn1: function () {
                                                            var strID = $("#url").val();
                                                            print(strID);
                                                        }
                                                        ,end:function(){
                                                            parent.layer.close(parent.layer.getFrameIndex(window.name));
                                                        }
                                                    });
                                                } else {
                                                    var dialog = parent.sy.modalDialogEasyui({
                                                        width: 800,
                                                        height: 580,
                                                        url: url,
                                                        buttons: [{
                                                            text: '打印',
                                                            handler: function () {
                                                                var strID = $("#url").val();
                                                                print(strID);
                                                            }
                                                        }, {
                                                            text: '取消',
                                                            handler: function () {
                                                                dialog.dialog('destroy');
                                                            }
                                                        }]
                                                    });
                                                }
                                            }
                                        }, 'json');
                            }
                        });
                    }
                }
            });
        }
        function print(strID) {
            var LODOP; //声明为全局变量
            LODOP = getLodop();
            LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_按网址打印");
            LODOP.ADD_PRINT_URL(30, 20, 746, "95%", strID);
            LODOP.SET_PRINT_STYLEA(0, "HOrient", 3);
            LODOP.SET_PRINT_STYLEA(0, "VOrient", 3);
            LODOP.SET_SHOW_MODE("MESSAGE_GETING_URL", ""); //该语句隐藏进度条或修改提示信息
            LODOP.SET_SHOW_MODE("MESSAGE_PARSING_URL", "");//该语句隐藏进度条或修改提示信息
            LODOP.PREVIEW();
        }
        //保存照片
        function uploadFjView() {
            var obj = new Object();
            var lb = 'tyaqjg';
            var dmz = 'SPJGFJ01';
            var url = "<%=basePath%>jsp/pub/pub/pubUploadFj.jsp";
            if ('<%=v_mark%>' === 'qyjc') {
                parent.sy.modalDialog({
                    title: '附件管理',
                    param: {
                        ajdjid: <%=resultid%>,
                        dmlb: lb,
                        fjcsdmz: dmz,
                        time: new Date().getMilliseconds()
                    },
                    area: ['100%', '100%'],
                    content: url,
                    btn: ['关闭']
                });
            } else {
                var dialog = parent.sy.modalDialog({
                    title: '附件管理',
                    param: {
                        ajdjid: <%=resultid%>,
                        dmlb: lb,
                        fjcsdmz: dmz,
                        time: new Date().getMilliseconds()
                    },
                    width: 950,
                    height: 700,
                    url: url,
                    //生成按钮写法一
                    buttons: [{
                        text: '关闭',
                        handler: function () {
                            dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
                        }
                    }]
                });
            }
        }

        //关闭窗口
        function clo() {
//            parent.closeWindow();
            window.open("about:blank","_self").close()
//           window.close();window.close();window.close();window.close();window.close();
//            $("#" + sy.getDialogId()).dialog("close");
        }
    </script>
</head>
<body>
<input type="hidden" name="url" id="url"/>

<form id="fm" name="fm" method="post">
    <input type="hidden" id="resultid" name="resultid" value="<%=resultid %>"/>
    <input type="hidden" id="comid" name="comid" value="<%=comid %>"/>
    <input type="hidden" id="planid" name="planid" value="<%=planid %>"/>
    <input type="hidden" name="aaa027" id="aaa027" value="<%=aaa027 %>"/>
    <sicp3:groupbox title="检查结果信息">
        <div id="grid" style="height:520px;overflow:auto;margin: 10px">
            <input id='resultng' name="resultng" class="easyui-text" style="width: 650px ;height: 60px "
                   placeholder="请输入您的核查意见"/>

            <div id='bz'></div>
            <div>
                <h3>四、添加附件：</h3>
                <input type="button" value="选择附件" onclick="uploadFjView();"/>
            </div>
            <div>
                <h3>五、经办陪同人：</h3>
                <input type="text" id="resultperson" name="resultperson" placeholder="陪同人签名"/>
            </div>
        </div>
    </sicp3:groupbox>
</form>
<% if (!"qyjc".equals(v_mark)) {%>
<div style="text-align:right; margin-top: 5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="queding();">确定</a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <%--<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clo();">取消 </a>--%>
</div>
<%}%>
</body>
</html>
