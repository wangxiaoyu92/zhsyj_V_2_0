<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>

<!DOCTYPE html>
<html>
<head>
    <title>检查计划信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        var form;
        var laydate;
        // 执法计划类别
        var planchecktype = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
        var v_lhfjndpddj = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;

        var plancodelod = '';

        $(function () {

            $('#plancode').blur(function () {
                var plancode = $('#plancode').val();
                if (plancode == null || plancode == '') {
                    return false;
                }
                if (plancode != plancodelod) {
                    checkUniqueness();
                }
            })
            layui.use(['form', 'laydate'], function () {
                form = layui.form;
                laydate = layui.laydate;
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var url = basePath + 'supervision/savePlan';
                    /* gu20180312                   var plantypearea = funarea();
                     if (plantypearea == null) {
                     layer.msg('必填项不能为空', {icon: 5, shade: 0, time: 2000, anim: 6});
                     $('#plantypeareas').css('border', 'solid 1px red');
                     return false;
                     }*/
                    var planchecktype = $('#planchecktype ').val();
                    var plantitle = $('#plantitle').val();
                    var plancode = $('#plancode').val();
                    var planstdate = $('#planstdate').val();
                    var planeddate = $('#planeddate').val();
                    var plantype = "1";// $("input[name='plantype']:checked").val();
                    var plancontent = $('#plancontent').val();
                    var planremark = $('#planremark').val();

                    var formData = {
                        //gu20180312 plantypearea: plantypearea,
                        planchecktype: planchecktype,
                        plantitle: plantitle,
                        plancode: plancode,
                        planstdate: planstdate,
                        planeddate: planeddate,
                        plantype: plantype,
                        plancontent: plancontent,
                        planremark: planremark,
                        lhfjndpddj: $('#lhfjndpddj').val()
                    };
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
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

//                showcomList();//执法计划下拉列表
                //gu20180312 gettypes("COMDALEI");
                intSelectData("planchecktype", planchecktype);
                intSelectData("lhfjndpddj", v_lhfjndpddj);
                form.render();
                laydate.render({//执法时间处理
                    elem: '#plandate'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#planstdate').val(val[0]);
                        $('#planeddate').val(val[1]);
                    }
                });

//                g_layselectPutSelectData("lhfjndpddj",v_lhfjndpddj);
            })

            $("#btn_query").click(function () {//验证
                checkUniqueness();
                return false;
            })
            //查询企业类别
            // 企业大类
// 		var sq = eval(cb_comdalei2);
// 		var str ="";
// 		for(var i=0;i<cb_comdalei2.length;i++){
// 		alert(sq[i].id);
// 		alert(sq[i].text);
// $("#plantypeareas").append("<input type='checkbox' name=plantypearea  id='plantypearea"+sq[i].id+"' value='"+sq[i].id+"'> "+sq[i].text+"</input>");
// 		}
        });

        //范围切换(str 为范围标识如按类别COMXIAOLEI)
        function selectplantype(str) {
            $('#plantypeareas').empty();
            gettypes(str);
        }

        //执法计划下拉列表
        function showcomList() {
            for (var i = 0; i < planchecktype.length; i++) {
                $("#planchecktype").append('<option value=\'' + planchecktype[i].id + '\' >' + planchecktype[i].text + '</option>');
            }
            form.render('select');
        }

        //复选框取值
        function funarea() {
            var obj = document.getElementsByName("plantypearea");
            var check_val = '';
            var check = 0;
            for (k in obj) {
                if (obj[k].checked) {
                    check += 1;
                    check_val += obj[k].value + ',';
                }
            }
            if (check == 0) {
                return null;
            }
            return check_val;
        }
        //获取企业类别列表
        function gettypes(str) {
            $.post(basePath + 'supervision/getqiyeType', {
                        type: str
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            if (mydata.length > 0) {
                                for (var i = 0; i < mydata.length; i++) {
                                    $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                }
                                form.render('checkbox');
                            }
                        }
                    }, 'json');

            return true;
        }

        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        //验证编码唯一性
        function checkUniqueness() {
            plancodelod = $('#plancode').val();
            var plancode = $('#plancode').val().toUpperCase();
            if (plancode != null && plancode != "") {
                $.post(basePath + 'supervision/checkCode', {
                            plancode: plancode
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.total;
                                //存在
                                if (mydata > 0) {
                                    layer.msg("编号重复请重新填写");
                                    $('#plancode').val("");
                                    $('#greentext').html("<font color='red' id='greentext'>保证编码唯一</font>");
                                } else {
                                    plancodelod = plancode;
                                    $('#plancode').val(plancode);
                                    $('#greentext').html("<font color='green' id='greentext'>此编号可以使用</font>");
                                }
                            }
                        }, 'json');
            }
        }

        //表单提交
        function submitForm() {
            $("#save").click();
        }

    </script>
</head>

<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">

        <form id="fm" class="layui-form" method="post"style="height: 600px">
            <div class="layui-container">
                <input type="hidden" name="planid" id="planid">

                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px"><font
                                        color="red">*</font>执法计划类型：</label>

                                <div class="layui-input-inline">
                                    <select id="planchecktype" name="planchecktype" required
                                            lay-verify="required"></select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px"><font
                                        color="red">*</font>计划名称：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="plantitle" name="plantitle" required lay-verify="required"
                                           placeholder="名称" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px"><font
                                        color="red">*</font>编号：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="plancode" name="plancode" required lay-verify="required"
                                           autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-input-inline">
                                    <%--<button id="btn_query" class="layui-btn layui-btn-sm layui-btn-normal">--%>
                                    <%--<i class="layui-icon">&#xe6b2;</i>验证--%>
                                    <%--</button>--%>
                                    <font color="red" id="greentext">保证编码唯一</font>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">量化或风险等级:</label>

                                <div class="layui-input-inline">
                                    <select lay-filter="sel_lhfjndpddj_filter" id="lhfjndpddj" name="lhfjndpddj"
                                            >
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px"><font
                                        color="red">*</font>执法时间：</label>

                                <div class="layui-input-inline">
                                    <input type="text" id="plandate" required lay-verify="required" readonly
                                           class="layui-input">
                                </div>
                                <input type="text" id="planstdate" name="planstdate" class="layui-hide" readonly>
                                <input type="text" id="planeddate" name="planeddate" class="layui-hide" readonly>
                            </div>
                        </div>
                        <%--                <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px">执法范围：</label>

                                            <div class="layui-input-inline" style="width: 500px">
                                                <input type="radio" name="plantype" value="1" title="按类别" checked
                                                       autocomplete="off" class="layui-input">
                                                <input type="radio" name="plantype" value="2" title="按区域" disabled
                                                       autocomplete="off" class="layui-input">
                                                <input type="radio" name="plantype" value="3" title="按特定对象" disabled
                                                       autocomplete="off" class="layui-input">
                                            </div>
                                        </div>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label" style="width: 100px"><font color="red">*</font></label>

                                            <div class="layui-input-inline" style="width: 600px">
                                                <div id="plantypeareas"></div>
                                            </div>
                                        </div>--%>
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">内容：</label>

                                <div class="layui-input-inline" style="width: 75%">
                        <textarea style="width:100%; height: 100px" id="plancontent"
                                  name="plancontent"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 100px">备注：</label>

                                <div class="layui-input-inline" style="width: 75%">
                        <textarea rows="" cols="" style="width: 100%;height: 100px" name="planremark"
                                  id="planremark"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item" style="display: none">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="save"
                                    id="save">保存
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>