<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ taglib uri="/WEB-INF/permission.tld" prefix="ck" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
    String v_jyjcxmid = StringHelper.showNull2Empty(request.getParameter("jcxmid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>检验检测项目</title>
    <jsp:include page="${contextPath}/inc.jsp">
        <jsp:param name="isLayUI" value="false"/>
    </jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var jcxmmcjc_old='';
        var jcxmmcOld='';
        var treeObj;
        var v_SFYX = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var v_jyjcxmlx = <%=SysmanageUtil.getAa10toJsonArray("JYJCXMLX")%>;
        var v_sfmulu = <%=SysmanageUtil.getAa10toJsonArray("shifoubz")%>;

        var grid;
        var form;
        var element;
        var layer;
        var table;
        var laydate;

        var setting = {
            async: {
                enable: true, //启用异步加载
                url: basePath + 'jyjc/queryJyjcxmZTree',  //调用后台的方法
                dataFilter: ajaxDataFilter,//用于对 Ajax返回数据进行预处理
                autoParam: ["functionid"], //向后台传递的参数
                otherParam: {} //额外的参数
            },
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "jyjcxmid",
                    pIdKey: "jcxmparentid",
                    rootPId: 0
                },
                key: {
                    name: "jcxmmc"
                }
            },
            callback: {
                onClick: onClick
            }

        };
        var setting2={
            view: {
                showLine: true
            },
            async: {
                enable: true, //启用异步加载
                url: basePath + 'jyjc/queryJyjcxmZTree',  //调用后台的方法
                dataFilter: ajaxDataFilter,//用于对 Ajax返回数据进行预处理
                autoParam: ["functionid"], //向后台传递的参数
                otherParam: {}//额外的参数
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "jyjcxmid",
                    pIdKey: "jcxmparentid",
                    rootPId: 0
                },
                key: {
                    name: "jcxmmc"
                }
            },
            callback: {
                onClick: onClick2
            }
        }
        $(function () {
            refreshZTree();
            layui.use(['form', 'table', 'element', 'laydate', 'layer'], function () {
                form = layui.form;
                table = layui.table;
                element = layui.element;
                laydate = layui.laydate;
                layer = layui.layer;
                laydate.render({
                    elem:"#jcxmczsj"
                    ,type:"datetime"
                })
                var url = basePath + 'jyjc/saveJyjcxm2';
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
                                refreshZTree();
                            });
                        } else {
                            layer.open({
                                title: '提示'
                                , content: '保存失败' + result.msg
                            });
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            })
            intSelectData("sfyx",v_SFYX);
            intSelectData("jyjcxmlx",v_jyjcxmlx);//gu20180724
            intSelectData("sfmulu",v_sfmulu);//gu20180724
            $('#jcxmmc').blur(function () {
                var jcxmmc = $('#jcxmmc').val();
                if (jcxmmc == null || jcxmmc == '') {
                    return false;
                }
                if (jcxmmc != jcxmmcOld) {
                    checkJcxmmc();
                }
            })
            //姓名改变,自动生成首字母大写
            $('#jcxmmcjc').blur(function () {
                var name = $('#jcxmmcjc').val();
                if (name != jcxmmcjc_old) {
                    getPinYin();
                }
            })
        });
        //获取名称拼音
        function getPinYin() {
            jcxmmcjc_old = $('#jcxmmcjc').val();
            if (jcxmmcjc_old != "") {
                $.post(basePath + '/zfba/zfrygl/getPY', {
                            'jcxmmcjc': jcxmmcjc_old
                        },
                        function (data) {
                            $('#jcxmmcjc').val(data);
                        },
                        'json');
            }
        }
        function checkJcxmmc() {
            var jcxmmc = $('#jcxmmc').val().toUpperCase();
            if (jcxmmc != null && jcxmmc != "") {
                $.post(basePath + 'jyjc/checkJcxmmc', {
                            jcxmmc: jcxmmc
                        },
                        function (result) {
                            if (result.code == '0') {
                                var mydata = result.total;
                                //存在
                                if (mydata > 0) {
                                    layer.msg("项目名称重复请重新填写");
                                    $('#jcxmmc').val("");
                                } else {
                                    $('#jcxmmc').val(jcxmmc);
                                }
                            }
                        }, 'json');
            }
        }
        //初始化zTree树
        function refreshZTree() {
            //初始化机构树
            $.post(basePath + 'jyjc/queryJyjcxmZTree', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);

                    treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    addCate();
                } else {
                    layer.alert('提示' + result.msg);
                }
            }, 'json');
            getPinYin();
        }

        //单击节点事件
        function onClick(event, treeId, treeNode) {
            $('#fm').form('load', treeNode);//用节点数据填充form
            jcxmmcOld=treeNode.jcxmmc;
            //如果是最外层的父类 则父类名称为空
            if(treeNode.parentname==undefined){
                $("#parentname").val("");
            }
            form.render('select');
        }
        function onClick2(event, treeId, treeNode) {
            $("#parentname").val(treeNode.jcxmmc);
            //gu20180531 $("#jcxmparentid").val(treeNode.jcxmparentid);
            $("#jcxmparentid").val(treeNode.jyjcxmid);
            hideMenu();
        }
        function ajaxDataFilter(treeId, parentNode, responseData) {
            var zNodes =eval(responseData.mydata);//获取后台传递的数据
            return zNodes;
        }


    </script>
    <script type="text/javascript">

        function refresh() {
            parent.window.refresh();
        }

        // 新增
        function addCate() {
            $('#fm').form('clear');
//            $('#aaz093').val('');
//             $('#aaa102').val('');
//             $('#aaa103').val('');
//             $('#aaa104').combotree('setValue','');
            $('#sfyx').val("1");
//            form.render('select');
            <%--$('#jcxmid').val('<%=v_jyjcxmid%>');--%>
        }

        // 删除
        function delCate() {
            var jyjcxmid = $('#jyjcxmid').val();
            if (jyjcxmid == null || jyjcxmid == "") {
                layer.alert('请选择要删除的分类');
                return false;
            }
            layer.open({
                title: '警告'
                , icon: '3'
                , content: '你确定要删除该项记录么？'
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(basePath + 'jyjc/delJyjcxm2', {
                            jyjcxmid: jyjcxmid
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('删除成功', {time: 1000}, function () {
                                    refreshZTree();
                                });
                                //如果删除本页的最后一条数据时 则查询上一页的数据而不是让他在本页无数据的状态
                            } else {
                                layer.open({
                                    title: "提示",
                                    content: "删除失败：" + result.msg //这里content是一个普通的String
                                });
                            }
                        },
                        'json');
                }
            });
        }

        function showMenu() {
            var cityObj = $("#parentname");
            var cityOffset = $("#parentname").offset();
            $("#menuContent").css({
                left: cityOffset.left-254 + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            refreshZTree2();
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "menuContent"
                    || $(event.target).parents("#menuContent").length > 0)) {
                hideMenu();
            }
        }

        function refreshZTree2() { //初始化父菜单下拉框
            $.fn.zTree.init($("#treeDemo2"), setting2);
        }
        //选择检测标准
        function myselectjcbz() {
            var v_bzbh = "";
            var v_jyjcjcbzbid = "";
            sy.modalDialog({
                title: '选择检验检测项目标准',
                area: ['100%', '100%'],
                content: basePath + 'jyjc/jyjcjcbzbIndex?op=select'
                , btn: ['确定', '取消'] //可以无限个按钮
                , param: {
                    a: new Date().getMilliseconds(),
                    singleSelect: "true",
                    jyjcjcbzbid:$("#jyjcjcbzbid").val()
                }
                , btn1: function (index, layero) {
                    window[layero.find('iframe')[0]['name']].queding();
                }
            }, function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少
                if(v_retStr!=null&&v_retStr!=''){
                    v_retStr=v_retStr.data;
                    if (v_retStr != null && v_retStr.length > 0) {
                        for (var k = 0; k <= v_retStr.length - 1; k++) {
                            var myrow = v_retStr[k];
                            if ("" == v_jyjcjcbzbid) {
                                v_bzbh = myrow.bzbh;
                                v_jyjcjcbzbid = myrow.jyjcjcbzbid;
                            } else {
                                v_bzbh = v_bzbh + "," + myrow.bzbh;
                                v_jyjcjcbzbid = v_jyjcjcbzbid + "," + myrow.jyjcjcbzbid;
                            }
                        }
                        var jcbzbh=$("#bzbh").val();
                        var jcbzbid=$("#jyjcjcbzbid").val();
                        var v_jcbzbh='';
                        var v_jcbzbid=''
                        if(''==jcbzbh){
                            v_jcbzbh=jcbzbh+v_bzbh;
                            v_jcbzbid=jcbzbid+v_jyjcjcbzbid;
                        }else{
                            v_jcbzbh=jcbzbh+","+v_bzbh;
                            v_jcbzbid=jcbzbid+","+v_jyjcjcbzbid;
                        }
                        $("#bzbh").val(v_jcbzbh);
                        $("#jyjcjcbzbid").val(v_jcbzbid);
                    }
                }

            });
        }

        //选择检测方法
        function myselectjcff() {
            var v_jcffbzbh = "";
            var v_jyjcjcffbzbid = "";
            sy.modalDialog({
                    title: '选择检验检测方法标准',
                    area: ['100%', '100%'],
                    param: {
                        a: new Date().getMilliseconds(),
                        singleSelect: "true",
                        jyjcffbzbid:$("#jyjcffbzbid").val()
                    },
                    content: basePath + 'jyjc/jcffglIndex?op=select',
                    btn: ['确定', '取消'], //可以无限个按钮
                    btn1: function (index, layero) {
                        window[layero.find('iframe')[0]['name']].queding();
                    }
                },function (dialogID) {
                    var v_retStr = sy.getWinRet(dialogID);
                    sy.removeWinRet(dialogID);//不可缺少
                if(v_retStr!=null&&v_retStr!=''){
                    v_retStr=v_retStr.data;
                    if (v_retStr != null && v_retStr.length > 0) {
                        for (var k = 0; k <= v_retStr.length - 1; k++) {
                            var myrow = v_retStr[k];
                            if ("" == v_jyjcjcffbzbid) {
                                v_jcffbzbh = myrow.jcffbzbh;
                                v_jyjcjcffbzbid = myrow.jyjcffbzbid;
                            } else {
                                v_jcffbzbh = v_jcffbzbh + "," + myrow.jcffbzbh;
                                v_jyjcjcffbzbid = v_jyjcjcffbzbid + "," + myrow.jyjcffbzbid;
                            }
                        }
                        var ffbzbh=$("#jcffbzbh").val();
                        var ffbzbid=$("#jyjcffbzbid").val();
                        var v_ffbzbh='';
                        var v_ffbzbid=''
                        if(''==ffbzbh){
                            v_ffbzbh=ffbzbh+v_jcffbzbh;
                            v_ffbzbid=ffbzbid+v_jyjcjcffbzbid;
                        }else{
                            v_ffbzbh=ffbzbh+","+v_jcffbzbh;
                            v_ffbzbid=ffbzbid+","+v_jyjcjcffbzbid;
                        }
                        $("#jcffbzbh").val(v_ffbzbh);
                        $("#jyjcffbzbid").val(v_ffbzbid);
                    }
                }
            });
        }
        function myclearjcbz() {
            $("#bzbh").val('');
            $("#jyjcjcbzbid").val('');
            $("#jyjcxmjcbzid").val('');
        }
        function myclearjcff() {
            $("#jcffbzbh").val('');
            $("#jyjcffbzbid").val('');
            $("#jyjcxmjcffbz").val('');
        }

    </script>
</head>
<body>
<div class="layui-layout-body">
    <div class="layui-side" style="width: 250px;">
        <div class="layui-side-scroll" style="width:100%;">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="layui-body" style="margin-left: 55px; width: 79%;">
        <div class="layui-collapse">
            <div class="layui-colla-item" style="width:100%">
                <h2 class="layui-colla-title">分类信息</h2>
                <div class="layui-colla-content layui-show">
                    <form class="layui-form" id="fm">
                        <%--<input name="jcxmmcjc" id="jcxmmcjc" type="text"/>--%>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检查项目ID:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jyjcxmid" name="jyjcxmid" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>是否目录:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <select id="sfmulu" name="sfmulu" lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>检查项目编号:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcxmbh" name="jcxmbh" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>检查项目名称:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcxmmc" name="jcxmmc" lay-verify="required"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>父级分类:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="parentname" name="parentname" lay-verify="required"
                                       autocomplete="off"  class="layui-input" onclick="showMenu();">
                                <input type="hidden" id="jcxmparentid" name="jcxmparentid">
                            </div>
                        </div>
                        <div id="menuContent" class="menuContent"
                             style="display:none;position:absolute;z-index:333;height: 200px;width: 250px;">
                            <ul id="treeDemo2" class="ztree"></ul>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>是否有效:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <select id="sfyx" name="sfyx" lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px"><font
                                    class="myred">*</font>项目分类:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <select id="jyjcxmlx" name="jyjcxmlx" lay-verify="required"></select>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检验检测标准:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="bzbh" name="bzbh" readonly
                                       class="layui-input">
                                <input type="hidden" id="jyjcjcbzbid" name="jyjcjcbzbid">
                                <input type="hidden" id="jyjcxmjcbzid" name="jyjcxmjcbzid">
                            </div>
                            <div class="layui-input-inline" style="width: auto">
                                <a href="javascript:void(0)" class="layui-btn layui-btn-sm"
                                   iconCls="icon-search" onclick="myselectjcbz()">选择检测标准 </a>
                            </div>
                            <div class="layui-input-inline" style="width: auto">
                                <a href="javascript:void(0)" class="layui-btn layui-btn-sm" id="remove1"
                                   iconCls="icon-search" onclick="myclearjcbz()">清除 </a>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">检验检测方法:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcffbzbh" name="jcffbzbh" readonly
                                       class="layui-input">
                                <input type="hidden" id="jyjcffbzbid" name="jyjcffbzbid">
                                <input type="hidden" id="jyjcxmjcffbz" name="jyjcxmjcffbz">
                            </div>
                            <div class="layui-input-inline" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn layui-btn-sm"
                                   iconCls="icon-search" onclick="myselectjcff()">选择检测方法 </a>
                            </div>
                            <div class="layui-input-inline" style="width: auto;">
                                <a href="javascript:void(0)" class="layui-btn layui-btn-sm" id="remove2"
                                   iconCls="icon-search" onclick="myclearjcff()">清除 </a>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">标准值:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcxmbzz" name="jcxmbzz"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">操作员:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcxmczy" name="jcxmczy" readonly
                                       class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 100px">操作时间:</label>
                            <div class="layui-input-inline" style="width: 600px">
                                <input type="text" id="jcxmczsj" name="jcxmczsj"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <ck:permission biz="addSysfunction">
                                    <button class="layui-btn" data-type="addSysfunction" data="btn_addSysfunction"
                                            >新增
                                    </button>
                                </ck:permission>
                                <ck:permission biz="delSysfunction">
                                    <button class="layui-btn layui-btn-danger" type="button"
                                            data="btn_delSysfunction" onclick="delCate()">删除
                                    </button>
                                </ck:permission>
                                <ck:permission biz="saveSysfunction">
                                    <button class="layui-btn" data-type="saveSysfunction" data="btn_saveSysfunction"
                                            lay-submit="" lay-filter="save">保存
                                    </button>
                                </ck:permission>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>