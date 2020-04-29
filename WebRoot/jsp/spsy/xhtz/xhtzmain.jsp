<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	} 
	Sysuser Vsuer= SysmanageUtil.getSysuser();
	String qylb = Vsuer.getComsyqylx();
%>
<!DOCTYPE html>
<html>
<head>
<title>销货台账</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
<script type="text/javascript">
var grid;
var detail;
 
	$(function() {
		var url="";
		if( '<%=qylb%>' == 1){
			url = basePath + 'spsy/productin/querysckc';  //生产
		} else if('<%=qylb%>'==2){
			url = basePath + 'spsy/productin/querykcsy'; //流通
		}
		 grid = $('#grid').datagrid({
		    width:1100,
		    height:265,
		    toolbar: '#toolbar',
		    pageSize:20,
		    pageList:[10,15,20],
		    nowrap:true,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:true,
		    singleSelect:true,//True 就会只允许选中一行
		    fitColumns: true,
		    //fit:true,//让DATAGRID自适应其父容器
		    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    pagination:true,//底部显示分页栏
		    rownumbers:true,//是否显示行号	
		    idField: 'qledgerstockid', //该列是一个唯一列
		    url:url,
		    onClickRow:function(rowIndex,rowData){
		    	querydetail(rowData);
		    },	
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : 'ID',
				field : 'qledgerstockid',
				hidden : true
			},{
				width : '100',
				title : '商品ID',
				field : 'lgproid',
				hidden : true
			},{ 
				width : '100',
				title : '商品名称',
				field : 'lgproname',
				hidden : false
			},{
				width : '100',
				title : '商品批次',
				field : 'lgpropc',
				hidden : false
			},{
				width : '150',
				title : '商品数量',
				field : 'lgprojysl',
				hidden : false
			},{
				width : '150',
				title : '计量数量',
				field : 'lgprojydwmc',
				hidden : false
			},{
				width : '150',
				title : '生产日期',
				field : 'lgproscrq',
				hidden : false
			},{ 
				width : '100',
				title : '保质期单位ID',
				field : 'lgprobzqdwcode',
				hidden : true
			},{
				width : '100',
				title : '保质期单位名称',
				field : 'lgprobzqdwmc',
				hidden : true 
			},{
				width : '100',
				title : '保质期',
				field : 'lgprobzq',
				hidden : false ,
			 	formatter:function(value,rec){
					  if(rec.lgprobzqdwmc=='月'){
						  	 return value+'个'+rec.lgprobzqdwmc;
					      }else{
					         return value+rec.lgprobzqdwmc;
						  }
				}
			},{
				width : '100',
				title : '到期日期',
				field : 'lgprodqrq',
				hidden : false
			},{
				width : '80',
				title : '剩余数量',
				field : 'lgprosysl',
				hidden : false
			},{
			    width : '150',
				title : '交易日期',
				field : 'lgprojyrq',
			 	formatter:function(value,row,index){
			      	if('<%=qylb%>'==1){
				    	$("td[field='lgprojyrq']").hide();
			     	}
				}
			}  
			] ]
		});
		
		 detail = $('#detail').datagrid({
		    title:'出售明细',
			 toolbar: '#toolbar1',
		    width:1100,
		    height:265,
		    pageSize:20,
		    pageList:[10,15,20],
		    nowrap:true,//True 就会把数据显示在一行里
		    striped:true,//奇偶行使用不同背景色
		    collapsible:true,
		    singleSelect:true,//True 就会只允许选中一行
		    fitColumns: true,
		   // fit:true,//让DATAGRID自适应其父容器
		    fitColumns:false,//是否禁止出现水平滚动条：True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动
		    pagination:true,//底部显示分页栏
		    rownumbers:true,//是否显示行号	
		    idField: 'lqledgersalesid', //该列是一个唯一列
		    url:'',
		    sortOrder: 'asc',	
			columns : [ [
	        {
				width : '100',
				title : 'ID',
				field : 'lqledgersalesid',
				hidden : true
			},{
				width : '100',
				title : '商品ID',
				field : 'lgsproid',
				hidden : true
			},{ 
				width : '100',
				title : '买方企业名称',
				field : 'commc',
				hidden : false
			},{ 
				width : '100',
				title : '商品名称',
				field : 'lgsproname',
				hidden : false
			},{
				width : '100',
				title : '商品批次',
				field : 'lgspropc',
				hidden : false
			},{
				width : '150',
				title : '生产日期',
				field : 'lgsproscrq',
				hidden : false
			},{
				width : '150',
				title : '交易日期',
				field : 'lgsprojyrq',
				hidden : false
			},{
				width : '100',
				title : '保质期单位ID',
				field : 'lgsprobzqdwcode',
				hidden : true
			},{
				width : '100',
				title : '保质期单位名称',
				field : 'lgsprobzqdwmc',
				hidden : true 
			},{
				width : '100',
				title : '保质期',
				field : 'lgsprobzq',
				hidden : false ,
			 	formatter:function(value,rec){
					    if(rec.lgsprobzqdwmc=='月'){
						  	 return value+'个'+rec.lgsprobzqdwmc;
					   }else{
					       return value+rec.lgsprobzqdwmc;
						  }
					}
			},{
				width : '100',
				title : '到期日期',
				field : 'lgsprodqrq',
				hidden : false
			},{
					width : '80',
					title : '交易数量',
					field : 'lgsprojysl',
					hidden : false
			},{
				width : '80',
				title : '计量单位',
				field : 'lgsprojydwmc',
				hidden : false
			}
			] ]
		});
});

    function querydetail(rowdata){
       if(rowdata){
         	$("#detail").datagrid({
			   url : basePath + 'spsy/productin/querySalesDetail?lgsproid='+rowdata.lgproid+'&lgspropc='+rowdata.lgpropc		
			}); 	    	
       } 
   }  

  //出售
  var salesIndex=function(){ 
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑信息',
				width : 760,
				height : 560,
				url : basePath + 'spsy/productin/salesIndex?qledgerstockid=' + row.qledgerstockid+'&qylb='+'<%=qylb%>',
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
			$.messager.alert('提示', '请先选择要出售的产品！', 'info');
		}
	};

function uploadFjView(){
	var row = $('#detail').datagrid('getSelected');
	if (row) {
		var url = basePath + "/pub/pub/uploadFjViewIndex?folderName=xiaoshoupiao&fjwid="+row.lqledgersalesid+"&fjtype=1";//1图片
		//创建模态窗口
		parent.sy.modalDialog({
			title : '上传附件',
			width : 900,
			height : 700,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);
			sy.removeWinRet(dialogID);//不可缺少
			if(obj != null){
				$('#detail').datagrid('reload');
			}
		});

	}else{
		$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
	}
}
</script>   
</head>
<body>  
	<div region="center" style="overflow: auto;" border="false"></div>
	<sicp3:groupbox title="商品信息列表">
		<div id="toolbar">
			<table>
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						data="btn_salesIndex" iconCls="icon-add" plain="true"
						onclick="salesIndex()">出售</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td> 
				</tr>
			</table>
        </div>
	    <div id="grid" ></div>
	</sicp3:groupbox>
	<sicp3:groupbox title="明细">
		<div id="toolbar1">
			<table>
				<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton"
						   data="btn_salesIndex" iconCls="icon-add" plain="true"
						   onclick="uploadFjView()">上传交易附件</a></td>
					<td>
						<div class="datagrid-btn-separator"></div>
					</td>
				</tr>
			</table>
		</div>
		<div id="detail" style="height:350px;overflow:auto;"></div>
	</sicp3:groupbox>
	 
</body>
</html>