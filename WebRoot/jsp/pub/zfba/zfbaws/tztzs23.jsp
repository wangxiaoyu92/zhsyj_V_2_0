<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%@ page import="com.askj.zfba.dto.Zfwstztzs23DTO" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    //案件登记id
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //执法文书代码值
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    //附件参数代码名称
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    //是否可以保存0否1是
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
    //第23个文书   听证通知书
    Zfwstztzs23DTO dto = new Zfwstztzs23DTO();
    if (request.getAttribute("mybean") != null) {
        dto = (Zfwstztzs23DTO) request.getAttribute("mybean");
    }
%>

<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <style type="text/css">
        .b1 {
            white-space-collapsing: preserve;
        }

        .b2 {
            margin: 1.0in 1.25in 1.0in 1.25in;
        }

        .s1 {
            font-weight: bold;
            color: black;
        }

        .s2 {
            font-weight: bold;
        }

        .s3 {
            color: black;
        }

        .s4 {
            font-family: 仿宋_GB2312;
            color: black;
        }

        .s5 {
            text-decoration: underline;
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
            font-family: Times New Roman;
            font-size: 22pt;
        }

        .p3 {
            margin-top: 0.108333334in;
            text-align: end;
            hyphenate: auto;
            font-family: 仿宋;
            font-size: 10.5pt;
        }

        .p4 {
            text-indent: 0.072916664in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p5 {
            text-indent: 0.36458334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p6 {
            text-indent: -0.072916664in;
            margin-left: 0.072916664in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p7 {
            margin-right: 0.65625in;
            margin-top: 0.108333334in;
            text-align: end;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p8 {
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p9 {
            text-indent: 3.7916667in;
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p10 {
            text-indent: 0.29166666in;
            margin-left: 0.072916664in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p11 {
            text-indent: 0.2777778in;
            margin-left: 0.072916664in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p12 {
            text-indent: 0.06944445in;
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p13 {
            text-align: justify;
            hyphenate: auto;
            font-family: Times New Roman;
            font-size: 10.5pt;
        }
    </style>

    <title>食品药品行政处罚文书</title>
    <meta content="X" name="author">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            var v_tztzsid = $("#tztzsid").val();
            if (v_tztzsid == null || v_tztzsid == "" || v_tztzsid.length == 0) {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }

        });
        function mysave() {
            //下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
            parent.$.messager.progress({
                text: '正在提交....'
            });
            $('#myform').form('submit', {
                url: basePath + '/pub/wsgldy/savezfwstztzs',
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
                        $("#tztzsid").val(result.tztzsid);
                        $("#saveBtn").linkbutton('disable');
                        $("#lcwmbBtn").linkbutton('enable');
                        $("#printBtn").linkbutton('enable');
                        alert("保存成功！");
                    } else {
                        alert("保存失败：" + result.msg);
                    }
                }
            });
        }
        function myprint() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_tztzsid = $("#tztzsid").val();

            var url = "<%=basePath%>pub/wsgldy/zfwstztzsPrintIndex?ajdjid="
                + v_ajdjid + "&zfwsqtbid=" + v_tztzsid + "&time=" + new Date().getMilliseconds();


            //创建模态窗口
            parent.sy.modalDialog({
                title: ''
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            });
        }


        //另存为模板
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_tztzsid = $("#tztzsid").val();

            if (v_ajdjid == null || v_ajdjid == "" || v_ajdjid.length == 0) {
                alert('案件登记id为空，不能另存为模板');
                return false;
            }

            var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid="
                + v_ajdjid + "&zfwsdmz=" + v_zfwsdmz + "&time=" + new Date().getMilliseconds();

            //创建模态窗口
            parent.sy.modalDialog({
                title: ''
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
                title: ''
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
                    var v_zfwsqtbid = myrow.zfwsqtbid;
                    $.post('<%=basePath%>pub/wsgldy/queryZfwsmobanObj?time=' + new Date().getMilliseconds(), {
                            zfwsmbid: v_zfwsmbid,
                            zfwsqtbid: v_zfwsqtbid,
                            cssbfhyjsid: $("#cssbfhyjsid").val(),
                            ajdjid: $("#ajdjid").val()
                        },
                        function (result) {
                            if (result.code == '0') {
                                var retdata = result.data;
                                GloballoadData(retdata);
                            } else {
                                parent.$.messager.alert('提示', '查询模板信息失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
                }
            });
        }

        // 关闭并刷新父窗口
        function closeAndRefreshWindow() {
            var s = new Object();
            s.type = "ok";
            sy.setWinRet(s);
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
    <title>食品药品行政处罚文书</title>
    <meta content="X" name="author">
</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
    <form id="myform" method="post">
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        <input id="tztzsid" name="tztzsid" type="hidden" value="${mybean.tztzsid}"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
        <p class="p1">
				<span class="s1"><input id="xzjgmc" name="xzjgmc" style="width: 280px;"
                                        value="${mybean.xzjgmc}"/></span>
        </p>
        <p class="p2">
            <span class="s2">听证通知书</span>
        </p>
        <div align="right">
            <p class="p3">
					<span class="s3">  
						 <input id="tztzwsbh" name="tztzwsbh" style="width: 280px;"
                                value="${mybean.tztzwsbh}"/></span>
            </p>
        </div>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p4">
				<span class="s3"> <input id="tztzdsr" name="tztzdsr"
                                         style="width: 240px;" value="${mybean.tztzdsr}"/>：</span>
        </p>
        <p class="p5">
            <span>根据你（单位）</span>
            <span><input name="tztzsqrq" id="tztzsqrq" class="Wdate" style="width: 150px;"
                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                         value="${mybean.tztzsqrq}"/></span>
            <span>&times;年&times;月&times;日就</span>
            <span><input id="tztzsay" name="tztzsay"
                         style="width:300px;" value="${mybean.tztzsay}"/></span>
            <span>（具体案由）一案提出的听证要求，我局决定于</span>
            <span><input name="tztzjxrq" id="tztzjxrq" class="Wdate" style="width: 150px;"
                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                         value="${mybean.tztzjxrq}"/></span>
            <span>&times;年&times;月&times;日&times;时&times;分在</span>
            <span><input id="tztzdd" name="tztzdd"
                         style="width:150px;" value="${mybean.tztzdd}"/></span>
            <span>（听证地点）举行听证。本次听证由</span>
            <span><input id="tztzzcr" name="tztzzcr"
                         style="width:150px;" value="${mybean.tztzzcr}"/></span>
            <span>（单位、职务、姓名）为听证主持人，</span>
            <span><input id="tztzjly" name="tztzjly"
                         style="width:150px;" value="${mybean.tztzjly}"/></span>
            <span>为记录人。请你（单位）或者委托代理人持本通知准时参加。</span>
        </p>
        <p class="p5">
				<span>如你（单位）认为主持人与本案有直接利害关系的，有权申请回避。申请主持人回避，可在听证举行前
				（&times;年&times;月&times;日前）向我局提出申请并说明理由。因特殊原因需申请延期举行的，应当在</span>
            <span><input name="tztzsyqrq" id="tztzsyqrq" class="Wdate" style="width: 150px;" value="${mybean.tztzsyqrq}"
                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
            <span>&times;年&times;月&times;
				日前向我局提出，由我局决定是否延期。若无正当理由不按时参加听证，又不事先说明理由的，视为放弃听证权利，本机关将终止听证。</span>
        </p>
        <p class="p5">
            <span>参加听证前，请你（单位）注意下列事项：</span>
        </p>
        <p class="p5">
				<span>1.当事人可亲自参加听证，也可以委托1-2名代理人参加听证。委托代理人参加听证的，
					应在听证举行前提交由当事人或当事人的法定代表人签署的授权委托书，载明委托的事项、权限和期限。
				</span>
        </p>
        <p class="p5">
            <span>2.参加听证时应携带当事人或委托代理人的身份证明原件及其复印件和有关证据材料。</span>
        </p>
        <p class="p5">
            <span>3.当事人有证人出席作证的，应通知有关证人出席作证，并事先告知本机关联系人。</span>
        </p>
        <p class="p5">
            <span>联系人：</span>
            <span><input id="tztzlxr" name="tztzlxr"
                         style="width:200px;" value="${mybean.tztzlxr}"/></span>
            <span>联系电话：</span>
            <span><input id="tztzlxdh" name="tztzlxdh"
                         class="easyui-validatebox" validtype="phoneAndMobile"
                         style="width:200px;" value="${mybean.tztzlxdh}"/></span>
        </p>
        <p class="p5">
            <span>单位地址：</span>
            <span><input id="tztzdz" name="tztzdz"
                         style="width:200px;" value="${mybean.tztzdz}"/></span>
        </p>
        <div align="right">
            <p class="p7">
                <span class="s3">（公 章）</span>
            </p>
            <p class="p7">
					<span class="s3"> &times;年&times;月&times;日 <input
                            name="tztzgzrq" id="tztzgzrq" class="Wdate"
                            onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            style="width: 175px;" value="${mybean.tztzgzrq}"> </span>
            </p>
        </div>
        <p class="p10">
            <span>听证申请人或委托代理人：</span>
            <span><input id="tztzstzsqr" name="tztzstzsqr"
                         style="width:200px;" value="${mybean.tztzstzsqr}"/></span>
            <span>（签字或盖章）</span>
            <span><input name="tztzstzsqrrq" id="tztzstzsqrrq" class="Wdate" style="width: 150px;"
                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                         value="${mybean.tztzstzsqrrq}"/></span>
            <span>年   月   日</span>
        </p>

        <p class="p13">
            <span class="s2">注：正文3号仿宋体字，存档（1）。</span>
        </p>
        <p class="p14"></p>

        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <table>
            <tr align="right" style="height: 60px;">
                <td align="right">
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
                    <%} %>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:void(0);" id="BtnFanhui" class="easyui-linkbutton"
                       onclick="closeAndRefreshWindow();"
                       data-options="iconCls:'icon-back'">关闭</a>
                </td>
            </tr>
        </table>
    </form>
    </body>
</div>
</html>
