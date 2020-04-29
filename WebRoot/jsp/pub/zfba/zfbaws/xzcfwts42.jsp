<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfwts42DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Zfwsxzcfwts42DTO dto = new Zfwsxzcfwts42DTO();
    if (request.getAttribute("mybean") != null) {
        dto = (Zfwsxzcfwts42DTO) request.getAttribute("mybean");
    }
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String v_ajzfwsid = StringHelper.showNull2Empty(request.getParameter("ajzfwsid"));
    String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
%>
<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
        .b1 {
            white-space-collapsing: preserve;
        }

        .b2 {
            margin: 1.0in 1.25in 1.0in 1.25in;
        }

        .s1 {
            font-weight: bold;
        }

        .s2 {
            color: black;
        }

        .s3 {
            font-family: 仿宋_GB2312;
        }

        .p1 {
            text-align: center;
            hyphenate: auto;
            font-family: 宋体;
            font-size: 22pt;
        }

        .p2 {
            margin-top: 0.108333334in;
            text-align: end;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p3 {
            text-indent: 0.29166666in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p4 {
            text-indent: 0.44791666in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p5 {
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p6 {
            text-align: justify;
            hyphenate: auto;
            font-family: 宋体;
            font-size: 10pt;
        }

        .p7 {
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p8 {
            text-indent: 0.06944445in;
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p9 {
            text-align: justify;
            hyphenate: auto;
            font-family: Times New Roman;
            font-size: 10pt;
        }

    </style>
    <title>行政处罚委托书</title>
    <meta content="X" name="author">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);
        var mygrid;
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            var v_xzcfwtsid = $("#xzcfwtsid").val();
            if (v_xzcfwtsid == null || v_xzcfwtsid == "" || v_xzcfwtsid.length == 0) {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }
        });
        //保存

        function mysave() {
            var url = basePath + 'pub/wsgldy/saveZfwsxzcfwts';
            //下面的例子演示了如何提交一个有效并且避免重复提交的表单
            parent.$.messager.progress({
                text: '正在提交....'
            }); // 显示进度条

            $('#myform').form(
                'submit',
                {
                    url: url,
                    onSubmit: function () {
                        var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                        if (!isValid) {
                            parent.$.messager.progress('close'); // 如果表单是无效的则隐藏进度条
                        }
                        return isValid;
                    },
                    success: function (result) {
                        parent.$.messager.progress('close');// 隐藏进度条
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            $("#xzcfwtsid").val(result.xzcfwtsid);
                            $("#saveBtn").linkbutton('disable');
                            $("#lcwmbBtn").linkbutton('enable');
                            $("#printBtn").linkbutton('enable');
                            alert("保存成功！");
                        } else {
                            parent.$.messager.alert('提示', '保存失败：' + result.msg,
                                'error');
                        }
                    }
                });
        }
        //打印
        function myprint() {
            var obj = new Object();
            var v_zfwslydjid = $("#ajdjid").val();
            var v_xzcfwtsid = $("#xzcfwtsid").val();

            var url = "<%=basePath%>pub/wsgldy/zfwsxzcfwtsPrintIndex?ajdjid="
                + v_zfwslydjid + "&zfwsqtbid=" + v_xzcfwtsid + "&time=" + new Date().getMilliseconds();
            //创建模态窗口
            parent.sy.modalDialog({
                title: '打印'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            });
        }

        //保存模板
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_xzcfwtsid = $("#xzcfwtsid").val();
            if (v_ajdjid == null || v_ajdjid == "" || v_ajdjid.length == 0) {
                alert('案件登记id为空，不能另存为模板');
                return false;
            }
            if (v_xzcfwtsid == null || v_xzcfwtsid == "" || v_xzcfwtsid.length == 0) {
                alert('请先保存，保存成功后，才能另存为模板');
                return false;
            }
            var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
                + v_ajdjid + "&zfwsdmz=" + v_zfwsdmz + "&time=" + new Date().getMilliseconds();
            //创建模态窗口
            parent.sy.modalDialog({
                title: '另存模板'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['保存为模板文书', '关闭']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            });
        }

        //提取模板
        function tqMoban() {
            var obj = new Object();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
                + v_zfwsdmz + "&zfwsdmmc=<%=v_fjcsdmmc%>&time=" + new Date().getMilliseconds()));
            //创建模态窗口
            parent.sy.modalDialog({
                title: '提取模板'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.type) {
                    var myrow = v_retStr.data;
                    parent.$.messager.progress({
                        text: '数据加载中....'
                    });
                    var v_zfwsmbid = myrow.zfwsmbid;
                    var v_zfwsqtbid = myrow.zfwsqtbid;
                    $.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time=' + new Date().getMilliseconds(), {
                            zfwsmbid: v_zfwsmbid,
                            zfwsqtbid: v_zfwsqtbid,
                            xzcfwtsid: $("#xzcfwtsid").val(),
                            ajdjid: $("#ajdjid").val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var retdata = result.data;
                                //var kk=$.parseJSON(retdata);
                                //$('form').form('load',retdata);
                                GloballoadData(retdata);
                            } else {
                                parent.$.messager.alert('提示', '查询模板信息失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
                }
            })
        }

        // 关闭并刷新父窗口
        function closeAndRefreshWindow() {
            var s = new Object();
            s.type = "ok";
            sy.setWinRet(s);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
    <form id="myform" method="post">
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        <input id="ajzfwsid" name="ajzfwsid" type="hidden" value="<%=v_ajzfwsid%>"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>"/>
        <input id="xzcfwtsid" name="xzcfwtsid" type="hidden"
               value="${mybean.xzcfwtsid}"/>
        <p class="p1">
            <span class="s1">行政处罚委托书</span>
        </p>
        <div align="right">
            <p class="p2">
				<span><input id="zfwsbh" name="zfwsbh"
                             style="width:200px;" value="${mybean.zfwsbh}"/></span>
            </p>
        </div>
        <hr style="height:2px;border:none;border-top:2px solid #555555;">
        <p class="p3">
            <span>委托机关：</span>
            <span class="s2"><input id="wtjg" name="wtjg"
                                    style="width:200px;" value="${mybean.wtjg}"/></span>
        </p>
        <p class="p3">
            <span>法定代表人：</span>
            <span class="s2"><input id="wtjgfrdb" name="wtjgfrdb"
                                    style="width:150px;" value="${mybean.wtjgfrdb}"/></span>
            <span>职务：</span>
            <span class="s2"><input id="wtjgfrdbzw" name="wtjgfrdbzw"
                                    style="width:150px;" value="${mybean.wtjgfrdbzw}"/></span>
            <span>单位地址：</span>
            <span class="s2"><input id="wtjgfrdbdwdz" name="wtjgfrdbdwdz"
                                    style="width:250px;" value="${mybean.wtjgfrdbdwdz}"/></span>
        </p>
        <p class="p3">
            <span>受委托机关：</span>
            <span class="s2"><input id="swtjg" name="swtjg"
                                    style="width:200px;" value="${mybean.swtjg}"/></span>
        </p>
        <p class="p3">
            <span>法定代表人：</span>
            <span class="s2"><input id="swtjgfrdb" name="swtjgfrdb"
                                    style="width:150px;" value="${mybean.swtjgfrdb}"/></span>
            <span>职务：</span>
            <span class="s2"><input id="swtjgfrdbzw" name="swtjgfrdbzw"
                                    style="width:150px;" value="${mybean.swtjgfrdbzw}"/></span>
            <span>单位地址：</span>
            <span class="s2"><input id="swtjgfrdbdwdz" name="swtjgfrdbdwdz"
                                    style="width:250px;" value="${mybean.swtjgfrdbdwdz}"/></span>
        </p>
        <p class="p3">
            <span>根据</span>
            <span class="s2"><input id="gjflfggd" name="gjflfggd"
                                    style="width:300px;" value="${mybean.gjflfggd}"/></span>
            <span>（法律法规依据名称及条、款、项具体内容）的规定，经</span>
            <span class="s2"><input id="jjmc" name="jjmc"
                                    style="width:100px;" value="${mybean.jjmc}"/></span>
            <span>局与</span>
            <span class="s2"><input id="jdwmc" name="jdwmc"
                                    style="width:120px;" value="${mybean.jdwmc}"/></span>
            <span>(单位)研究，现由</span>
            <span class="s2"><input id="yjmc" name="yjmc"
                                    style="width:120px;" value="${mybean.yjmc}"/></span>
            <span>局委托</span>
            <span class="s2"><input id="wtdwmc" name="wtdwmc"
                                    style="width:120px;" value="${mybean.wtdwmc}"/></span>
            <span>(单位)实施：</span>
            <span class="s2"><textarea id="cfsxssfw" name="cfsxssfw"
                                       style="width: 770px;height:100px;">${mybean.cfsxssfw}</textarea></span>
            <span>（处罚事项和实施范围）。委托期限自</span>
            <span class="s2"><input name="wtksrq" id="wtksrq" class="Wdate" style="width: 150px;"
                                    onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    value="${mybean.wtksrq}"/></span>
            <span class="s2">&times;</span>
            <span>年</span>
            <span class="s2">&times;</span>
            <span>月</span>
            <span class="s2">&times;</span>
            <span>日至</span>
            <span class="s2"><input name="wtjsrq" id="wtjsrq" class="Wdate" style="width: 150px;"
                                    onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    value="${mybean.wtjsrq}"/></span>
            <span class="s2">&times;</span>
            <span>年</span>
            <span class="s2">&times;</span>
            <span>月</span>
            <span class="s2">&times;</span>
            <span>日止。</span>
        </p>
        <p class="p3">
			<span>委托期间，<input id="wtqjdwmc" name="wtqjdwmc"
                              style="width:100px;" value="${mybean.wtqjdwmc}"/>
			(单位)必须以<input id="wtqjyjmc" name="wtqjyjmc"
                          style="width:100px;" value="${mybean.wtqjyjmc}"/>
			局的名义，在委托范围内实施行政处罚，并接受
			<input id="jsjjdmc" name="jsjjdmc"
                   style="width:100px;" value="${mybean.jsjjdmc}"/>
			局的监督；由此产生的法律后果，由
			<input id="yjcdmc" name="yjcdmc"
                   style="width:100px;" value="${mybean.yjcdmc}"/>
			局承担。<input id="wtdw" name="wtdw"
                       style="width:100px;" value="${mybean.wtdw}"/>
			(单位)不得将委托事项再委托。</span>
        </p>
        <p class="p4">
			<span>法定代表人签字：<input id="wtjgdbrqz" name="wtjgdbrqz"
                                 style="width:100px;" value="${mybean.wtjgdbrqz}"/>
				法定代表人签字：<input id="swtjgdbrqz" name="swtjgdbrqz"
                               style="width:100px;" value="${mybean.swtjgdbrqz}"/></span>
        </p>
        <p class="p4">
			<span>委托机关（印章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			受委托单位（印章）</span>
        </p>
        <p class="p6">
            <input name="wtjgdbrqzrq" id="wtjgdbrqzrq" class="Wdate" style="width: 150px;"
                   onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${mybean.wtjgdbrqzrq}"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input name="swtjgdbrqzrq" id="swtjgdbrqzrq" class="Wdate" style="width: 150px;"
                   onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})" value="${mybean.swtjgdbrqzrq}"/>
        </p>
        <p class="p8">
            <span class="s2">注：正文3号仿宋体字，存档（1）。</span>
        </p>

        <hr style="height:2px;border:none;border-top:2px solid #555555;">
        <div id="btn">
            <table>
                <tr align="right" style="height: 60px;">
                    <td colspan=4 align="right">
                        <% if (v_canbaocun == null || "".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);" id="saveBtn" class="easyui-linkbutton" onclick="mysave()"
                           data-options="iconCls:'icon-save'">保存</a>
                        <%} %>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);" id="printBtn" class="easyui-linkbutton" onclick="myprint();"
                           data-options="iconCls:'icon-print'">打印</a>


                        <% if (v_canbaocun == null || "".equals(v_canbaocun) || "1".equals(v_canbaocun)) {%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);" id="lcwmbBtn" class="easyui-linkbutton" onclick="saveAsMoban();"
                           data-options="iconCls:'ext-icon-book_add'">另存为模块</a>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);" id="lcwBtn" class="easyui-linkbutton" onclick="tqMoban();"
                           data-options="iconCls:'ext-icon-book_go'">从模板提取</a>
                        <%}%>

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton"
                           onclick="closeAndRefreshWindow();"
                           data-options="iconCls:'icon-back'">关闭</a>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    </body>
</div>
</html>
