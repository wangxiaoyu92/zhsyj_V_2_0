<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	String v_spsjlx = StringHelper.showNull2Empty(request.getParameter("spsjlx"));//商品数据类型
	//querykind 查询数据类型 空或0 不加其他条件 为1 加只查本企业商品
	String v_querykind = StringHelper.showNull2Empty(request.getParameter("querykind"));
	if (null==v_querykind || "".equals(v_querykind)){
		v_querykind="0";
	}
	String v_singleSelect = StringHelper.showNull2Empty(request.getParameter("singleSelect"));//是否单选
	Boolean b_singleSelect=false;
	if (v_singleSelect!=null && "true".equals(v_singleSelect)){
		b_singleSelect=true;
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
// 商品类别
var v_jcyplb = <%=SysmanageUtil.getAa10toJsonArray("JCYPLB")%>;
//商品归类
var v_jcypgl = <%=SysmanageUtil.getAa10toJsonArray("JCYPGL")%>;

var mygrid;
//var v_singleSelect=(obj.singleSelect=="true");
//var v_comjyjcbz=obj.comjyjcbz;

$(function() {		
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			//url: basePath + '/pub/pub/querySelectShangpin',     
			queryParams: {
				querykind:'<%=v_querykind%>',
				spsjlx:'<%=v_spsjlx%>'
			},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:'<%=b_singleSelect%>',//True 就会只允许选中一行
			checkOnSelect : true,
			selectOnCheck : true,	
			onLoadSuccess:function(data){
					$(this).datagrid('clearSelections');
			},
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'jcypid', //该列是一个唯一列
		    sortOrder: 'asc',	
		    onDblClickRow:function(rowIndex, rowData){
		    	queding();
		    },
			columns : [ [ 
            {width : '100',
				//title : '企业ID',
				checkbox:'true',
				field : 'jcypid',
				hidden : false
			},{
				width : '150',
				title : '商品名称',
				field : 'jcypmc',
				hidden : false
			},{
				width : '100',
				title : '商品简称',
				field : 'jcypjc',
				hidden : false
			},{
				width : '90',
				title : '所属品牌',
				field : 'jcypsspp',
				hidden : true
			},{
				width : '70',
				title : '规格',
				field : 'impcpgg',
				hidden : false
			},{
				width : '60',
				title : '商品商标',
				field : 'spsb',
				hidden : false
			},{
				width : '80',
				title : '商品规格型号',
				field : 'spggxh',
				hidden : false
			},{
				width : '90',
				title : '商品计量单位',
				field : 'spjldw',
				hidden : false
			} ,{
				width : '100',
				title : '商品执行标准号',
				field : 'spzxbzh',
				hidden : false
			} ,{
				width : '80',
				title : '商品保质期',
				field : 'spbzq',
				hidden : false
			},{
				width : '120',
				title : '商品类别',
				field : 'jcyplb',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jcyplb,value);
				}				
			},{
				width : '120',
				title : '商品归类',
				field : 'jcypgl',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jcypgl,value);
				}				
			},{
				width : '120',
				title : '操作员',
				field : 'jcypczy',
				hidden : false
			},{
				width : '120',
				title : '操作时间',
				field : 'jcypczsj',
				hidden : false
			}
			] ]
		});
		
		query();
});///////////////////////////////

	function query() {
		var param = {
			'jcypmc': $('#jcypmc').val(),
			'jcypjc': $('#jcypjc').val(),
			'querykind':'<%=v_querykind%>',
			'spsjlx':'<%=v_spsjlx%>'
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectShangpin',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}

	//选择数据返回
	var getDataInfo = function($dialog, $form, $pjq){
		var row = mygrid.datagrid('getSelected'); 
	    if(row){
	    	$form.form('load',row);
	    	$dialog.dialog('close');
	    }else{
	        $pjq.messager.alert('提示','请选择业务数据!','info');
	    }
	}; 
	
	function refresh(){
		$('#commc').val('');
	} 
   
   function shangpinguanli(){
        var v_singleSelect="true";
		var dialog = parent.sy.modalDialog({
			title : '管理',
			width : 900,
			height : 530,
			url : basePath + 'jsp1.0/jyjc/jyjcyp.jsp?spsjlx=<%=v_spsjlx%>&singleSelect='+v_singleSelect+'&a='+new Date().getMilliseconds(),
			buttons : [{
				text : '关闭',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
				}
			} ]
		},function(dialogID) {
			$("#mygrid").datagrid('reload');
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}  

	   // 保存 
	var queding = function($dialog) {
	    var rows = mygrid.datagrid('getSelections'); 
		if (rows!="") {
			   sy.setWinRet(rows);
			   parent.$("#"+sy.getDialogId()).dialog("close"); 			 
		}else{
			$.messager.alert('提示', '请先选择记录！', 'info');
		} 
	}; 

	// 关闭窗口
	var closeWindow = function($dialog){
    	$dialog.dialog('close');
	};
	
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" fit="true" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;height:30px;">
        		   <tr>
						<td style="text-align:right;"><nobr>商品简称（首字母拼音）</nobr></td>
						<td><input id="jcypjc" name="jcypjc" style="width: 200px" /></td>
						<td colspan="2" rowspan="2">
					  	&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>	
								&nbsp;&nbsp;							
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="shangpinguanli()"> 新增商品 </a>
						</td>        		   
        		   </tr>
        		   <tr>
						<td style="text-align:right;"><nobr>商品名称</nobr></td>
						<td><input id="jcypmc" name="jcypmc" style="width: 200px" /></td>
        		   </tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="企业列表">
				<div id="mygrid" style="width:860px;height: 360px "></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>