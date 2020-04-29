<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
    String v_userdalei = sysuser.getUserdalei();//1非企业用户2企业用户
    String name = sysuser.getUsername();//获取当前登录用户

%>
<%
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
    String v_comid = StringHelper.showNull2Empty(request.getParameter("comid"));  //企业id
    String sh = StringHelper.showNull2Empty(request.getParameter("sh"));  //审核
    String v_comid2 = "nocomid";
    if (v_comid != null && !"".equalsIgnoreCase(v_comid)) {
        v_comid2 = v_comid;
    }
    String v_iframeUrl = basePath + "/jsp/baseinfo/pcompany/pcomZzzm.jsp?op=view&comid=" + v_comid2;
    String v_piciframeUrl = basePath + "/pub/pub/delFjViewIndex?op=view&fjwid=" + v_comid2 + "&fjtype=1&ZuoWeiIframe=1";

%>
<!DOCTYPE html>
<html>
<head>
    <title><title>企业信息</title>
    </title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="true"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var v_comspjkbz = <%=SysmanageUtil.getAa10toJsonArray("COMSPJKBZ")%>;
        // 企业大类
        //var comdalei = <%=SysmanageUtil.getAa10ComdaleiGrant("COMDALEI","")%>;
        // 企业小类
        var comxiaolei = <%=SysmanageUtil.getAa10toJsonArray("COMXIAOLEI")%>;
        // 店面类型
        var comdmlx = <%=SysmanageUtil.getAa10toJsonArray("COMDMLX")%>;
        // 特色菜系
        var comtscx = <%=SysmanageUtil.getAa10toJsonArray("COMTSCX")%>;
        // 审核标志
        var comshbz = <%=SysmanageUtil.getAa10toJsonArray("CAE092")%>;
        // 检验检测单位标志
        //var comjyjcbz = <%=SysmanageUtil.getAa10toJsonArray("COMJYJCBZ")%>;
        // 资质证明
        //var comzzzm = <%=SysmanageUtil.getAa10toJsonArray("COMZZZM")%>;
        //var cb_comdalei; // 企业大类
        //var cb_comxiaolei; // 企业小类
        var cb_comshbz; // 企业审核标志
        var cb_comjyjcbz; // 企业检验检测标志
        var cb_comshengdm; // 省代码
        var cb_comdmlx; // 店面类型
        var cb_comtscx; // 特色菜系
        var cb_comzzzm; // 资质证明
        var form; // form表单（查询条件）
        var layer; // 弹出层
        var laydate;
        $(function () {
            intSelectData('comspjkbz', v_comspjkbz);
            layui.use(['form', 'layer', 'laydate'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                laydate.render({
                    elem: '#comclrq'
                });
                form.verify({
//                    tel: function (value, item) {
//                        if (!new RegExp("^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$").test(value)) {
//                            return '固定电话号码格式不正确，请使用下面的格式：020-88888888';
//                        }
//                    }
                    comzzjgdm: function (value, item) {
                        if (new RegExp(/[\u4E00-\u9FA5\uF900-\uFA2D]/).test(value)) {
                            return '请输入正确格式';
                        }
                    }
                    , comyzbm: function (value, item) {
                        if (!new RegExp("^[0-9]\\d{5}$").test(value)) {
                            return '邮编格式不正确';
                        }
                    }
                });
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(saveRole)', function (data) {
                    var formData = data.field;
                    formData['orderno']=$('#orderno').val();
                    /*console.log(formData)*/
                    if (!lock) {    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + 'pcompany/savePcompany', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                if ('' == '<%=op%>') {
                                    obj.type = "saveOk";
                                } else {
                                    obj.type = "ok";
                                }
                                sy.setWinRet(obj);
                                closeWindow();
                            });

                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock = true;//业务逻辑执行失败了，打开锁
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                //将数据加载到编辑页面的表单中
                var v_comid = '<%=v_comid%>';
                if (v_comid != null && v_comid != "") {
                    $.post(basePath + 'pcompany/queryPcompanyDTO', {
                                comid: v_comid   //(将数据库中值通过此id传给前段页面)
                            },
                            function (result) {
                                if (result.code == '0') {
                                    var mydata = result.data;
                                    for (var attr in mydata) {
                                        $("#" + attr).val(mydata[attr]);
                                    }
//                                    $('form').form('load', result.data);
                                    form.render();
                                    //$('#comdalei').combobox('setValues',eval("["+mydata.comdalei2+"]"));
                                    var qymtzpath = $("#qymtzpath").val();
                                    if (qymtzpath != "") {
                                        $("#qymtz").attr("src", "<%=contextPath%>" + qymtzpath);
                                    }
                                    ;
                                } else {
                                    layer.open({
                                        title: "提示",
                                        content: "查询失败：" + result.msg //这里content是一个普通的String
                                    });
                                }

                            }, 'json');

                    if ('<%=op%>' == 'view' || '<%=sh%>' == 'exam') {
                        $('form :input').addClass('input_readonly');
                        $('form :input').attr('readonly', 'readonly');
                        $('.Wdate').attr('disabled', true);
                        $("#btnselectcom").css('display', 'none');
                        $("#mySelectComfenlei").css('display', 'none');
                        $('#dtdw').css('display', 'none');
                        $('#btn_rcjdglry').css('display', 'none');
                        $('#comclrq').attr('disabled', true);
                        $('#comspjkbz').attr('disabled', true);
                        $('#remove').css('display', 'none');
                        $("a").each(function (index, object) {
                            if (object.id != "btn_close") {
                                object.removeAttribute("onclick");
                            }
                            ;
                        });
                        //showUploadFj($('#comid').val());
                    }
                    ;
                    myshowOrHide("");
                }
            });
//		myshowOrHide("");
        });/////////////////////////////////////////

        //判断4品1械
        function mycheckSpyx(prm_comdalei) {
            var v_ret = "9";
            var v_comdalei;
            if (prm_comdalei != null && prm_comdalei != "") {
                v_comdalei = prm_comdalei.split("|");
                for (var i = 0; i < v_comdalei.length; i++) {
                    if (v_comdalei[i].indexOf("101") >= 0) {
                        v_ret = "1";
                        break;
                    }
                }
            }
            return v_ret;
        }

        function myshowOrHide(prm_comdalei) {
            var v_dalei;
            v_dalei = prm_comdalei;
            if (v_dalei.length == 0) {
//	    v_dalei=$("#comdalei").combobox("getValue");
            }
            //if(v_dalei=="6" || v_dalei=="7"|| v_dalei=="13"|| v_dalei=="14"|| v_dalei=="15"|| v_dalei=="16"|| v_dalei=="17"){
            var v_spyx = mycheckSpyx(prm_comdalei);
            if (v_spyx == "1") {
                document.getElementById("cyqyyincang").style.display = "";
            } else {
                document.getElementById("cyqyyincang").style.display = "none";
            }
        }
        ;
        function submitForm() {
            if ($('#comyzbm').val()) {
                $('#comyzbm').attr('lay-verify', 'comyzbm');
            } else {
                $('#comyzbm').removeAttr('lay-verify', 'comyzbm');
            }
            if ($('#comemail').val()) {
                $('#comemail').attr('lay-verify', 'email');
            } else {
                $('#comemail').removeAttr('lay-verify', 'email');
            }
            if ($('#comfrsfzh').val()) {
                $('#comfrsfzh').attr('lay-verify', 'identity');
            } else {
                $('#comfrsfzh').removeAttr('lay-verify', 'identity');
            }
            if ($('#comyddh').val()) {
                $('#comyddh').attr('lay-verify', 'phone');
            } else {
                $('#comyddh').removeAttr('lay-verify', 'phone');
            }
            if ($('#comzczj').val()) {
                $('#comzczj').attr('lay-verify', 'number');
            } else {
                $('#comzczj').removeAttr('lay-verify', 'number');
            }
            $("#saveRoleBtn").click();
        }
        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }


        // 从地区下拉树中读取
        function myselectarea() {
            var url = "<%=basePath%>pub/pub/selectareaIndex?a=" + new Date().getMilliseconds();
            var dialog = parent.sy.modalDialog({
                title: ' ',
                param: {
                    singleSelect: "true"
                },
                width: 800,
                height: 600,
                url: url
            }, function (dialogID) {
                var v_retSt = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少


                if (v_retSt != null) {
                    $("#comshengmc").val(v_retSt.comshengmc); // 省名称
                    $("#comshimc").val(v_retSt.comshimc); // 市名称
                    $("#comxianmc").val(v_retSt.comxianmc); // 县名称
                    $("#comxiangmc").val(v_retSt.comxiangmc); // 乡名称
                    $("#comcunmc").val(v_retSt.comcunmc); // 村名称
                    $("#comshengdm").val(v_retSt.comshengdm); // 省代码
                    $("#comshidm").val(v_retSt.comshidm); // 市代码
                    $("#comxiandm").val(v_retSt.comxiandm); // 县代码
                    $("#comxiangdm").val(v_retSt.comxiangdm); // 乡代码
                    $("#comcundm").val(v_retSt.comcundm); // 村代码
                }
            });
        }

        //地图定位获取经纬度
        function myselectjwd() {
            var v_address = $("#comdz").val();
            parent.sy.modalDialog({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                ,
                area: ['100%', '100%'] //
                ,
                title: '选择经纬度'
                ,
                content: basePath + 'jsp/pub/pub/pubMap.jsp?address=' + encodeURI(encodeURI(v_address)) + '&a=' + new Date().getMilliseconds()
                ,
                shade: [0.8, 'gray'] // 遮罩
                ,
                btn: ['确定', '退出']
                ,
                btn1: function (index, layero) {
                    var iframeWin = parent.window[layero.find('iframe')[0]['name']];
                    iframeWin.geocoders();
                }
            },function (dialogID) {
                var obj=sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    $('#comjdzb').val(obj.jdzb);
                    $('#comwdzb').val(obj.wdzb);
                }
            });
        }

        //验证身份证的正确性
        function checkSfz() {
            var sfz = $('#comfrsfzh').val();
            var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
            if (reg.test(sfz)) {
                return true;
            } else {
                layer.alert("身份证格式错误，请重新输入");
                $('#comfrsfzh').focus();
                return false;
            }
        }

        function showMenu_aaa027() {
            if ('<%=op%>' == 'view') {
                return;
            }
            var v_opkind = "addcompany";
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?opkind=' + v_opkind;
            sy.modalDialog({
                title: '选择地址'
                , area: ['300px', '400px']
                , content: url
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#aaa027').val(k.aaa027);
                    $('#aaa027name').val(k.aaa027name);
                    $('#comdz').val(k.aab301);
                }
            });
        }

        //从单位信息表中读取
        function showMenu_aaa027_layui() {
            var v_opkind = "addcompany";
            var url = basePath + 'jsp/pub/pub/selectAaa027.jsp?opkind=' + v_opkind;

            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                , area: ['100%', '100%'] //
                , maxmin: false
                , title: '选择区域'
                , content: url
                , shade: [0.8, 'gray'] // 遮罩
                , btn: ['确定', '退出']
                , yes: function (index) {
                    //当点击‘确定’按钮的时候，获取弹出层返回的值
                    var v_retObj = window["layui-layer-iframe" + index].onClick_aaa027();
                    //打印返回的值，看是否有我们想返回的值。
                    if (v_retObj != null) {
                        $('#aaa027').val(v_retObj.aaa027);
                        $('#aaa027name').val(v_retObj.aaa027name);
                        $('#comdz').val(v_retObj.aab301);
                    }
                    //最后关闭弹出层
                    layer.close(index);
                },
                cancel: function () {
                    //右上角关闭回调
                }
            });
        }


        //获取上传的图片
        function showUploadFj(comid) {
            if (comid != '' && comid != null) {
                $.post(basePath + '/pub/pub/queryFjViewList', {
                            'fjwid': comid
                        },
                        function (result) {
                            var mydata = result.data;
                            if (mydata != null) {
                                var playerHtml = '';
                                for (var i = 0; i < mydata.length; i++) {
                                    var imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + contextPath + mydata[i].fjpath;
                                    playerHtml = playerHtml + "<div style='float:left;text-align:center;margin:0 20px 20px 0;'><a onclick=\"showPic('" + imgUrl + "')\"><img width=\"200px\" height=\"150px\"style=\"padding:2px;border:1px solid #ccc;\" src=\"" + sy.contextPath + mydata[i].fjpath + "\"/></a></div>";
                                }
                                $('#picbox').append(playerHtml);
                            } else {
                                $('#picbox').append("暂未上传图片！");
                            }
                        }, 'json');
            }
        }

        //预览图片
        function showPic(imgUrl) {
            var dialog = parent.sy.modalDialog({
                title: '图片预览',
                width: 800,
                height: 600,
                url: imgUrl
            });
        }


        function mygetcomxiaolei(prm_comdalei) {
            parent.$.messager.progress({
                text: '数据加载中....'
            });
            var v_url = '<%=basePath%>/pub/pub/getComxiaoleiFromComdalei';
            $.post(v_url, {
                        aaa102: prm_comdalei
                    },
                    function (result) {
                        if (result.code == '0') {
                            var mydata = result.data;
//				$('#comxiaolei').combobox('setValue',mydata);
                        } else {
                            parent.$.messager.alert('提示', '查询失败：' + result.msg, 'error');
                        }
                        parent.$.messager.progress('close');
                        showUploadFj($('#comid').val());
                    }, 'json');
        }
        ;


        //从单位信息表中读取
        function mySelectComfenlei() {
            var v_mycomdaleicode = $("#comdalei").val();
            //var v_mycomxiaoleicode=$("#comxiaolei").val();
            //var obj = new Object();
            //obj.singleSelect="true";	//

            //obj.mycomdaleicode=v_mycomdaleicode;
            //obj.mycomxiaoleicode=v_mycomxiaoleicode;

            parent.layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                ,
                area: ['100%', '100%'] //
                ,
                title: '选择分类'
                ,
                content: basePath + 'pub/pub/selectComfenleiIndex?a=' + new Date().getMilliseconds() + '&mycomdaleicode=' + v_mycomdaleicode
                ,
                shade: [0.8, 'gray'] // 遮罩
                ,
                btn: ['确定', '退出']
                ,
                yes: function (index) {
                    //当点击‘确定’按钮的时候，获取弹出层返回的值
                    var v_retObj = parent.window["layui-layer-iframe" + index].myqueding();
                    //打印返回的值，看是否有我们想返回的值。
                    if (v_retObj != null) {
                        $("#comdalei").val(v_retObj.comdaleicode);
                        $("#comdaleiname").val(v_retObj.comdaleiname);
                    }
                    //最后关闭弹出层
                    parent.layer.close(index);
                },
                cancel: function () {
                    //右上角关闭回调
                }
                /*			,btn1: function(index, layero){
                 var iframeWin = window[layero.find('iframe')[0]['name']];
                 iframeWin.myqueding();
                 var v_retObj = $.parseJSON($('#comdaleiname').val());
                 //				alert(v_retObj.comdaleicode+"=="+v_retObj.comdaleiname+"=="+v_retObj.comxiaoleicode+"=="+v_retObj.comxiaoleiname);
                 if (v_retObj!=null){
                 $("#comdalei").val(v_retObj.comdaleicode);
                 $("#comdaleiname").val(v_retObj.comdaleiname);
                 $("#comxiaolei").val(v_retObj.comxiaoleicode);
                 $("#comxiaoleiname").val(v_retObj.comxiaoleiname);
                 }
                 }*/
            });
        }

        // 上传图片附件
        function uploadFjViewCanNoId(prm_fjtype) {
            var v_fjwid = $("#comid").val();
            var url = basePath + "/pub/pub/uploadFjViewIndex";
            parent.sy.modalDialog({
                type: 2,
                area: ['100%', '100%'],
                title: '上传图片附件'
                , content: url
                , param: {
                    folderName: "company",
                    fjwid: v_fjwid,
                    fjtype: prm_fjtype,
                    uploadOne: "yes"
                }
                ,btn:['关闭']
            }, function (dialogID) {
                var retVal = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if (retVal != null) {
                    if (retVal.type == 'ok') {
                        if (prm_fjtype == "4") {//企业门头照
                            $("#qymtzpath").val(retVal.fjpath);
                            $("#qymtzname").val(retVal.fjname);
                            $("#qymtz").attr("src", "<%=contextPath%>" + retVal.fjpath);
                        }
                    }
                    if (retVal.type == 'deleteok') {
                        var v_defaultpic = "/images/default.jpg";
                        if (prm_fjtype == "4") {//企业门头照
                            $("#qymtzpath").val("");
                            $("#qymtzname").val("");
                            $("#qymtz").attr("src", "<%=contextPath%>" + v_defaultpic);
                        }
                    }
                }
            });
        }
        ;
        //从单位信息表中读取
        function myselectAjdjXgry_layui(prm_rykind) {
            var v_useridstr = $("#comrcjdglryid").val();
            var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr=" + v_useridstr + "&a=" + new Date().getMilliseconds();
            var v_comrcjdglryid = "";
            var v_comrcjdglryname = "";
            parent.sy.modalDialog({
                title: '选择人员'
                , area: ['100%', '100%']
                , content: url
                , btn: ['保存','取消']
                , btn1: function (index, layero) {
                    parent. window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr != null && v_retStr.length > 0) {
                    for (var k = 0; k <= v_retStr.length - 1; k++) {
                        var myrow = v_retStr[k];
                        if ("" == v_comrcjdglryid) {
                            v_comrcjdglryid = myrow.userid;
                            v_comrcjdglryname = myrow.description;
                        } else {
                            v_comrcjdglryid = v_comrcjdglryid + "," + myrow.userid;
                            v_comrcjdglryname = v_comrcjdglryname + "," + myrow.description;
                        }
                    }
                    $("#comrcjdglry").val(v_comrcjdglryname);
                    $("#comrcjdglryid").val(v_comrcjdglryid);
                }
                ;
            });
        }
        ;


        function myclearRcjdgly() {
            $("#comrcjdglry").val('');
            $("#comrcjdglryid").val('');
        }
        function toTop(v_comid, v_comdalei) {
            $.post(basePath + 'pcompany/sort', {
                        comid: v_comid,  //(将数据库中值通过此id传给前段页面)
                        comdalei: v_comdalei,
                        type: 0
                    },
                    function (result) {
                        if (result.code == 0) {
                            $('#orderno').val(result.data);
                            layer.msg("置顶成功", {time: 1000});
                        } else {
                            layer.alert("置顶失败!" + result.msg, {time: 1000});
                        }
                    }, 'json');
        }

        //置底
        function toBottom(v_comid, v_comdalei) {
            $.post(basePath + 'pcompany/bottom', {
                        comid: v_comid,  //(将数据库中值通过此id传给前段页面)
                        comdalei: v_comdalei,
                        type: 0
                    },
                    function (result) {
                        if (result.code == 0) {
                            $('#orderno').val(result.data);
                            layer.msg("置底成功", {time: 1000});
                        } else {
                            layer.alert("置底失败!", {time: 1000});
                        }
                    }, 'json');
        }
    </script>
</head>
<body>
<form class="layui-form" action="" id="pcompany">
    <input type="hidden" name="comfjpath" id="comfjpath"/>
    <input type="hidden" name="comid" id="comid" value="<%=v_comid %>">
    <input type="hidden" name="comdm" id="comdm">
    <input type="hidden" name="comfwnfww" id="comfwnfww" value="0">
    <input type="hidden" name="comxkzbh" id="comxkzbh">
    <input type="hidden" name="comfrxb" id="comfrxb">
    <input type="hidden" name="comfrzw" id="comfrzw">
    <input type="hidden" name="comcz" id="comcz">
    <input type="hidden" name="comzclb" id="comzclb">
    <input type="hidden" name="comdzcczymc" id="comdzcczymc">
    <input type="hidden" name="comdzcsj" id="comdzcsj">
    <input type="hidden" name="comshbz" id="comshbz">
    <input type="hidden" name="comshr" id="comshr">
    <input type="hidden" name="comshsj" id="comshsj">
    <input type="hidden" name="comshwtgyy" id="comshwtgyy">
    <input type="hidden" name="comqyxz" id="comqyxz">
    <input type="hidden" name="comlrcomid" id="comlrcomid">
    <input type="hidden" name="comghsorxhs" id="comghsorxhs">
    <input type="hidden" name="combxbz" id="combxbz">
    <input type="hidden" name="comhhbbz" id="comhhbbz">
    <input type="hidden" name="comsyqylx" id="comsyqylx">
    <input type="hidden" name="comywtz" id="comywtz">
    <input type="hidden" name="combeizhu" id="combeizhu">
    <input type="hidden" name="orgid" id="orgid">
    <input type="hidden" name="commcjc" id="commcjc">
    <input type="hidden" name="comjyjcbz" id="comjyjcbz">
    <%--<input type="hidden" name="orderno" id="orderno">--%>
    <input type="hidden" name="sjdatatime" id="sjdatatime">
    <input type="hidden" name="sjdatacomid" id="sjdatacomid">
    <input type="hidden" name="sjdatacomdm" id="sjdatacomdm">

    <input type="hidden" name="comxiaolei" id="comxiaolei">
    <input type="hidden" name="comxiaoleiname" id="comxiaoleiname">

    <table class="layui-table">
        <tr>
            <td style="text-align:right;width: 160px"><font class="myred">*</font>企业名称:</td>
            <td colspan="2">
                <input type="text" id="commc" name="commc" lay-verify="required" style="width: 400px"
                       autocomplete="off" class="layui-input">
            </td>
            <td rowspan="4" colspan="2" style="text-align: center;">
                <div style="text-align: center;" id="qymtzzhaopian_div">
                    <img src="<%=contextPath%>/images/default.jpg" name="qymtz" id="qymtz" height="130" width="150"
                         onclick="g_showBigPic(this.src);"/>
                </div>
                <a id="btnselectcom" href="javascript:void(0)"
                   class="layui-btn" iconCls="icon-upload"
                   onclick="uploadFjViewCanNoId(4)">选择企业门头照</a>
                <input type="hidden" id="qymtzpath" name="qymtzpath">
                <input type="hidden" id="qymtzname" name="qymtzname">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>企业分类:</td>
            <td>
                <input type="text" id="comdaleiname" name="comdaleiname" lay-verify="required" readonly
                       autocomplete="off" class="layui-input" style="width:400px;">
                <input type="hidden" id="comdalei" name="comdalei">

            </td>

            <td style="  text-align: center;">
                <a href="javascript:void(0)" class="layui-btn"
                   id="mySelectComfenlei" onclick="mySelectComfenlei()">选择分类 </a>
            </td>
        </tr>
        <%--			<tr>
                        <td style="text-align:right;">企业小类:
                        </td>
                        <td colspan="1">
                            <input type="text" id="comxiaoleiname" name="comxiaoleiname"
                                   autocomplete="off" class="layui-input" >
                            <input type="text" id="comxiaolei" name="comxiaolei" style="display: none">
                        </td>
                    </tr>--%>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>所属地区:</td>
            <td colspan="2">
                <%--					<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
                                        <ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:250px;height:250px;"></ul>
                                    </div>--%>

                <div class="layui-form-item" style="padding-top: 13px;">
                    <div class="layui-input-inline">
                        <input type="text" id="aaa027name" name="aaa027name" lay-verify="required" style="width:200px;"
                               autocomplete="off" class="layui-input layui-bg-gray" onclick="showMenu_aaa027();"
                               readonly>
                        <input name="aaa027" id="aaa027" type="hidden"/>
                    </div>
                    <label class="layui-form-label" style="width: 5%"></label>
                    <label class="layui-form-label">公众端显示标志:</label>

                    <div class="layui-input-inline">
                        <select id="comspjkbz" name="comspjkbz"></select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>企业地址:</td>
            <td colspan="2">
                <input type="text" id="comdz" name="comdz" lay-verify="required" style="width:400px;"
                       autocomplete="off" class="layui-input" value="">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>企业生产地址:</td>
            <td <%= (op != null && "edit".equalsIgnoreCase(op) && "admin".equalsIgnoreCase(name) || "view".equalsIgnoreCase(op) ? "" : "colspan='3'")%>>
                <input type="text" id="comscdz" name="comscdz" style="width:400px;"
                       autocomplete="off" class="layui-input">
            </td>

          <% if (op != null && "edit".equalsIgnoreCase(op) && "admin".equalsIgnoreCase(name) || "view".equalsIgnoreCase(op)) { %>
            <td style="text-align:right;">公众端展示排序</td>
            <td>
                <% if (op != null && "edit".equalsIgnoreCase(op)) { %>
                <a href="javascript:void(0)" class="layui-btn-sm layui-btn"
                   onclick="toTop('<%=v_comid%>',$('#comdalei').val())">置顶</a>

                <a href="javascript:void(0)" class="layui-btn-sm layui-btn"
                   onclick="toBottom('<%=v_comid%>',$('#comdalei').val())">置底</a>
                <%}%>
                <input type="<%= (op != null && "edit".equalsIgnoreCase(op)? "hidden" : "text")%>" id="orderno"
                       name="orderno" class="layui-input">
            </td>
            <%}{%>
              <input type="hidden" name="orderno" id="orderno">
            <%}%>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>地图定位:</td>
            <td colspan="2">
                <div class="layui-form-item" style="padding-top: 13px;">
                    <label class="layui-form-label">经度坐标:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="comjdzb" name="comjdzb" readonly="readonly" lay-verify="required"
                               autocomplete="off" class="layui-input">
                    </div>
                    <label class="layui-form-label">纬度坐标:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="comwdzb" name="comwdzb" readonly="readonly" lay-verify="required"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
            </td>
            <td>
                <a href="javascript:void(0)" class="layui-btn" id="dtdw"
                   iconCls="icon-search" onclick="myselectjwd()">选择经纬度 </a>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>选择日常监督管理人员：</td>
            <td colspan="2">
                <input type="text" id="comrcjdglry" name="comrcjdglry"
                       autocomplete="off" class="layui-input" readonly="readonly">
            </td>
            <td>
                <input type="hidden" id="comrcjdglryid" name="comrcjdglryid">
                <% if ("1".equals(v_userdalei)) {%>
                <a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
                   iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
                &nbsp;&nbsp;
                <a href="javascript:void(0)" class="layui-btn" id="remove"
                   iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
                <%} %>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>企业法人/业主：</td>
            <td>
                <input type="text" id="comfrhyz" name="comfrhyz" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>法人/业主身份证号：</td>
            <td>
                <input type="text" id="comfrsfzh" name="comfrsfzh"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>注册资金(万元)：</td>
            <td>
                <input type="text" id="comzczj" name="comzczj" lay-verify="number"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred">*</font>企业负责人：</td>
            <td>
                <input type="text" id="comfzr" name="comfzr" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>组织机构代码：</td>
            <td>
                <input type="text" id="comzzjgdm" name="comzzjgdm" lay-verify="comzzjgdm"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>企业成立日期：</td>
            <td>
                <input type="text" id="comclrq" name="comclrq" class="layui-input" placeholder="年/月/日">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">固定电话：</td>
            <td>
                <input type="text" id="comgddh" name="comgddh" lay-verify="tel"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>移动电话：</td>
            <td>
                <input type="text" id="comyddh" name="comyddh"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>电子邮箱：</td>
            <td>
                <input type="text" id="comemail" name="comemail"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>邮政编码：</td>
            <td>
                <input type="text" id="comyzbm" name="comyzbm" lay-verify="comyzbm"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>企业qq：</td>
            <td>
                <input type="text" id="comqq" name="comqq"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>企业网址：</td>
            <td>
                <input type="text" id="comwz" name="comwz"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred"></font>从业人数：</td>
            <td>
                <input type="text" id="comcyrs" name="comcyrs"
                       autocomplete="off" class="layui-input">
            </td>
            <td style="text-align:right;"><font class="myred"></font>专/兼职管理人员数：</td>
            <td>
                <input type="text" id="comzjzglrs" name="comzjzglrs"
                       autocomplete="off" class="layui-input">
            </td>
        </tr>
        <tr>
            <td style="text-align:right;"><font class="myred">*</font>企业简介:</td>
            <td colspan="3">
			<textarea class="layui-textarea" id="comjianjie" name="comjianjie" lay-verify="required"
                      rows="6"></textarea>
            </td>
        </tr>
        <tbody style="display:none" id="cyqyyincang">
        <tr>
            <td style="text-align:right;">
                <nobr>餐厅面积:</nobr>
            </td>
            <td><input id="comctmj" name="comctmj" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>厨房面积:</nobr>
            </td>
            <td><input id="comcfmj" name="comcfmj" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>总面积:</nobr>
            </td>
            <td><input id="comzmj" name="comzmj" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>店面类型:</nobr>
            </td>
            <td><input id="comdmlx" name="comdmlx" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>就餐人数:</nobr>
            </td>
            <td><input id="comjcrs" name="comjcrs" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>持健康证人数:</nobr>
            </td>
            <td><input id="comcjkzrs" name="comcjkzrs" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>特色菜系:</nobr>
            </td>
            <td><input id="comtscx" name="comtscx" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>特色菜:</nobr>
            </td>
            <td><input id="comtsc" name="comtsc" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        </tbody>

        <tbody style="display:none" id="qyUserYincang">
        <tr>
            <td style="text-align:right;">
                <nobr>厂商识别码:</nobr>
            </td>
            <td>
                <input id="comcssbm" name="comcssbm" style="width: 200px"
                       class="layui-input"/>
            </td>
            <td style="text-align:right;">
                <nobr>企业投诉电话:</nobr>
            </td>
            <td>
                <input id="comtsdh" name="comtsdh" style="width: 200px"
                       class="layui-input"/>
            </td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>企业正门方向:</nobr>
            </td>
            <td><input id="comzmfx" name="comzmfx" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>前一年度固定资产（现值）:</nobr>
            </td>
            <td><input id="comqyndgdzcxz" name="comqyndgdzcxz" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>前一年度流动资金:</nobr>
            </td>
            <td><input id="comqyndldzj" name="comqyndldzj" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>前一年度总产值:</nobr>
            </td>
            <td><input id="comqyndzcz" name="comqyndzcz" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>前一年度年销售额:</nobr>
            </td>
            <td><input id="comqyndnxse" name="comqyndnxse" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>前一年度缴税金额:</nobr>
            </td>
            <td><input id="comqyndyjse" name="comqyndyjse" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>前一年度年利润:</nobr>
            </td>
            <td><input id="comqyndnlr" name="comqyndnlr" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>是否通过HACCP认证:</nobr>
            </td>
            <td><input id="comsftghaccp" name="comsftghaccp" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>HACCP认证证书编号:</nobr>
            </td>
            <td><input id="comhaccpbh" name="comhaccpbh" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>HACCP发证单位名:</nobr>
            </td>
            <td><input id="comhaccpfzdw" name="comhaccpfzdw" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>ISO9000证书编号:</nobr>
            </td>
            <td><input id="comiso9000bh" name="comiso9000bh" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>ISO9000发证单位名:</nobr>
            </td>
            <td><input id="comiso9000fzdw" name="comiso9000fzdw" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>占地面积:</nobr>
            </td>
            <td><input id="comzdmj" name="comzdmj" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr>建筑面积:</nobr>
            </td>
            <td><input id="comjzmj" name="comjzmj" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        <tr>
            <td style="text-align:right;">
                <nobr>营业时间:</nobr>
            </td>
            <td><input id="comyysj" name="comyysj" style="width: 200px"
                       class="layui-input"/></td>
            <td style="text-align:right;">
                <nobr> 企业风险等级:</nobr>
            </td>
            <td><input id="comfxdj" name="comfxdj" style="width: 200px"
                       class="layui-input"/></td>
        </tr>
        </tbody>
    </table>
    <% if (op != null && "view".equalsIgnoreCase(op)) { %>
    <%--<p  class="prowcolor">企业资质证明信息</p>--%>
    <h2 class="layui-colla-title" style="font-size: 15px">企业资质证明信息</h2>
    <iframe name="myfrmname" id="myfrmid" scrolling="auto" frameborder="0"
            style="width:98%;height: 300px;" src="<%=v_iframeUrl%>">
    </iframe>
    <%--<p  class="prowcolor">企业图片</p>--%>
    <h2 class="layui-colla-title" style="font-size: 15px">企业图片</h2>

    <div id="picbox" style="width:98%;text-align:center;">
        <iframe name="mypiciframename" id="mypiciframeid"
                scrolling="auto" frameborder="0" style="width:100%;height: 350px;"
                src="<%=v_piciframeUrl%>"></iframe>
    </div>
    <%} %>
    <div class="layui-form-item" style="display: none">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="saveRole"
                    id="saveRoleBtn">保存
            </button>
        </div>
    </div>

</form>

</body>
</html>