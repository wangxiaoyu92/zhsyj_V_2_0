<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
	String jklx = StringHelper.showNull2Empty(request.getParameter("jklx"));
	String camorgid = StringHelper.showNull2Empty(request.getParameter("camorgid"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>监控摄像头列表【自动播放】</title>
	<jsp:include page="${contextPath}/inc_spjk.jsp"></jsp:include>
	<script type="text/javascript">
        var basePath = '<%=basePath%>';
        //企业id
        var jkqybh = '<%=comid%>';
        var jklx = '<%=jklx%>';
        var camorgid = '<%=camorgid%>';

        $(function() {
            loadCameraList();
            if (jkqybh != '') {
                loadJkComFzr();
            }
        });

        // 获取监控企业的负责人
        function loadJkComFzr(){
            $.ajax({
                type: "POST",
                dataType: "json",
                url: basePath+'/jk/jkgl/queryJkfzrList',
                data : {'comid' : jkqybh },
                success: function(data) {
                    var userInfos = data.rows;
                    if (userInfos.length > 0) {
                        for (var i = 0; i < userInfos.length; i++) {
                            if (userInfos[i].username != null && userInfos[i].username != '') {
                                $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].username + "</span>");
                            }
                            if (userInfos[i].mobile2 != null && userInfos[i].mobile2 != '') {
                                $("#fzrinfo").append("<span style='margin-left: 30px;'>" + userInfos[i].mobile2 + "</span>");
                            }
                        }
                    }
                }
            });
        }

        //获取企业的视频摄像头列表
        function loadCameraList(){
            $.ajax({
                type: "POST",
                dataType: "json",
                url: basePath+'/jk/jkgl/getJkyList',
                data : {'jkqybh' : jkqybh,'jklx' : jklx,'camorgid' : camorgid},
                success: function(data) {
                    if (data.total<=0){
                        var html = "";
                        html += " <table width=\"100%\"  style=\"text-align:left;margin-top:15px;\">";
                        html += " <tr>";
                        html += "     <td  style=\"font-size:16px;color: red;\">未获取到监控源【监控摄像头不在线或监控服务器出现问题】，请联系系统管理员！</td>";
                        html += " </tr>";
                        html += " <tr>";
                        html += "</table>";
                        $(".mclzPlayer").append(html);
					}
                    var cams = data.rows;
                    loadCameraPlayer(cams);
                }
            });
        }

        function loadCameraPlayer(cams){
            for(var i=0;i<cams.length;i++){
                var jkybh = cams[i].ocxId;
                var v_camName=cams[i].camName;//gu20180420
                $(".mclzPlayer").append("<div id='p_"+jkybh+"' class='player4'></div>");
                addRtmpPlayNewObj(jkybh);
            }
        }

        // 关闭窗口
        var closeWindow = function($dialog, $pjq){
            $dialog.dialog('destroy');
        };
	</script>
</head>
<body>
<div id="fzrinfo" style="height: 40px; color: blue; font-size: 20px; margin-left: 30px;"></div>
<div class="mclzPlayer" ></div>
</body>
</html>