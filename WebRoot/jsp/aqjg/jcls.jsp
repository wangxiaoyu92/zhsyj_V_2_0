<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.askj.zfba.service.AjdjService" %>
<%@ page import="com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String planid = StringHelper.showNull2Empty(request.getParameter("planid"));
    String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
    String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
    String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));
    String aaz093 = StringHelper.showNull2Empty(request.getParameter("aaz093"));
    String v_qtbwid = StringHelper.showNull2Empty(request.getParameter("qtbwid"));
    String v_checkdatakind = StringHelper.showNull2Empty(request.getParameter("checkdatakind"));
    String v_mark = StringHelper.showNull2Empty(request.getParameter("mark"));

    AjdjService v_AjdjService = new AjdjService();
    Wf_node v_wf_node = v_AjdjService.getStartNodeFromYwpym("zfbalc");
    String v_psbh = "";
    String v_nodeid = "";
    String v_nodename = "";
    if (v_wf_node != null) {
        v_psbh = v_wf_node.getPsbh();
        System.out.println(v_wf_node.getNodeid().toString());
        v_nodeid = v_wf_node.getNodeid().toString();
        v_nodename = v_wf_node.getNodename();
    }
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>安全检查</title>
    <script language="javascript" src="<%=basePath %>lodop/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop"
               width=0 height=0 pluginspage="<%=basePath %>lodop/install_lodop32.exe"></embed>
    </object>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var grid;
        var LODOP; //声明为全局变量
        $(function () {
            var planid = $("#planid").val();
            var comid = $("#comid").val();
            var v_qtbwid = $("#qtbwid").val();
            grid = $("#grid").datagrid({
                // title:'采集信息查询',
                url: basePath + '/common/sjb/getoldPlanList?planid=' + planid + '&comid=' + comid + '&qtbwid=' + v_qtbwid,
                iconCls: 'icon-ok',
                height: 450,
                pageSize: 10,
                pageList: [10, 20, 30],
                nowrap: true,//True 就会把数据显示在一行里
                striped: true,//奇偶行使用不同背景色
                collapsible: true,
                singleSelect: true,//True 就会只允许选中一行
                fit: false,//让DATAGRID自适应其父容器
                fitColumns: false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
                pagination: true,//底部显示分页栏
                rownumbers: true,//是否显示行号
                loadMsg: '数据加载中,请稍后...',
                columns: [[
                    {
                        title: '计划标题',
                        field: 'plantitle',
                        align: 'left',
                        width: 340
                    }, {
                        title: '结果id',
                        field: 'resultid',
                        align: 'left',
                        width: 100,
                        hidden: true
                    }, {
                        title: '经办日期',
                        field: 'operatedate',
                        align: 'left',
                        width: 150,
                        hidden: false
                    }, {
                        title: '结果检查日期',
                        field: 'resultdate',
                        align: 'left',
                        width: 150,
                        hidden: false
                    }, {
                        title: '备注',
                        field: 'resultremark',
                        align: 'left',
                        width: 80,
                        hidden: false
                    }, {
                        title: '结果完成状态',
                        field: 'resultstate',
                        align: 'left',
                        width: 100,
                        formatter: function (value, rec) {
                            var str;
                            if (value == '4') {
                                str = '<a href="javascript:getResultHtmlByresultId(\'' + rec.resultid
                                + '\')" mce_href="#">已完成请打印</a> ';
                            } else {
                                $("#toolbar").find('td').eq(0).css("display", "none");
                                str = '<a href="javascript:myselectcom(\'' + rec.resultid
                                + '\')" mce_href="#">未完成请继续检查</a> ';
                            }
                            return str;//
                        }
                    }
                ]]
            });
        });
        //添加新的检查项
        var checkterm = function () {
            $.post(basePath + '/common/sjb/queryCheckMasterId', {//  getoldPlanList
                        comid: $('#comid').val(),
                        planid: $('#planid').val(),
                        qtbwid: $('#qtbwid').val(),
                        checkdatakind: $('#checkdatakind').val()
                    },
                    function (result) {
                        if (result.code == "0000") {
                            var resultid = result.resultid;
                            myselectcom(resultid);
                        }
                    }, 'json');
        };
        //文书管理
        function wenshu() {
            var row = $('#grid').datagrid('getSelected');
            if (row) {
                var url = basePath + "/pub/wsgldy/pubWsglIndex";
                var v_ajdjid = row.resultid;
                parent.sy.modalDialog({
                    title: '文书管理'
                    , area: ['100%', '100%']
                    , content: url
                    , param: {
                        ajdjid: v_ajdjid,
                        comid: '<%=comid%>',
                        operatetype: 'mobilecheck',
                        psbh: '<%=v_psbh%>',
                        nodeid: '<%=v_nodeid%>',
                        nodename: encodeURI(encodeURI('<%=v_nodename%>'))
                    }
                    , btn: ['关闭']
                });
            } else {
                $.messager.alert('提示', '请先选择要填写文书的计划！', 'info');
            }
        }
        //打开检查项页面
        function myselectcom(resultid) {
            var url = "<%=basePath%>jsp/aqjg/jcx.jsp";
            if ('<%=v_mark%>' === "qyjc") {
                parent.sy.modalDialog({
                    title: '附件管理'
                    , param: {
                        resultid: resultid,
                        comid: $('#comid').val(),
                        aaa027: $('#aaa027').val(),
                        comdalei: $('#comdalei').val(),
                        aaz093: $('#aaz093').val(),
                        planid: $('#planid').val(),
                        qtbwid: $('#qtbwid').val(),
                        checkdatakind: $('#checkdatakind').val(),
                        mark: 'qyjc',
                        a: new Date().getMilliseconds()
                    }
                    , area: ['100%', '100%']
                    , content: url
                    , btn: ['保存', '关闭']
                    , btn1: function (index, layero) {
                        parent.window[layero.find('iframe')[0]['name']].queding();
                    }
                }, function (dialogID) {
                    var obj = sy.getWinRet(dialogID);
                    sy.removeWinRet(dialogID);//不可缺少
                    if (obj.type == 'ok') {
                        $("#grid").datagrid("reload");
                    }
                });
            } else {
                //创建模态窗口
                var dialog = parent.sy.modalDialog({
                    title: '附件管理',
                    param: {
                        resultid: resultid,
                        comid: $('#comid').val(),
                        aaa027: $('#aaa027').val(),
                        comdalei: $('#comdalei').val(),
                        aaz093: $('#aaz093').val(),
                        planid: $('#planid').val(),
                        qtbwid: $('#qtbwid').val(),
                        checkdatakind: $('#checkdatakind').val(),
                        a: new Date().getMilliseconds()
                    },
                    width: 820,
                    height: 600,
                    url: url
                }, function (dialogID) {
                    var obj = sy.getWinRet(dialogID);
                    sy.removeWinRet(dialogID);//不可缺少
                    if (obj.type == 'ok') {
                        $("#grid").datagrid("reload");
                    }
                });
            }

        }
        // 打印检查结果
        function getResultHtmlByresultId(resultid) {
            var url = basePath + '/common/sjb/getResultHtmlByresultId?'
                    + 'resultid=' + resultid
                    + '&comid=' + $('#comid').val()
                    + '&planid=' + $('#planid').val();
            if ('<%=v_mark%>' === "qyjc") {
                parent.sy.modalDialog({
                    title: '检查结果',
                    area: ['100%', '100%'],
                    content: url,
                    btn: ['打印', '关闭'],
                    btn1: function () {
                        var strID = url;
                        print(strID);
                    }
                });
            } else {
                var dialog = parent.sy.modalDialog({
                    title: '检查结果',
                    width: 820,
                    height: 570,
                    url: url,
                    buttons: [{
                        text: '打印',
                        handler: function () {
                            var strID = url;
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
        function print(strID) {
            LODOP = getLodop();
            LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_按网址打印");
            LODOP.ADD_PRINT_URL(30, 20, 746, "95%", strID);
            LODOP.SET_PRINT_STYLEA(0, "HOrient", 3);
            LODOP.SET_PRINT_STYLEA(0, "VOrient", 3);
            LODOP.SET_SHOW_MODE("MESSAGE_GETING_URL", ""); //该语句隐藏进度条或修改提示信息
            LODOP.SET_SHOW_MODE("MESSAGE_PARSING_URL", "");//该语句隐藏进度条或修改提示信息
            LODOP.PREVIEW();
        }
        //跳转到检查项页面
        /* function jcxIndex(resultid){
         var dialog = parent.sy.modalDialog({
         title : '检查项',
         width : 870,
         height : 570,
         url : basePath + '/aqgl/jcxIndex?'
         +'resultid='+resultid
         +'&comid='+$('#comid').val()
         +'&aaa027='+$('#aaa027').val()
         +'&comdalei='+$('#comdalei').val()
         +'&aaz093='+$('#aaz093').val()
         +'&planid='+$('#planid').val()
         +'&qtbwid='+$('#qtbwid').val()
         +'&checkdatakind='+$('#checkdatakind').val(),
         buttons : [ {
         text : '确定',
         handler : function() {
         dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
         }
         },{
         text : '取消',
         handler : function() {
         dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
         }
         } ]
         });
         } */
        //关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            $dialog.dialog('destroy');
        };
    </script>
</head>
<body>
<form id="fm" name="fm" method="post">
    <input type="hidden" name="comid" id="comid" value="<%=comid %>"/>
    <input type="hidden" name="planid" id="planid" value="<%=planid %>"/>
    <input type="hidden" name="resultid" id="resultid"/>
    <input type="hidden" name="comdalei" id="comdalei" value="<%=comdalei %>"/>
    <input type="hidden" name="aaa027" id="aaa027" value="<%=aaa027 %>"/>
    <input type="hidden" name="aaz093" id="aaz093" value="<%=aaz093 %>"/>
    <input type="hidden" name="qtbwid" id="qtbwid" value="<%=v_qtbwid %>"/>
    <input type="hidden" name="checkdatakind" id="checkdatakind" value="<%=v_checkdatakind %>"/>
    <input type="hidden" name="detaillist" id="detaillist"/>

    <div id="toolbar">
        <sicp3:groupbox title="任务列表">
            <table>
                <tr>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton"
                           data="btn_aqrwIndex" iconCls="icon-add" plain="true"
                           onclick=" checkterm()">添加检查</a></td>
                    <td>
                        <div class="datagrid-btn-separator"></div>
                    </td>
                    <%if("qyjc".equals(v_mark)){%>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton"
                           data="btn_aqrwIndex" plain="true" onclick=" wenshu()">
                        <img src="<%=basePath%>images/pub/icon-modify.png" align="absmiddle">文书</a></td>
                    <td>
                        <div class="datagrid-btn-separator"></div>
                    </td>
                    <%}%>
                </tr>
            </table>
        </sicp3:groupbox>
    </div>
    <div id="grid" style="height:540px;overflow:auto;margin: 20px"></div>
</form>
</body>
</html>
