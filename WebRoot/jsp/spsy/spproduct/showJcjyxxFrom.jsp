<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	// 产品id
	String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
	// 产品批次号
	String jcpc = StringHelper.showNull2Empty(request.getParameter("jcpc"));
%>
<!DOCTYPE html>
<html>
<head>
<title>产品检测检验信息列表</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	var s = new Object();
	s.type = "ok";   // 设为刷新父页面
	sy.setWinRet(s);
	var mygrid;

	$(function() {
		mygrid = $('#mygrid').datagrid({
			url: basePath + '/spsy/spproduct/queryProductJcjyxx?proid=<%=proid%>&jcpc=<%=jcpc%>',     
			striped : true,// 奇偶行使用不同背景色
			singleSelect:true,//True 就会只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,	
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'qproductjcid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ {
				width : '100',
				title : '检测检验信息id',
				field : 'qproductjcid',
				hidden : true
			},{
				width : '100',
				title : '产品id',
				field : 'proid',
				hidden : true
			},{
				width : '120',
				title : '检测项目',
				field : 'jcitem',
				hidden : false
			},{
				width : '80',
				title : '检验员',
				field : 'jcjcy',
				hidden : false
			},{
				width : '100',
				title : '检测结果',
				field : 'jcjg',
				hidden : false
			},{
				width : '100',
				title : '检测单位',
				field : 'jcdw',
				hidden : false
			},{
				width : '100',
				title : '检测时间',
				field : 'jcsj',
				hidden : false
			},{
				width : '80',
				title : '批次号',
				field : 'jcpc',
				hidden : false
			},{
				width:300,
				title:'操作',
				field:'opt',
				align:'center',
	            formatter:function(value,rec){ 
					  var v_ret = '<a href="javascript:updataJcjyxx(\''+rec.qproductjcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/edit.gif" align="absmiddle">修改</a>&nbsp;&nbsp;'
					  	+'<a href="javascript:deleteJcjyxx(\''+rec.qproductjcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/cancel.png" align="absmiddle">删除</a>&nbsp;&nbsp;'
					  	+'<a href="javascript:uploadFjView(\''+rec.qproductjcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/upload.png" align="absmiddle">上传图片</a>&nbsp;&nbsp;'
					  	+'<a href="javascript:delFjView(\''+rec.qproductjcid+'\')" mce_href="#">'
					  	+'<img src="<%=basePath%>images/pub/set.png" align="absmiddle">管理图片</a>&nbsp;&nbsp;';
	                  return  v_ret; 
	             }   
	        }
			] ]
		});
	});

	// 修改检测检验信息
	function updataJcjyxx(id) {
		var url = basePath + 'spsy/spproduct/jcjyxxFromIndex';
		var dialog = parent.sy.modalDialog({
				title : '修改',
				param : {
					qproductjcid : id
				},
				width : 600,
				height : 300,
				url : url
		},closeModalDialogCallback);
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){
		var obj = sy.getWinRet(dialogID);
		if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
			$("#mygrid").datagrid("reload");
		}
		sy.removeWinRet(dialogID);//不可缺少
	}
	// 删除检测检验信息
	function deleteJcjyxx(id) {
		$.post(basePath + '/spsy/spproduct/deleteJcjyxx', {
			qproductjcid: id
		},
		function(result) {
			if (result.code == '0') {
				$.messager.alert('提示','删除成功！','info',function(){
					$('#mygrid').datagrid('reload');
				});
			} else {
				$.messager.alert('提示', "删除失败：" + result.msg, 'error');
			}
		}, 'json');
	}

	//上传图片附件（只保存图片到服务器）
	function uploadFjView(id){
		var url = basePath + 'pub/pub/uploadFjViewIndex';
		var dialog = parent.sy.modalDialog({
				title : '上传图片',
				param : {
					folderName : "sycp",
					fjwid : id
				},
				width : 900,
				height : 700,
				url : url
		},closeModalDialogCallback);
	}

	// 删除图片附件
	function delFjView(id){
		var url = basePath + 'pub/pub/delFjViewIndex';
		var dialog = parent.sy.modalDialog({
				title : '删除',
				param : {
					fjwid : id
				},
				width : 900,
				height : 700,
				url : url
		},closeModalDialogCallback);
	}

	// 上传附件（使用的是可以保存到数据库中的方法）
	function uploadJcjyxxfj(id){
		var v_dmlb = "SCQYCPJCTP"; // 生产企业产品检测图片
		var url = basePath + 'pub/pub/pubUploadFjListIndex';
		var dialog = parent.sy.modalDialog({
				title : '上传图片',
				param : {
					ajdjid : id,
					dmlb : v_dmlb,
					time : new Date().getMilliseconds()
				},
				width : 900,
				height : 500,
				url : url
		},closeModalDialogCallback);
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: auto;" border="false">
        	<sicp3:groupbox title="产品检测检验信息">
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   
</body>
</html>