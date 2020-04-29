<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    String v_planid = StringHelper.showNull2Empty(request.getParameter("planid"));  //计划id
    String v_op = StringHelper.showNull2Empty(request.getParameter("op"));  //计划id
    String oldplantypearea = StringHelper.showNull2Empty(request.getParameter("plantypearea"));  //计划选择的企业大类
//    String v_canedit = StringHelper.showNull2Empty(request.getParameter("canedit"));  //是否可以修改0不可1可以
//    if ("".equals(v_canedit)){
//        v_canedit="1";
//    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>修改计划信息</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <script type="text/javascript">
        //gjf20180312 定义一个存储当一级菜单变化获取的二级的数据
        var v_lhfjndpddj = <%=SysmanageUtil.getAa10toJsonArray("LHFJNDPDDJ")%>;
        var b_twotypedata;
        var v_oldplantypearea = "<%=oldplantypearea%>";
        var v_plantypeareaArray = new Array();
        ;//gu20180322
        var v_panypeareadescArray = new Array();
        ;//gu20180322

        // 企业大类
        var planchecktype = <%=SysmanageUtil.getAa10toJsonArray("ITEMTYPE")%>;
        var cb_planchecktype; // 执法计划类别
        var form;
        var laydate;
        var table;

        $(function () {
            layui.use(['form', 'laydate', 'element', 'table'], function () {
                form = layui.form;
                laydate = layui.laydate;
                var element = layui.element;

                laydate.render({//执法时间处理
                    elem: '#plandate'
                    , range: '~'
                    , done: function (value, date, endDate) {
                        var val = value.split('~');
                        $('#planstdate').val(val[0]);
                        $('#planeddate').val(val[1]);
                    }
                });

                var v_lhfj = "${obj.data.lhfjndpddj}";
                $("#lhfjndpddj").val(v_lhfj);

                if ($('#planid').val().length > 0) {
                    var plantypearea = '${obj.data.plantypearea }'.split(',');
                    // 企业大类
                    gettypes("COMDALEI", plantypearea);

                    if ('<%=v_op%>' == 'view') {
                        $('#item2').css('display', 'none');
                        $('#selectItems').css('display', 'none');
                        $('form :input').attr('disabled', 'disabled');
                        $('#planchecktype').attr('disabled', 'disabled');
                        $('#item5').css('display', '');
                        $('#item4').css('display', 'none');
                        //执行项数据
                        viewyouyi();
                        form.render();
                    } else {
                        getitemsByplan();
                    }
                }
                ;
                showcomList();//执法计划下拉列表
                // g_layselectPutSelectData("lhfjndpddj",v_lhfjndpddj);
                showcomListnew();

            })
        });


        //执法计划下拉列表
        function showcomList(value) {
            intSelectData('planchecktype', planchecktype);
//            for (var i = 0; i < planchecktype.length; i++) {
//                $("#planchecktype").append('<option value=\'' + planchecktype[i].id + '\' >' + planchecktype[i].text + '</option>');
//            }
            var value = $('#plancheck').val();
            $('#planchecktype').val(value);
            form.render('select');
        }

        function showcomListnew() {
            intSelectData('lhfjndpddj', v_lhfjndpddj);
//            for (var i = 0; i < v_lhfjndpddj.length; i++) {
//                $("#lhfjndpddj").append('<option value=\'' + v_lhfjndpddj[i].id + '\' >' + v_lhfjndpddj[i].text + '</option>');
//            }
            var value = $('#lhfj').val();
            $('#lhfjndpddj').val(value);
            form.render('select');
        }
        //获取企业类别列表
        function gettypes(str, oldvalue) {
            $.post(basePath + 'supervision/getqiyeType', {
                        type: str
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            if (mydata == null || mydata == '') {
                                $('#zhifafanwei').css('display', 'none');
                                return false;
                            }
                            if (mydata.length > 0) {
                                for (var i = 0; i < mydata.length; i++) {
                                    if ('<%=v_op%>' == 'view') {
                                        if (oldvalue.length > 0) {
                                            if (oldvalue.indexOf(mydata[i].id) >= 0) {
                                                $("#plantypeareas").append("<input type='checkbox' checked='checked' disabled name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                            } else {
                                                $("#plantypeareas").append("<input type='checkbox' disabled name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                            }
                                        } else {
                                            $("#plantypeareas").append("<input type='checkbox' disabled name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                        }
                                    } else {
                                        if (oldvalue.length > 0) {
                                            if (oldvalue.indexOf(mydata[i].id) >= 0) {
                                                $("#plantypeareas").append("<input type='checkbox' checked='checked' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                            } else {
                                                $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                            }
                                        } else {
                                            $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + mydata[i].id + "' value='" + mydata[i].id + "' title='" + mydata[i].name + " '/>");
                                        }
                                    }
                                }
                                form.render("checkbox");
                            }
                        }
                    }, 'json');
            return true;
        }

        // 关闭窗口
        var closeWindow = function ($dialog, $pjq) {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        };

        //有数值显示(查询出父类名称)
        function viewyouyi() {
            var planid = "<%=v_planid%>";
            $.post(basePath + 'supervision/getPlansAndpidnameByid', {
                        planid: planid
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
                            if (mydata.length > 0) {
                                $('#item5').append("<tr><td>执法项</td><td>编号</td></tr>");
                                for (var f = 0; f < mydata.length; f++) {
                                    $('#item5').append("<tr class='item_4' id='" + mydata[f].contentid + "' ><td><input type='hidden'  name='items' value='" + mydata[f].contentid + "&" + mydata[f].itemid + "'  />" + mydata[f].contentcode + "." + mydata[f].content + "<font color='blue'>[" + mydata[f].itemname + "]<font color='red'>[" + mydata[f].itempidname + "]</font></td><td>" + mydata[f].contentid + "</td></tr>");
                                }
                            } else {

                            }
                        }
                    }, 'json');
        }
    </script>
    <script type="text/javascript">
        var str2 = "<tr><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>";
        var str3 = "<tr class='title' id='item3'> </tr>";
        var allitems;
        var olditems;
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        $(function () {
//            getitemsByplan();
            layui.use(['form', 'table'], function () {
                form = layui.form;
                form.on('select(oneType)', function (data) {
                    queryTwoPlanDTO('');
                });
                form.on('select(twoType)', function (data) {
                    queryThreePlanDTO('');
                });
                form.on('submit(save)', function (data) {
                    var url = basePath + 'supervision/updatePlan';
                    /* gu20180312                   var plantypearea = funarea();
                     if (plantypearea == null) {
                     layer.msg('必填项不能为空', {icon: 5, shade: 0, time: 2000, anim: 6});
                     $('#plantypeareas').css('border', 'solid 1px red');
                     return false;
                     }*/
                    //gu20180312
                    if ($('#twoType').val()) {
                        var v_plantypearea = funarea();
                    } else {
                        var v_plantypearea = null;
                    }

                    var planid = $('#planid').val();
                    var planchecktype = $('#planchecktype').val();//执法计划类型
                    var plantitle = $('#plantitle').val();//计划名称
                    var plancode = $('#plancode').val();//编号
                    var planstdate = $('#planstdate').val();//执法开始时间
                    var planeddate = $('#planeddate').val();//执法结束时间
                    //var plantype = $("input[name='plantype']:checked").val();
                    var plantype = "1";//按区域
                    var plancontent = $('#plancontent').val();//内容
                    var planremark = $('#planremark').val();//备注
                    var items1 = $("input[name='items']");//执法项

                    var items = new Array();
                    for (var i = 0; i < items1.length; i++) {
                        items[i] = items1[i].value;
                    }
                    if (items1.length == 0) {

                    }
                    var formData = {
                        plantypearea: v_plantypearea,
                        planid: planid,
                        planchecktype: planchecktype,
                        plantitle: plantitle,
                        plancode: plancode,
                        planstdate: planstdate,
                        planeddate: planeddate,
                        plantype: plantype,
                        plancontent: plancontent,
                        planremark: planremark,
                        items: items,
                        lhfjndpddj: $('#lhfjndpddj').val()//量化等级风险
                    }
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: formData,
                        traditional: true,
                        success: function (result) {
                            result = $.parseJSON(result);
                            if (result.code == '0') {
                                layer.msg('保存成功', {time: 1000}, function () {
                                    v_oldplantypearea = v_plantypearea;//gu20180325
                                    var obj = new Object();
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
        })
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

        //表单提交
        function submitForm() {
            if ($('#twoType').val()) {
                if (v_plantypeareaArray) {
                    var v_plantypearea = funarea();
                    if (v_plantypearea == null) {
                        layer.msg('企业分类不能为空', {icon: 5, shade: 0, time: 1000, anim: 6});
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
                $.post(basePath + 'supervision/queryOnePlanDTO',
                        {
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
        ;

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
        ;


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
                                $("#plantypeareas").append("<input type='checkbox' checked='checked' name='plantypearea' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
                            } else {
                                $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
                            }
                        } else {
                            $("#plantypeareas").append("<input type='checkbox' name='plantypearea' id='" + v_plantypeareaArray[i] + "' value='" + v_plantypeareaArray[i] + "' title='" + v_panypeareadescArray[i] + " '/>");
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
        ;


        //三级类别
        function queryThreePlanDTO(str) {
            var checkValue = $("#twoType").val();
            var oldvalue = $('#selecttext').val();
            if (checkValue == "" || checkValue == null) {
                $('#zhifafanwei').css('display', 'none');
                $('#item2').empty();
                $('#item4').empty();
                var str1 = "<tr ><td><input type='checkbox' id='allitems'  name='' value='' onclick=\"allyouyi()\"  />选择</td><td style='text-align: center;'>执法项</td><td style='text-align: center;'>编号</td></tr>"
                $('#item2').append(str1);
                $('#item4').append(str2).append(str3);
                allitems = "";
            } else {
                $('#twoitempid').val(checkValue);
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
                                if (mydata != "" && mydata != null) {
                                    allitems = mydata;
                                    if (oldvalue != null && oldvalue != "") {
                                        $('.' + oldvalue).css('display', 'none');
                                        $('.' + checkValue).css('display', '');
                                    }
                                    for (var i = 0; i < mydata.length; i++) {
                                        $('#item2').append("<tr  class='" + mydata[i].itempid + "' ><td><input type='checkbox' onclick=\"youyi('" + mydata[i].contentid + "','" + mydata[i].content + "','" + mydata[i].itemid + "','" + mydata[i].itemname + "')\" name='itmes1' id='" + mydata[i].contentid + "a' value='" + mydata[i].contentid + "&" + mydata[i].itemid + "'  /></td><td>" + +mydata[i].contentcode+mydata[i].content + "<font color='red'>[" + mydata[i].itemname + "]</font></td><td>" + mydata[i].contentid + "</td></tr>");
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
                        $('#item3').after("<tr class='item_3' id='" + allitems[i].contentid + "' ><td><input type='hidden'  name='items' value='" + allitems[i].contentid + "&" + allitems[i].itemid + "'  />" + allitems[i].content + "<font color='red'>[" + allitems[i].itemname + "]</font></td><td>" + allitems[i].contentid + "</td></tr>");

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
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">计划信息</h2>

            <div class="layui-colla-content layui-show">
                <form id="fm1" class="layui-form" method="post">
                    <div class="layui-container">
                        <input type="hidden" name="planid" id="planid" value="<%=v_planid %>">

                        <div class="layui-row">
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px"><font color="red">*</font>执法计划类型：</label>

                                    <div class="layui-input-inline">
                                        <select id="planchecktype" name="planchecktype" lay-verify="required"></select>
                                    </div>
                                    <input type="hidden" id="plancheck" value="${obj.data.planchecktype }">
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px"><font color="red">*</font>计划名称：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="plantitle" name="plantitle" lay-verify="required"
                                               placeholder="名称"
                                               autocomplete="off" class="layui-input" value="${obj.data.plantitle }">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px"><font
                                            color="red">*</font>编号：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="plancode" name="plancode" readonly
                                               autocomplete="off" class="layui-input layui-bg-gray"
                                               value="${obj.data.plancode }"
                                                >
                                    </div>
                                </div>
                            </div>
                            <%--<div class="layui-input-inline">--%>
                            <%--<input type="button" class="layui-btn layui-btn-sm layui-btn-disabled"--%>
                            <%--value="验证">--%>
                            <%--<font color="red" id="greentext">保证编码唯一</font>--%>
                            <%--</div>--%>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px">量化或风险等级:</label>

                                    <div class="layui-input-inline">
                                        <select lay-filter="sel_lhfjndpddj_filter" id="lhfjndpddj" name="lhfjndpddj"
                                                value="${obj.data.lhfjndpddj }">
                                        </select>
                                    </div>
                                    <input type="hidden" id="lhfj" value="${obj.data.lhfjndpddj }">
                                </div>
                            </div>
                            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width: 100px"><font color="red">*</font>执法时间：</label>

                                    <div class="layui-input-inline">
                                        <input type="text" id="plandate" lay-verify="required" readonly
                                               class="layui-input" lay-verify="required"
                                               value="${fn:substring(obj.data.planstdate,0,10) } ~ ${fn:substring(obj.data.planeddate,0,10) }">
                                    </div>
                                    <input type="hidden" id="planstdate" name="planstdate" readonly
                                           value="${fn:substring(obj.data.planstdate,0,10) }">
                                    <input type="hidden" id="planeddate" name="planeddate" readonly
                                           value="${fn:substring(obj.data.planeddate,0,10) }">
                                </div>
                            </div>
                            <%--gu20180312                <div class="layui-form-item">
                                                <label class="layui-form-label" style="width: 100px"><font color="red">*</font>执法范围：</label>

                                                <div class="layui-input-inline" style="width: 500px">
                                                    <input type="radio" name="plantype" value="1" title="按类别" checked
                                                           autocomplete="off" class="layui-input">
                                                    <<input type="radio" name="plantype" value="2" title="按区域" disabled
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

                                    <div class="layui-input-inline" style="width: 78%">
                        <textarea rows="" cols="" style="width: 100%;height: 100px" id="plancontent"
                                  name="plancontent">${obj.data.plancontent }</textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                                <div class="layui-form-item">
                                    <label class="layui-form-label" style="width:100px">备注：</label>

                                    <div class="layui-input-inline" style="width: 78%">
                        <textarea rows="" cols="" style="width: 100%;height: 100px" name="planremark"
                                  id="planremark">${obj.data.planremark }</textarea>
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
                </form>
            </div>
        </div>
    </div>
    <div class="layui-collapse">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title">执法项设置</h2>

            <div class="layui-colla-content layui-show" style="position: absolute;width: 100%;">
                <div class="layui-table" style="width: 99%;">
                    <input type="hidden" name="selecttext" id="selecttext" value="">

                    <div style="width: 100%;" id="selectItems">
                        <form class="layui-form">
                            <div class="layui-form-item" style="width: 100%;">
                                <div class="layui-input-inline">
                                    <select id="oneType" name="oneType" lay-filter="oneType"></select>
                                </div>
                                <div id="twoTypeselect" class="layui-input-inline" style="display: none">
                                    <select name="twoType" id="twoType" lay-filter="twoType"></select>
                                </div>
                                <div id="zhifafanwei" class="layui-input-inline" style="width: 600px;display:none">
                                    <label class="layui-form-label" style="width: 100px"><font
                                            color="red">*</font>企业分类：</label>

                                    <div id="plantypeareas"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div style="width: 95%">
                        <table class="table" id="item2" style="width: 50%;float: left;">
                            <tr>
                                <td style="width: 70px"><input type="checkbox" id="allitems" onclick="allyouyi()"
                                                              value=""/>选择
                                </td>
                                <td style="text-align: center;width: 300px">执法项</td>
                                <td style="text-align: center;width: 200px">编号</td>
                            </tr>
                        </table>

                        <div style="width: 2%"></div>
                        <form id="fm" method="post">
                            <input type="hidden" name="oneitempid" id="oneitempid" value="" readonly="readonly">
                            <input type="hidden" name="twoitempid" id=twoitempid value="" readonly="readonly">
                            <table class="table" id="item5" style="width:99%;text-align: center;display: none">
                                <table class="table" id="item4" style="width:45%;float: right;">
                                    <tr>
                                        <td style="text-align: center;width: 300px">执法项</td>
                                        <td style="text-align: center;width: 200px">编号</td>
                                    </tr>
                                    <tr class="title" id="item3">
                                    </tr>
                                </table>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>