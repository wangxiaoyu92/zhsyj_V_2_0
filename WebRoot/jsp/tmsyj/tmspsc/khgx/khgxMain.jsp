<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 	
    String jgztkhgx = StringHelper.showNull2Empty(request.getParameter("jgztkhgx"));
 %>

<!DOCTYPE HTML>
<html>
  <head>
    <title>客户关系</title>
    <jsp:include page="${contextPath}/inc.jsp"></jsp:include>
    <script type="text/javascript">
       var jgztkhgx = <%=SysmanageUtil.getAa10toJsonArray("jgztkhgx")%>;
       var vjgztkhgx;
       var vjgztfwnfww;
       var grid; 
	   var khgx =<%=jgztkhgx%>;
	   var tit;
	 $(function  (){
		    if(khgx==1){
		       tit="供应商";
		    }else if(khgx==2){
		       tit="生产商";
		    }else if(khgx==3){
		       tit="经销商";
		    } 
		 vjgztkhgx = $('#jgztkhgx').combobox({
	    	data : jgztkhgx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    }); 	
		 vjgztfwnfww = $('#jgztfwnfww').combobox({
	    	data : [{id:'',text:'==请选择=='},
	    			{id:'1',text:'范围内'},
			        {id:'2',text:'范围外'}],     
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    }); 	
  		grid=$("#grid").datagrid({
	    url: basePath +"/khgx/queryKhgxList?jgztkhgx=<%=jgztkhgx%>" , 
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
    	idField: 'hjgztkhgxid', //该列是一个唯一列
    	loadMsg:'数据加载中,请稍后...',
        columns:[[
        {
          title:'监管主体客户关系id',
          field:'hjgztkhgxid',
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
          title:'客户名称',
          field:'jgztkhmc',
          align:'left',
          width:150 
          },{
          title:'客户关系',
          field:'jgztkhgxinfo',
          align:'left',
          width:80 ,
          hidden : true
          },{
          title:'客户简称',
          field:'jgztkhmcjc',
          align:'left',
          width:120  
          },{
          title:'联系人',
          field:'jgztkhlxr',
          align:'left',
          width:60 
          },{
          title:'手机号',
          field:'jgztkhyddh',
          align:'left',
          width:100 
          },{
          title:'固定电话',
          field:'jgztkhgddh',
          align:'left',
          width:100 
          },{
          title:'范围划分',
          field:'jgztfwnfww',
          align:'left',
          width:60,
          formatter :function (value, rec){
          	if(value==1){
          	return rec.jgztfwnfww="范围内"; 
          	}else{
          	return rec.jgztfwnfww="范围外"; 
          	}
          } 
          },{
          title:'资质证明',
          field:'jgztkhzzzmmcinfo',
          align:'left',
          width:120
          },{
          title:'资质证明编号',
          field:'jgztkhzzzmbh',
          align:'left',
          width:120
          },{
          title:'联系地址',
          field:'jgztkhlxdz',
          align:'left',
          width:150  
          }  
        ]]
     }); 
   })
   //新增客户关系
    var url;
    var addkhgx=function(tjlx){  
	     var dialog =  parent.sy.modalDialog({
			title : '添加'+tit,
			width : 640,
			height : 360,
			url : basePath + '/khgx/khgxFrom?jgztkhgx=<%=jgztkhgx%>',
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
   //编辑客户关系
    var editkhgx=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	     var dialog =  parent.sy.modalDialog({
			title : '编辑'+tit,
			width : 640,
			height : 360,
			url : basePath + '/khgx/khgxFrom?hjgztkhgxid='+row.hjgztkhgxid,
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
	//删除客户关系
    var delkhgx=function(){
       var row = $('#grid').datagrid('getSelected'); 
       if(row){
	   // var id = row.hjgztkhgxid;
			$.messager.confirm('警告', '您确定要删除该条信息吗?',function(r) {
				if (r) {
					$.post(basePath + 'khgx/delKhgx', {
						hjgztkhgxid: row.hjgztkhgxid
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
			title : '查看'+tit,
			width : 640,
			height : 360,
			url : basePath + '/khgx/khgxFrom?op=show&hjgztkhgxid='+row.hjgztkhgxid,
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		});
		}else{
			$.messager.alert('提示', '请先选择要检查的信息！', 'info');
		}
	}; 
	function query() {
		var param = {
			'jgztkhgx': $('#jgztkhgx').val(),
			'jgztkhgx': '<%=jgztkhgx%>',
			'jgztfwnfww': $('#jgztfwnfww').combobox('getValue') 
		};
		grid.datagrid({
			url :  basePath +"/khgx/queryKhgxList", 			
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
			var url = basePath + "/pub/pub/uploadFjViewIndexEasyui?folderName=khgxzzzm&fjwid="+row.hjgztkhgxid+"&fjtype=11";//11客户关系资质证明图片

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
					if(obj.type == 'ok'){
						//
					}
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
						<td style="text-align:right;"><nobr>客户关系</nobr></td>
						<td><input id="jgztkhgx" name="jgztkhgx" style="width: 200px" /></td>	 
						<td style="text-align:right;"><nobr>企业范围</nobr></td>
						<td><input id="jgztfwnfww" name="jgztfwnfww" style="width: 200px"/></td>						
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
						id="btn_archiveFormIndex" name="" data="btn_archiveFormIndex"
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
							iconCls="icon-upload" plain="true" onclick="uploadFjView()">上传资质证明图片</a>
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
