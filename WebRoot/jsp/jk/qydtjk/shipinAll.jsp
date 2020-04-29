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

%>
<%
	String eventjdzb = StringHelper.showNull2Empty(request.getParameter("eventjdzb"));
	String eventwdzb = StringHelper.showNull2Empty(request.getParameter("eventwdzb"));
	String eventcontent = StringHelper.showNull2Empty(request.getParameter("eventcontent"));
	String operateperson = StringHelper.showNull2Empty(request.getParameter("operateperson"));
%>
<!DOCTYPE html>
<html>
<head>
	<title>极光推送内容</title>
	<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
	<script type="text/javascript">
        $(function () {

            layui.use(['form', 'layer', 'laydate','table'], function () {
                form = layui.form;
                layer = layui.layer;
                laydate = layui.laydate;
                table = layui.table;

                form.on('submit(saveRole)', function (data) {
                    var checkStatus = table.checkStatus('allusergrid');
                    var v_usergridData = checkStatus.data;
                    if (v_usergridData==null || v_usergridData.length==0){
                        $.messager.alert('提示', '请选择人员！', 'info');
                        return false;
                    }
                    v_usergridData=$.toJSON(v_usergridData);

                    var eventjdzb=$("#eventjdzb").val();
                    var eventwdzb=$("#eventwdzb").val();
                    var v_eventcontent=$("#eventcontent").val();
                    var operateperson=$("#operateperson").val();
                    //$("#texts").val(v_eventcontent);

                    //var formData = data.field;
                    //var texts=$("#texts").val();
					/*console.log(formData)*/
                    $.post(basePath + '/common/sjb/jpushMinglingMsgAll', {
                            "eventjdzb": eventjdzb,
                            "eventwdzb": eventwdzb,
                            // "eventcontent": prm_jpushInfo,
                           // "operateperson": userid,
                            "jpushmingling":"yingjishipin",
                            "jpushtitle":"应急视频",
                            "jpushcontent":v_eventcontent,
						    "usergridstr":v_usergridData
                        },
                        function (result) {
                            if (result.code == '0') {
                                $.messager.alert('提示', '发送视频调度通知成功！', 'info');
                                closeWindow();

                            } else {
                                $.messager.alert('提示', '发送视频调度通知失败：' + result.msg, 'error');
                            }
                        },
                        'json');
                    return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
                });

                table.render({
                    elem: '#allusergrid'
                    , method: 'post' // 如果无需自定义HTTP类型，可不加该参数
                    , url: basePath + 'sysmanager/sysuser/querySysuserNocom'
                    , page: true // 展示分页
					,height:380
                    , limit: 500 // 每页展示条数
                    , limits: [500, 1000, 1500] // 每页条数选择项
                    , cellMinWidth: 80 //全局定义常规单元格的最小宽度
                    , request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'rows' //每页数据量的参数名，默认：limit
                    }
                    , response: {
                        countName: 'total' //数据总数的字段名称，默认：count
                        , dataName: 'rows' //数据列表的字段名称，默认：data
                    }
                    , cols: [[
                        {type: 'checkbox'}
                        ,{field: 'orgname', title: '机构名称', width: 150}
                        //,{field: 'userid', title: '用户ID', width: 210}
                        //, {field: 'username', title: '用户名称', width: 120}
                        , {field: 'description', title: '用户描述', width: 150}
                        , {field: 'mobile', title: '手机号', event: 'trclick'}
                        , {field: 'mobile2', title: '手机号2', event: 'trclick'}
                        //, {field: 'aaa027name', title: '统筹区', event: 'trclick'}
                    ]]
                });
                
            })
        })
        function submitForm() {
            $("#saveRoleBtn").click();
        }

        // 关闭窗口
        function closeWindow() {
            parent.layer.close(parent.layer.getFrameIndex(window.name));
        }



	</script>
</head>
<body>
	<form class="layui-form" action="" id="pcompany">
		<input type="hidden" name="eventjdzb" id="eventjdzb" value="<%=eventjdzb %>">
		<input type="hidden" name="eventwdzb" id="eventwdzb" value="<%=eventwdzb %>">
		<input type="hidden" name="eventcontent" id="eventcontent" value="<%=eventcontent %>">
		<input type="hidden" name="operateperson" id="operateperson" value="<%=operateperson %>">
		<div style="padding: 20px; background-color: #F2F2F2;">
			<div class="layui-row layui-col-space15">
<%--				<div class="layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">请输入发送的消息</div>
						<div class="layui-card-body">

							<textarea id="texts" name="texts"  style="width: 420px;" rows="6" placeholder="请输入内容" class="layui-textarea" value="<%=eventcontent%>"></textarea>


							<div class="layui-form-item" style="display: none">
								<div class="layui-input-block">
									<button class="layui-btn" lay-submit="" lay-filter="saveRole"
											id="saveRoleBtn">确定
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>--%>
				<div class="layui-col-md12">
					<div class="layui-card">
						<div class="layui-card-header">请选择人员</div>
						<div class="layui-card-body">
							<table class="layui-hide" id="allusergrid" lay-filter="tableFilter" ></table>
							<div class="layui-form-item" style="display: none">
								<div class="layui-input-block">
									<button class="layui-btn" lay-submit="" lay-filter="saveRole"
											id="saveRoleBtn">确定
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


	</form>

</body>
</html>