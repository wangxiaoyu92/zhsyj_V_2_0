<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zzhdsoft.siweb.dto.FjDTO" %>
<%@ page import="com.zzhdsoft.utils.StringHelper" %>

<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + contextPath + "/";
%>
<%
    List fjList = (List) request.getAttribute("fjList");
    String url = (String) request.getAttribute("url");
    String v_ZuoWeiIframe = StringHelper.showNull2Empty(request.getParameter("ZuoWeiIframe"));
    if (v_ZuoWeiIframe == null || "".equals(v_ZuoWeiIframe)) {
        v_ZuoWeiIframe = "0";
    }
    String op = StringHelper.showNull2Empty(request.getParameter("op"));  //选项
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>附件预览</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <jsp:include page="${contextPath}/inc_upload.jsp"></jsp:include>
    <script type="text/javascript">
        var s = new Object();
        s.type = "ok";
        sy.setWinRet(s);
        var layer;
        var form;
        $(function () {
            layui.use(['form', 'layer'], function () {
                layer = layui.layer;
                form = layui.form;
            })
        });

        //删除附件
        function delFj() {
            var fjid = [];
            $("input:checked").each(function () {
                fjid.push(this.value);
            });
            if (fjid.length > 0) {
                layer.open({
                    title: '警告!'
                    , btn: ['确定', '取消']
                    , content: '确定删除照片吗？'
                    , yes: function (index, layero) {
                        $.ajax({
                            url: basePath + '/pub/pub/delFj',
                            type: 'post',
                            async: true,
                            cache: false,
                            timeout: 100000,
                            data: 'fjid=' + fjid,
                            dataType: 'json',
                            error: function () {
                                layer.alert('服务器繁忙，请稍后再试！');
                            },
                            success: function (result) {
                                if (result.code == '0') {
                                    layer.open({
                                        title: '提示'
                                        , content: '删除成功'
                                        , yes: function (index, layero) {
//                                            parent.myrefreshfrm();//gu20170110
//                                            parent.iframeuse();//gu20170110
                                            window.location.reload();
                                        }
                                    });
                                } else {
                                    layer.alert('删除失败:' + result.msg);
                                }
                            }
                        });

                    }
                })
            }
            else {
                layer.alert('请先选择要删除的照片！');
            }

        }


        //关闭窗口
        function closeAndRefreshWindow() {
            parent.closeAndRefreshWindow();//gu20170110
        }

        //预览图片
        function showPic(imgUrl) {
            parent.parent.sy.modalDialog({
                title: '查看'
                , type: 2
                , content: imgUrl
                , area: ['100%', '100%']
                , btn: ['关闭']
            }, function () {
                //关闭窗口
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            });
        }

    </script>
</head>
<body>
<form id="fm" method="post">

    <%
        if (null != fjList && fjList.size() > 0) {
    %>
    <div class="layui-form box" id="box">
        <ul>
            <%
                FjDTO fj = null;
                for (int i = 0; i < fjList.size(); i++) {
                    fj = (FjDTO) fjList.get(i);
                    String fjpath = contextPath + fj.getFjpath();
                    String fjid = fj.getFjid();
                    String imgUrl = contextPath + "/jsp/pub/pub/pubUploadFjViewTool.jsp?img_src=" + fjpath;
            %>
            <li>
                <!--        	<a href="<%=fjpath %>" data-lightbox="fj" ><img class="example-image" src="<%=fjpath %>"  width="100%" height="100%"/></a><br/> -->
                <a onclick="showPic('<%=imgUrl %>');"><img src="<%=fjpath %>" width="100%"
                                                           height="100%"/></a><br/>

                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        <input type="checkbox" name="ck" value="<%=fjid %>" title="选择">
                    </div>
                </div>
            </li>
            <%
                }
            %>
        </ul>
    </div>
    <table style="width: 99%;">
        <tr>
            <td style="text-align:center;">
                <% if (op != null && !"view".equalsIgnoreCase(op)) { %>
                <input value="删除" type="button" class="layui-btn" onclick="delFj();">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <%} %>
                <% if (!"1".equalsIgnoreCase(v_ZuoWeiIframe)) { %>
                <input value="退出" type="button" class="layui-btn" onclick="closeAndRefreshWindow();">
                <%} %>
            </td>
        </tr>
    </table>
    <%
            //无主题上传图片回显
        }else if(!"".equals(url) && url!=null){
    %>
    <div class="layui-form box" id="box">
        <ul>
            <li>
                <a onclick="showPic('<%=contextPath+url %>');"><img src="<%=contextPath+url %>" width="100%"
                                                           height="100%"/></a><br/>
            </li>
        </ul>
    </div>
    <%}%>
</form>
</body>
</html>