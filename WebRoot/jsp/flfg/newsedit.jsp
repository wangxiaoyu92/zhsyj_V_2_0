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
%>
<%
	News news = (News)request.getAttribute("news");
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
<title>编辑法律法规</title>
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
	var form;
	var layer;
	var index;
	var layedit;
	var selectNodes;
	//下拉框列表
	var newscate = <%=SysmanageUtil.getNewsCatetoJsonArray()%>;
	function initSelectTreeData() {
		$.ajax({
			type: "POST",
			url: basePath + '/newscate/queryNewscateTree',
			success: function (result) {
				selectNodes = result.replace(/text/g, 'name'); // 将返回结果中‘text’全部替换为‘name’
				selectNodes = $.parseJSON(selectNodes);
			}
		});
	}
	$(function () {
		initSelectTreeData();
		layui.use(['form','layer','layedit'], function () {
			form = layui.form;
			layer = layui.layer;
			layedit = layui.layedit;
			index = layedit.build('newscontent'); //建立编辑器
            var lock=true;
			form.on('submit(saveNews)', function(data){
				var newscontent = $("#newscontent").val();
				var newstitle = $("#newstitle").val();
				var newsispicture = $("#newsispicture").val();
				var sfyx = $("#sfyx").val();
				var newsfrom = $("#newsfrom").val();
				var cateid = $("#cateid").val();
				var newstjsj = $("#newstjsj").val();
				var newsid = $("#newsid").val();
				var formData = {
					"newsid":newsid,"newstjsj":newstjsj,"cateid":cateid,"newsfrom":newsfrom,
					"sfyx":sfyx,"newsispicture":newsispicture,"newstitle":newstitle,
					"newscontent":newscontent
				};
                if(!lock){    // 判断该锁是否打开，如果是关闭的，则直接返回
                    return false;
                }
                lock = false;  //进来后，立马把锁锁住
				$.post(basePath + '/news/saveNews', formData, function (result) {
					result = $.parseJSON(result);
					if (result.code == "0"){
						layer.msg('保存成功！', {time : 1000},function(){
							var obj = new Object();
							obj.type = "ok";
							sy.setWinRet(obj);
							closeWindow();
						});
					} else {
						layer.open({
							title : "提示",
							content: "保存失败：" + result.msg //这里content是一个普通的String
						});
						lock=true;
					}
				});
				return false; // 阻止表单跳转。如果需要表单跳转，去掉这段即可。
			});
		});
		layui.config({
			base: basePath + 'jslib/plib/extend/' //自定义组件的目录--相对路径
		}).use(['treeselect'], function () {
			treeselect = layui.treeselect;
			treeselect.render({
				elem: "#cateid",
				data: selectNodes
			});
		});
	});
	// 保存

	function saveFun() {
		layedit.sync(index);//同步富文本框内容到文本框中
		if ($('#newscontent').val()) {//文本框有内容时清空样式
			$('.layui-layedit').removeAttr("style");
		}else{//无内容显示红色边框
			$('.layui-layedit').css('border-color', 'red');
		}
		$("#saveNewsBtn").click();
	}
	//关闭窗口
	function closeWindow(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}
</script>
</head>
<body>
<div class="layui-table">
	<div region="center" style="overflow: hidden;" border="false">
		<form id="fm" class="layui-form" method="post">
			<div class="layui-form-item">
				<label class="layui-form-label">法律编号:</label>

				<div class="layui-input-inline">
					<input type="text" id="newsid" name="newsid" readonly value="<%=newsid %>"
						   autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">添加时间:</label>

				<div class="layui-input-inline">
					<input type="text" id="newstjsj" name="newstjsj" readonly value="<%=news.getNewstjsj()%>"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-input-inline layui-input-treeselect" style="display: none">
				<label class="layui-form-label">法律分类:</label>
				<input type="text" name="cateid" id="cateid" value="6" disabled="disabled"
					   autocomplete="off" class="layui-input">
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>法律标题:</label>
				<div class="layui-input-inline" style="width: 650px">
					<input type="text" id="newstitle" name="newstitle" value="<%=newstitle %>" lay-verify="required"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">法律来源:</label>

				<div class="layui-input-inline" style="width: 650px">
					<input type="text" id="newsfrom" name="newsfrom" value="<%=newsfrom %>"
						   autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item" style="display: none">
				<label class="layui-form-label">是否有效:</label>
				<div class="layui-input-inline" style="width: 280px">
					<input type="text" id="sfyx" name="sfyx" disabled="disabled" value="1">
				</div>
				<label class="layui-form-label">是否图片:</label>
				<div class="layui-input-inline" style="width: 280px">
					<input id="newsispicture" name="newsispicture" disabled="disabled" value="0">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="myred">*</font>法律法规内容:</label>

				<div height="100px" class="layui-input-inline" style="width: 650px">
                            <textarea id="newscontent" name="newscontent" lay-verify="required"><%=newscontent %></textarea>
				</div>
			</div>
			<div class="layui-form-item" style="display: none">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit="" lay-filter="saveNews"
							id="saveNewsBtn">保存</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>