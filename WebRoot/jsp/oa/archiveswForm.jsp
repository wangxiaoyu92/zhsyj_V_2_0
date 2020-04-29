<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.db.DbUtils" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	String id=DbUtils.getSequenceStr();
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String v_arcid = StringHelper.showNull2Empty(request.getParameter("archiveid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>公文管理</title>
	<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<style type="text/css">
		body{
			overflow: scroll;
		}
	</style>
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
	<script src="<%=basePath %>jslib/ckeditor_4.7.0/ckeditor.js"></script>
	<script type="text/javascript">
        var index;
        var form;
        var layer;
        var layedit;
        var laydate;
        var v_lwjg = <%=SysmanageUtil.getAa10toJsonArray("lwjg")%>; // 来文机关

        $(function () {
            $.ajax({
                type: 'POST',
                url: basePath + '/workflow/queryWfywlcuser',
                dataType: 'json',
                data: {
                    psbh: 'WF2018051100356',
                    nodeid: 17
                },
                async: false,
                success: function (result) {
                    var mydata = result.fzruserid;
                    $("#cyryid").val(mydata);
                }
            })
            layui.use(['form', 'layer', 'laydate', 'layedit'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                layedit=layui.layedit;
                var myDate = new Date();
                laydate.render({
                    elem: '#archiveopperdate',
                    type:'datetime'
                    ,value: myDate
                });
                laydate.render({
                    elem: '#sealtime',
                    type:'datetime'
                    ,value: myDate
                });
                index=layedit.build('archivecontent');
                form.on('select()', function(data){
                    var lw=$("#lwjg").val();
                    $.ajax({
                        type:'POST',
                        url:basePath + '/egovernment/archive/querySwbianhao',
                        dataType:'json',
                        data:{ lwjg:lw},
                        async:false,
                        success:function(result){
                            var mydata = result.data;
                            $("#writing3").val(mydata);
                            $("#swzbh").val(lw+mydata);
                        }
                    });
                    if(lw=='1'){
                        $("#archivetitle").val("河南省食品药品监督管理局");
                        $("#writing1").val("豫食药监");
                    }else{
                        $("#archivetitle").val("");
                        $("#writing1").val("");
                    }
                });
                var lock=true;
                form.on('submit(saveNews)', function (data) {
                    var formData=data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + '/egovernment/archive/addArchive?', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });
                            /*var ywbh='<%=id%>';
                            var comdm="11";
                            var commc="[收文]"+$("#archivetitle").val();
                            var yewumcpym="gwglswlc";
                            var transval="";
                            var yewutablename="egarchiveinfo";
                            var yewucolname="archiveid";
                            var fzruserid=$("#cyryid").val();
                            var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?"+
                                "ywbh="+ywbh+
                                "&comdm="+comdm+
                                "&commc="+commc+
                                "&yewumcpym="+yewumcpym+
                                "&transval="+transval+
                                "&yewutablename="+yewutablename+
                                "&fzruserid="+fzruserid+
                                "&yewucolname="+yewucolname+
                                "&time="+new Date().getMilliseconds()));
                                    $.post(v_url, {
                                        },
                                        function (result) {
                                            if (result.code == '0') {
                                                /!*layer.msg('受理成功！', {time: 1000
                                                }, function () {
                                                    parent.layer.close(parent.layer.getFrameIndex(window.name));
                                                });*!/
                                                layer.msg('保存成功,已经开始受理！', {time: 1000}, function () {
                                                    var obj = new Object();
                                                    obj.type = "saveOk";
                                                    sy.setWinRet(obj);
                                                    closeWindow();

                                                });
                                            } else {
                                                layer.open({
                                                    title: "提示",
                                                    content: "受理失败：" + result.msg //这里content是一个普通的String
                                                });
                                            }
                                        },
                                        'json');*/




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


            });
            intSelectData('lwjg', v_lwjg);

            var id = $("#archiveid").val();
            if (id != "" && id != null) {
                $.ajax({
                    type:'POST',
                    url:basePath + '/egovernment/archive/queryArchiveDTO',
                    dataType:'json',
                    data:{archiveid:$('#archiveid').val()},
                    async:false,
                    success:function(result){
                        var mydata = result.data;
                        $('#archivecontent').val(mydata.archivecontent);
                        $('form').form('load', mydata);
                        form.render();
                    }
                });
                if ('<%=op%>' == 'view') {
                    $('form:input').addClass('input_readonly');
                    $('form:input').attr('readonly', 'readonly');
                    $('input').attr('disabled', 'true');
                    CKEDITOR.on('instanceReady', function (ev) {
                        editor = ev.editor;
                        editor.setReadOnly(true);
                    });

                }
            }
            var myyear = new Date();
            var year=myyear.getFullYear();
            $("#writing2").val(year.toString());


        });


        // 保存
        function saveFun() {
            layedit.sync(index);//同步富文本框内容到文本框中
//            if ($('#archivecontent').val()) {//文本框有内容时清空样式
//                $('.layui-layedit').removeAttr("style");
//            }else{//无内容显示红色边框
//                $('.layui-layedit').css('border-color', 'red');
//            }
            $("#saveNewsBtn").click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        // 上传图片附件
        function uploadFjView(type) {
            var id = "<%=id%>"
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传正文附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: id,
                    fjtype: type
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    /*$("#ceshi").html(myrow.fjpath);*/ //人员id
                    var html = $("#ceshi").html();
                    html = "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
                    $("#ceshi").html(html);
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }


        function uploadFjViewqt(type) {

            var id = "<%=id%>"
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传其它附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: id,
                    fjtype: type
                }
            }, function (dialogID) {
                var obj = sy.getWinRet(dialogID);
                if (obj == null || obj == '') {
                    return;
                }
                if (obj.type == "ok") {
                    var myrow = obj.data;
                    /*$("#ceshi").html(myrow.fjpath);*/ //人员id
                    var html = $("#ceshinew").html();
                    html += "<a href='javascript:;' onclick=check('" + myrow.fjpath + "')>" + obj.fjname + "</a></br>";
                    $("#ceshinew").html(html);
                }
                sy.removeWinRet(dialogID);//不可缺少
                if (obj != null) {
                    if (obj.type == 'ok') {
                        //
                    }
                }
            });
        }
        function check(s) {
            window.open(s);

        }



	</script>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="archiveid" name="archiveid" type="hidden" value="<%=v_arcid%>"/>
            <input id="fileid" name="fileid" type="hidden" value="<%=id%>"/>
            <input id="messagetype" name="messagetype" type="hidden" value="2"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>来文机关:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <select name="lwjg" id="lwjg" autocomplete="off" lay-verify="required"></select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>收文总编号:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="swzbh" name="swzbh" lay-verify="required"
                           autocomplete="off" class="layui-input">
                    <input id="cyryid" name="cyryid" type="hidden"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>文档标题:</label>

                <div class="layui-input-inline" style="width: 630px">
                    <input type="text" id="archivetitle" name="archivetitle"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">来文字号:</label>
                <div class="layui-input-inline" style="width: 130px">
                    <input type="text" id="writing1" name="writing1"
                           autocomplete="off" class="layui-input"><%--字(
                    <input type="text" id="writing2" name="writing2"
                           autocomplete="off" class="layui-input">)
                    <input type="text" id="writing3" name="writing3"
                           autocomplete="off" class="layui-input">号--%>
                </div>
                <label class="layui-form-label" style="width: 20px">字(</label>
                <div class="layui-input-inline" style="width: 130px">
                    <input type="text" id="writing2" name="writing2"
                           autocomplete="off" class="layui-input">

                </div>
                <label class="layui-form-label" style="width: 1px">)</label>

                <div class="layui-input-inline" style="width: 130px">
                    <input type="text" id="writing3" name="writing3"
                           autocomplete="off" class="layui-input">

                </div>
                <label class="layui-form-label" style="width: 20px">号</label>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">收文时间:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="sealtime" name="sealtime" lay-verify="required"
                           autocomplete="off" class="layui-input">

                </div>
                <label class="layui-form-label" style="width: 90px">添加时间:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="archiveopperdate" name="archiveopperdate" lay-verify="required"
                           autocomplete="off" class="layui-input">

                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">密级:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="rank" name="rank"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">份数:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="number" name="number"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">正文附件:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <span class="font_main" style="padding-top: 50px"></span>
                    <a id="btnselectcom" href="javascript:void(0)"
                       class="layui-btn" iconCls="icon-upload"
                       onclick="uploadFjView('GWZWFJ')">上传正文附件</a><br/>
                    <span id="ceshi"></span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">其它附件:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <span class="font_main" style="padding-top: 50px"></span>
                    <a id="btnselectcomnew" href="javascript:void(0)"
                       class="layui-btn" iconCls="icon-upload"
                       onclick="uploadFjViewqt('GWQTFJ')">上传其它附件</a><br/>
                    <span id="ceshinew"></span>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">文档内容:</label>
                <div class="layui-input-inline" style="width: 650px">
                    <textarea id="archivecontent" name="archivecontent"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">备注:</label>

                <div class="layui-input-inline" style="width: 650px">
                    <textarea placeholder="请输入内容" class="layui-textarea" id="archiveremark" name="archiveremark"></textarea>
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