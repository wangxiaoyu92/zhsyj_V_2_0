<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.dto.Zfwsxzcfjds28DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    // 案件登记id
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    // 执法文书代码值
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    // 附件参数代码名称
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    // 是否可以保存0否1是
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
    // 行政处罚决定书
    Zfwsxzcfjds28DTO dto = new Zfwsxzcfjds28DTO();
    if (request.getAttribute("mybean") != null) {
        dto = (Zfwsxzcfjds28DTO) request.getAttribute("mybean");
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
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p4 {
            text-indent: 0.29166666in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p5 {
            text-indent: 0.29166666in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p6 {
            text-indent: 2.7708333in;
            text-align: justify;
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
            text-indent: 0.06944445in;
            margin-top: 0.108333334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p10 {
            text-align: justify;
            hyphenate: auto;
            font-family: Times New Roman;
            font-size: 10.5pt;
        }
    </style>

    <title>行政处罚决定书</title>
    <meta content="X" name="author">

    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var v_wfxwdc = <%=SysmanageUtil.getAa10toJsonArray("WFXWDC")%>;
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            var v_xzcfjdsid = $("#xzcfjdsid").val();
            if (v_xzcfjdsid == null || v_xzcfjdsid == "" || v_xzcfjdsid.length == 0) {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }
            v_wfxwdc = $('#wfxwdc').combobox({
                data: v_wfxwdc,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
        });
        /**
         * 保存
         */
        function mysave() {
            var url = basePath + '/pub/wsgldy/saveZfwsxzcfjds';

            parent.$.messager.progress({
                text: '正在提交....'
            });	// 显示进度条

            $('#myform').form('submit', {
                url: url,
                onSubmit: function () {
                    // 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                        parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;
                },
                success: function (result) {
                    parent.$.messager.progress('close');// 隐藏进度条
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        $("#xzcfjdsid").val(result.xzcfjdsid);
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
            var v_xzcfjdsid = $("#xzcfjdsid").val();
            var url = "<%=basePath%>pub/wsgldy/zfwsxzcfjdsPrintIndex?ajdjid="
                + v_ajdjid + "&zfwsqtbid=" + v_xzcfjdsid + "&time=" + new Date().getMilliseconds();

            //创建模态窗口
            parent.sy.modalDialog({
                title:'打印',
                 area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            });
        }
        /**
         * 另存为模板
         */
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_xzcfjdsid = $("#xzcfjdsid").val();

            if (v_ajdjid == null || v_ajdjid == "" || v_ajdjid.length == 0) {
                alert('案件登记id为空，不能另存为模板');
                return false;
            }

            if (v_xzcfjdsid == null || v_xzcfjdsid == "" || v_xzcfjdsid.length == 0) {
                alert('请先保存，保存成功后，才能另存为模板');
                return false;
            }

            var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid=" + v_ajdjid
                + "&zfwsdmz=" + v_zfwsdmz + "&time=" + new Date().getMilliseconds();
            //创建模态窗口
            parent.sy.modalDialog({
                title:'另存模板',
                area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['保存为模板文书', '关闭']
                , btn1: function (index, layero) {
                    parent.window[layero.find('iframe')[0]['name']].submitForm();
                }
            });
        }
        /**
         * 从模板提取
         */
        function tqMoban() {
            var obj = new Object();
            var v_zfwsdmz = $("#zfwsdmz").val();

            var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz="
                + v_zfwsdmz + "&zfwsdmmc=<%=v_fjcsdmmc%>&time=" + new Date().getMilliseconds()));

            //创建模态窗口
            parent.sy.modalDialog({
                title:'另模板提取',
                area: ['100%', '100%']
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
                            xzcfjdsid: $("#xzcfjdsid").val(),
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

        function myselectPcyzdsz() {

            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            parent.sy.modalDialog({
                title: '选择法律法规'
                , area: ['100%', '100%']
                , content: url,
                param: {
                    singleSelect: "true",
                    tabname: "zfwsxzcfjds28",
                    colname: "cfjdwfgd",
                    a: new Date().getMilliseconds()
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);

                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        $("#cfjdwfgd").val(myrow.avalue); //公司名称
                    }
                }
                ;
            });
        }
        function myselectPcyzdsz2() {
            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            var dialog = parent.sy.modalDialog({
                title: '选择法律法规'
                , area: ['100%', '100%']
                , content: url,
                param: {
                    singleSelect: "true",
                    tabname: "zfwsxzcfjds28",
                    colname: "cfjdwfgd",
                    a: new Date().getMilliseconds()
                }, offset: ["0px"]
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        $("#cfjdyjgd").val(myrow.avalue); //公司名称
                    }
                }
                ;
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

</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
    <form id="myform" method="post">
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
        <input id="xzcfjdsid" name="xzcfjdsid" type="hidden" value="${mybean.xzcfjdsid}"/>
        <p class="p1"><span class="s1"><input type="text" id="zxjgmc" name="zxjgmc"
                                              style="width: 260px;" value="${mybean.zxjgmc}"/></span></p>
        <p class="p2"><span class="s2">行政处罚决定书</span></p>
        <div align="right">
            <p class="p3"><span class="s3">
				<input type="text" id="cfjdwsbh" name="cfjdwsbh" style="width: 260px;"
                       value="${mybean.cfjdwsbh}"/>
				</span>
            </p>
        </div>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p5"><span>当事人：</span></p>
        <p class="p5">
            <span>（个人）姓名：</span>
            <span><input id="cfjdbcfrzrrxm" name="cfjdbcfrzrrxm"
                         style="width: 200px;" value="${mybean.cfjdbcfrzrrxm}"/></span>
            <span>公民身份（其他有效证件）号码：</span>
            <span><input id="gmsfhm" name="gmsfhm"
                         style="width: 200px;" value="${mybean.gmsfhm}"/></span>
        </p>
        <p class="p5">
            <span>（单位）名称：</span>
            <span><input id="cfjdbcfrdwmc" name="cfjdbcfrdwmc"
                         style="width: 200px;" value="${mybean.cfjdbcfrdwmc}"/></span>
            <span>法定代表人（负责人）：</span>
            <span><input id="cfjdbcfrdwfddbr" name="cfjdbcfrdwfddbr"
                         style="width: 200px;" value="${mybean.cfjdbcfrdwfddbr}"/></span>
        </p>
        <p class="p5">
            <span>住所（地址）：</span>
            <span><input id="cfjddz" name="cfjddz"
                         style="width: 500px;" value="${mybean.cfjddz}"/></span>
        </p>
        <p class="p5">
            <span>我局于</span>
            <span><input name="cfjdlarq" id="cfjdlarq" class="Wdate" style="width: 150px;"
                         onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"/></span>
            <span>&times;年&times;月&times;日对</span>
            <span><input id="cfjdajmc" name="cfjdajmc"
                         style="width: 280px;" value="${mybean.cfjdajmc}"/></span>
            <span>（案由）立案调查。经查，你（单位）</span>
            <span><input id="cfjdwfss" name="cfjdwfss"
                         style="width: 500px;" value="${mybean.cfjdwfss}"/></span>
            <span>（陈述违法事实。载明违法行为发生的时间、地点、情节等内容）。上述行为违反了</span>
            <span><input type="text" id="cfjdwfgd" name="cfjdwfgd"
                         style="width: 200px;text-align: left;" value="${mybean.cfjdwfgd}"/>
          		<input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz();"></span>
            <span>（法律法规依据名称及条、款、项具体内容）的规定。</span>
            <textarea id="syzmnr" name="syzmnr" style="width: 800px;height: 50px;"
            >${mybean.syzmnr}</textarea>
            <span>（列举证据形式，阐述证据所要证明的内容）。根据你（单位）违法行为的事实、性质、情节、社会危害程度和相关证据，参照《</span>
            <span><input id="xzcfclbz" name="xzcfclbz"
                         style="width:200px;" value="${mybean.xzcfclbz}"/></span>
            <span>法（条例、办法）行政处罚裁量标准》，你（单位）的违法行为</span>
            <span style="text-indent: 0in;"><input type="text" id="wfxwdc" name="wfxwdc"
                                                   style="width: 100px;" value="${mybean.wfxwdc}"/></span>
            <span>（轻微、一般、严重或者特别严重）。</span>
        </p>
        <p class="p5">
            <span>根据</span>
            <span><input type="text" id="cfjdyjgdtk" name="cfjdyjgdtk"
                         style="width: 200px;text-align: left;" value="${mybean.cfjdyjgdtk}"/></span>
            <span>（法律法规依据名称及条、款、项具体内容）的规定，我局决定对你（单位）作出如下行政处罚：</span>
        </p>
        <p class="p4">
			<textarea id="cfjdxzcf" name="cfjdxzcf" style="width: 800px;height: 100px;"
            >${mybean.cfjdxzcf}</textarea>
        </p>
        <p class="p4">
            <span>你（单位）应当自收到本决定书之日起15日内将罚款缴至</span>
            <span><input type="text" id="cfjdjkyh" name="cfjdjkyh"
                         style="width: 150px;text-align: left;" value="${mybean.cfjdjkyh}"/></span>
            <span>（账号：</span>
            <span><input type="text" id="yhzh" name="yhzh"
                         style="width: 150px;text-align: left;" value="${mybean.yhzh}"/></span>
            <span>）。到期不缴纳罚款的，每日按罚款数额的3%加处罚款。</span>
        </p>
        <p class="p4">
            <span>你（单位）如不服本决定，可以自收到本决定书之日起六十日内向</span>
            <span class="s4"><input type="text" id="sjrmzf" name="sjrmzf"
                                    style="width: 150px;text-align: left;" value="${mybean.sjrmzf}"/></span>
            <span>人民政府或者</span>
            <span class="s4"><input type="text" id="sjspypjdglj" name="sjspypjdglj"
                                    style="width: 150px;text-align: left;" value="${mybean.sjspypjdglj}"/></span>
            <span>申请行政复议，或者在六个月内依法直接向</span>
            <span class="s4"><input type="text" id="sjrmfy" name="sjrmfy"
                                    style="width: 150px;text-align: left;" value="${mybean.sjrmfy}"/></span>
            <span>人民法院提起行政诉讼。逾期不申请行政复议，也不提起行政诉讼，又不履行本处罚决定的，我局将依法申请人民法院强制执行。</span>
        </p>
        <div align="right">
            <p class="p7">
                <span>（公    章）</span>
            </p>
            <p class="p7">
		        <span><input name="cfjdgzrq" id="cfjdgzrq"
                             class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                             style="width: 175px;" value="${mybean.cfjdgzrq}"/>
				</span>
            </p>
        </div>
        <p class="p9">
            <span class="s3">注：存档，必要时交</span>
            <span><input type="text" id="qzzzrmfy" name="qzzzrmfy"
                         style="width: 150px;text-align: left;" value="${mybean.qzzzrmfy}"/></span>
            <span>人民法院强制执行。</span>
        </p>
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
