<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.news.News"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	String ywbh = StringHelper.showNull2Empty(request.getParameter("ywbh"));
	String comdm = StringHelper.showNull2Empty(request.getParameter("comdm"));
    String yewumcpym = StringHelper.showNull2Empty(request.getParameter("yewumcpym"));
    String transval = StringHelper.showNull2Empty(request.getParameter("transval"));
    String yewutablename = StringHelper.showNull2Empty(request.getParameter("yewutablename"));
    String yewucolname = StringHelper.showNull2Empty(request.getParameter("yewucolname"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>收文管理</title>
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
        var layer;
        var form;
        $(function () {
            layui.use(['form', 'layer'], function () {
                form = layui.form;
                layer = layui.layer;
            });
            });






        //关闭窗口
        function closeWindow() {
            var ywbh='<%=ywbh%>';
            var comdm='<%=comdm%>';
            var commc="";
            var yewumcpym='<%=yewumcpym%>';
            var transval='<%=transval%>';
            var yewutablename='<%=yewutablename%>';
            var yewucolname='<%=yewucolname%>';
            var fzruserid=$("#workTaskDutyPerson").val();
            var cfmMsg= "确定要受理申请编号为【"+ywbh+"】的记录吗?";
            $.ajax({
                type:'POST',
                url:basePath + '/egovernment/archive/queryArchiveDTO',
                dataType:'json',
                data:{archiveid:ywbh},
                async:false,
                success:function(result){
                    var mydata = result.data;
                    commc="[收文]"+mydata.archivetitle;
                }
            });
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
            layer.open({
                title: '确认'
                , content: cfmMsg
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(v_url, {
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('受理成功！', {time: 1000
                                }, function () {
                                    parent.layer.close(parent.layer.getFrameIndex(window.name));
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
            });
        }

        //关闭窗口
        function closeWindowfw() {
            var ywbh='<%=ywbh%>';
            var comdm='<%=comdm%>';
            var commc="";
            var yewumcpym='<%=yewumcpym%>';
            var transval='<%=transval%>';
            var yewutablename='<%=yewutablename%>';
            var yewucolname='<%=yewucolname%>';
            var fzruserid=$("#workTaskDutyPerson").val();
            var cfmMsg= "确定要受理申请编号为【"+ywbh+"】的记录吗?";
            $.ajax({
                type:'POST',
                url:basePath + '/egovernment/archive/queryArchiveDTO',
                dataType:'json',
                data:{archiveid:ywbh},
                async:false,
                success:function(result){
                    var mydata = result.data;
                    commc="[发文]"+mydata.archivetitle;
                }
            });
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
            layer.open({
                title: '确认'
                , content: cfmMsg
                , btn: ['确定', '取消'] //可以无限个按钮
                , btn1: function (index, layero) {
                    $.post(v_url, {
                        },
                        function (result) {
                            if (result.code == '0') {
                                layer.msg('受理成功！', {time: 1000
                                }, function () {
                                    parent.layer.close(parent.layer.getFrameIndex(window.name));
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
            });
        }

        function myselectAjdjXgry_layui(prm_rykind){
            var v_useridstr=$("#workTaskDutyPerson").val();
            var url = "<%=basePath%>jsp/pub/pub/selectuserMore.jsp?useridstr="+v_useridstr+"&a="+new Date().getMilliseconds();
            var v_comrcjdglryid="";
            var v_comrcjdglryname="";
            parent.sy.modalDialog({
                title:'选择人员'
                ,area : ['100%','100%']
                ,content:url
                ,btn:['保存']
                ,btn1: function(index, layero){
                    parent.window[layero.find('iframe')[0]['name']].queding();
                }
            },function (dialogID) {
                var v_retStr = sy.getWinRet(dialogID);
                sy.removeWinRet(dialogID);//不可缺少

                if (v_retStr!=null && v_retStr.length>0){
                    for (var k=0;k<=v_retStr.length-1;k++){
                        var myrow = v_retStr[k];
                        if (""==v_comrcjdglryid){
                            v_comrcjdglryid=myrow.userid;
                            v_comrcjdglryname=myrow.description;
                        }else{
                            v_comrcjdglryid=v_comrcjdglryid+","+myrow.userid;
                            v_comrcjdglryname=v_comrcjdglryname+","+myrow.description;
                        }
                    }
                    $("#comrcjdglry").val(v_comrcjdglryname);
                    $("#workTaskDutyPerson").val(v_comrcjdglryid);
                }
            });
        }
        function myclearRcjdgly(){
            $("#comrcjdglry").val('');
            $("#workTaskDutyPerson").val('');
        }
	</script>
</head>
<body>

<div class="layui-table">
    <div region="center" style="overflow: hidden;" border="false">
        <form id="fm" class="layui-form" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">负责人:</label>
                <div class="layui-input-inline">
                    <input type="text" id="comrcjdglry" name="comrcjdglry"
                           autocomplete="off" class="layui-input" readonly="readonly">
                    <input type="hidden" id="workTaskDutyPerson" name="workTaskDutyPerson">

                </div>
                <div class="layui-input-inline" id="a">
                    <a href="javascript:void(0)" class="layui-btn" id="btn_rcjdglry"
                       iconCls="icon-search" onclick="myselectAjdjXgry_layui(1)">选择人员 </a>
                    &nbsp;&nbsp;
                    <a href="javascript:void(0)" class="layui-btn" id="remove"
                       iconCls="icon-no" onclick="myclearRcjdgly()">清除 </a>
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