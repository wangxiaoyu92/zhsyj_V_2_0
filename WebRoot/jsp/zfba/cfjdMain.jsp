<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page
	import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil"%>
<%
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null == basePath || "".equals(basePath)) {
		basePath = request.getScheme() + "://"
				+ request.getServerName() + ":"
				+ request.getServerPort() + request.getContextPath()
				+ "/";
	}
%>

<!DOCTYPE html>
<html>
<head>
<title>案件立案</title>

<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/zfba/cfjd/queryCfjd',
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
			frozenColumns : [[{
				width : '100',
				title : '案件登记ID',
				field : 'ajdjid',
				hidden : true
			},{
				width : '100',
				title : '案件状态',
				field : 'ajzt',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(v_ajzt,value);
				}
			},{
				width : '100',
				title : '企业代码',
				field : 'comdm',
				hidden : false
			},{
				width : '150',
				title : '企业名称',
				field : 'commc',
				hidden : false
			} ]],				
			columns : [ [ {
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
					return sy.formatGridCode(v_ajdjajly,value);
				}
			},
			{field:'opt',title:'操作',align:'left',width:200,
              formatter:function(value,rec){   
		    	  var v_OperRet='<a href="javascript:uploadFuJian('+rec.ajdjid+')" mce_href="#"><img src="../../images/pub/upload.png" align="absmiddle">附件管理</a>&nbsp;';
		    	      v_OperRet+='<a href="javascript:wenshuguanli('+rec.ajdjid+')" mce_href="#"><img src="../../images/pub/export_file.png" align="absmiddle">文书管理</a>&nbsp;';
		    	  
		    	  return v_OperRet;	                   
             }   
	        }  
			] ]
		});
});
//从单位信息表中读取
function myselectcom(){
    var url = basePath + 'pub/selectcom/selectcomIndex';
	var dialog = parent.sy.modalDialog({
			title : '选择企业',
			param : {
				singleSelect : "true",
				a : new Date().getMilliseconds()
			},
			width : 800,
			height : 500,
			url : url
	},function(dialogID) {
		var v_retStr = sy.getWinRet(dialogID);
		if (v_retStr != null && v_retStr.length > 0){
		    for (var k = 0; k <= v_retStr.length - 1; k++){
		      var myrow = v_retStr[k];
		      $("#commc").val(myrow.commc); //公司名称   
		      $("#comdm").val(myrow.comdm); //公司代码 
		    }
		}
	    sy.removeWinRet(dialogID);//不可缺少
	});    
}
	
	// 新增
	function addCfjd() {
		var dialog = parent.sy.modalDialog({
			title : '处罚案件新增',
			width : 870,
			height : 500,
			url : basePath + '/zfba/cfjd/cfjdFormIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, mygrid, parent.$);
				}
			},{
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	} 
	
	
	// 删除
	function delAjdj() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_ajdjid = row.ajdjid;

			$.messager.confirm('警告', '您确定要删除该案件吗?',function(r) {
				if (r) {
					$.post(basePath + '/zfba/ajdj/delAjdj', {
						ajdjid: row.ajdjid
					},
					function(result) {
						if (result.code == '0') {
							$.messager.alert('提示','删除成功！','info',function(){
								$('#mygrid').datagrid('reload'); 
			        		});    	
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的案件登记记录！', 'info');
		}
	} 
	
	
	// 查看
	function showAjdj() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看案件',
				width : 870,
				height : 500,
				url : basePath + '/zfba/ajdj/ajdjFormIndex?op=view&ajdjid=' + row.ajdjid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的案件登记信息！', 'info');
		}
	}
	
	function query() {
		var param = {
			'comdm': $('#comdm').val(),
			'commc': $('#commc').val()
		};
		mygrid.datagrid({
			url : basePath + '/zfba/dcqz/queryDcqz',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections');
	}
	//重置  刷新
	function refresh(){
		parent.window.refresh();	
	} 
	
	//附件管理
function uploadFuJian(v_ajdjid){	 	
	var url = basePath + 'pub/uploadfj/pubUploadFjListIndex';
	var dialog = parent.sy.modalDialog({
			title : '附件管理',
			param : {
				ajdjid : v_ajdjid,
				dmlb : "ZFAJLAFJ",
				time : new Date().getMilliseconds()
			},
			width : 900,
			height : 500,
			url : url
	},function(dialogID) {
	    sy.removeWinRet(dialogID);//不可缺少
	});
}

//文书管理
function wenshuguanli(v_ajdjid){
	var url = basePath + 'pub/ajwsgl/pubWsglIndex';
	var dialog = parent.sy.modalDialog({
			title : '文书管理',
			param : {
				ajdjid : v_ajdjid,
				time : new Date().getMilliseconds()
			},
			width : 900,
			height : 500,
			url : url
	},function(dialogID) {
	    sy.removeWinRet(dialogID);//不可缺少
	});
}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div region="center" style="overflow: true;" border="false">
			<sicp3:groupbox title="查询条件">
				<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 200px" />
								<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>
						</td>
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc"style="width: 200px" /></td>
						<td colspan="2"><a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search" onclick="query()">
								查 询 </a> &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload"
							onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
			</sicp3:groupbox>
			<sicp3:groupbox title="案件登记列表">
				<div id="toolbar">
					<table>
						<tr>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_addSysuser" iconCls="icon-add" plain="true"
								onclick="addCfjd()">添加处罚决定案件</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_queryAjdj"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showAjdj()">查看</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton"
								data="btn_delSysuser" iconCls="icon-remove" plain="true"
								onclick="delAjdj()">删除</a>
							</td>
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="mygrid" style="height:350px;overflow:auto;"></div>
			</sicp3:groupbox>
		</div>
	</div>



</body>
</html>