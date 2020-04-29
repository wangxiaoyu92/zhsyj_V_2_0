<%@ page language="java" import="java.util.*,com.zzhdsoft.utils.SysmanageUtil" pageEncoding="utf-8"%>
<%
String contextPath = request.getContextPath();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>范围外企业管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var v_comghsorxhs=<%=SysmanageUtil.getAa10toJsonArray("COMGHSORXHS")%>;
var v_comdalei = <%=SysmanageUtil.getAa10toJsonArray("COMDALEI")%>;
		
$(function(){

$('#mytab').datagrid({
    title:'范围外企业管理',
    iconCls:'icon-ok',
    width:800,
    height:450,
    pageSize:20,
    pageList:[10,15,20],
    nowrap:true,//True 就会把数据显示在一行里
    striped:true,//奇偶行使用不同背景色
    collapsible:true,
    singleSelect:true,//True 就会只允许选中一行
    fitColumns: true,
    fit:true,//让DATAGRID自适应其父容器
    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
    pagination:true,//底部显示分页栏
    rownumbers:true,//是否显示行号
    url: basePath + 'spsy/comout/queryComout',
    loadMsg:'数据加载中,请稍后...',   
    //sortName:'code',
    sortOrder:'desc',
    remoteSort:false,
    columns:[[
		{title:'企业ID',field:'comid',align:'center',hidden:true,width:120},	
		{title:'企业名称',field:'commc',align:'left',width:200},
		{title:'企业类型',field:'comdalei',align:'left',width:120,
			formatter : function(value, row) {
				return sy.formatGridCode(v_comdalei,value);
			}			
		},
		{title:'法定代表人/负责人',field:'comfrhyz',align:'left',width:100},
		{title:'联系电话',field:'comyddh',align:'center',width:150},
		{title:'厂家地址',field:'comdz',align:'left',width:200},
		{title:'合作关系',field:'comghsorxhs',align:'left',width:90,
			formatter : function(value, row) {
				return sy.formatGridCode(v_comghsorxhs,value);
			}
		},
		{title:'录入企业',field:'comlrcommc',align:'left',width:150,hidden:'true'},
		{title:'添加时间',field:'comdzcsj',align:'center',width:110},
		{field:'opt',title:'操作',align:'center',width:200,
              formatter:function(value,rec){ //<a href="javascript:delData('+rec.userId+')" mce_href="#"><img src="../jslib/jquery-easyui/themes/icons/delete.gif" align="absmiddle">删除</a>  
                  return '<span style="color:blue" mce_style="color:blue">'
                  		+'<a href="javascript:editData(\''+rec.comid+'\')" mce_href="#" >'
               			+'<img src="<%=basePath%>jslib/jquery-easyui-1.3.4/themes/icons/edit.gif" align="absmiddle">修改</a>' 
               			+'<a href="javascript:deleteData(\''+rec.comid+'\')" mce_href="#" >'
               			+'<img src="<%=basePath%>jslib/jquery-easyui-1.3.4/themes/icons/delete.gif" align="absmiddle">删除</a></span>';  
              }
		}  
	]],
     onDblClickRow:function(){//双击事件 查看、修改等操作
        var selected = $('#mytab').datagrid('getSelected');
			if(selected){
			  editData(selected.comid);
			}
     },
     //工具栏
     toolbar:[{
          text:'添加新企业',
          iconCls:'icon-add',
          handler:function(){
             $('#btnadd').linkbutton('enable');
             addData();
           }
        }]
   });  
	
});

//添加
function addData(){
	var url = basePath + 'jsp/spsy/comout/companyOutAdd.jsp';
	var dialog = parent.sy.modalDialog({
			title : '添加',
			width : 850,
			height : 400,
			url : url
	}, closeModalDialogCallback);
}

//修改
function editData(id){
	var url = basePath + 'jsp/spsy/comout/companyOutAdd.jsp';
	var dialog = parent.sy.modalDialog({
				title : '修改',
				param : {
					comid : id
				},
				width : 850,
				height : 400,
				url : url
		}, closeModalDialogCallback);
}
// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var obj = sy.getWinRet(dialogID);
	if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
		$("#mytab").datagrid("reload"); 
	}
	sy.removeWinRet(dialogID);//不可缺少		
}

//删除
function deleteData(v_comid){

		$.messager.confirm('警告', '您确定要删除吗?',function(r) {
			if (r) {
				$.post('<%=basePath%>spsy/comout/delCompanyout', {
					comid: v_comid
				},
				function(result) {
					if (result.code == '0') {
						$.messager.alert('提示','删除成功！','info',function(){
							$('#mytab').datagrid('reload'); 
		        		});    	
					} else {
						$.messager.alert('提示', "删除失败：" + result.msg, 'error');
					}
				},
				'json');
			}
		});

}
</SCRIPT>
</head>
<body>
	<div class="content_wrap" style="width:100%;height:100%">
		<table id="mytab" style="width:100%"></table>
	</div>
</body>
</html>