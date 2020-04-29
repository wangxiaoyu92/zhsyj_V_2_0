<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News" %>
<%@ page import="com.zzhdsoft.utils.StringHelper,com.zzhdsoft.utils.SysmanageUtil" %>
<%
    String contextPath = request.getContextPath();
    String basePath = GlobalConfig.getAppConfig("apppath");
    if (null == basePath || "".equals(basePath)) {
        basePath = request.getScheme() + "://" + request.getServerName()
                + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<%
    News news = (News) request.getAttribute("news");
    String newsid = StringHelper.showNull2Empty(news.getNewsid());
    String cateid = StringHelper.showNull2Empty(news.getCateid());
    String newsauthor = StringHelper.showNull2Empty(news.getNewsauthor());
    String newsfrom = StringHelper.showNull2Empty(news.getNewsfrom());
    String newscontent = StringHelper.showNull2Empty(news.getNewscontent());
    String newsispicture = StringHelper.showNull2Empty(news.getNewsispicture());
    String newstitle = StringHelper.showNull2Empty(news.getNewstitle());
    String newstjsj = StringHelper.showNull2Empty(news.getNewstjsj());
    String sfyx = StringHelper.showNull2Empty(news.getSfyx());
%>
<!DOCTYPE html>
<html>
<head>
    <title>编辑新闻</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
    <script type="text/javascript">
        var newscate = <%=SysmanageUtil.getNewsCatetoJsonArray()%>;
        //下拉框列表
        var form;
        var layer;
        var layedit;
        var index;

        $(function () {
            layui.use(['form', 'layer', 'layedit'], function () {
                form = layui.form;
                layer = layui.layer;
                layedit = layui.layedit;
                layedit.set({
                    uploadImage: {
                        url: '<%=contextPath%>/news/uploadnewsTp' //接口url
                        , type: 'post' //默认post
                    }
                });
                index = layedit.build('newscontent'); //建立编辑器
                form.on('submit(save)', function (data) {
                    var formData = data.field;
                    $.post(basePath + 'news/saveNews', formData, function (result) {
                        result = $.parseJSON(result);
                        if (result.code == '0') {
                            layer.msg('保存成功', {time: 1000}, function () {
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
                    });
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });
            });
        });
        $(function () {
            //获取是否有效
            var sfyx =<%=sfyx%>;
            //设置默认选中
            $('#sfyx').val(sfyx);
            //获取是否图片
            var newsispicture =<%=newsispicture%>;
            //设置默认选中
            $('#newsispicture').val(newsispicture);
            $("#catename").val(sy.formatGridCode(newscate, $("#cateid").val()));
        });

        //表单提交
        function submitForm() {
            layedit.sync(index);//同步富文本框内容到文本框中
            $("#saveNewsBtn").click();
        }
        //关闭
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }
        function showCate() {
            var cityObj = $("#catename");
            var cityOffset = $("#catename").offset();
            $("#cateContent").css({
                left: cityOffset.left + "px",
                top: cityOffset.top + cityObj.outerHeight() + "px"
            }).slideDown("fast");
            $("body").bind("mousedown", onBodyDown);
            refreshZTree();
        }
        function onBodyDown(event) {
            if (!(event.target.id == "cateBtn" || event.target.id == "cateContent"
                    || $(event.target).parents("#cateContent").length > 0)) {
                hideMenu();
            }
        }
        function hideMenu() {
            $("#cateContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        var setting = {
            view: {
                showLine: true
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "cateid",
                    pIdKey: "cateparentid",
                    rootPId: 0
                },
                key: {
                    name: "catename"
                }
            },
            callback: {
                onClick: onClick
            }
        };
        function refreshZTree() { //初始化父菜单下拉框
            //初始化树
            $.post(basePath + '/newscate/queryNewcateZTree', {}, function (result) {
                if (result.code == '0') {
                    //准备zTree数据
                    var zNodes = eval(result.mydata);
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                } else {
                    layer.alert(result.msg);
                }
            }, 'json');
        }
        //单击节点事件
        function onClick(event, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            var nodes = zTree.getSelectedNodes();
            $("#cateid").val(nodes[0].cateid);
            $("#catename").val(nodes[0].catename);
            hideMenu();
        }
    </script>
</head>
<body>
<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <div class="layui-container">
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">新闻编号：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="newsid" name="newsid" readonly value="<%=newsid %>"
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">添加时间：</label>

                            <div class="layui-input-inline" style="width:50%">
                                <input type="text" id="newstjsj" name="newstjsj" readonly
                                       value="<%=news.getNewstjsj() %>"
                                       autocomplete="off" class="layui-input layui-bg-gray">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%"><span
                                    style="color: red;">*</span>新闻分类：</label>

                            <div class="layui-input-inline layui-input-treeselect" style="width: 50%">
                                <input type="text" name="catename" id="catename" lay-verify="required"
                                       onclick="showCate();" class="layui-input layui-bg-gray">
                                <input name="cateid" id="cateid" type="hidden" value="<%=cateid %>"/>
                            </div>
                            <div id="cateContent" class="cateContent" style="display:none;position:fixed;z-index:333;">
                                <ul id="treeDemo" class="ztree" style="height:250px;width: auto;"></ul>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">新闻来源：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <input type="text" id="newsfrom" name="newsfrom" value="<%=newsfrom %>"
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
                                <select id="sfyx" name="sfyx" lay-verify="required">
                                    <option value="-1" disabled></option>
                                    <option value="0">无效</option>
                                    <option value="1">有效</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-col-md6 layui-col-xs6 layui-col-sm6">
                            <label class="layui-form-label" style="width: 20%">是否图片新闻：</label>

                            <div class="layui-input-inline" style="width: 50%">
                                <select id="newsispicture" name="newsispicture" lay-verify="required">
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
                            <label class="layui-form-label" style="width: 10%"><span
                                    style="color: red;">*</span>新闻标题：</label>

                            <div class="layui-input-inline" style="width: 80%">
                                <input type="text" id="newstitle" name="newstitle" lay-verify="required"
                                       placeholder="请输入标题"
                                       value="<%=newstitle %>" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-row">
                        <div class="layui-col-md12 layui-col-xs12 layui-col-sm12">
                            <label class="layui-form-label" style="width: 10%">新闻内容：</label>

                            <div height="100px" class="layui-input-inline" style="width: 80%">
                                <textarea id="newscontent" name="newscontent"><%=newscontent%></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item" style="display: none">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit="" lay-filter="save"
                                id="saveNewsBtn">保存
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>