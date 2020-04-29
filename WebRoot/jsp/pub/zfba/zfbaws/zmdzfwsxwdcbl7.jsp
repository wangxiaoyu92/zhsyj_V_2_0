<%@ page language="java" contentType="text/html;charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page
        import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil,com.askj.zfba.dto.Zfwsxwdcbl7DTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.util.List,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    //案件登记id
    String v_ajdjid = StringHelper.showNull2Empty(request.getParameter("ajdjid"));
    //执法文书代码值
    String v_zfwsdmz = StringHelper.showNull2Empty(request.getParameter("zfwsdmz"));
    //附件参数代码名称
    String v_fjcsdmmc = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("fjcsdmmc")), "UTF-8");
    //是否可以保存0否1是
    String v_canbaocun = StringHelper.showNull2Empty(request.getParameter("canbaocun"));
    //第7个文书   询问调查笔录
    Zfwsxwdcbl7DTO localZfwsxwdcbl7DTO = new Zfwsxwdcbl7DTO();
    if (request.getAttribute("mybean") != null) {
        localZfwsxwdcbl7DTO = (Zfwsxwdcbl7DTO) request.getAttribute("mybean");
    }
%>

<html>
<head>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>食品药品行政处罚文书</title>
    <meta content="X" name="author">
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
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
            color: black;
        }

        .s3 {
            font-family: 仿宋_GB2312;
            color: black;
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
            font-family: 宋体;
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
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p5 {
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p6 {
            text-indent: 0.25in;
            margin-top: 0.108333334in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p7 {
            text-indent: 0in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p8 {
            text-indent: -0.13in;
            margin-left: 0.14583333in;
            text-align: justify;
            hyphenate: auto;
            font-family: 仿宋_GB2312;
            font-size: 10.5pt;
        }

        .p9 {
            text-indent: -0.1388889in;
            margin-left: 0.1388889in;
            margin-top: 0.108333334in;
            text-align: justify;
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
    <script type="text/javascript">
        var s = new Object();
        s.type = "";   //设为空不刷新父页面
        sy.setWinRet(s);
        var mz;//民族
        var lb;//监督检查类别
        var v_mz = <%=SysmanageUtil.getAa10toJsonArray("AAC005")%>;
        var v_dcbljdjclb = <%=SysmanageUtil.getAa10toJsonArray("DCBLJDJCLB")%>;
        var layer;
        $(function () {
            layui.use(['layer'], function () {
                layer = layui.layer;
            })
            mz = $('#dcblmz').combobox({
                data: v_mz,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: '200'
            });
            lb = $('#dcbljdjclb').combobox({
                data: v_dcbljdjclb,
                valueField: 'id',
                textField: 'text',
                required: false,
                editable: false,
                panelHeight: 'auto'
            });
            var v_xwdcblid = $("#xwdcblid").val();
            if (v_xwdcblid == null || v_xwdcblid == "" || v_xwdcblid.length == 0) {
                $("#lcwmbBtn").linkbutton('disable');
                $("#printBtn").linkbutton('disable');
            } else {
                $("#lcwmbBtn").linkbutton('enable');
                $("#printBtn").linkbutton('enable');
            }

        });
        // 保存
        function mysave() {
            //下面的例子演示了如何提交一个有效并且避免重复提交的表单url: basePath+'/pub/zfwslaspb/savezfwslaspb';
            parent.$.messager.progress({
                text: '正在提交....'
            });
            $('#myform').form(
                'submit',
                {
                    url: basePath + '/pub/wsgldy/savezfwsxwdcbl',
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
                            $("#xwdcblid").val(result.xwdcblid);
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
        // 打印
        function myprint() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var url = "<%=basePath%>pub/wsgldy/zfwsxwdcblPrintIndex?ajdjid=" + v_ajdjid
                + "&zfwsqtbid=" + $('#xwdcblid').val() + "&time=" + new Date().getMilliseconds();

            //创建模态窗口
            sy.modalDialog({
                title: ''
                , area: ['700px', '650px']
                , content: url
                , offset: ["10px"]
                , btn: ['关闭']
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);

                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr.type == "ok") { //传递回的type为ok的时候才刷新页面。
                }
            });
        }

        //另存为模板
        function saveAsMoban() {
            var obj = new Object();
            var v_ajdjid = $("#ajdjid").val();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var v_xwdcblid = $("#xwdcblid").val();

            if (v_ajdjid == null || v_ajdjid == "" || v_ajdjid.length == 0) {
                alert('案件登记id为空，不能另存为模板');
                return false;
            }
            var url = "<%=basePath%>pub/wsgldy/zfwsmobanIndex?ajdjid=" + v_ajdjid + "&zfwsdmz=" + v_zfwsdmz + "&time=" + new Date().getMilliseconds();

            //创建模态窗口
            sy.modalDialog({
                title: ''
                , area: ['650px', '300px']
                , content: url
                , offset: ["10px"]
                , btn: ['保存为模板文书', '关闭']
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].submitForm();
                }
            });
        }

        //提取模板
        function tqMoban() {
            var obj = new Object();
            var v_zfwsdmz = $("#zfwsdmz").val();
            var url = encodeURI(encodeURI("<%=basePath%>pub/wsgldy/zfwsmobantqIndex?zfwsdmz=" + v_zfwsdmz + "&zfwsdmmc=<%=v_fjcsdmmc%>&time=" + new Date().getMilliseconds()));

            //创建模态窗口
            sy.modalDialog({
                title: ''
                , area: ['900px', '600px']
                , content: url
                , offset: ["10px"]
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
                            xwdcblid: $("#xwdcblid").val(),
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
        <input id="xwdcblid" name="xwdcblid" type="hidden" value="${mybean.xwdcblid}"/>
        <input id="zfwsdmz" name="zfwsdmz" type="hidden" value="<%=v_zfwsdmz%>"/>
        <p class="p1">
            <span class="s1">食品药品行政处罚文书</span>
        </p>
        <p class="p2">
            <span class="s1">询问调查笔录</span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p4">
            <span class="s2">案 由：</span><span class="s4"> <input
                id="ajdjay" name="ajdjay" style="width: 600px;"
                value="${mybean.ajdjay}"/> </span>
        </p>
        <p class="p5">
            <span class="s2">调查地点：</span><span class="s4"> <input
                id="dcbldcdd" name="dcbldcdd" style="width: 500px;"
                value="${mybean.dcbldcdd}"/> </span>
        </p>
        <p class="p5">
            <span class="s2">被调查人：</span><span class="s4"> <input
                id="dcblbdcr" name="dcblbdcr" style="width: 80px;"
                value="${mybean.dcblbdcr}"/> </span>
            <span class="s2">职务：</span>
            <span class="s4"> <input id="dcblzw"
                                     name="dcblzw" style="width: 60px;" value="${mybean.dcblzw}"/> </span>
            <span class="s2">民族：</span> <span class="s4"> <input id="dcblmz"
                                                                 name="dcblmz" value="${mybean.dcblmz}"
                                                                 style="width: 100px;"/> </span>
            <span class="s2">身份证号：</span>
            <span class="s4"> <input id="dcblsfzh" name="dcblsfzh"
                                     style="width: 180px;" value="${mybean.dcblsfzh}"
                                     class="easyui-validatebox" validtype="idcard"/> </span>
        </p>
        <p class="p5">
            <span class="s2">工作单位：</span>
            <span class="s4"> <input id="dcblgzdw" name="dcblgzdw" style="width: 150px;"
                                     value="${mybean.dcblgzdw}"/> </span>
            <span class="s2">联系方式：</span>
            <span class="s4"> <input id="dcbllxfs" name="dcbllxfs"
                                     style="width: 120px;" value="${mybean.dcbllxfs}"
                                     class="easyui-validatebox" validtype="phoneAndMobile"/>
				</span>
            <span class="s2">地址：</span>
            <span class="s4"> <input id="dcbldz" name="dcbldz" style="width: 180px;"
                                     value="${mybean.dcbldz}"/> </span>
        </p>
        <p class="p5">
            <span class="s2">调查人：</span>
            <span class="s4"> <input id="dcbldcr1" name="dcbldcr1" style="width: 100px;"
                                     value="${mybean.dcbldcr1}"/> </span>
            <span class="s2">、</span>
            <span class="s4"> <input id="dcbldcr2" name="dcbldcr2" style="width: 100px;"
                                     value="${mybean.dcbldcr2}"/> </span>
            <span class="s2">记录人：</span>
            <span class="s4"> <input id="dcbljlr" name="dcbljlr"
                                     style="width: 100px;" value="${mybean.dcbljlr}"/> </span>
            <span class="s2">监督检查类别：</span> <span
                class="s4"> <input id="dcbljdjclb" name="dcbljdjclb"
                                   style="width: 100px;" value="${mybean.dcbljdjclb}"/> </span>
        </p>
        <p class="p5">
            <span class="s2">调查时间：</span> <span class="s4"> <input
                name="dcbldckssj" id="dcbldckssj" class="Wdate"
                onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                readonly="readonly" style="width: 175px;"
            <% if(localZfwsxwdcbl7DTO.getDcbldckssj() != null){ %>
                value="${mybean.dcbldckssj}"
            <%} else { %> value="<%=SysmanageUtil.getDbtimeYmdHns() %>" <%} %>>
				</span>
            <span class="s2"> 年 月 日 时 分 </span>至 <input name="dcbldcjssj"
                                                        id="dcbldcjssj" class="Wdate"
                                                        onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                                        readonly="readonly" style="width: 175px;"
            <% if(localZfwsxwdcbl7DTO.getDcbldcjssj() != null){ %>
                                                        value="${mybean.dcbldcjssj}"
            <%} else { %> value="<%=SysmanageUtil.getDbtimeYmdHns() %>" <%} %>>
            <spanclass
            ="s4"> 时 分 </span>
        </p>
        <hr style="height:2px;border:none;border-top:2px solid #555555;"/>
        <p class="p6">
            <span class="s2">我们是</span>
            <span class="s4"> <input name="spypjdgljmcqc" id="spypjdgljmcqc"
                                     style="width: 180px;" value="${mybean.spypjdgljmcqc}">
				</span>
            <span class="s2">的执法人员</span>
            <span class="s4"><input id="dcblzfry1" name="dcblzfry1" style="width: 100px;"
                                    value="${mybean.dcblzfry1}"/>
				<input name="dcblzfry2" id="dcblzfry2" style="width: 200px;"
                       value="${mybean.dcblzfry2}">
				</span>
            <span class="s2"></span>
            <span class="s2">，执法证件名称、编号是：</span>
            <span class="s4"><input name="zfzjmc" id="zfzjmc" style="width: 150px;"
                                    value="${mybean.zfzjmc}">、
					<input name="dcbldcr1zjbh" id="dcbldcr1zjbh" style="width: 100px;"
                           value="${mybean.dcbldcr1zjbh}"> </span> <span class="s2">、
					<input name="dcbldcr2zjbh" id="dcbldcr2zjbh" style="width: 150px;"
                           value="${mybean.dcbldcr2zjbh}"> ，请你过目。
				</span>
        </p>
        <p class="p7">
            <span class="s2">问：你是否看清楚？</span>
        </p>
        <p class="p7">
				<span class="s2">答： <input name="dcblsfkqc" id="dcblsfkqc"
                                           style="width: 400px;" class="easyui-validatebox"
                    <% if(localZfwsxwdcbl7DTO.getDcblsfkqc() == null || "".equals(localZfwsxwdcbl7DTO.getDcblsfkqc())){ %>
                                           value="我已看清楚。"
                    <%} else {%> value="${mybean.dcblsfkqc}"<%} %>></span>
        </p>
        <p class="p6">
            <span class="s2">我们依法就</span>
            <span class="s4"> <input name="dcblygwt" id="dcblygwt" style="width: 260px;"
                                     value="${mybean.dcblygwt}"> </span>
            <span class="s2">有关问题进行调查，请予配合。依照法律规定，对于调查人员，
					有下列情形之一的，必须回避，你也有权申请调查人员回避： （1）系当事人或当事人的近亲属；（2）与本案有直接利害关系；
					（3）与当事人有其他关系，可能影响案件公正处理的。</span>
        </p>
        <p class="p7">
            <span class="s2">问：你是否申请调查人员回避？</span>
        </p>
        <p class="p7">
				<span class="s2">答： <input name="dcblsfsqdcryhb"
                                           id="dcblsfsqdcryhb" style="width: 400px;"
                    <% if(localZfwsxwdcbl7DTO.getDcblsfsqdcryhb() == null || "".equals(localZfwsxwdcbl7DTO.getDcblsfsqdcryhb())){ %>
                                           value="不申请回避。"
                    <%}  else {%> value="${mybean.dcblsfsqdcryhb}"<%} %>>
				</span>
        </p>
        <p class="p7">
            <span class="s2">问：你有如实接受调查的法律义务，如有意隐匿违法行为或故意作伪证将承担法律责任，你是否明白？</span>
        </p>
        <p class="p8">
				<span class="s2">答： <input name="dcblsfmbbnzwz"
                                           id="dcblsfmbbnzwz" style="width: 400px;" class="easyui-validatebox"
                    <% if(localZfwsxwdcbl7DTO.getDcblsfmbbnzwz() == null || "".equals(localZfwsxwdcbl7DTO.getDcblsfmbbnzwz())){ %>
                                           value="明白。"
                    <%}  else {%> value="${mybean.dcblsfmbbnzwz}"<%} %>>
				</span>
        </p>
        <p class="p7">
				<span class="s2">调查记录：
        <p>
						<textarea id="dcbldcjl" name="dcbldcjl" style="width: 800px;height: 200px;"
                                  data-options="required:false,validType:'length[0,5000]'">${mybean.dcbldcjl}</textarea>
        </p> </span>
        </p>
        <p class="p9"></p>
        <p class="p9"></p>
        <p class="p9"></p>
        <p class="p9"></p>
        <p class="p4"></p>
        <p class="p4"></p>
        <p class="p4"></p>
        <p class="p4"></p>
        <p class="p4"></p>
        <p class="p4">
            <span class="s2">被调查人签字：</span>
            <span class="s4"> <input
                    id="dcblbdcrqz" name="dcblbdcrqz" style="width: 170px;"
                    value="${mybean.dcblbdcrqz}"/> </span>
            <span class="s2"> 执法人员签字：</span>
            <span class="s4"> <input id="dcbldcrqz1" name="dcbldcrqz1"
                                     style="width: 90px;" value="${mybean.dcbldcrqz1}"/>、
					<input id="dcbldcrqz2" name="dcbldcrqz2"
                           style="width: 90px;" value="${mybean.dcbldcrqz2}"/>
				</span>

        </p>
        <p class="p4">
				<span class="s2"> 年 月 日 <input name="dcblbdcrqzrq"
                                               id="dcblbdcrqzrq" class="Wdate"
                                               onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                               readonly="readonly" style="width: 175px;"
                    <% if(localZfwsxwdcbl7DTO.getDcblbdcrqzrq() != null){ %>
                                               value="${mybean.dcblbdcrqzrq}"
                    <%} else { %> value="<%=SysmanageUtil.getDbtimeYmd()%>" <%} %>>
				</span>
            <span class="s2">年 月 日 <input name="dcbldcrqzrq" id="dcbldcrqzrq" class="Wdate"
                                          onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                          readonly="readonly" style="width: 175px;"
                <% if(localZfwsxwdcbl7DTO.getDcbldcrqzrq() != null){ %>
                                          value="${mybean.dcbldcrqzrq}"
                <%} else { %> value="<%=SysmanageUtil.getDbtimeYmd()%>" <%} %>>
				</span>
        </p>
        <p class="p10"></p>
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
