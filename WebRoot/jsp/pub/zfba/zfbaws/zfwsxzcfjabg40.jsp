<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjabg40DTO" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    //案件登记id
    String ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    // 执法文书编号
    String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    Zfwsxzcfjabg40DTO dto = new Zfwsxzcfjabg40DTO();
    if (request.getAttribute("mybean") != null) {
        dto = (Zfwsxzcfjabg40DTO) request.getAttribute("mybean");
    }
    // 审批分管负责人签字
    boolean v_xzcfjabg_spfgfzrqz = SysmanageUtil.isExistsFuncByBizid("xzcfjabg_spfgfzrqz");
    String v_xzcfjabg_spfgfzrqz_readonly = "";
    String v_xzcfjabg_spfgfzrqz_disable = "";
    if (!v_xzcfjabg_spfgfzrqz) {
        v_xzcfjabg_spfgfzrqz_readonly = "readonly='readonly' class='zfwstextReadonly'";
        v_xzcfjabg_spfgfzrqz_disable = "disabled='disabled'";
    }
%>


<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=GB2312">
    <style type="text/css">
        .b1 {
            white-space-collapsing: preserve;
        }

        .b2 {
            margin: 1.0in 1.2479167in 1.0in 1.2479167in;
        }

        .s1 {
            font-weight: bold;
            color: black;
        }

        .s2 {
            font-family: Times New Roman;
            font-weight: bold;
            color: black;
        }

        .s3 {
            color: black;
        }

        .p1 {
            text-align: center;
            hyphenate: auto;
            font-family: 黑体;
            font-size: 16pt;
        }

        .p2 {
            text-align: center;
            hyphenate: auto;
            font-family: 仿宋;
            font-size: 22pt;
        }

        .p3 {
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p4 {
            margin-top: 0.108333334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p5 {
            text-indent: 3.1944444in;
            margin-top: 0.108333334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p6 {
            text-indent: 3.9958334in;
            margin-top: 0.108333334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10pt;
        }

        .p7 {
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 22pt;
        }

        .p8 {
            text-align: justify;
            hyphenate: auto;
            font-family: Times New Roman;
            font-size: 10pt;
        }
    </style>
    <title>食品药品行政处罚文书</title>
    <meta content="X" name="author">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var ajdjajly =<%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>; // 案件登记案件来源
        var jafs =<%=SysmanageUtil.getAa10toJsonArray("jafs")%>; // 结案方式
        var jagddngl =<%=SysmanageUtil.getAa10toJsonArray("JAGDDAGL")%>; // 档案归类
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            ajdjajly = $('#ajdjajly').combobox({
                data: ajdjajly,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: '150'
            });
            jafs = $('#jagdjafs').combobox({
                data: jafs,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: '150'
            });
            jagddngl = $('#jagddagl').combobox({
                data: jagddngl,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: '150'
            });
            var v_xzcfjabgid = $("#xzcfjabgid").val();
            if (v_xzcfjabgid == null || v_xzcfjabgid == "" || v_xzcfjabgid.length == 0) {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }
        });
        //保存
        function mysave() {
            //下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
            parent.$.messager.progress({
                text: '正在提交....'
            });
            $('#myform').form(
                'submit',
                {
                    url: basePath + '/pub/wsgldy/saveXzcfjabg',
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
                            $("#xzcfjabgid").val(result.xzcfjabgid);
                            $("#saveBtn").linkbutton('disable');
                            $("#lcwmbBtn").linkbutton('enable');
                            $("#printBtn").linkbutton('enable');
                            alert("保存成功！");
                        } else {
                            alert('保存失败：' + result.msg);
                        }
                    }
                });
        }
        //打印
        function myprint() {
            var obj = new Object();
            var ajdjid = $("#ajdjid").val();
            var v_xzcfjabgid = $("#xzcfjabgid").val();
            var url = "<%=basePath%>pub/wsgldy/printXzcfjabgIndex?ajdjid=" + ajdjid
                + "&xzcfjabgid=" + v_xzcfjabgid + "&time=" + new Date().getMilliseconds();
            //创建模态窗口
            parent.sy.modalDialog({
                title: '打印'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            });
        }

        //保存为模板
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_xzcfjabgid = $("#xzcfjabgid").val();
            if (v_xzcfjabgid == null || v_xzcfjabgid == "" || v_xzcfjabgid.length == 0) {
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
                title: '模板提取'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.type==='ok') {
                    var myrow = v_retStr.data;
                    parent.$.messager.progress({
                        text: '数据加载中....'
                    });
                    var v_zfwsmbid = myrow.zfwsmbid;
                    $.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time=' + new Date().getMilliseconds(), {
                            zfwsmbid: v_zfwsmbid
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
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=ajdjid%>"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>"/>
        <input id="xzcfjabgid" name="xzcfjabgid" type="hidden" value="${mybean.xzcfjabgid}"/>
        <p class="p2">
            <span class="s2">行政处罚结案报告</span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p3">
				<span class="s3">案 由：<input id="ajdjay" name="ajdjay"
                                            style="width: 650px;" value="${mybean.ajdjay}"/>
				</span>
        </p>
        <p class="p3">
				<span class="s3">案件来源：<input id="ajdjajly" name="ajdjajly"
                                             style="width: 200px;" value="${mybean.ajdjajly}"/>
				</span>
        </p>
        <p class="p3">
				<span class="s3">被处罚单位（人）： <input type="text" id="jabgbcfdwr"
                                                  name="jabgbcfdwr" style="width: 220px;text-align: left;"
                                                  value="${mybean.jabgbcfdwr}"/>
					法定代表人（负责人）：<input type="text" id="jabgfddbr"
                                      name="jabgfddbr" style="width: 220px;text-align: left;"
                                      value="${mybean.jabgfddbr}"/>
				</span>
        </p>
        <p class="p3">
				<span class="s3">
				        立案日期：<input name="jabglarq" id="jabglarq" class="Wdate"
                                    onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    style="width: 270px;"
                                    value="${mybean.jabglarq}"> &times;年&times;月&times;日
					处罚日期：
					<input name="jabgcfrq" id="jabgcfrq" class="Wdate"
                           onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                           style="width: 225px;" value="${mybean.jabgcfrq}">
					&times;年&times;月&times;日
				</span>
        </p>
        <p class="p3">
				<span class="s3">处罚文书号：<input type="text" id="jabgcfwsh"
                                              name="jabgcfwsh" style="width: 260px;text-align: left;"
                                              value="${mybean.jabgcfwsh}"/>
					结案日期：
					<input name="jabgjarq" id="jabgjarq" class="Wdate"
                           onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                           style="width: 285px;" value="${mybean.jabgjarq}"> &times;年&times;月&times;日
				</span>
        </p>
        <p class="p3">
				<span class="s3">承办人： <input type="text" id="jabgcbr"
                                             name="jabgcbr" style="width: 280px;text-align: left;"
                                             value="${mybean.jabgcbr}"/>
					 填写人： <input type="text" id="jabgtxr"
                                 name="jabgtxr" style="width: 300px;text-align: left;"
                                 value="${mybean.jabgtxr}"/>
				</span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p3">
            <span class="s3">处罚种类和幅度：</span>
            <textarea id="jabgcfzlhfd" name="jabgcfzlhfd"
                      style="width: 770px;height: 200px;">${mybean.jabgcfzlhfd}</textarea>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p3">
            <span class="s3">执行结果：</span>
            <textarea id="jagdzxjg" name="jagdzxjg"
                      style="width: 770px;height: 200px;">${mybean.jagdzxjg}</textarea>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <div region="center" style="overflow: true;" border="false">
            <p class="p3">
				<span class="s3">结案方式：<input type="text" id="jagdjafs"
                                             name="jagdjafs" style="width: 130px;text-align: left;"
                                             value="${mybean.jagdjafs}"/></span>
            </p>
        </div>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p4">
				<span class="s3">归档日期： <input name="jagdrq" id="jagdrq" class="Wdate"
                                              onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                              style="width: 175px;" value="${mybean.jagdrq}">
					&times;年&times;月&times;日 
					档案归类： <input type="text" id="jagddagl" region="center"
                                 name="jagddagl" style="width: 130px; text-align: left;"
                                 value="${mybean.jagddagl}"/>
					 保存期限： <input type="text" id="jagdbcqx"
                                  name="jagdbcqx" style="width: 120px;text-align: left;"
                                  value="${mybean.jagdbcqx}"/></span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p3">
            <span class="s3">审批意见： </span>
            <textarea id="jagdspyj" name="jagdspyj"
                      style="width: 770px;height: 200px;">${mybean.jagdspyj}</textarea>
        </p>
        <p class="p6">
				<span class="s3">分管负责人：<input type="text" id="jagdfgfzrqz"
                                              name="jagdfgfzrqz" style="width: 220px;"
                                              value="${mybean.jagdfgfzrqz}" <%=v_xzcfjabg_spfgfzrqz_readonly %>/>（签字）
				</span>
        </p>
        <p class="p6">
				<span class="s3"> <input name="jagdfgfzrqzrq" id="jagdfgfzrqzrq" class="Wdate"
                                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"<%=v_xzcfjabg_spfgfzrqz_disable %>
                                         style="width: 175px;" value="${mybean.jagdfgfzrqzrq}"/>
					&times;年&times;月&times;日
				</span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
    </form>
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
                   data-options="iconCls:'ext-icon-book_add'">另存为模板</a>

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
    </body>
</div>
</html>
