<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>检验检测数据查询</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
	var page = 1; // 页面索引初始值   
    var rows = 10; // 每页显示条数初始化 
	$(function(){
		pageSplit();
		getCompanyInfo();
	});
	// 查看公司检验产品结果
	function showCompanyDetails(comid) {
		var dialog = parent.sy.modalDialog({
			title : '查看检测结果',
			width :800,
			height :400,
			url : basePath +'jyjc/jyjccompanyjcjgIndex?comid='+comid,
			buttons : [{
				text : '关闭',
				handler:function(){
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
				}
			}]
		});
	}
	// 获取公司信息
	function getCompanyInfo(){
		$.ajax({
		   type: "POST",
		   url: basePath + "jyjc/queryJyjcCompany",
		   dataType : "json",
		   data: {commc:$("#commc").val(),page:page,rows:rows},
		   success: function(data){
		   		// 给分页控件添加总条数记录
		   		$('#companyPage').pagination({ total: data.total});
				for ( var i = 0; i < data.rows.length; i++) {
					var v_comid = "'"+ data.rows[i].comid +"'";
					var v_comfjpath = basePath + data.rows[i].comfjpath;
					var img = "<li style='height:160px; width:130px; list-style-type:none;float:left;'>"
						+ "<div style='text-align: center; cursor: pointer; height:140px; width:110px;'"
						+ " onclick=showCompanyDetails(" + v_comid + ")>"
						+ "<img  src='" + v_comfjpath + "' height='140' width='110'><br/>"
						+ "<span>" + data.rows[i].commc+"</span>"
						+ "</div></li>";
					$("#companyDiv #companyUl").append(img);
				}
		   }
		}); 
	}
	// 分页
	function pageSplit(){
		$('#companyPage').pagination({  
            pageSize: rows,  
            pageNumber: page,  
            pageList: [5, 10, 15, 20],  
            // 选择新页面时触发事件
            onSelectPage: function (pageNumber, pageSize) {  
            	page = pageNumber;
            	rows = pageSize;
            	queryCompany();
                $(this).pagination('loading');  
                $(this).pagination('loaded');  
            }  
        });
	}
	// 查询公司
	function queryCompany(){
		// 清空公司显示信息
		$("#companyDiv #companyUl").empty();
		// 重新查询公司信息
		getCompanyInfo();
	}
	// 重置页面
	function refresh(){
		parent.window.refresh();	
	}   
	//新增检验检测公司
	var addJyjccompany = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增检验检测结果',
			width : 900,
			height : 600,
			url : basePath + '/jyjc/jyjcjgFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
				}
			},{
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
	};

	// 删除检验检测结果信息
	function delJyjcjg() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var jcjgid = row.jcjgid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?该操作将不可恢复',function(r) {
				if (r) {
					$.post(basePath + '/jyjc/delJyjcjg', {
						jcjgid: jcjgid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', '删除失败：' + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的检验检测项目信息！', 'info');
		}
	}  	
	
	//查看检验检测项目
	var showJyjcjg = function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var dialog = parent.sy.modalDialog({
				title : '查看检验检测结果',
				width :900,
				height :600,
				url : basePath +'/jyjc/jyjcjgFormIndex?op=view&jcjgid='+row.jcjgid,
				buttons : [{
					text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
				}]
			});
		}else{
			$.messager.alert('提示','请先选择要查看的信息！','info');
		}
	};
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width:200px;" /></td>	
						<td colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queryCompany()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="检验检测单位">
				<div id="companyDiv" style="height:350px;overflow:auto;">
					<ul id="companyUl"></ul>
				</div>
				<div class="easyui-pagination" id="companyPage" style="background:#efefef;border:1px solid #ccc;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>