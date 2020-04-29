<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%@ page import="com.zzhdsoft.utils.db.DbUtils" %>
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
        // 是否采纳
        var v_type = [{"id":"1","text":"发文"},{"id":"2","text":"收文"}];
        var v_fwtype = [{"id":"2","text":"行政文件"},{"id":"1","text":"党组市直机关发文"},{"id":"3","text":"食安办发文"}];
        var index;
        var form;
        var layer;
        var layedit;
        var laydate;

        $(function () {
            if ('<%=op%>' == 'view') {
                $('#swzbh').attr('disabled', 'disabled');
            }
            intSelectData("messagetype", v_type);
            intSelectData("swzbh", v_fwtype)
            var id = '<%=v_arcid%>';
            fj();
            fjqt();
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
                var lock=true;
                form.on('submit(saveNews)', function (data) {
                    var formData=data.field;
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false;  //进来后，立马把锁锁住
                    $.post(basePath + '/egovernment/archive/addArchive', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == "0") {
                            /*layer.msg('保存成功！', {time: 1000}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
                                sy.setWinRet(obj);
                                closeWindow();
                            });*/
                            if (id != "" && id != null) {
                                layer.msg('保存成功！', {time: 1000}, function () {
                                    var obj = new Object();
                                    obj.type = "saveOk";
                                    sy.setWinRet(obj);
                                    closeWindow();
                                });
                            }else{
                                debugger
                                var ywbh='<%=id%>';
                                var comdm="11";
                                var commc="[发文]"+$("#archivetitle").val();
                                var yewumcpym="gwglfwlc";
                                var transval="";
                                var yewutablename="egarchiveinfo";
                                var yewucolname="archiveid";
                                var swzbh=$("#swzbh").val();
                                var fzruserid="";
                                var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWffwprocess?"+
                                    "ywbh="+ywbh+
                                    "&comdm="+comdm+
                                    "&commc="+commc+
                                    "&swzbh="+swzbh+
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
                                            /*layer.msg('受理成功！', {time: 1000
                                            }, function () {
                                                parent.layer.close(parent.layer.getFrameIndex(window.name));
                                            });*/
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
                                    'json');

                            }
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

                if (id != "" && id != null) {
                    $.ajax({
                        type:'POST',
                        url:basePath + '/egovernment/archive/queryArchiveDTO',
                        dataType:'json',
                        data:{archiveid:id},
                        async:false,
                        success:function(result){
                            var mydata = result.data;
                            if(mydata){
//                                $('#archivecontent').val(mydata.archivecontent);
                                $("iframe[textarea='archivecontent']")[0].contentDocument.body.innerHTML=mydata.archivecontent;
                                $('form').form('load', mydata);
                            }
                        }
                    });
                    if ('<%=op%>' == 'view') {
                        $('form:input').addClass('input_readonly');
                        $('form:input').attr('readonly', 'readonly');
                        $('input').attr('disabled', 'true');
                        $('textarea').attr('disabled', 'true');
//                        console.log( $('#swzbh'))
                        $('#swzbh').attr('disabled', 'disabled');

                        $("iframe[textarea='archivecontent']")[0].contentDocument.body.contentEditable = false;

                    }
                }

            });
            ;
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
            if ('<%=op%>' == 'add') {
                var fjwid='<%=id%>';
            }else{
                var fjwid='<%=v_arcid%>';
            }
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传正文附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: fjwid,
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

            if ('<%=op%>' == 'add') {
                var fjwid='<%=id%>';
            }else{
                var fjwid='<%=v_arcid%>';
            }
            var url = basePath + "jsp/pub/egovernment/uploadViewWare.jsp";
            parent.sy.modalDialog({
                area: ['100%', '100%'],
                title: '上传其它附件'
                , content: url
                , param: {
                    folderName: "writing",
                    fjwid: fjwid,
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
        function fj() {
            var html = "";
            if ('<%=op%>' == 'add') {
                var fjwid='<%=id%>';
            }else{
                var fjwid='<%=v_arcid%>';
            }
            $.ajax({
                type: 'POST',
                url: basePath + '/workflow/FJ',
                dataType: 'json',
                data: {fjwid:fjwid, fjtype:'GWZWFJ'},
                async: false,
                success: function (result) {
                    var mydata = result.data;
                    for (var i = 0; i < mydata.length; i++) {
                        var a = mydata[i].fjname;
                        var b = mydata[i].fjpath;
                        html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

                    }
                }
            });
            $("#ceshi").html(html);
        }
        function fjqt() {
            var html = "";
            if ('<%=op%>' == 'add') {
                var fjwid='<%=id%>';
            }else{
                var fjwid='<%=v_arcid%>';
            }
            $.ajax({
                type: 'POST',
                url: basePath + '/workflow/FJ',
                dataType: 'json',
                data: {fjwid: fjwid,
                    fjtype:'GWQTFJ'
                },
                async: false,
                success: function (result) {
                    var mydata = result.data;
                    for (var i = 0; i < mydata.length; i++) {
                        var a = mydata[i].fjname;
                        var b = mydata[i].fjpath;
                        html += "<a href='javascript:;' onclick=check('" + b + "')>" + a + "</a></br>";

                    }
                }
            });
            $("#ceshinew").html(html);
        }

        function check(s) {
            window.open(s);

        }
	</script>
    <style>
        .layui-form-item{
            margin-left: 15%;
            margin-right: 15%;
        }
    </style>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <input id="archiveid" name="archiveid" type="hidden" value="<%=v_arcid%>"/>
            <input id="fileid" name="fileid" type="hidden" value="<%=id%>"/>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">文档编号:</label>

                <div class="layui-input-inline" style="width: 350px">
                    <input type="text" id="archivecode" name="archivecode"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px"><font class="myred">*</font>文档标题:</label>

                <div class="layui-input-inline" style="width: 650px">
                    <input type="text" id="archivetitle" name="archivetitle"
                           autocomplete="off" class="layui-input" lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">发文类型:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <select name="swzbh"  id="swzbh" autocomplete="off" ></select>
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
                <label class="layui-form-label" style="width: 90px">会稿:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="huigao" name="huigao"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">密级:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="rank" name="rank"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">期限:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="term" name="term"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">定密依据:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="fixedbasis" name="fixedbasis"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">主送:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="maindelivery" name="maindelivery"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">抄送:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="copy" name="copy"
                           autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">打字:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="typing" name="typing"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">校对:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="proofreading" name="proofreading"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">份数:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="number" name="number"
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label" style="width: 90px">封发时间:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="sealtime" name="sealtime"
                           autocomplete="off" class="layui-input">

                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">发文编号:</label>
                <label class="layui-form-label" style="width: 1px">中</label>
                <div class="layui-input-inline" style="width: 130px">


                    <input type="text" id="writing1" name="writing1"
                           autocomplete="off" class="layui-input">
                    <%--字(
                    <input type="text" id="writing2" name="writing2"
                           autocomplete="off" class="layui-input">)
                    <input type="text" id="writing3" name="writing3"
                           autocomplete="off" class="layui-input">号--%>
                </div>
                <label class="layui-form-label" style="width: 60px">(</label>
                <div class="layui-input-inline" style="width: 130px">
                    <input type="text" id="writing2" name="writing2"
                           autocomplete="off" class="layui-input" >

                </div>
                <label class="layui-form-label" style="width: 1px">)</label>

                <div class="layui-input-inline" style="width: 130px">
                    <input type="text" id="writing3" name="writing3"
                           autocomplete="off" class="layui-input" >

                </div>
                <label class="layui-form-label" style="width: 20px">号</label>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">主题词:</label>

                <div class="layui-input-inline" style="width: 250px">
                    <input type="text" id="thematicwords" name="thematicwords"
                           autocomplete="off" class="layui-input" >
                </div>
                    <label class="layui-form-label" style="width: 90px">收发文:</label>

                    <div class="layui-input-inline" style="width: 250px">
                        <select name="messagetype" disabled id="messagetype" autocomplete="off" ></select>
                    </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 90px">添加时间:</label>

                <div class="layui-input-inline" style="width: 350px">
                    <input type="text" id="archiveopperdate" name="archiveopperdate"
                           autocomplete="off" class="layui-input" >

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