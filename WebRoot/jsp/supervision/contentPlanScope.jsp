<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,java.net.URLDecoder" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));  //计划id
    String v_plancode = URLDecoder.decode(StringHelper.showNull2Empty(request.getParameter("plancode")), "utf-8");
    String oldplantypearea = StringHelper.showNull2Empty(request.getParameter("plantypearea"));  //计划选择的企业大类
%>
<!DOCTYPE html>
<html>
<head>
    <title>设置执行范围</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        // 设置默认返回值
        var obj = new Object();
        // obj.type = "ok"; // 当为ok时，父页面刷新；不是ok时，不刷新父页面
        // sy.setWinRet(obj);
        //gjf20180312 定义一个存储当一级菜单变化获取的二级的数据
        var b_twotypedata;
        var v_oldplantypearea = "<%=oldplantypearea%>";
        var v_plantypeareaArray = new Array();
        //gu20180322
        var v_panypeareadescArray = new Array();
        //gu20180322

        var str2 = "<tr><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>";
        var str3 = "<tr class='title' id='item3'> </tr>";
        var allitems;
        var olditems;
        var form;
        var table;
        $(function () {
            getitemsByplan();
            layui.use(['form', 'table'], function () {
                form = layui.form;
                form.on('select(oneType)', function (data) {
                    queryTwoPlanDTO('');
                });
                form.on('select(twoType)', function (data) {
                    queryThreePlanDTO('');
                });
                form.on('submit(save)', function (data) {
                    //gu20180312
                    if ($('#twoType').val()) {
                        var v_plantypearea = funarea();

                    } else {
                        var v_plantypearea = null;
                    }

                    var items1 = $("input[name='items']");
                    var items = new Array();
                    for (var i = 0; i < items1.length; i++) {
                        items[i] = items1[i].value;
                    }
                    var planid = $('#planid').val();
                    var formData = {
                        planid: planid,
                        items: items,
                        plantypearea: v_plantypearea
                    }
                    var url = basePath + 'supervision/savePicset';
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: formData,
                        traditional: true,
                        success: function (result) {
                            result = $.parseJSON(result);
                            if (result.code == '0') {
                                layer.msg('保存成功', {time: 500}, function () {
                                    v_oldplantypearea = v_plantypearea;//gu20180325
                                    obj.type = "ok";
                                    sy.setWinRet(obj);
                                    closeWindow();
                                });
                            } else {
                                layer.open({
                                    title: '提示'
                                    , content: '保存失败' + result.msg
                                });
                            }
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                })
            })
        });
        //复选框取值
        function funarea() {
            var  selectcheck = $("input:checkbox[name='plantypeareacbx']:checked").map(function(index,elem) {
                return $(elem).val();
            }).get().join(',');
            return selectcheck;
        }
        //复选框取值
        function funarea_bak() {
            var obj = document.getElementsByName("plantypeareacbx");
            var check_val = '';
            var check = 0;
            for (k in obj) {
                if (obj[k].checked) {
                    check += 1;
                    check_val += obj[k].value + ',';
                    alert(check_val);
                }
            }
            if (check == 0) {
                return null;
            }
            return check_val;
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        //表单提交
        function submitForm() {
            if ($('#twoType').val()) {
                if (v_plantypeareaArray) {
                    var v_plantypearea = funarea();
                    if (v_plantypearea == null) {
                        layer.msg('企业分类不能为空', {icon: 5, shade: 0, time: 2000, anim: 6});
                        $('#plantypeareas').css('border', 'solid 1px red');
                        return false;
                    }
                }
            }
            $("#save").click();
        }

        //获取计划信息关联的执行项
        function getitemsByplan() {
            var planid = "<%=v_planid%>";
            $.post(basePath + 'supervision/getPlansByid', {
                        planid: planid
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            if (mydata.length > 0) {
                                //获得一类
                                olditems = mydata;
                                queryOnePlanDTO(mydata);
                            } else {
                                //获得一类
                                queryOnePlanDTO("");
                                //获得二类
                                queryTwoPlanDTO("");
                            }
                        }
                    }, 'json');
        }

        //查询项对象
        function getitemsByid(str) {
            $.post(basePath + 'supervision/getitemsByid', {
                        itemid: str[0].itempid
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            $("#oneType").val(mydata.itempid);
                            queryTwoPlanDTO(str);
                        }
                    }, 'json');
        }
        //获得一级分类
        function queryOnePlanDTO(str) {
            $.post(basePath + 'supervision/queryOnePlanDTO', {
                        itempid: '0000000000000000000000000'
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            $('#oneType').append("<option   value=''>--请选择--</option>");
                            for (var i = 0; i < mydata.length; i++) {
                                $('#oneType').append("<option   value='" + mydata[i].itemid + "'>" + mydata[i].itemname + "</option>");
                            }
                            form.render('select');
                            //有数值
                            if (str != null && str != "") {
                                getitemsByid(str);
                            }
                        }
                    }, 'json');
        }
        //二级类别
        function queryTwoPlanDTO(str) {
            var checkValue = $("#oneType").val();
            if (checkValue == "" || checkValue == null) {
                var oldvalue = $('#selecttext').val();
                $('#twoType').empty();
                $('#twoTypeselect').css('display', 'none');
                $('#zhifafanwei').css('display', 'none');
                if (oldvalue != null && oldvalue != "") {
                    $('.' + oldvalue).css('display', 'none');
                }
                allitems = "";
            } else {
                $('#oneitempid').val(checkValue);
                $('#twoTypeselect').css('display', '');
                $('#zhifafanwei').css('display', 'none');
                //隐藏
                var oldvalue = $('#selecttext').val();
                if (oldvalue != null && oldvalue != "") {
                    $('.' + oldvalue).css('display', 'none');
                }
                $.post(basePath + 'supervision/queryOnePlanDTO', {
                            itempid: checkValue
                        },
                        function (result) {
                            if (result.code == '0') {
                                //var mydata = result.data;
                                b_twotypedata = result.data;//gu20180324
                                if (b_twotypedata.length > 0) {
                                    $('#twoType').empty();
                                    $('#twoType').append("<option   value=''>--请选择--</option>");
                                    for (var i = 0; i < b_twotypedata.length; i++) {
                                        $('#twoType').append("<option   value='" + b_twotypedata[i].itemid + "'>" + b_twotypedata[i].itemname + "</option>");
                                    }
                                    form.render('select');
                                    //有数值
                                    if (str != null && str != "") {
                                        $("#twoType").val(str[0].itempid);
                                        queryThreePlanDTO(str);
                                    }
                                } else {
                                    $('#twoType').empty();
                                    $('#twoTypeselect').css('display', 'none');
                                }
                            }
                        }, 'json');

            }
        }

        function getPlanTypeAreaFromTwotype(prm_itemid) {
            var v_area;
            var v_areadesc;
            for (var i = 0; i < b_twotypedata.length; i++) {
                if (b_twotypedata[i].itemid == prm_itemid) {
                    v_area = b_twotypedata[i].plantypearea;
                    v_areadesc = b_twotypedata[i].plantypeareadesc;
                    if (v_area != null && v_area != '') {
                        if (v_area.length > 0) {
                            v_plantypeareaArray = v_area.split(",");
                            v_panypeareadescArray = v_areadesc.split(",");
                        }
                    } else {
                        v_plantypeareaArray = null;
                        v_panypeareadescArray = null;
                    }
                }
            }
        }

        //获取企业类别列表
        function getqiyetypes(prm_itemid) {
            document.getElementById("zhifafanwei").style.display = "";
            $("#plantypeareas").empty();
            getPlanTypeAreaFromTwotype(prm_itemid);
            if (v_plantypeareaArray != null) {
                if (v_plantypeareaArray.length > 0) {
                    for (var i = 0; i < v_plantypeareaArray.length; i++) {
                        if (v_oldplantypearea.length > 0) {
                            if (v_oldplantypearea.indexOf(v_plantypeareaArray[i]) >= 0) {
                                $("#plantypeareas").append("<input type='checkbox' checked='checked' name='plantypeareacbx' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
                            } else {
                                $("#plantypeareas").append("<input type='checkbox' name='plantypeareacbx' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
                            }
                        } else {
                            $("#plantypeareas").append("<input type='checkbox' name='plantypeareacbx' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
                        }
                    }
                    form.render('checkbox');
                }
            } else {
                $('#zhifafanwei').css('display', 'none');
            }

            /*            $.post(basePath + 'supervision/getqiyeType', {
             type: 'COMDALEI',
             querykind:'1',
             itemid:prm_itemid
             },
             function (result) {
             if (result.code == '0') {
             var mydata = result.data;
             if (mydata.length > 0) {
             for (var i = 0; i < mydata.length; i++) {
             if (v_oldplantypearea.length > 0) {
             if (v_oldplantypearea.indexOf(mydata[i].id) >= 0) {
             $("#plantypeareas").append("<input type='checkbox' checked='checked' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
             } else {
             $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
             }
             } else {
             $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
             }
             }
             form.render('checkbox');
             }
             }
             }, 'json');*/

            return true;
        }

        //三级类别
        function queryThreePlanDTO(str) {
            var checkValue = $("#twoType").val();
            var oldvalue = $('#selecttext').val();
            if (checkValue == "" || checkValue == null) {
                $('#zhifafanwei').css('display', 'none');
                $('#item2').empty();
                $('#item4').empty();
                var str1 = "<tr><td style='text-align: center' colspan='3'><font style='font-size: 14px;' color='red'>请选择检查项" +
                        "</font></td></tr><tr><td style='width: 12%'><input type='checkbox' id='allitems' onclick='allyouyi()'" +
                        " value=''/>选择</td><td style='text-align: center;width: 35%'>执法项</td><td style='text-align: center;" +
                        "width: 25%'>编号</td></tr>";
                $('#item2').append(str1);
                $('#item4').append(str2).append(str3);
                allitems = "";
            } else {
                $('#twoitempid').val(checkValue);
//                $('#item4').empty();
//                $('#item4').append(str2).append(str3);
                $.post(basePath + 'supervision/queryThreePlanDTO', {
                            itempid: checkValue,
                            page: 5
                        },
                        function (result) {
                            if (result.code == '0') {
                                //gjf20180312
                                getqiyetypes(checkValue);

                                var mydata = result.data;
                                var mytotal = result.total;
                                if (mydata.length > 0) {
                                    allitems = mydata;
                                    if (oldvalue != null && oldvalue != "") {
                                        $('.' + oldvalue).css('display', 'none');
                                        $('.' + checkValue).css('display', '');
                                    }
                                    for (var i = 0; i < mydata.length; i++) {
                                        $('#item2').append("<tr  class='" + mydata[i].itempid + "' ><td><input type='checkbox' onclick=\"youyi('" + mydata[i].contentid + "','" + mydata[i].content + "','" + mydata[i].itemid + "','" + mydata[i].itemname + "')\" name='itmes1' id='" + mydata[i].contentid + "a' value='" + mydata[i].contentid + "&" + mydata[i].itemid + "'  /></td><td>" + mydata[i].content + "<font color='red'>[" + mydata[i].itemname + "]</font></td><td>" + mydata[i].contentid + "</td></tr>");
                                    }
                                    form.render();
                                    //有数值
                                    if (olditems != null && olditems != "") {
                                        for (var d = 0; d < olditems.length; d++) {
                                            if ($('#' + olditems[d].contentid + "a").prop("checked")) {

                                            } else {
                                                //右面没有相应id是否存在，说明用户取消了就不选中
                                                if ($('#' + olditems[d].contentid).length > 0) {
                                                    $('#' + olditems[d].contentid + "a").prop("checked", true);
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    $('#item2').empty();
                                }
                                //有数值
                                if (str != null && str != "") {
                                    for (var f = 0; f < str.length; f++) {
                                        $('#' + str[f].contentid + "a").prop("checked", true);
                                    }
                                    //右侧数据
                                    edityouyi(str);
                                }
                            }
                        }, 'json');

                $('#selecttext').val(checkValue);
            }
        }
        //有数值显示
        function edityouyi(str) {
            if (str != null && str != "") {
                for (var f = 0; f < str.length; f++) {
                    $('#item4').append("<tr class='item_4' id='" + str[f].contentid + "' ><td><input type='hidden'  name='items' value='" + str[f].contentid + "&" + str[f].itemid + "'  />" + str[f].content + "<font color='red'>[" + str[f].itemname + "]</font></td><td>" + str[f].contentid + "</td></tr>");
                }
            }
        }
        //往右增加
        function youyi(contentid, content, itemid, itemname) {
            if ($('#' + contentid + "a").prop("checked")) {
                //往右增加
                $('#item3').before("<tr class='item_3' id='" + contentid + "' ><td><input type='hidden'  name='items' value='" + contentid + "&" + itemid + "'  />" + content + "<font color='red'>[" + itemname + "]</font></td><td>" + contentid + "</td></tr>");
            } else {
                $('#' + contentid).remove();
            }
        }

        //全部右移
        function allyouyi() {
            if ($('#allitems').prop("checked")) {
                //全部选中
                for (var i = 0; i < allitems.length; i++) {
                    if ($('#' + allitems[i].contentid + "a").prop("checked")) {

                    } else {
                        $('#' + allitems[i].contentid + "a").prop("checked", true);
                        $('#item3').before("<tr class='item_3' id='" + allitems[i].contentid + "' ><td><input type='hidden'  name='items' value='" + allitems[i].contentid + "&" + allitems[i].itemid + "'  />" + allitems[i].content + "<font color='red'>[" + allitems[i].itemname + "]</font></td><td>" + allitems[i].contentid + "</td></tr>");

                    }
                }
            } else {
                //全部取消
                for (var i = 0; i < allitems.length; i++) {
                    $('#' + allitems[i].contentid + "a").prop("checked", false);
                    $('#' + allitems[i].contentid).remove();
                }
            }
        }
    </script>

</head>

<body>
<div class="layui-fluid">
    <div style="width: 99%;" class="layui-table">
        <input type="hidden" name="selecttext" id="selecttext" value="">

        <form class="layui-form">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <select id="oneType" name="oneType" lay-filter="oneType"></select>
                </div>
                <div id="twoTypeselect" class="layui-input-inline" style="display: none">
                    <select name="twoType" id="twoType" lay-filter="twoType"></select>
                </div>
                <div id="zhifafanwei" class="layui-input-inline" style="width: 600px;display:none">
                    <label class="layui-form-label" style="width: 100px"><font color="red">*</font>企业分类：</label>

                    <div id="plantypeareas"></div>
                </div>
            </div>
        </form>
        <div style="width: 95%;">

            <table class="table" id="item2" style="width: 50%;float: left;">
                <tr>
                    <td style="text-align: center" colspan="3"><font style="font-size: 14px;" color="red">请选择检查项</font>
                    </td>
                </tr>
                <tr>
                    <td style="width: 12%"><input type="checkbox" id="allitems" onclick="allyouyi()" value=""/>选择</td>
                    <td style="text-align: center;width: 35%">执法项</td>
                    <td style="text-align: center;width: 25%">编号</td>
                </tr>
            </table>

            <div style="width: 2%"></div>
            <form id="fm" method="post">
                <input type="hidden" name="planid" id="planid" value="<%=v_planid%>">
                <input type="hidden" name="plancode" id="plancode" value="<%=v_plancode%>">
                <input type="hidden" name="oneitempid" id="oneitempid" value="" readonly="readonly">
                <input type="hidden" name="twoitempid" id=twoitempid value="" readonly="readonly">
                <table style="width:45%;float: right;">
                    <tr>
                        <td style="text-align: center"><font style="font-size: 14px;" color="blue">已经选中的检查项</font></td>
                    </tr>
                </table>
                <table class="table" id="item4" style="width:45%;float: right;">
                    <tr>
                        <td style="text-align: center;">执法项</td>
                        <td style="text-align: center;">编号</td>
                    </tr>
                    <tr class="title" id="item3">
                    </tr>
                </table>
                <div class="layui-form-item" style="display: none">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="save"
                                id="save">保存
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>