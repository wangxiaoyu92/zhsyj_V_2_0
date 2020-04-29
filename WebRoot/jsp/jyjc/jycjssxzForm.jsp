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

    String op = StringHelper.showNull2Empty(request.getParameter("op"));
    String jycjssxzid = StringHelper.showNull2Empty(request.getParameter("jycjssxzid"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>抽检实施细则信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <style type="text/css">
        /**treeselect*/
        .layui-form-select .layui-tree {
            display: none;
            position: absolute;
            left: 0;
            top: 42px;
            padding: 5px 0;
            z-index: 999;
            min-width: 100%;
            border: 1px solid #d2d2d2;
            max-height: 300px;
            overflow-y: auto;
            background-color: #fff;
            border-radius: 2px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .12);
            box-sizing: border-box;
        }

        .layui-form-selected .layui-tree {
            display: block;
        }
    </style>
    <script type="text/javascript">
        var cbt_newcate;
        var selectNodes;
        var index;
        var form;
        var layer;
        var layedit;
        var cbt_newcate;
        $(function () {
            layui.use(['form', 'layer', 'layedit'], function () {
                form = layui.form;
                layer = layui.layer;
                layedit = layui.layedit;
                index = layedit.build('zhms'); //建立编辑器
                var lock=true;
                form.on('submit(saveNews)', function (data) {
                    var formData=data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + '/jyjc/savejycjssxz', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                        } else {
                            layer.open({
                                title: "提示",
                                content: "保存失败：" + result.msg //这里content是一个普通的String
                            });
                            lock=true;
                        }
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
                var id = $("#jycjssxzid").val();
                if (id != "" && id != null) {
                    /* $.post(basePath + '/jyjc/queryjycjssxzDTO', {
                     jycjssxzid : $('#jycjssxzid ').val()
                     },
                     function (result) {
                     if (result.code == '0') {
                     var mydata = result.data;
                     $('#viewjycjcpflname').val(mydata.cjcpamc);
                     $('#jyxmdescname').val(mydata.jcxmmc);
                     $('form').form('load', mydata);
                     } else {
                     layer.open({
                     title: "提示",
                     content: "查询失败：" + result.msg //这里content是一个普通的String
                     });
                     }
                     }, 'json');*/
                    $.ajax({
                        type:'POST',
                        url:basePath + '/jyjc/queryjycjssxzDTO',
                        dataType:'json',
                        data:{jycjssxzid:$('#jycjssxzid ').val()},
                        async:false,
                        success:function(result){
                            var mydata = result.data;
                            text=mydata.text;
                            $('#viewjycjcpflname').val(mydata.cjcpamc);
                            $('form').form('load', mydata);
                            $('#jyxmdescname').val(result.jcxmdesc);
                            $('#jyxmdesc').val(result.jcxmmc);
                            $('#jcxmmc').val(result.jcxmmc);
                            $("iframe[textarea='zhms']")[0].contentDocument.body.innerHTML=mydata.zhms;
                        }
                    });
                    if ('<%=op%>' == 'view') {
                        $('form:input').addClass('input_readonly');
                        $('form:input').attr('readonly', 'readonly');
                        $('textarea').attr('readonly', 'readonly');
                        $('input').attr('disabled', 'true');
                        $("iframe[textarea='zhms']")[0].contentDocument.body.contentEditable = false;
                    }
                }
            });
        });


        // 保存
        function saveFun() {
            layedit.sync(index);//同步富文本框内容到文本框中
            if ($('#zhms').val()) {//文本框有内容时清空样式
                $('.layui-layedit').removeAttr("style");
            }else{//无内容显示红色边框
                $('.layui-layedit').css('border-color', 'red');
            }
            $("#saveNewsBtn").click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }

        function showMenu_aaa027() {
            if ('<%=op%>' == 'view') {
                return;
            }
            sy.modalDialog({
                title: '选择抽检产品分类'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectjycjcpfl.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#viewjycjcpflid').val(k.viewjycjcpflid);
                    $('#viewjycjcpflname').val(k.viewjycjcpflname);
                }
                sy.removeWinRet(dialogID);
            });
        }

        function showMenu_aaa027new() {
            if ('<%=op%>' == 'view') {
                return;
            }
          /*  sy.modalDialog({
                title: '选择检测项目'
                , area: ['300px', '400px']
                , content: basePath + 'jsp/pub/pub/selectjycjjcxm.jsp'
            }, function (dialogID) {
                var k = sy.getWinRet(dialogID);
                if (typeof(k.type) != "undefined" && k.type != null && k.type == 'ok') {
                    $('#jyxmdesc').val(k.jyxmdesc);
                    $('#jyxmdescname').val(k.jyxmdescname);
                }
                sy.removeWinRet(dialogID);
            });*/
          var jyxmdesc=$('#jcxmmc').val();
            layer.open({
                type: 2 // 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                ,
                area: ['300px', '400px']
                ,
                title: '选择分类'
                ,

                content: basePath + 'jsp/pub/pub/selectjycjjcxm.jsp?jyxmdesc='+jyxmdesc
                ,
                shade: [0.8, 'gray'] // 遮罩
                ,
                btn: ['确定', '退出']
                ,
                yes: function (index) {
                    //当点击‘确定’按钮的时候，获取弹出层返回的值
                    var v_retObj = window["layui-layer-iframe" + index].myqueding();
                    //打印返回的值，看是否有我们想返回的值。
                    if (v_retObj != null) {
                        $("#jyxmdesc").val(v_retObj.jyxmdesc);
                        $("#jyxmdescname").val(v_retObj.jyxmdescname);
                    }
                    //最后关闭弹出层
                    layer.close(index);
                },
                cancel: function () {
                    //右上角关闭回调
                }
            });
        }
    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="jycjssxzid" name="jycjssxzid" type="hidden" value="<%=jycjssxzid%>"/>
            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px"><font class="myred">*</font>抽检产品分类:</label>

                    <div class="layui-input-inline">
                        <input name="viewjycjcpflname" id="viewjycjcpflname" onclick="showMenu_aaa027();"
                               readonly="readonly" class="layui-input layui-bg-gray" lay-verify="required"/>
                        <input name="viewjycjcpflid" id="viewjycjcpflid" type="hidden"/>
                    </div>
                    <div id="menuContent_aaa027" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
                        <div class="layui-side-scroll" style="width:250px;">
                            <ul id="treeDemo_aaa027" class="ztree"></ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font class="myred">*</font>检测项目:</label>

                    <div class="layui-input-inline">
                        <input name="jyxmdescname" id="jyxmdescname" onclick="showMenu_aaa027new();"
                               readonly="readonly" class="layui-input layui-bg-gray" lay-verify="required"/>
                        <input name="jyxmdesc" id="jyxmdesc" type="hidden"/>
                        <input name="jcxmmc" id="jcxmmc" type="hidden"/>
                    </div>
                    <div id="menuContent_aaa027new" class="layui-side layui-bg-gray" style="display:none; position: absolute;">
                        <div class="layui-side-scroll" style="width:250px;">
                            <ul id="treeDemo_aaa027new" class="ztree"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px"><font class="myred">*</font>适用范围:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="syfw" name="syfw" lay-verify="required"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label"><font class="myred">*</font>产品种类:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="cpzl" name="cpzl"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px"><font class="myred">*</font>抽样型号或规格:</label>

                    <div class="layui-input-inline">
                        <input type="text" id="cyxhhgg" name="cyxhhgg"
                               autocomplete="off" class="layui-input" >
                    </div>
                </div>
            </div>
            <div class="layui-col-md6 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label">抽样单:</label>
                    <div class="layui-input-inline" >
                        <input type="text" id="cyd" name="cyd"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px">检验依据:</label>

                    <div class="layui-input-inline" style="width: 700px">
                        <textarea placeholder="请输入内容" class="layui-textarea" id="jyjj" name="jyjj"></textarea>

                    </div>
                </div>
            </div>
            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px">抽样方法及数量:</label>

                    <div class="layui-input-inline" style="width: 700px">
                        <textarea placeholder="请输入内容" class="layui-textarea" id="cyffjsl" name="cyffjsl"></textarea>
                    </div>
                </div>
            </div>
            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px">封样和样品运输贮存:</label>

                    <div class="layui-input-inline" style="width: 700px">
                        <textarea placeholder="请输入内容" class="layui-textarea" id="fyhypyszc" name="fyhypyszc"></textarea>
                    </div>
                </div>
            </div>
            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px">判断原则与结论:</label>

                    <div class="layui-input-inline" style="width: 700px">
                        <textarea placeholder="请输入内容" class="layui-textarea" id="pdyzyjl" name="pdyzyjl"></textarea>
                    </div>
                </div>
            </div>
            <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 180px"><font class="myred">*</font>综合描述:</label>

                    <div class="layui-input-inline" style="width: 700px">
                        <textarea id="zhms" name="zhms" lay-verify="required"></textarea>
                    </div>
                </div>
            </div>

            <div class="layui-form-item" style="display: none">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="saveNews"
                            id="saveNewsBtn">保存
                    </button>
                </div>
            </div>
        </form>
    </div>

</div>
</body>
</html>