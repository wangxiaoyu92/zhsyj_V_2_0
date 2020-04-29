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
	String v_fileid = StringHelper.showNull2Empty(request.getParameter("fileid"));
	String op = StringHelper.showNull2Empty(request.getParameter("op"));
%>
<!DOCTYPE html>
<html>
<head>
<title>公文管理</title>
<jsp:include page="${contextPath}/inc_check.jsp"></jsp:include>
<style type="text/css">
  body{
   overflow: scroll;
  }
 </style>

<script type="text/javascript">
	var layedit;
	var layer;
	var form;
	var table;
	var laydate;
	var index;
	$(function() {
	    layui.use(['form','table','layedit','laydate','layer'],function () {
			form=layui.form,table=layui.table,layedit=layui.layedit,laydate=layui.laydate,layer=layui.layer;
			index=layedit.build('filecontent');
			laydate.render({
				elem:'#fileopperdate',
				type:'datetime'
            })
            if ($('#fileid').val().length > 0) {
                $.post(basePath + '/egovernment/archive/queryGdarchive', {
                        fileid : $('#fileid').val()
                    },
                    function(result) {
                        if (result.code=='0') {
                            var mydata = result.data;
                            $('form').form('load', mydata);
                            //富文本编辑器手动赋值  因为自动渲染一直失败——
                            $("iframe[textarea='filecontent']")[0].contentDocument.body.innerHTML=mydata.filecontent;
                            if('<%=op%>' == 'view'){
                                $('form :input').addClass('input_readonly');
                                $('form :input').attr('readonly','readonly');
                                $("#fileopperdate").attr("disabled",true);
                                //富文本编辑器只读
                                $("iframe[textarea='filecontent']")[0].contentDocument.body.contentEditable=false;
                            }

                        } else {
                            layer.alert('提示:查询失败：'+result.msg);
                        }
                    }, 'json');
            }
        });


	});

	// 保存
	var submitForm = function($dialog, $grid, $pjq) {
        layedit.sync(index);
		$pjq.messager.progress();	// 显示进度条
		var url;
		if($('#archiveid').val().length > 0){
			url = basePath + '/egovernment/archive/addArchive';
		}else{
			url = basePath + '/egovernment/archive/addArchive';
		}
		//下面的例子演示了如何提交一个有效并且避免重复提交的表单
		$.messager.progress();	// 显示进度条
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){
				var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交.
				if(!isValid){
					$pjq.messager.progress('close');	// 如果表单是无效的则隐藏进度条
				}
				return isValid;
	        },
	        success: function(result){
	        	$pjq.messager.progress('close');// 隐藏进度条
	        	result = $.parseJSON(result);
			 	if (result.code=='0'){
			 		$.messager.alert('提示','保存成功！','info',function(){
						 $grid.datagrid('load');
	        			$dialog.dialog('destroy');
	        		});
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }
		});
	};
	// 关闭窗口
	var closeWindow = function($dialog, $pjq){
     	$dialog.dialog('destroy');
	 };
</script>
</head>
<body>
		<form id="fm" class="layui-form" action="">
			<input id="fileid" name="fileid" type="hidden" value="<%=v_fileid%>"/>
			<table class="layui-table" lay-skin="nob">
				<tr>
					<td style="text-align:right;;width: 141px;height: 57px"><nobr>文档编号：</nobr></td>
					<td><input type="text" id="filecode" name="filecode"
							   class="layui-input"></td>
				</tr>
				<tr>
					<td style="text-align:right;;width: 141px;height: 57px"><nobr>文档标题：</nobr></td>
					<td><input type="text" id="filetitle" name="filetitle" lay-verify="required"
							   class="layui-input"></td>
				</tr>
				<tr>
					<td style="text-align:right;;width: 141px;height: 57px"><nobr>添加时间：</nobr></td>
					<td><input type="text" id="fileopperdate" name="fileopperdate" lay-verify="required"
							   class="layui-input"></td>
				</tr>
				<tr>
					<td style="text-align:right;;width: 141px;"><nobr>文档内容：</nobr></td>
					<td>
						<textarea id="filecontent" name="filecontent"></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;;width: 141px;"><nobr>备注：</nobr></td>
					<td>
						<textarea class="layui-textarea" id="fileremark" name="fileremark"></textarea>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>