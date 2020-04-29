<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>安全检查</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
       var grid;

	 $(function  (){  	
  grid=$("#grid").datagrid({
	   // title:'采集信息查询',
	    url: basePath +"/aqgl/queryjcrw", 
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
        {
          title:'任务id',
          field:'taskid',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'计划id',
          field:'planid',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'统筹区',
          field:'aaa027',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'AAZ093',
          field:'aaz093',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'企业id',
          field:'comid',
          align:'left',
          width:100 ,
          hidden : true
          },{ title:'企业类型',
          field:'comdalei',
          align:'left',
          width:100,
          hidden :true
          },{
          title:'计划标题',
          field:'plantitle',
          align:'left',
          width:200 
          },{
          title:'计划类型',
          field:'plantype',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'企业名称',
          field:'commc',
          align:'left',
          width:200 
          },{
          title:'任务名称',
          field:'taskname',
          align:'left',
          width:150 
          },{
          title:'任务描述',
          field:'taskremark',
          align:'left',
          width:150 
          },{
          title:'经办人',
          field:'aaa011',
          align:'left',
          width:100 
          },{
          title:'任务开始时间',
          field:'tasktimest',
          align:'left',
          width:100 
          },{
          title:'任务结束时间',
          field:'tasktimeed',
          align:'left',
          width:100 
          },{
          title:'经办时间',
          field:'datetime',
          align:'left',
          width:100
         }  
        ]]
     }); 
   })
   //新增检查
    var checkterm=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '现场检查',
			width : 870,
			height : 650,
			url : basePath + '/aqgl/jcxIndex?planid='+row.planid+'&comid='+row.comid+'&comdalei='+row.comdalei+'&aaa027='+row.aaa027+'&aaz093='+row.aaz093,
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
			$.messager.alert('提示', '请先选择要查看的信息！', 'info');
		}
	};
	//检查历史
    var checkhis=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '现场检查',
			width : 870,
			height : 650,
			url : basePath + '/aqgl/jclsIndex?planid='+row.planid+'&comid='+row.comid+'&comdalei='+row.comdalei+'&aaa027='+row.aaa027+'&aaz093='+row.aaz093,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示', '请先选择要检查的企业！', 'info');
		}
	};
    </script>
  </head>
  
  <body> 
		 
	<div id="toolbar">
		<sicp3:groupbox title="任务列表">
			<table>
				<tr>
					<!-- <td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_aqrwIndex" iconCls="icon-add" plain="true"
						onclick=" checkterm()">检查</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td> -->
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_aqrwIndex" iconCls="icon-edit" plain="true"
						onclick="checkhis()">执行检查</a></td>
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
