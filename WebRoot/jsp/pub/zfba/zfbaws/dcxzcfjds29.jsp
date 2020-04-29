<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%@ page import="com.askj.zfba.dto.Zfwsdcxzcfjds29DTO" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Zfwsdcxzcfjds29DTO dto = new Zfwsdcxzcfjds29DTO();
    if (request.getAttribute("mybean") != null) {
        dto = (Zfwsdcxzcfjds29DTO) request.getAttribute("mybean");
    }
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    String zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));//是否可以保存0否1是
    String sjws = null;
    if (request.getAttribute("sjws") != null) {
        sjws = (String) request.getAttribute("sjws");
    }
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
            color: black;
        }

        .s2 {
            font-weight: bold;
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
            text-indent: 3.4722223in;
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
            margin-left: 0.29166666in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p6 {
            text-indent: 0.29166666in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p7 {
            text-indent: 0.29166666in;
            text-align: justify;
            hyphenate: auto;
            font-family: FZFS;
            font-size: 10.5pt;
        }

        .p8 {
            text-align: justify;
            hyphenate: auto;
            font-family: FZFS;
            font-size: 10.5pt;
        }

        .p9 {
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p10 {
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p11 {
            text-indent: 3.8194444in;
            margin-top: 0.108333334in;
            text-align: start;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 5pt;
        }

        .p12 {
            margin-top: 0.108333334in;
            text-align: start;
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

    <title>当场行政处罚决定书</title>
    <meta content="X" name="author">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        var mygrid;
        var dccffddbrxb; // 法定负责人性别
        var v_xb = <%=SysmanageUtil.getAa10toJsonArray("RYXB")%>;
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            dccffddbrxb = $('#dccffddbrxb').combobox({
                data: v_xb,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
            if ($("#dcxzcfjdsid").val() == "") {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }
            if (<%=sjws%>=='2'
            )
            {
                $("#lcwmbBtn").eq(0).hide();
                $("#lcwBtn").eq(0).hide();
                $("#BtnFanhui").eq(0).hide();
            }
        });

        //保存
        function mysave() {
            var url = basePath + 'pub/wsgldy/saveZfwsdcxzcfjds29';
            //下面的例子演示了如何提交一个有效并且避免重复提交的表单
            parent.$.messager.progress({
                text: '正在提交....'
            });	// 显示进度条
            $('#myform').form('submit', {
                url: url,
                onSubmit: function () {
                    var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
                    if (!isValid) {
                        parent.$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
                    }
                    return isValid;
                },
                success: function (result) {
                    parent.$.messager.progress('close');// 隐藏进度条
                    result = $.parseJSON(result);
                    if (result.code == '0') {
                        $("#dcxzcfjdsid").val(result.dcxzcfjdsid);
                        $("#saveBtn").linkbutton('disable');
                        $("#lcwmbBtn").linkbutton('enable');
                        $("#printBtn").linkbutton('enable');
                        alert("保存成功！");
                    } else {
                        parent.$.messager.alert('提示', '保存失败：' + result.msg, 'error');
                    }
                }
            });
        }

        function myprint() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var sjws = <%=sjws%>;
            var v_dcxzcfjdsid = $("#dcxzcfjdsid").val();
            if (sjws == '2') {
                var url = "<%=basePath%>/common/sjb/getajdjDocumentsHtml?ajdjid="
                    + v_ajdjid + "&dcxzcfjdsid=" + v_dcxzcfjdsid + "&type=" + '6' + "&time=" + new Date().getMilliseconds();
                self.location = url;
            } else {
                var url = "<%=basePath%>pub/wsgldy/Zfwsdcxzcfjds29IndexPrint?ajdjid="
                    + v_ajdjid + "&dcxzcfjdsid=" + v_dcxzcfjdsid + "&time=" + new Date().getMilliseconds();
                //创建模态窗口
                parent.sy.modalDialog({
                    title: '打印'
                    , area: ['100%', '100%']
                    , content: url
                    , offset: ["0px"]
                    , btn: ['关闭']
                });
            }
        }

        //保存模板
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_dcxzcfjdsid = $("#dcxzcfjdsid").val();
            if (v_ajdjid == null || v_ajdjid == "" || v_ajdjid.length == 0) {
                alert('案件登记id为空，不能另存为模板');
                return false;
            }
            if (v_dcxzcfjdsid == null || v_dcxzcfjdsid == "" || v_dcxzcfjdsid.length == 0) {
                alert('请先保存，保存成功后，才能另存为模板');
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
                title: '模板提取'
                , area: ['100%', '100%']
                , content: url
                , param: {
                    zfwsdmmc: "<%=v_fjcsdmmc%>",
                    zfwsdmz: v_zfwsdmz,
                    time: new Date().getMilliseconds()
                }
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
                                GloballoadData(retdata);
                            } else {
                                parent.$.messager.alert('提示', '查询模板信息失败：' + result.msg, 'error');
                            }
                            parent.$.messager.progress('close');
                        }, 'json');
                }

            })
        }
        // 违反的法律法规
        function myselectWfflfg() {
            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            //创建模态窗口
            parent.sy.modalDialog({
                title: '违反的法律法规'
                , area: ['100%', '100%']
                , content: url,
                param: {
                    singleSelect: "true",
                    tabname: "zfwsdcxzcfjds29",
                    colname: "dcxzcfjdswfflfg",
                    getflfg: "1",
                    a: new Date().getMilliseconds()
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        $("#dccfwfgd").val(myrow.avalue);
                    }
                }
                sy.removeWinRet(dialogID);//不可缺少
            })
        }
        // 依据的法律法规
        function myselectYjflfg() {
            var url = "<%=basePath%>jsp/pub/pub/selectPcyzdsz.jsp";
            //创建模态窗口
            parent.sy.modalDialog({
                title: '依据的法律法规'
                , area: ['100%', '100%']
                , content: url,
                param: {
                    singleSelect: "true",
                    tabname: "zfwsdcxzcfjds29",
                    colname: "dcxzcfjdsyjflfg",
                    getflfg: "1",
                    a: new Date().getMilliseconds()
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);//不可缺少
                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        $("#dccfyjgd").val(myrow.avalue); //公司名称
                    }
                }
                ;
                sy.removeWinRet(dialogID);//不可缺少
            })
        }


        // 违反依据法律法规
        function myselectYjfjfg(str) {
            $("#dccfyjgd").val(str);
        }

        // 违反的法律法规
        function myselectWfflfg1(str) {
            $("#dccfwfgd").val(str);
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
<body class="b1 b2 zfwsbackgroundcolor">
<form id="myform" method="post">
    <input id="ajdjid" name="ajdjid" type="hidden" value="<%=v_ajdjid%>"/>
    <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=zfwsdmz%>"/>
    <input id="dcxzcfjdsid" name="dcxzcfjdsid" type="hidden"
           value="${mybean.dcxzcfjdsid}"/>
    <p class="p1">
			<span class="s1"><input id="xzjgmc" name="xzjgmc"
                                    style="width:200px;" value="${mybean.xzjgmc}"/></span>
    </p>
    <p class="p2">
        <span class="s2">当场行政处罚决定书</span>
    </p>
    <div align="right">
        <p class="p3">
			<span><input id="dccfwsbh" name="dccfwsbh"
                         style="width:300px;" value="${mybean.dccfwsbh}"/></span>
        </p>
    </div>
    <hr style="height:2px;border:none;border-top:2px solid #555555;">
    <p class="p4">
        <span>当事人名称或姓名：</span>
        <span><input id="dccfdsr" name="dccfdsr"
                     style="width:150px;" value="${mybean.dccfdsr}"/></span>
        <span>性别：</span>
        <span style="text-indent: 0in;"><input id="dccffddbrxb" name="dccffddbrxb"
                                               style="width:80px;" value="${mybean.dccffddbrxb}"/></span>
        <span>公民身份号码：</span>
        <span><input id="gmsfhm" name="gmsfhm"
                     style="width:200px;" value="${mybean.gmsfhm}"/></span>
    </p>
    <p class="p4">
        <span>法定代表人或负责人姓名：</span>
        <span><input id="dccffddbr" name="dccffddbr"
                     style="width:100px;" value="${mybean.dccffddbr}"/></span>
        <span>职务：</span>
        <span><input id="dccffddbrzw" name="dccffddbrzw"
                     style="width:100px;" value="${mybean.dccffddbrzw}"/></span>
        <span>地址：</span>
        <span><input id="dccfdz" name="dccfdz"
                     style="width:200px;" value="${mybean.dccfdz}"/></span>
    </p>
    <p class="p4">
        <span>你（单位）</span>
        <span><input id="dccfwfxw" name="dccfwfxw"
                     style="width:400px;" value="${mybean.dccfwfxw}"/></span>
        <span>的行为，违反了</span>
        <span><input id="dccfwfgd" name="dccfwfgd"
                     style="width:400px;" value="${mybean.dccfwfgd}"/>
				<input type="button" style="color:blue;" value="选择" onclick="myselectWfflfg()"></span>
        <span>（法律法规依据名称及条、款、项）的规定。我局执法人员当场向你（单位）告知了违法事实、
				依据和依法享有的权利。并听取了你（单位）的陈述申辩（或：对此，你（单位）未作陈述申辩），现依据</span>
        <span><input id="dccfyjgd" name="dccfyjgd"
                     style="width:400px;" value="${mybean.dccfyjgd}"/>
				<input type="button" style="color:blue;" value="选择" onclick="myselectYjflfg()"></span>
        <span>（法律法规依据名称条、款、项具体内容），决定对你（单位）给予以下行政处罚：</span>
    </p>
    <p class="p5">
        <span>1.警告；2.罚款人民币</span>
        <span class="s3"><input id="fkrmbdxqian" name="fkrmbdxqian"
                                style="width:50px;" value="${mybean.fkrmbdxqian}"/></span>
        <span>仟</span>
        <span class="s3"><input id="fkrmbdxbai" name="fkrmbdxbai"
                                style="width:50px;" value="${mybean.fkrmbdxbai}"/></span>
        <span>佰</span>
        <span class="s3"><input id="fkrmbdxshi" name="fkrmbdxshi"
                                style="width:50px;" value="${mybean.fkrmbdxshi}"/></span>
        <span>拾</span>
        <span class="s3"><input id="fkrmbdxyuan" name="fkrmbdxyuan"
                                style="width:50px;" value="${mybean.fkrmbdxyuan}"/></span>
        <span>元整（大写）。  &yen;：</span>
        <span class="s3"><input id="fkrmbxx" name="fkrmbxx"
                                style="width:100px;" value="${mybean.fkrmbxx}"/></span>
    </p>
    <p class="p6">
        <span>缴纳罚款方式：（1）当场收缴。    （2）自收到本决定书之日起15日内将罚款缴至</span>
        <span class="s3"><input id="fmkjkyh" name="fmkjkyh"
                                style="width:100px;" value="${mybean.fmkjkyh}"/>
				（&times;&times;路&times;号&times;&times;&times;&times;银行） </span>
        <span>。账号：</span>
        <span class="s3"><input id="yhzh" name="yhzh"
                                style="width:150px;" value="${mybean.yhzh}"/></span>
        <span>户名：</span>
        <span class="s3"><input id="yhhm" name="yhhm"
                                style="width:150px;" value="${mybean.yhhm}"/></span>
        <span>。到期不缴纳罚款的，根据《中华人民共和国行政处罚法》第五十一条第（一）项的规定，每日按罚款数额的3%加处罚款。</span>
    </p>
    <p class="p6">
        <span>如你（单位）不服本行政处罚决定，可以自收到本决定书之日起六十日内向</span>
        <span class="s3"><input id="sjrmzf" name="sjrmzf"
                                style="width:100px;" value="${mybean.sjrmzf}"/></span>
        <span>人民政府或者</span>
        <span class="s3"><input id="sjspypjdglj" name="sjspypjdglj"
                                style="width:100px;" value="${mybean.sjspypjdglj}"/></span>
        <span>申请行政复议，也可以自收到本决定书之日起六个月内依法直接向</span>
        <span class="s3"><input id="sjrmfy" name="sjrmfy"
                                style="width:100px;" value="${mybean.sjrmfy}"/></span>
        <span>人民法院提起行政诉讼。逾期不申请行政复议，也不提起行政诉讼，又不履行本处罚决定的，我局将依法申请人民法院强制执行。</span>
    </p>
    <p class="p7"></p>
    <p class="p8"></p>
    <p class="p4">
        <span>当事人：</span>
        <span><input id="dccfdsrqz" name="dccfdsrqz"
                     style="width:150px;" value="${mybean.dccfdsrqz}"/>（签字）</span>
        <span>执法人员：</span>
        <span><input id="dccfzfryqz" name="dccfzfryqz"
                     style="width:150px;" value="${mybean.dccfzfryqz}"/></span>
        <span>、</span>
        <span><input id="dccfzfryqz2" name="dccfzfryqz2"
                     style="width:150px;" value="${mybean.dccfzfryqz2}"/> （签字）</span>
    </p>
    <p class="p9">
			<span>&times;年&times;月&times;日:<input
                    name="dccfdsrqzrq" id="dccfdsrqzrq" class="Wdate"
                    onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    style="width: 175px;" value="${mybean.dccfdsrqzrq}"/></span>
    </p>
    <div align="right">
        <p class="p10">
            <span class="s4"> （公    章）</span>
        </p>
        <p class="p10">
				<span class="s4">&times;年&times;月&times;日:<input
                        name="dccfgzrq" id="dccfgzrq" class="Wdate"
                        onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                        style="width: 175px;" value="${mybean.dccfgzrq}"/></span>
        </p>
    </div>
    <p class="p12">
        <span class="s4">注：存档（1），必要时交</span>
        <span class="s4"><input id="qzzzrmfy" name="qzzzrmfy"
                                style="width:100px;" value="${mybean.qzzzrmfy}"/></span>
        <span class="s4">人民法院强制执行（1）。</span>
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
    </div>

</form>
</body>
</html>
