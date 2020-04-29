<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String planid = StringHelper.showNull2Empty(request.getParameter("planid"));
    String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
    String comdalei = StringHelper.showNull2Empty(request.getParameter("comdalei"));
    String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));
    String aaz093 = StringHelper.showNull2Empty(request.getParameter("aaz093"));
    String resultid = StringHelper.showNull2Empty(request.getParameter("resultid"));
    String v_qtbwid = StringHelper.showNull2Empty(request.getParameter("qtbwid"));
    String v_checkdatakind = StringHelper.showNull2Empty(request.getParameter("checkdatakind"));
    String v_mark = StringHelper.showNull2Empty(request.getParameter("mark"));
%>

<!DOCTYPE HTML>
<html>
<head>
    <base target="_self">
    <style type="text/css">
        #hid {
            visibility: hidden;
        }

        #red {
            color: red;
        }

        #green {
            color: #00FF00;
        }

        #blue {
            color: #98FB98;
        }

        #tp {
            background-color: #87CEFA;
        }
    </style>
    <title>安全检查</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var obj = new Object();
        obj.type = "ok";   //设为空不刷新父页面
        sy.setWinRet(obj);
        var grid;
        $(function () {
            //获取resultid
            // 	loadOldPlanList();
            //加载检查项
            loadCheckItem();
            //点击不合格出现不合格原因呢
            $('#grid').datagrid({
                onClickRow: function (index, data) {
                    var row = $('#grid').datagrid('getSelected');
                    var radioValue = $('input[name=' + row.contentid + ']:checked').val();
                    data.detaildecide = radioValue;
                }
            });

        });
        //获取resultid
        /* 	var loadOldPlanList = function (){
         var data = {
         planid : $('#planid').val(),
         comid : $('#comid').val()
         };
         $.post(basePath + '/common/sjb/getoldPlanList',data,
         function (result){
         if(result.code=='0'){
         $("#resultid").val(result.rows[0].resultid);
         }
         },'json');
         }   */

        function updateResultByid() {
            var params =
            {
                resultid: $('#resultid').val(),
                comdalei: $('#comdalei').val(),
                aaa027: $('#aaa027').val(),
                planid: $('#planid').val(),
                aaa383: '3',
                resultstate: '3'
            };
            $.post(basePath + '/aqgl/updateResultByid', params,
                    function (result) {
                        if (result.code == '0') {
                            openjcjg(); //打开检查结果页
                        }
                    }, 'json');
        }
        //打开检查结果页
        function openjcjg() {
            var v_url = "<%=basePath%>jsp/aqjg/jcjg.jsp?"
                    + "resultid=" + $('#resultid').val()
                    + "&comid=" + $('#comid').val()
                    + "&aaa027=" + $('#aaa027').val()
                    + "&planid=" + $('#planid').val()
                    + "&mark=<%=v_mark%>";
            $("#fm").attr("action", v_url);
            $("#fm").submit();
        }

        function loadCheckItem() {
            var str;
            var planid = $('#planid').val();
            var comid = $('#comid').val();
            var resultid = $('#resultid').val();
            var itemid = $('#comdalei').val();
            var columns = [
                {title: '内容id', field: 'contentid', align: 'left', width: 100, hidden: true},
                {title: '项目id', field: 'itemid', align: 'left', width: 100, hidden: true},
                {title: '项目序号', field: 'itemsortid', align: 'left', width: 100, hidden: true},
                {title: '内容评分值', field: 'contentscore', align: 'left', width: 100, hidden: true},
                {title: '内容编号', field: 'contentcode', align: 'left', width: 100, hidden: true},
                {title: '详细分值', field: 'detailscore', align: 'left', width: 100, hidden: true},
                {
                    title: '评分决定', field: 'detaildecide', align: 'left', width: 100, hidden: true,
                    formatter: function (value, rec) {
                        if (value == "") {
                            return rec.detaildecide = 1;
                        } else {
                            return rec.detaildecide = value;
                        }
                    }
                },
                {
                    title: '项目名称', field: 'itemname', align: 'left', width: 60,
                    formatter: function (value, rec) {
                        return "检查项目:<br/>检查内容:<br/>"
                                + "<span id='tp'><input id='hid'/></span>";
                    }
                },
                {
                    title: '检查内容', field: 'content', align: 'left', width: 700,
                    formatter: function (value, rec) {
                        str = "<div>" + rec.itemname + "<br/>" + rec.contentcode + "." + value + "<br/>";
                        if (rec.detaildecide == 2) {
                            str += "<span id='tp'><input type='radio' name='" + rec.contentid + "' value='1'/><span id='green'> 合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='2' checked/><span id='red'> 不合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='3'/><span id='blue'> 合理缺项 </span> ";
                        } else if (rec.detaildecide == 3) {
                            str += "<span id='tp'><input type='radio' name='" + rec.contentid + "' value='1'/><span id='green'> 合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='2'/><span id='red'> 不合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='3' checked/><span id='blue'> 合理缺项 </span> ";
                        } else {
                            str += "<span id='tp'><input type='radio' name='" + rec.contentid + "' value='1' checked/><span id='green'> 合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='2'/><span id='red'> 不合格 </span> "
                            + "<input type='radio' name='" + rec.contentid + "' value='3'/><span id='blue'> 合理缺项 </span> ";
                            rec.detailscore = rec.contentscore;
                        }
                        str += " &nbsp;&nbsp;&nbsp;<span id='hid'>不合格理由<input type='text'/></span></span></div>";
                        return str;
                    }
                }];
            grid = $('#grid').datagrid(
                    {
                        url: basePath
                        + '/common/sjb/getPlansByqyTypeAndid?comid='
                        + comid + '&planid='
                        + planid + '&resultid='
                        + resultid + '&item='
                        + itemid,
                        iconCls: 'icon-ok',
                        height: 560,
                        nowrap: true,//True 就会把数据显示在一行里
                        striped: true,//奇偶行使用不同背景色
                        collapsible: true,
                        singleSelect: true,//True 就会只允许选中一行
                        fit: false,//让DATAGRID自适应其父容器
                        fitColumns: false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
                        pagination: false,//底部显示分页栏
                        rownumbers: true,//是否显示行号
                        loadMsg: '数据加载中,请稍后...',
                        columns: [columns]
                    });
        }

        //提交保存
        function queding() {
//						parent.$.messager.progress({
//							text : '正在提交....'
//						}); // 显示进度条
            var rows = grid.datagrid("getRows");
            $('#detaillist').val($.toJSON(rows));
            $('#fm').form('submit', {
                url: basePath + '/aqgl/bathSaveCheckDetail',
                success: function (result) {
//								parent.$.messager.progress('close');// 隐藏进度条
                    result = $.parseJSON(result);
                    if (result.code == '0000') {
                        //加载检查页
                        updateResultByid();

                    } else {
                        alert("保存失败：" + result.msg);
                    }
                }
            });
        }
        //关闭窗口
        function closeWindow() {
            parent.$("#" + sy.getDialogId()).dialog("close");
        }
    </script>
</head>
<body>
<form id="fm" name="fm" method="post">
    <input type="hidden" name="comid" id="comid" value="<%=comid %>"/>
    <input type="hidden" name="planid" id="planid" value="<%=planid %>"/>
    <input type="hidden" name="resultid" id="resultid" value="<%=resultid %>"/>
    <input type="hidden" name="comdalei" id="comdalei" value="<%=comdalei %>"/>
    <input type="hidden" name="aaa027" id="aaa027" value="<%=aaa027 %>"/>
    <input type="hidden" name="aaz093" id="aaz093" value="<%=aaz093 %>"/>
    <input type="hidden" name="qtbwid" id="qtbwid" value="<%=v_qtbwid %>"/>
    <input type="hidden" name="checkdatakind" id="checkdatakind" value="<%=v_checkdatakind %>"/>
    <input type="hidden" name="detaillist" id="detaillist"/>
</form>
<sicp3:groupbox title="检查结果信息">
    <div id="grid" style="height:540px;overflow:auto;margin: 20px"></div>
</sicp3:groupbox>
<% if (!"qyjc".equals(v_mark)) {%>
<div style="text-align:right; margin-top: 5px">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="queding();">确定</a>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeWindow();">取消 </a>
</div>
<%}%>
</body>
</html>
