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

<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var aaa027name = sy.getUrlParam("aaa027name"); // 统筹区
var slbz = sy.getUrlParam("slbz"); // 受理标识
var ajjsbz = sy.getUrlParam("ajjsbz"); // 案件结束标识
var param = { 
	'slbz' : slbz,
	'ajjsbz' : ajjsbz,
	'aaa027name' : aaa027name
};
var mygrid;
var A_ajjsbz; // 案件结束标志
// 案件登记案件来源
var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
// 案件受理标志
var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("SLBZ")%>;
// 案件结束标志
var V_AJJSBZ = <%=SysmanageUtil.getAa10toJsonArrayXz("AJJSBZ")%>;

$(function() {
		mygrid = $('#mygrid').datagrid({
			toolbar: '#toolbar',
			url: basePath + '/zfba/ajdj/queryAjdj',
			queryParams : param,
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度
		    idField: 'ajdjid', //该列是一个唯一列
		    sortOrder: 'asc',	
			columns : [ [
		        {
					width : '100',
					title : '案件登记ID',
					field : 'ajdjid',
					hidden : false
				},{
					width : '100',
					title : '企业代码',
					field : 'comdm',
					hidden : true
				},{
					width : '150',
					title : '企业名称',
					field : 'commc',
					hidden : false
				},{
					width : '100',
					title : '企业地址',
					field : 'comdz',
					hidden : false
				},{
					width : '80',
					title : '企业法人',
					field : 'comfrhyz',
					hidden : false
				},{
					width : '100',
					title : '企业法人身份证号',
					field : 'comfrsfzh',
					hidden : false
				} ,{
					width : '80',
					title : '联系电话',
					field : 'comyddh',
					hidden : false
				} ,{
					width : '120',
					title : '案发时间',
					field : 'ajdjafsj',
					hidden : false
				},{
					width : '120',
					title : '案由',
					field : 'ajdjay',
					hidden : false
				},{
					width : '120',
					title : '案件来源',
					field : 'ajdjajly',
					hidden : false,
					formatter : function(value, row) {
						return sy.formatGridCode(v_AJDJAJLY,value);
					}
				},{
					width : '80',
					title : '受理标志',
					field : 'slbz',
					hidden : false,
					formatter : function(value, row) {
						return sy.formatGridCode(v_slbz,value);
					}
				},{
					width : '80',
					title : '结束标志',
					field : 'ajjsbz',
					hidden : false,
					formatter : function(value, row) {
						return sy.formatGridCode(V_AJJSBZ,value);
					}
				},{
					width : '90',
					title : '受理人',
					field : 'slczy',
					hidden : false
				},{
					width : '120',
					title : '受理时间',
					field : 'slsj',
					hidden : false
				}  
			] ]
		});
});

	//受理日志
	function shoulirizhi(){	 
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
		   	var url = basePath + 'workflow/wfywlclogIndex';
			var dialog = parent.sy.modalDialog({
					title : '受理日志',
					param : {
						ywbh : row.ajdjid,
						time : new Date().getMilliseconds()
					},
					width : 1200,
					height : 600,
					url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
	    }else{
			$.messager.alert('提示', '请先选择要受理的案件登记记录！', 'info');
		}
	}
	
	// 查看
	function showAjdj() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var url = basePath + 'zfba/ajdj/ajdjFormIndex';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						ajdjid : row.ajdjid,
						op : "view"
					},
					width : 950,
					height : 580,
					url : url
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的案件登记信息！', 'info');
		}
	};
	function query() {
		var param = {
			'slbz' : slbz,
			'ajjsbz' : ajjsbz,
			'aaa027name' : aaa027name,
			'commc': $('#commc').val()
		};
		mygrid.datagrid({
			url : basePath + '/zfba/ajdj/queryAjdj',			
			queryParams : param
		});
		mygrid.datagrid('clearSelections'); 
	}
	
	function refresh(){
		parent.window.refresh();	
	} 
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width:200px" /></td>
						<td style="text-align:center;" colspan="2">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>	
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="案件登记列表">
	        	<div id="toolbar">
	        		<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showAjdj"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showAjdj()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)"  class="easyui-linkbutton" data="btn_shoulirizhi"
								iconCls="ext-icon-overlays" plain="true" onclick="shoulirizhi()">受理日志</a> 
							</td>
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>
        </form>         
    </div>   
</body>
</html>