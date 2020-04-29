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
<style type="text/css">
   hide{
   display: none;
   }
</style>
<title>检验检登记  </title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
var grid;
 	 $(function (){   
  grid=$("#grid").datagrid({
	   // title:'采集信息查询',
	    url:  basePath + '/jyjc/queryJyjccydj', 
    	iconCls:'icon-ok',
    	height:450,
    	pageSize:10,
    	pageList:[10,20,30],
    	nowrap:true,//True 就会把数据显示在一行里
    	striped:true,//奇偶行使用不同背景色
    	collapsible:true,
    	singleSelect:true,//True 就会只允许选中一行
    	fit:false,//让DATAGRID自适应其父容器
    	fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    	pagination:true,//底部显示分页栏
    	rownumbers:true,//是否显示行号
    	idField: 'cydjid', //该列是一个唯一列id 
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
          {title:'id',field:'cydjid',align:'left',width:100,hidden : true} ,
          {title:'抽样编号',field:'cybh',align:'left',width:100} ,
          {title:'抽样单位id',field:'bcydwcomid',align:'left',width:100 ,hidden : true} ,
          {title:'生产单位id',field:'scdwcomid',align:'left',width:100 ,hidden : true} ,
          {title:'被抽样单位',field:'bcydw',align:'left',width:100 } ,
          {title:'被抽样单位地址',field:'bcydwdz',align:'left',width:100 },
          {title:'生产单位',field:'scdw',align:'left',width:100 } ,
          {title:'样品名称',field:'ypmc',align:'left',width:100 } ,
          {title:'抽样数量',field:'countcy',align:'left',width:100},
          {title:'样品批号/生产日期',field:'ypbh',align:'left',width:100} ,
          {title:'抽样经手人',field:'cyjsr',align:'left',width:100},
          {title:'被抽样单位联系电话',field:'tel',align:'left',width:100 } ,
          {title:'抽样时间',field:'cysj',align:'left',width:100},
          {title:'抽样分类',field:'cyfl',align:'left',width:100  } ,
          {title:'被抽样单位分类',field:'bcydwfl',align:'left',width:100 } ,
          {title:'经办人',field:'aae011',align:'left',width:100},
          {title:'经办时间',field:'aae036',align:'left',width:100}
        ]]
     }); 
   })
 var jyjccydjFromIndex=function(){
	  var dialog =  parent.sy.modalDialog({
			title : '采集信息',
			width : 870,
			height : 500,
			url : basePath + '/jyjc/jyjccydjFormIndex',
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
	//编辑
	var update= function () {
		var row = $('#grid').datagrid('getSelected');
		var url=basePath + '/jyjc/jyjccydjFormIndex';
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑信息',
				param : {
					cydjid : row.cydjid
				},
				width : 870,
				height : 500,
				url : url,
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
		}else{
			$.messager.alert('提示', '请先选择要修改的消息！', 'info');
		}
	};
	//查看
	var show= function(){
		var row = $('#grid').datagrid('getSelected');
		if(row){
			var url=basePath +"/jyjc/jyjccydjFormIndex";
			var dialog = parent.sy.modalDialog({
				title : '查看检验检测项目',
				param : {
				cydjid : row.cydjid,
				op:'view'
				},
				width :900,
				height :600,
				url : url,
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
	//删除
	 function deljyjccydj() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var id = row.cydjid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'jyjc/deljyjccydj', {
						id: id
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的检验检测项目信息！', 'info');
		}
	}  	
	
	//选择企业
	function selectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex";
		var dialog = parent.sy.modalDialog({
		title : '选择企业',
		param : {
		style:"help:no;status:no;scroll:no;dialogWidth:800px;dialogHeight:500px;dialogTop:100px;" +
		"dialogLeft:400px;resizable:no;center:no",
		a : new Date().getMilliseconds(),
		singleSelect:"true",
		comjyjcbz : "1"
		},
		width : 800,
		height : 600,
		url : url
		},function (dialogID){
		var obj = sy.getWinRet(dialogID);//不可缺少
		if (obj!=null && obj.length>0){
		 for (var k=0;k<=obj.length-1;k++){
		 var myrow=obj[k];
	     $("#bcydw").val(myrow.comdm);
	 }
	}
	sy.removeWinRet(dialogID);//不可缺少	
	})
	}
	 //查询
   function querycydj() {
		var bcydw= $('#bcydw').val();
		var cybh= $('#cybh').val();
		var param = { 
			'bcydw':bcydw ,
			'cybh':cybh 
		}; 
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections');
	}
   //重置
   function refresh(){
		parent.window.refresh();	
	} 
   var cydjdr=function(){
        var dialog =  parent.sy.modalDialog({
			title : '抽样导入',
			width : 870,
			height : 500,
			url : basePath + '/jyjc/cydjdrIndex',
			buttons : [{
				text : '关闭',
					handler:function(){
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog,parent.$);
					}
			} ]
		});
   }
   //项目和报告管理
   function xmhbg() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑项目和报告信息',
				width : 870,
				height : 700,
				url : basePath + '/jyjc/jyjccyxmhbgIndex?id=' + row.cydjid,
				buttons : [ {
					text : '确定',
					id : 'submitbutton',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
					}
				},{
					text : '取消',
					id : '55555',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要修改的消息！', 'info');
		}
	}  	
</script>
</head>
<body>
	<div region="center" style="overflow: true;" border="false">
		<sicp3:groupbox title="查询条件">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:center;"><nobr>企业</nobr></td>
					<td><input id="bcydw" name="bcydw" style="width: 200px" /> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick=" selectcom()">选择企业 </a></td>
					<td style="text-align:center;"><nobr>抽样编号</nobr></td>
					<td><input id="cybh" name="cybh" style="width: 200px"/> </td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="querycydj()"> 查 询 </a>
						&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-reload"
						onclick="refresh()"> 重 置 </a></td>
				</tr>
			</table>
		</sicp3:groupbox>
	</div>
	<div id="toolbar">
		<sicp3:groupbox title="抽样登记列表">
			<table>
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_saveJyjccydj" iconCls="icon-add" plain="true"
						onclick="jyjccydjFromIndex()">增加</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_saveJyjccydj" iconCls="icon-edit" plain="true"
						onclick="update()">编辑</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_queryJyjccydj" iconCls="ext-icon-report_magnify" plain="true"
						onclick="show()">查看</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_deljyjccydj" iconCls="icon-remove" plain="true"
						onclick="deljyjccydj()">删除</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_cydjdrIndex" iconCls="ext-icon-report_go" plain="true"
						onclick="cydjdr()">信息导入</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_jyjccyxmhbg" iconCls="icon-edit" plain="true"
						onclick="xmhbg()">检测项目和报告管理</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</sicp3:groupbox>
	</div>
	<div id="grid" style="height:350px;overflow:auto;"></div>
</body>
</html>