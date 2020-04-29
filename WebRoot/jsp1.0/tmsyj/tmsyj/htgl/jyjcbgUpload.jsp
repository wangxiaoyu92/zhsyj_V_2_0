<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 	
    //String v_jgztpickind = StringHelper.showNull2Empty(request.getParameter("jgztpickind"));
 %>

<!DOCTYPE HTML>
<html>
  <head>
    <title>客户关系</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
       var grid; 

	 $(function  (){	
  		grid=$("#grid").datagrid({
	    url: basePath +"/tmsyjhtgl/queryJgztpicList?jgztpickind=2" , 
    	iconCls:'icon-ok',
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
    	idField: 'hjgztxgpicid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
	    onLoadSuccess:function(data){
	    	grid.datagrid("unselectAll"); 
	    },    	
        columns:[[
        {
          title:'监管主体相关图片上传id',
          field:'hjgztxgpicid',
          align:'left',
          width:100,
          hidden : true
          },{
          title:'监管主体id',
          field:'hviewjgztid',
          align:'left',
          width:100,
          hidden : true
          },{
				width : '80',
				title : '是否上传',
				field : 'uploadflag',
				hidden : false,
				formatter:function(value,row){
					if (value=null || value=="" || value=="0"){
						return '<span style="color:red">否</span>';
					}else{
						return '<span style="color:blue">是</span>';
					}
				}					
			},{ 
          title:'检测人员',
          field:'zcry',
          align:'left',
          width:150 
          },{
          title:'检测机构',
          field:'jcdw',
          align:'left',
          width:200  
          },{
          title:'自查时间',
          field:'zcsj',
          align:'left',
          width:160 ,
          hidden : false
          },{
          title:'操作员',
          field:'aae011',
          align:'left',
          width:120  
          },{
              title:'操作时间',
              field:'aae036',
              align:'left',
              width:160 ,
              hidden : false
              }
        ]]
     }); 
   })
   //新增客户关系
    var url;
    var addkhgx=function(){  
	     var dialog =  parent.sy.modalDialog({
			title : '添加',
			width : 400,
			height : 420,
			url : basePath + 'tmsyjhtgl/jyjcbgUploadFormIndex?op=add',
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
		},function (dialogID){
				sy.removeWinRet(dialogID);//不可缺少
			});
	};
   //编辑客户关系
    var editkhgx=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑',
			width : 640,
			height : 360,
			url : basePath + 'tmsyjhtgl/jyjcbgUploadFormIndex?op=edit&hjgztxgpicid='+row.hjgztxgpicid,
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
		},function (dialogID){
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要编辑的信息！', 'info');
		}
	};
	//删除客户关系
    var delkhgx=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hjgztkhgxid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'tmsyjhtgl/delJgztpic', {
						hjgztxgpicid: row.hjgztxgpicid
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
			$.messager.alert('提示', '请先选择要删除的信息！', 'info');
		}
	};
	//查看客户关系
    var showkhgx=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '查看',
			width : 640,
			height : 360,
			url : basePath + 'tmsyjhtgl/jyjcbgUploadFormIndex?op=view&hjgztxgpicid='+row.hjgztxgpicid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		},function (dialogID){
				sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要检查的信息！', 'info');
		}
	}; 
	function query() {
		var param = {
			'jgztpickind':'2',
			'aae036start': $('#aae036start').datebox('getValue'),
			'aae036end': $('#aae036end').datebox('getValue')
		};
		grid.datagrid({
			url :  basePath +"tmsyjhtgl/queryJgztpicList", 			
			queryParams : param
		});
		grid.datagrid('clearSelections'); 
	}
	
	// 刷新
	function refresh(){
		parent.window.refresh();	
	} 
	
	// 上传资质证明图片
	function uploadFjView(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=jyjcbgpic&fjwid="+row.hjgztxgpicid+"&fjtype=16";//16检验检测报告图片 
			//创建模态窗口
			var dialog = parent.sy.modalDialog({
				title : '上传附件',
				width : 900,
				height : 700,
				url : url
			},function (dialogID){
				var obj = sy.getWinRet(dialogID);
				sy.removeWinRet(dialogID);//不可缺少

				if(obj != null){
					$('#grid').datagrid('reload'); 
				}
			});

		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	
    </script>
  </head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
        <%-- <sicp3:groupbox title="查询条件"> --%>
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>操作开始时间</nobr></td>
						<td><input id="aae036start" name="aae036start" style="width: 200px" 
						   class="easyui-datebox"/></td>	
						<td style="text-align:right;"><nobr>操作结束时间</nobr></td>
						<td><input id="aae036end" name="aae036end" style="width: 200px" 
						   class="easyui-datebox"/></td>							
						<td>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	     <%--    </sicp3:groupbox>		 
		<sicp3:groupbox title= "列表信息"> --%>
			<div id="toolbar">
			<table> 
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="" iconCls="icon-add" plain="true"
						onclick="addkhgx()">增加</a></td>
					<td> 
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="" iconCls="icon-edit" plain="true"
						onclick="editkhgx()" id="btn_khgxMainIndex">编辑</a></td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_archiveFormIndex" name="" data=""
						iconCls="ext-icon-application_form_magnify" plain="true" onclick="showkhgx()">查看</a>
					</td>
					<td>
					<div class="datagrid-btn-separator"></div></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						id="btn_delArchive" name="btn_delArchive" data=""
						iconCls="icon-remove" plain="true" onclick="delkhgx()">删除</a></td>
					<td>
					<div class="datagrid-btn-separator"></div>
					</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data=""
							iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传检测报告图片</a>
						</td>					
				</tr>
			</table>
			</div> 
			<div id="grid" style="height:350px;overflow:auto;"></div>
		<%-- </sicp3:groupbox> --%>
		</div>
    </div>            
</body>
</html>
