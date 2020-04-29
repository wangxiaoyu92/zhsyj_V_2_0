<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String v_jyjcjcbzbid = StringHelper.showNull2Empty(request.getParameter("jyjcjcbzbid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测检测标准</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var bzbhOld='';
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var v_BZSTATE =<%=SysmanageUtil.getAa10toJsonArray("JYJCBZSTATE")%>;
        var v_jyjcbzfenlei =<%=SysmanageUtil.getAa10toJsonArray("JYJCBZFENLEI")%>;
        var v_jyjczbfenlei =<%=SysmanageUtil.getAa10toJsonArray("JYJCZBFENLEI")%>;
        var v_jyjcicsfenlei = <%=SysmanageUtil.getAa10toJsonArray("JYJCICSFENLEI")%>
        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjcbzfenlei',  //调用后台的方法
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            data: {
                key: {
                    name: "text"
                }
            },
            callback: {
                onClick: onClick
            }
        }
        var setting2 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjczbfenlei',  //调用后台的方法
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            data: {
                key: {
                    name: "text"
                }
            },
            callback: {
                onClick: onClick2
            }
        }
        var setting3 = {
            async: {
                enable: true, //启用异步加载
                url: basePath + '/pub/pub/queryJiBieCanShuTree?aaa100=jyjcicsfenlei',  //调用后台的方法
                dataFilter: ajaxDataFilter //用于对 Ajax返回数据进行预处理
            },
            data: {
                key: {
                    name: "text"
                }
            },
            callback: {
                onClick: onClick3
            }
        }
        var layer;
        var form;
        var table;
        var layedit;
        var index;
        var laydate;
        var jyjcbzfenleiId;
        var jyjczbfenleiId;
        var jyjcicsfenleiId;
        $(function () {
            layui.use(['layer', 'form', 'table', 'layedit', 'laydate'], function () {
                layer = layui.layer;
                form = layui.form;
                table = layui.table;
                layedit = layui.layedit;
                laydate = layui.laydate;

                laydate.render({
                    elem: '#fbrq'
                })
                laydate.render({
                    elem: '#ssrq'
                })
                laydate.render({
                    elem: '#zfrq'
                })
                laydate.render({
                    elem: '#sfrq'
                })
                laydate.render({
                    elem: '#fsrq'
                })
                index = layedit.build("bzcontent");
                var lock= true;
                var url=basePath + 'jyjc/saveJyjcbz';
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false  //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                var obj = new Object();
                                if ('' == ('<%=op%>')) {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                if ($('#jyjcjcbzbid').val().length > 0) {
                    $.post(basePath + 'jyjc/queryJyjcjcbzbDTO',{
                            jyjcjcbzbid : $('#jyjcjcbzbid').val()
                        },
                        function(result) {
                            if (result.code=='0') {
                                var mydata = result.data;
                                $('form').form('load', mydata);
                                bzbhOld =mydata.bzbz;
                                //富文本编辑器的赋值
                                $("iframe[textarea='bzcontent']")[0].contentDocument.body.innerHTML=mydata.bzcontent;
                                //编辑保存时的赋值
                                jyjcbzfenleiId=mydata.jyjcbzfenlei;
                                jyjczbfenleiId=mydata.jyjczbfenlei;
                                jyjcicsfenleiId=mydata.jyjcicsfenlei;
                                //回显时的值是内容 而不是id
                                $("#jyjcbzfenlei").val(sy.formatGridCode(v_jyjcbzfenlei,mydata.jyjcbzfenlei));
                                $("#jyjczbfenlei").val(sy.formatGridCode(v_jyjczbfenlei,mydata.jyjczbfenlei));
                                $("#jyjcicsfenlei").val(sy.formatGridCode(v_jyjcicsfenlei,mydata.jyjcicsfenlei));
                                form.render('select');
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "查询失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        }, 'json');

                    if('<%=op%>' == 'view'){
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly','readonly');
                        $('form :input').removeAttr("onclick");
                        $('.Wdate').attr('disabled',true);
                        $('select').attr('disabled', true);
                        $('input').attr('disabled', true);
                        //富文本编辑器只读
                        $("iframe[textarea='bzcontent']")[0].contentDocument.body.contentEditable=false;
                    }
                }

            })

            intSelectData('sfyx', v_SFYX);
            intSelectData('jyjcbzstate', v_BZSTATE);
            $('#bzbh').blur(function () {
                var bzbh = $('#bzbh').val();
                if (bzbh == null || bzbh == '') {
                    return false;
                }
                if (bzbh != bzbhOld) {
                    checkBzbh();
                }
            })

        });
        //验证编码唯一性
        function checkBzbh() {
            var bzbh = $('#bzbh').val().toUpperCase();
            if (bzbh != null && bzbh != "") {
                $.post(basePath + 'jyjc/checkBzbh', {
                            bzbh: bzbh
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.total;
                                //存在
                                if (mydata > 0) {
                                    layer.msg("编号重复请重新填写");
                                    $('#bzbh').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编码唯一</font>");
                                } else {
                                    $('#bzbh').val(bzbh);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
            }
        }
        function submitForm() {
            layedit.sync(index);
//            $("#bzcontent").val(layedit.getContent(index));
            //保存的是id
            $("#jyjcbzfenlei").val(jyjcbzfenleiId);
            $("#jyjczbfenlei").val(jyjczbfenleiId);
            $("#jyjcicsfenlei").val(jyjcicsfenleiId);
            $("#saveAjdjBtn").click();
        }
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        function onClick(e, treeId, treeNode) {
            var text = treeNode.text;
            jyjcbzfenleiId=treeNode.id;
            $("#jyjcbzfenlei").val(text);
            hideMenu(1);
        }
        function onClick2(e, treeId, treeNode) {
            var text = treeNode.text;
            jyjczbfenleiId=treeNode.id;
            $("#jyjczbfenlei").val(text);
            hideMenu(2);
        }
        function onClick3(e, treeId, treeNode) {
            jyjcicsfenleiId=treeNode.id;
            var text = treeNode.text;
            $("#jyjcicsfenlei").val(text);
            hideMenu(3);
        }

        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes = responseData;//获取后台传递的数据
            return zNodes;
        }

        function showMenu(a) {
            if (a == 1) {
                var left = $("#jyjcbzfenlei");
                var leftOffset = $("#jyjcbzfenlei").offset();
                $("#menuContent").css({
                    left: leftOffset.left-25 + "px",
                    top: leftOffset.top + left.outerHeight()-10 + "px"
                }).slideDown("fast");
                $("body").bind("mousedown", onBodyDown);
            } else if (a == 2) {
                var left = $("#jyjczbfenlei");
                var leftOffset = $("#jyjczbfenlei").offset();
                $("#menuContent2").css({
                    left: leftOffset.left-25 + "px",
                    top: leftOffset.top +left.outerHeight()-10 + "px"
                }).slideDown("fast");
                $("body").bind("mousedown", onBodyDown2);
            } else {
                var left = $("#jyjcbzfenlei");
                var leftOffset = $("#jyjcicsfenlei").offset();
                $("#menuContent3").css({
                    left: leftOffset.left-25+ "px",
                    top: leftOffset.top + left.outerHeight()-10 + "px"
                }).slideDown("fast");
                $("body").bind("mousedown", onBodyDown3);
            }

            refreshZTree(a);
        }

        function onBodyDown(event) {
            //这里不能定义a变量 会导致event undifine  setting的onckick方法同理 暂时未想出更好的方法
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent"
                    || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu(1);
            }
        }

        function onBodyDown2(event) {
            //这里不能定义a变量 会导致event undifine  setting的onckick方法同理 暂时未想出更好的方法
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent2"
                    || $(event.target).parents("#menuContent2").length > 0)) {
                hideMenu(2);
            }
        }

        function onBodyDown3(event) {
            //这里不能定义a变量 会导致event undifine  setting的onckick方法同理 暂时未想出更好的方法
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent3"
                    || $(event.target).parents("#menuContent3").length > 0)) {
                hideMenu(3);
            }
        }

        function hideMenu(a) {
            if (a == 1) {
                $("#menuContent").fadeOut("fast");
                $("body").unbind("mousedown", onBodyDown);
            } else if (a == 2) {
                $("#menuContent2").fadeOut("fast");
                $("body").unbind("mousedown", onBodyDown2);
            } else {
                $("#menuContent3").fadeOut("fast");
                $("body").unbind("mousedown", onBodyDown3);
            }
        }

        function refreshZTree(a) {
            if (a == 1) {
                $.fn.zTree.init($("#treeDemo"), setting);
            } else if (a == 2) {
                $.fn.zTree.init($("#treeDemo2"), setting2);
            } else {
                $.fn.zTree.init($("#treeDemo3"), setting3);
            }

        }


    </script>
</head>

<body>
<div class="layui-table">
    <div region="center">
        <form class="layui-form" id="myf" action="">
            <div class="layui-container">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 150px">检验检测检测标准id:</label>
                    <div class="layui-input-inline">
                        <input class="layui-input layui-bg-gray" value="<%=v_jyjcjcbzbid%>" id="jyjcjcbzbid"
                               name="jyjcjcbzbid" readonly="readonly">
                    </div>
                    <label class="layui-form-label" style="width: 248px">标准分类:</label>
                    <div class="layui-input-inline">
                        <input id="jyjcbzfenlei" name="jyjcbzfenlei" class="layui-input layui-bg-gray"
                               autocomplete="off"  onclick="showMenu(1);"  readonly/>
                    </div>
                </div>
                <div id="menuContent" class="menuContent"
                     style="display:none;position:absolute;z-index:333;height: 200px;width: 185px;">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>

                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px"><font class="myred">*</font>标准编号:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="bzbh" name="bzbh" lay-verify="required">
                        </div>
                        <div class="layui-input-inline" style="width: 100px">
                            <font color="red" id="greentext" style="line-height: 40px">保证编码唯一</font>
                        </div>
                        <label class="layui-form-label" style="width: 138px"><font class="myred">*</font>标准状态:</label>
                        <div class="layui-input-inline">
                            <select name="jyjcbzstate" id="jyjcbzstate"></select>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">英文名称:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="engname" name="engname">
                        </div>
                        <label class="layui-form-label" style="width: 248px">中文名称:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="chinaname" name="chinaname">
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">替代情况:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="tdqk" name="tdqk">
                        </div>
                        <label class="layui-form-label" style="width: 248px">中标分类:</label>
                        <div class="layui-input-inline">
                            <input id="jyjczbfenlei" name="jyjczbfenlei" onclick="showMenu(2);"
                                   readonly class="layui-input layui-bg-gray"/>
                        </div>
                        <div id="menuContent2" class="menuContent"
                             style="display:none;position:absolute;z-index:333;height: 200px;width: 185px;">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">ICS分类:</label>
                        <div class="layui-input-inline">
                            <input id="jyjcicsfenlei" name="jyjcicsfenlei" onclick="showMenu(3);"
                                   readonly class="layui-input layui-bg-gray"/>
                        </div>
                        <label class="layui-form-label" style="width: 248px">UDC分类:</label>
                        <div class="layui-input-inline">
                            <select id="jyjcudcfenlei" name="jyjcudcfenlei"></select>
                        </div>
                        <div id="menuContent3" class="menuContent"
                             style="display:none;position:absolute;z-index:333;height: 200px;width: 185px;">
                            <ul id="treeDemo3" class="ztree"></ul>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">发布部门:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="fbbm" name="fbbm">
                        </div>
                        <label class="layui-form-label" style="width: 248px">发布日期:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="fbrq" name="fbrq" >
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">实施日期:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="ssrq" name="ssrq" >
                        </div>
                        <label class="layui-form-label" style="width: 248px">作废日期:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="zfrq" name="zfrq" >
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">首发日期:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="sfrq" name="sfrq" >
                        </div>
                        <label class="layui-form-label" style="width: 248px">复审日期:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="fsrq" name="fsrq" >
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">提出单位:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="tcdw" name="tcdw">
                        </div>
                        <label class="layui-form-label" style="width: 248px">出口单位:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="gkdw" name="gkdw">
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">主管部门:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="zgbm" name="zgbm">
                        </div>
                        <label class="layui-form-label" style="width: 248px">起草单位:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="qcdw" name="qcdw">
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">起草人:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" id="rcr" name="rcr">
                        </div>
                        <label class="layui-form-label" style="width: 248px">是否有效:</label>
                        <div class="layui-input-inline">
                            <select name="sfyx" id="sfyx"></select>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 150px">操作员:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input layui-bg-gray" id="aae011" name="aae011" readonly>
                        </div>
                        <label class="layui-form-label" style="width: 248px">操作时间:</label>
                        <div class="layui-input-inline">
                            <input class="layui-input layui-bg-gray" id="aae036" name="aae036" readonly>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <label class="layui-form-label" style="width: 150px">标准内容:</label>
                    <div class="layui-input-inline" style="width: 70%">
                        <textarea id="bzcontent" name="bzcontent"></textarea>
                    </div>
                </div>
                <div class="layui-form-item" style="display: none">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="save" id="saveAjdjBtn">保存
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>