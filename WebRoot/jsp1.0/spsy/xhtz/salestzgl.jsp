<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.siweb.entity.sysmanager.Sysuser" %>
<%
String contextPath = request.getContextPath();
String basePath = GlobalConfig.getAppConfig("apppath");
if (null==basePath || "".equals(basePath)){
	 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
	 	+ request.getServerPort() + request.getContextPath() + "/";
}%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <jsp:include page="${contextPath}/inc.jsp"></jsp:include> 
  <script type="text/javascript">
  var grid;
   $(function(){
      grid = $('#grid').datagrid({
            toolbar: '#toolbar', 
		    width:900,
		    height:400,
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
		    url:basePath +'/spsy/productin/salestzgl',
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
			} 
			] ]
		});
   });
   //查看
   var showStock =function () {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看信息',
				width : 870,
				height : 600,
				url : basePath +'spsy/productin/tzdetailIndex', 
				param : {
					lqledgersalesid : row.lqledgersalesid
				},
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
    //选择企业
	function selectcom(){
		var url = basePath + 'pub/pub/selectcomIndex';
		var dialog = parent.sy.modalDialog({
				title : '选择企业',
				param : {
					a : new Date().getMilliseconds(),
					singleSelect : "true"
				},
				width : 800,
				height : 500,
				url : url
		}, closeModalDialogCallback);
	}
	// 窗口关闭回掉函数
	function closeModalDialogCallback(dialogID){		
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
			for (var k = 0; k <= v_retStr.length - 1; k++) {
				var myrow = v_retStr[k];
				$("#commc").val(myrow.commc); //公司名称   
				$("#comdm").val(myrow.comdm); //公司代码         
			}
		}
		sy.removeWinRet(dialogID);//不可缺少		
	}
   //查询
    function salestzjg(){ 
		var lgsfromcomid= $('#lgsfromcomid').val();
		var lgsprojyrq= $('#lgsprojyrq').val();
		var lgsproname= $('#lgsproname').val();
		var param = { 
				'lgsfromcomid':lgsfromcomid ,
				'lgsproname':lgsproname ,
				'lgsprojyrq':lgsprojyrq 
		}; 
		$('#grid').datagrid('reload', param);
		$('#grid').datagrid('clearSelections'); 
	} 
   //重置
   function refresh(){
		parent.window.refresh();	
   }
  </script>
  </head> 
  <body> 
  <div region="center" style="overflow: true;" border="false">
		<sicp3:groupbox title="查询条件">
			<table class="table" style="width: 99%;">
				<tr>
					<td style="text-align:center;"><nobr>供货企业</nobr></td>
					<td><input id="lgsfromcomid" name="lgsfromcomid" style="width: 200px" /> <a
						href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick=" selectcom()">选择企业 </a></td>
					<td style="text-align:center;"><nobr>商品名称</nobr></td>
					<td><input id="lgsproname" name="lgsproname" style="width: 200px" /> </td>
				</tr>	
				<tr>
				    <td style="text-align:center;"><nobr>交易时间</nobr></td>
				    <td><input name="lgsprojyrq" id="lgsprojyrq"  class="Wdate easyui-validatebox"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						style="width: 200px;"></td>
					<td style="text-align:center;" colspan="2"><a href="javascript:void(0)" class="easyui-linkbutton"
						iconCls="icon-search" onclick="salestzjg()"> 查 询 </a>
						&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
						class="easyui-linkbutton" iconCls="icon-reload"
						onclick="refresh()"> 重 置 </a></td>
				</tr>
			</table>
		</sicp3:groupbox>
		<sicp3:groupbox title="销售列表">
		<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showStock"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showStock()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 																																													
						</tr>
					</table>
				</div>
			<div id="grid" ></div>
	    </sicp3:groupbox>	
	</div>
  </body>
</html>
