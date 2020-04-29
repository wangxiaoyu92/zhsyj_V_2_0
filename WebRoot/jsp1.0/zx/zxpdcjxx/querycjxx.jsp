<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
String contextPath = request.getContextPath();
String basePath = GlobalConfig.getAppConfig("apppath");
if (null==basePath || "".equals(basePath)){
	 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
}
%>
<!DOCTYPE html>
<html>
<head>
<title>信息采集</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<jsp:include page="${contextPath}/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
  var ddd;

	 $(function  (){  	
  ddd=$("#ddd").datagrid({
	   // title:'采集信息查询',
	    url:  basePath + 'zx/zxpdcjxx/queryDTO', 
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
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
          {title:'年度',field:'niandu',align:'left',width:100} ,
          {title:'cjid',field:'cjid',align:'left',width:100,hidden : true} ,
          {title:'企业id',field:'comid',align:'left',width:100 ,hidden : true} ,
          {title:'项目评定代码',field:'xmcsdm',align:'left',width:100  } ,
          {title:'企业名称',field:'commc',align:'left',width:100 } ,
          {title:'操作员姓名',field:'czyxm',align:'left',width:100 } ,
          {title:'操作时间',field:'czsj',align:'left',width:100 } ,
          {title:'数据来源',field:'sjly',align:'left',width:100,
        	  formatter: function(value,row,index){
  				if (value=="1"){
  					return "手工添加";
  					//return value;
  				} else {
  					return "系统添加";
  				}
  			}
		  },
          
          {title:'采集得分',field:'cjdf',align:'left',width:100} ,
          {title:'备注',field:'beizhu',align:'left',width:100}
        ]]
     }); 
   })
   $(function(){
	   var myDate = new Date(); 
	   var year= myDate.getFullYear(); 
	   for(var i=year;i>2010;i--){
	   var t='<option  value='+(i)+'>'+i+'</option>';
	  			  //设置value的值和  列表参数
	  			  var $ts=$(t);
	  			  $("#niandu").append($ts);} 
   })
   //查询
   function querycjxx() {
		var commc= $('#commc').val();
		var niandu= $('#niandu').val();
		var param = { 
			'commc':commc ,
			'niandu':niandu 
		}; 
		$('#ddd').datagrid('reload', param);
		$('#ddd').datagrid('clearSelections');
	}
   //重置
   function refresh(){
		parent.window.refresh();	
	} 
   
  //增加
   var add=function(){
	  var dialog =  parent.sy.modalDialog({
			title : '采集信息',
			width : 870,
			height : 500,
			url : basePath + '/zx/zxpdcjxx/cjxxIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ddd, parent.$);
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
		var row = $('#ddd').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑信息',
				width : 870,
				height : 500,
				url : basePath + '/zx/zxpdcjxx/cjxxIndex?cjid=' + row.cjid,
				buttons : [ {
					text : '确定',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.submitForm(dialog, ddd, parent.$);
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
	var show =function () {
		var row = $('#ddd').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				width : 870,
				height : 500,
				url : basePath + '/zx/zxpdcjxx/cjxxIndex?op=view&cjid=' + row.cjid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	// 删除
	 var delcjxx=function () {
		var row = $('#ddd').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的企业的相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/zx/zxpdcjxx/delcjxx', {
						 cjid : row.cjid 
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								$('#ddd').datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的企业！', 'info');
		}
	} 
   //选择企业
  function selectcom(){
		var url = "<%=basePath%>pub/pub/selectcomIndex?a="+new Date().getMilliseconds();

		var dialog = parent.sy.modalDialog({
			title : ' ',
			param : {
				singleSelect : true
			},
			width : 800,
			height : 600,
			url : url
		},function(dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);
			if (obj!=null && obj.length>0){
				for (var k=0;k<=obj.length-1;k++){
					var myrow=obj[k];
					$("#commc").val(myrow.commc); //公司名称
					$("#comid").val(myrow.comid); //公司代码
				}
			}
		});
  }
</script>
</head>
<body>

	<div region="center" style="overflow: true;" border="false">
		<sicp3:groupbox title="查询条件">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:center;"><nobr>企业</nobr></td>
					<td><input id="commc" name="commc" style="width: 200px" /> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick=" selectcom()">选择企业 </a></td>
					<td style="text-align:center;"><nobr>年度</nobr></td>
					<td><select id="niandu" name="niandu" style="width: 200px">
							<option value="">==请选择==</option>
					</select></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="querycjxx()"> 查 询 </a>
						&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-reload"
						onclick="refresh()"> 重 置 </a></td>
				</tr>
			</table>
		</sicp3:groupbox>
	</div>
	<div id="toolbar">
		<sicp3:groupbox title="采集信息列表">
			<table>
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_cjxxIndex" iconCls="icon-add" plain="true"
						onclick=" add()">增加</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_cjxx" iconCls="icon-edit" plain="true"
						onclick="update()">编辑</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_queryDTO" iconCls="ext-icon-report_magnify" plain="true"
						onclick="show()">查看</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_delcjxx" iconCls="icon-remove" plain="true"
						onclick="delcjxx()">删除</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</sicp3:groupbox>
	</div>
	<div id="ddd" style="height:350px;overflow:auto;"></div>

</body>
</html>