<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加预案信息</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
        //下拉框列表
        var newscate = <%=SysmanageUtil.getNewsCateOfYjyaToJsonArray()%>;
        var sfyx = <%=SysmanageUtil.getAa10toJsonArray("SFYX")%>;
        var form;
        var layer;
        var layedit;
        var index;
        $(function () {
//		var cateidOptions = '';
//		for (var i = 0; i < newscate.length; i++) {
//			cateidOptions += '<option value=\'' + newscate[i].id + '\' >' + newscate[i].text + '</option>';
//		}
//		$("#cateid").append(cateidOptions);
            layui.use(['form', 'layer', 'layedit'], function () {
                form = layui.form;
                layer = layui.layer;
                layedit = layui.layedit;
                index = layedit.build('newscontent'); //建立编辑器
                console.log(newscate);
                intSelectData('cateid', newscate);
                form.render();
                var url = basePath + '/news/saveNews';
                var lock = true;// 锁住表单   这里定义一把锁
                form.on('submit(save)', function (data) {
                    var newscontent = $("#newscontent").val();
                    var newstitle = $("#newstitle").val();
                    var newsispicture = $("#newsispicture").val();
                    var sfyx = $("#sfyx").val();
                    var newsfrom = $("#newsfrom").val();
                    var cateid = $("#cateid").val();
                    var newstjsj = $("#newstjsj").val();
                    var newsid = $("#newsid").val();
                    var formData = {
                        "newsid": newsid, "newstjsj": newstjsj, "cateid": cateid, "newsfrom": newsfrom,
                        "sfyx": sfyx, "newsispicture": newsispicture, "newstitle": newstitle,
                        "newscontent": newscontent
                    };
                    if (newscontent.length == 0) {
                        layer.alert('请输入预案内容！');
                        return false;
                    }
                    if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                        return false;
                    }
                    lock = false; //进来后，立马把锁锁住
                    $.post(url, formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 500}, function () {
                                var obj = new Object();
                                obj.type = "saveOk";
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
            });
        });


        // 保存
        function saveYaxx() {
            layedit.sync(index);//同步富文本框内容到文本框中
            $("#saveYaxxBtn").click();
        }
        //关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" action="">
            <div class="layui-container">
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">预案编号：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="newsid" name="newsid" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">添加时间：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="newstjsj" name="newstjsj" readonly
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%"><span style="color: red;">*</span>预案分类：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <select id="cateid" name="cateid" lay-verify="required">
                                </select>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">预案来源：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="newsfrom" name="newsfrom"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">是否有效：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <select id="sfyx" name="sfyx">
                                    <option value="1">有效</option>
                                    <option value="0">无效</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">是否图片预案：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <select id="newsispicture" name="newsispicture">
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>预案标题：</label>

                            <div class="layui-input-inline" style="width: 80%">
                                <input type="text" id="newstitle" name="newstitle" required lay-verify="required"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <label class="layui-form-label" style="width: 10%"><span style="color: red;">*</span>预案内容：</label>
                            <div height="100px" class="layui-input-inline" style="width: 80%">
                                <textarea id="newscontent" name="newscontent"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item" style="display: none">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="save" id="saveYaxxBtn">保存
                        </button>
                    </div>
                </div>
            </div>

        </form>
    </div>
</div>
</body>
</html>