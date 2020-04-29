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

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    // 案件登记id
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    // 执法文书代码值
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    // 附件参数代码名称
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    // 是否可以保存0否1是
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
    // 行政处罚决定书
    Zfwsxzcfjds28DTO localZfwsxzcfjds28DTO = new Zfwsxzcfjds28DTO();
    if (request.getAttribute("mybean") != null) {
        localZfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO) request.getAttribute("mybean");
    }
%>
<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=GB2312">
    <style type="text/css">.b1 {
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
        color: black;
    }

    .s3 {
        text-decoration: underline;
    }

    .s4 {
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
        font-family: Times New Roman;
        font-size: 22pt;
    }

    .p3 {
        margin-top: 0.108333334in;
        text-align: end;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p4 {
        text-indent: -0.072916664in;
        margin-left: 0.09791667in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p5 {
        text-indent: 0.29166666in;
        margin-right: 0.013194445in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p6 {
        text-indent: -0.055555556in;
        margin-left: 0.054166667in;
        text-align: justify;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p7 {
        text-indent: -0.055555556in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p8 {
        text-indent: 0.28611112in;
        margin-left: -0.054166667in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p9 {
        text-indent: 0.28611112in;
        margin-left: -0.007638889in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p10 {
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p11 {
        text-indent: 0.28611112in;
        text-align: justify;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p12 {
        text-indent: 0.28055555in;
        margin-left: 0.072916664in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p13 {
        text-indent: 0.28611112in;
        margin-left: 0.0027777778in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p14 {
        margin-left: 0.10763889in;
        text-align: justify;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p15 {
        text-indent: 0.28611112in;
        margin-left: 0.072916664in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p16 {
        margin-right: 0.29166666in;
        margin-top: 0.108333334in;
        text-align: end;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p17 {
        margin-top: 0.108333334in;
        text-align: end;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p18 {
        text-indent: 0.3263889in;
        margin-left: 0.072916664in;
        text-align: start;
        hyphenate: auto;
        font-family: 宋体;
        font-size: 12pt;
    }

    .p19 {
        text-align: start;
        hyphenate: auto;
        font-family: 宋体;
        font-size: 12pt;
    }

    .p20 {
        text-indent: 0.06944445in;
        margin-top: 0.108333334in;
        text-align: start;
        hyphenate: auto;
        font-family: 仿宋_GB2312;
        font-size: 10pt;
    }

    .p21 {
        text-align: justify;
        hyphenate: auto;
        font-family: Times New Roman;
        font-size: 10pt;
    }
    </style>
    <title>行政处罚决定书</title>
    <meta content="X" name="author">

    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);
        var mygrid;
        var v_cfjdbcfrzrrxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        var v_cfjdbcfrdwfddbrxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
        var v_wfxwdc = <%=SysmanageUtil.getAa10toJsonArray("WFXWDC")%>;
        var v_zzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
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
            v_cfjdbcfrzrrxb = $('#cfjdbcfrzrrxb').combobox({
                data: v_cfjdbcfrzrrxb,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
            v_cfjdbcfrdwfddbrxb = $('#cfjdbcfrdwfddbrxb').combobox({
                data: v_cfjdbcfrdwfddbrxb,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
            v_wfxwdc = $('#wfxwdc').combobox({
                data: v_wfxwdc,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
            v_zzzm = $('#cfjdbcfrdwyyzz').combobox({
                data: v_zzzm,
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
            var url = "<%=basePath%>pub/wsgldy/zfwsxzcfjdsPrintIndex?ajdjid=" + v_ajdjid + "&zfwsqtbid=" + v_xzcfjdsid + "&time=" + new Date().getMilliseconds();
            //创建模态窗口
            sy.modalDialog({
                title: '打印'
                , area: ['100%', '100%']
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
            sy.modalDialog({
                title: '模板另存'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['保存为模板文书', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
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
            sy.modalDialog({
                title: '模板提取'
                , area: ['100%', '100%']
                , content: url
                , offset: ["0px"]
                , btn: ['关闭']
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);

                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr != null && v_retStr.length > 0) {
                    var myrow = v_retStr[0];
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
            })
        }

        function myselectPcyzdsz() {
            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            var dialog = parent.sy.modalDialog({
                title: '从单位信息表中读取'
                , area: ['800px', '350px']
                , content: url,
                param: {
                    singleSelect: "true",
                    tabname: "zfwsxzcfjds28",
                    colname: "cfjdwfgd",
                    a: new Date().getMilliseconds()
                }, offset: ["5px"]
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                if (v_retStr != null) {
                    $("#cfjdwfgd").val(v_retStr.avalue); //公司名称

                }
                sy.removeWinRet(dialogID);//不可缺少
            })
        }
        function myselectPcyzdsz2() {
            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            var dialog = parent.sy.modalDialog({
                title: '从单位信息表中读取'
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
            })
        }

        // 关闭并刷新父窗口
        function closeAndRefreshWindow() {
            var s = new Object();
            s.type = "ok";
            sy.setWinRet(s);
            parent.$("#" + sy.getDialogId()).dialog("close");
        }
    </script>

</head>
<div style="width: 210mm; margin: 0 auto">
    <body class="b1 b2 zfwsbackgroundcolor">
    <form id="myform" method="post">
        <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
        <input id="xzcfjdsid" name="xzcfjdsid" type="hidden" value="${mybean.xzcfjdsid}"/>
        <p class="p1"><span class="s1">食品药品行政处罚文书</span></p>
        <p class="p2"><span class="s1">行政处罚决定书</span></p>
        <div align="right">
            <p class="p3"><span class="s2">
				<input type="text" id="cfjdwsbh" name="cfjdwsbh" class="easyui-validatebox"
                       data-options="required:true" style="width: 260px;text-align: right;"
                        <%if (localZfwsxzcfjds28DTO.getCfjdwsbh() != null && !"".equals(localZfwsxzcfjds28DTO.getCfjdwsbh())) {%>
                       value="${mybean.cfjdwsbh}" <%}else{%>value="（××）食药监×罚〔年份〕×号"<%}%>/>
				</span>
            </p>
        </div>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p4">
            <span>被处罚人（自然人）姓名：</span><span class="s3"><input type="text"
                                                             id="cfjdbcfrzrrxm" name="cfjdbcfrzrrxm"
                                                             style="width: 120px;text-align: left;"
                                                             value="${mybean.cfjdbcfrzrrxm}"/></span>
            <span>性别：</span><span class="s3"><input type="text" id="cfjdbcfrzrrxb"
                                                    name="cfjdbcfrzrrxb" style="width:100px;text-align: left;"
                                                    value="${mybean.cfjdbcfrzrrxb}"/></span>
            <span>年龄：</span><span class="s3"><input type="text" id="cfjdbcfrzrrnl"
                                                    name="cfjdbcfrzrrnl" style="width: 60px;text-align: left;"
                                                    value="${mybean.cfjdbcfrzrrnl}"/></span>
        </p>
        <p class="p5">
            <span>所在单位：</span><span class="s3"><input type="text" id="cfjdbcfrzrrszdw"
                                                      name="cfjdbcfrzrrszdw" style="width: 240px;text-align: left;"
                                                      value="${mybean.cfjdbcfrzrrszdw}"/></span>
            <span>住址：</span><span class="s3"><input type="text" id="cfjdbcfrzrrszdwdz"
                                                    name="cfjdbcfrzrrszdwdz" style="width: 300px;text-align: left;"
                                                    value="${mybean.cfjdbcfrzrrszdwdz}"/></span>
        </p>
        <p class="p6">
            <span>被处罚人（单位）名称：</span><span class="s3"><input type="text" id="cfjdbcfrdwmc"
                                                            name="cfjdbcfrdwmc" style="width: 600px;text-align: left;"
                                                            value="${mybean.cfjdbcfrdwmc}"/></span>
        </p>
        <p class="p6">
            <span>地址：</span><span class="s3"><input type="text" id="cfjdbcfrdwdz"
                                                    name="cfjdbcfrdwdz" style="width: 650px;text-align: left;"
                                                    value="${mybean.cfjdbcfrdwdz}"/></span>
        </p>
        <p class="p6">
            <span>营业执照或其他资质证明：</span><span class="s3"><input type="text" id="cfjdbcfrdwyyzz"
                                                             name="cfjdbcfrdwyyzz"
                                                             style="width: 150px;text-align: left;"
                                                             value="${mybean.cfjdbcfrdwyyzz}"/></span>
            <span>编号：</span><span class="s3"><input type="text" id="cfjdbcfrdwyyzzbh" name="cfjdbcfrdwyyzzbh"
                                                    style="width: 150px;text-align: left;"
                                                    value="${mybean.cfjdbcfrdwyyzzbh}"/></span>
        </p>
        <p class="p6">
            <span>法定代表人或负责人：</span><span class="s3"><input type="text" id="cfjdbcfrdwfddbr"
                                                           name="cfjdbcfrdwfddbr" style="width: 150px;text-align: left;"
                                                           value="${mybean.cfjdbcfrdwfddbr}"/></span>
            <span>性别：</span><span class="s3"><input type="text" id="cfjdbcfrdwfddbrxb" name="cfjdbcfrdwfddbrxb"
                                                    style="width: 80px;text-align: left;"
                                                    value="${mybean.cfjdbcfrdwfddbrxb}"/></span>
            <span>职务：</span><span class="s3"><input type="text" id="cfjdbcfrdwfddbrzw" name="cfjdbcfrdwfddbrzw"
                                                    style="width: 120px;text-align: left;"
                                                    value="${mybean.cfjdbcfrdwfddbrzw}"/></span>
        </p>
        <p class="p9">
            <span> 本机关于</span><span class="s2">
         <input name="cfjdlarq" id="cfjdlarq"
                class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                style="width: 170px;" value="${mybean.cfjdlarq}"/>对</span>
            <span class="s2"><input type="text" id="cfjdajmc" name="cfjdajmc"
                                    style="width: 300px;text-align: left;" value="${mybean.cfjdajmc}"/></span>
            <span>一案立案调查。经查，你（单位）</span>
            <span class="s2">于  <input name="cfjdwfxwksrq" id="cfjdwfxwksrq"
                                       class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                       style="width: 170px;" value="${mybean.cfjdwfxwksrq}"/>至
			   <input name="cfjdwfxwjsrq" id="cfjdwfxwjsrq"
                      class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                      style="width: 170px;" value="${mybean.cfjdwfxwjsrq}"/>实施了 </span>
        </p>
        <p class="p10">
         <span><input type="text" id="cfjdwfxw" name="cfjdwfxw"
                      style="width: 450px;text-align: left;" value="${mybean.cfjdwfxw}"/></span><span
                class="s2">违法行为。</span>
        </p>
        <p class="p11">
            <span class="s4">违法事实：</span><span><textarea class="easyui-validatebox bbtextarea"
                                                         data-options="required:true" id="cfjdwfss" name="cfjdwfss"
                                                         style="width: 780px;height: 100px;">${mybean.cfjdwfss}</textarea>
					</span>
        </p>
        <p class="p11">
            <span class="s4">相关证据：</span><span><textarea class="easyui-validatebox bbtextarea"
                                                         data-options="required:true" id="cfjdxgzj" name="cfjdxgzj"
                                                         style="width: 780px;height: 100px;">${mybean.cfjdxgzj}</textarea>
					</span>
        </p>
        <p class="p12">
            <span class="s4">违法行为等次：</span>
            <span>根据你（单位）的违法事实、性质、情节、社会危害程度和相关证据，你（单位）的违法行为为轻微
         <input type="text" id="wfxwdc" name="wfxwdc"
                style="width: 100px;text-align: left;" value="${mybean.wfxwdc}"/>
                <!-- （属于一般的认定为一般、属于严重的认定为严重，属于特别严重的认定为特别严重） -->。</span>
        </p>
        <p class="p12">
         <span class="s2">你（单位）的上述行为已违反了<input type="text" id="cfjdwfgd" name="cfjdwfgd"
                                               style="width: 200px;text-align: left;" value="${mybean.cfjdwfgd}"/>
          <input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz();">
                      （法律法规名称及条、款、项）的规定：<input type="text" id="cfjdwfgdtk" name="cfjdwfgdtk"
                                               style="width: 200px;text-align: left;" value="${mybean.cfjdwfgdtk}"/>（法律法规具体条、款、项内容）。</span>
        </p>
        <p class="p13">
            <span class="s4">行政处罚依据和种类：</span>
            <span>依据<input type="text" id="cfjdyjgd" name="cfjdyjgd"
                           style="width: 200px;text-align: left;" value="${mybean.cfjdyjgd}"/>
          <input type="button" style="color:blue;" value="选择" onclick="myselectPcyzdsz2();">
          </span>
            <span class="s2">（法律法规名称及条、款、项）</span>
            <span>的规定：<input type="text" id="cfjdyjgdtk" name="cfjdyjgdtk"
                             style="width: 200px;text-align: left;" value="${mybean.cfjdyjgdtk}"/>（</span>
            <span class="s2">法律法规具体条、款、项内容</span>
            <span>），决定对你（单位）作出如下行政处罚：</span>
        </p>
        <p class="p14">
          <span><textarea class="easyui-validatebox bbtextarea"
                          data-options="required:true" id="cfjdxzcf" name="cfjdxzcf"
                          style="width: 780px;height: 100px;">${mybean.cfjdxzcf}</textarea></span>
        </p>
        <p class="p15">
            <span class="s4">行政处罚履行方式和期限：</span>
            <span>你（单位）应当自接到本决定书之日起15日内将罚款缴至    <input type="text" id="cfjdjkyh" name="cfjdjkyh"
                                                       style="width: 150px;text-align: left;"
                                                       value="${mybean.cfjdjkyh}"/>银行（地址：                 ）。到期不缴纳的，每日按罚款数额的3%加处罚款。</span>
        </p>
        <p class="p15">
            <span class="s4">不服行政处罚决定申请行政复议或者提起行政诉讼的途径和期限：</span>
            <span>如不服本决定，可以自收到本决定书之日起六十日内向<input type="text" id="sjrmzf" name="sjrmzf"
                                                 style="width: 150px;text-align: left;" value="${mybean.sjrmzf}"/>人民政府或者<input
                    type="text" id="sjspypjdglj" name="sjspypjdglj" style="width: 150px;text-align: left;"
                    value="${mybean.sjspypjdglj}"/>局申请行政复议，或者在三个月内直接向人民法院起诉。逾期不申请行政复议、不向人民法院起诉又不履行本处罚决定的，我局将申请人民法院强制执行。
          </span>
        </p>
        <p class="p15"></p>
        <p class="p15"></p>
        <p class="p15"></p>
        <p class="p3">
          <span class="s2">（公    章）
          </span>
        </p>
        <p class="p3">
        <span class="s2"><input name="cfjdgzrq" id="cfjdgzrq"
                                class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                style="width: 175px;" value="${mybean.cfjdgzrq}"/>
		</span>
        </p>
        <p class="p18"></p>
        <p class="p18"></p>
        <p class="p18"></p>
        <p class="p18">
            <span> </span>
        </p>
        <p class="p19"></p>
        <p class="p19"></p>
        <p class="p19"></p>
        <p class="p19"></p>
        <p class="p20">
            <span class="s2">注：正文3号仿宋体字，存档（1），必要时交&times;&times;&times;人民法院强制执行（1）。被处罚人（自然人）和被处罚人（单位）栏，根据案情区分制作。</span>
        </p>
        <p class="p19"></p>
        <p class="p21">
            <span> </span>
        </p>
        <p class="p21"></p>
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
                       data-options="iconCls:'ext-icon-book_add'">另存为模块</a>
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
