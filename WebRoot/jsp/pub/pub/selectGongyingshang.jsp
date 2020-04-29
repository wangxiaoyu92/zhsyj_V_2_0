<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.zzhdsoft.utils.StringHelper"%>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
	
	String v_jgztkhgx = StringHelper.showNull2Empty(request.getParameter("jgztkhgx"));  //客户关系 1供应商2生产商3经销商
	String v_gxmc="供应商";
	if ("2".equalsIgnoreCase(v_jgztkhgx)){
		v_gxmc="生产商";
	}else if ("3".equalsIgnoreCase(v_jgztkhgx)){
		v_gxmc="经销商";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
// 监管主体范围内范围外
var v_jgztfwnfww = <%=SysmanageUtil.getAa10toJsonArray("JGZTFWNFWW")%>;

var mygrid;
var singleSelect = sy.getUrlParam("singleSelect");
var v_singleSelect = (singleSelect=="true");
var v_comjyjcbz=sy.getUrlParam("comjyjcbz");

$(function() {		
		mygrid = $('#mygrid').datagrid({
			title: '<%=v_gxmc%>',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/pub/pub/querySelectGongyingshang?jgztkhgx=<%=v_jgztkhgx%>',   
			//queryParams: {comjyjcbz:v_comjyjcbz},
			striped : true,// 奇偶行使用不同背景色
			singleSelect:v_singleSelect,//True 就会只允许选中一行
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
		    idField: 'hjgztkhgxid', //该列是一个唯一列
		    sortOrder: 'asc',			
			columns : [ [ 
            {width : '100',
				//title : '企业ID',
				checkbox:'true',
				field : 'hjgztkhgxid',
				hidden : false
			},{
				width : '200',
				title : '客户名称',
				field : 'jgztkhmc',
				hidden : false
			},{
				width : '90',
				title : '客户名称简称',
				field : 'jgztkhmcjc',
				hidden : false
			},{
				width : '120',
				title : '客户范围内范围外',
				field : 'jgztfwnfww',
				hidden : false,
				formatter:function(value,row){
					return sy.formatGridCode(v_jgztfwnfww,value);
				}				
			},{
				width : '90',
				title : '客户编号',
				field : 'jgztkhbh',
				hidden : false
			},{
				width : '70',
				title : '联系人',
				field : 'jgztkhlxr',
				hidden : false
			},{
				width : '100',
				title : '移动电话',
				field : 'jgztkhyddh',
				hidden : false
			},{
				width : '80',
				title : '固定电话',
				field : 'jgztkhgddh',
				hidden : false
			},{
				width : '120',
				title : '联系地址',
				field : 'jgztkhlxdz',
				hidden : false
			} ,{
				width : '100',
				title : '资质证明名称',
				field : 'jgztkhzzzmmc',
				hidden : false
			} ,{
				width : '80',
				title : '资质证明编号',
				field : 'jgztkhzzzmbh',
				hidden : false
			}
			] ]
		});
});///////////////////////////////

	function query() {
		var param = {
			'jgztkhgx': $('#jgztkhgx').val(),	
			'jgztkhmc': $('#jgztkhmc').val(),
			'jgztkhmcjc': $('#jgztkhmcjc').val()
		};
		mygrid.datagrid({
			url : basePath + '/pub/pub/querySelectGongyingshang',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections'); 
	}

	function refresh(){
		$('#jgztkhmc').val('');
		$('#jgztkhmcjc').val('');
	} 
	
   function queding(){
     var rows=mygrid.datagrid('getSelections'); 
	   if (rows!="") {
		   sy.setWinRet(rows);
		   parent.$("#"+sy.getDialogId()).dialog("close"); 
		}else{
			$.messager.alert('提示', '请先选择记录！', 'info');
		} 
   }
   
   

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                 
        <div region="center" style="overflow: true;" border="false">
           <input type="hidden" name="jgztkhgx" id="jgztkhgx" value="<%=v_jgztkhgx%>">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr><%=v_gxmc%>名称</nobr></td>
						<td><input id="jgztkhmc" name="jgztkhmc" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr><%=v_gxmc%>简称</nobr></td>
						<td><input id="jgztkhmcjc" name="jgztkhmcjc" style="width: 100px" /></td>																		

					  	<td colspan="2">
					  	&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="queding()"> 确定</a>
								&nbsp;&nbsp;&nbsp;&nbsp;								
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="企业列表">
				<div id="mygrid" style="width:900px;height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>	        
        </div>        
    </div>   

</body>
</html>