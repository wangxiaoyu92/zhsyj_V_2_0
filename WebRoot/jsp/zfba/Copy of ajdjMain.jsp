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
var mygrid;
var v_ajdjajly = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;


$(function() {
		mygrid = $('#mygrid').datagrid({
			//title: '用户列表',
			//iconCls: 'icon-tip',
			toolbar: '#toolbar',
			url: basePath + '/zfba/ajdj/queryAjdj',
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
			columns : [ [ {
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
					return sy.formatGridCode(v_ajdjajly,value);
				}
			}
			] ]
		});
});

	// 新增
	function addAjdj() {
		var dialog = parent.sy.modalDialog({
			title : '案件新增',
			width : 870,
			height : 500,
			url : basePath + '/zfba/ajdj/ajdjFormIndex',
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
	
	// 保存用户
	function saveAjdj() {
		$('#ajdjAddDlgfm').form('submit',{
			url: basePath + '/zfba/ajdj/saveAjdj',
			onSubmit: function(){ 
		    	var isValid = $(this).form('validate');// 做form字段验证,返回true表示所有字段合法  ,返回false将停止form提交. 
				return isValid;	
	        },
	        success: function(result){ 
	        	result = $.parseJSON(result);  
			 	if (result.code=='0'){
	        		$.messager.alert('提示','保存成功！','info',function(){
	        			$('#ajdjAddDlg').dialog('close');
						$('#mygrid').datagrid('reload');  
	        		}); 	                        	                     
              	} else {
              		$.messager.alert('提示','保存失败：'+result.msg,'error');
                }
	        }    
		});
	} 
	
	// 删除
	function delAjdj() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_ajdjid = row.ajdjid;

			$.messager.confirm('警告', '您确定要删除该用户吗?',function(r) {
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
	
	// 编辑
	function updateAjdj() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var v_ajdjid = row.ajdjid;

			$('#ajdjAddDlgfm').form('load',row);
			$('#ajdjAddDlg').dialog('open').dialog('setTitle', '编辑案件登记');
		}else{
			$.messager.alert('提示', '请先选择要修改的案件登记记录！', 'info');
		}
	} 
	
	function query() {
		var param = {
			'comdm': $('#comdm').val(),
			'commc': $('#commc').val()
		};
		mygrid.datagrid({
			url : basePath + '/zfba/ajdj/queryAjdj',			
			queryParams : param
		}); 
		mygrid.datagrid('clearSelections');
	}
	
	//查询企业信息
	function querySelectcom() {
		var v_form = $('#myqueryfm');
		var dialog = parent.sy.modalDialog({
			title : '企业信息',
			iconCls : 'ext-icon-monitor',
			width : 800,
			height : 600,
			url : basePath + 'pub/selectcomIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getDataInfo(dialog, v_form, parent.$); 
				}
			},{
				text : '取消',
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
	//查询企业信息
	function querySelectcom2() {
		var v_form = $('#ajdjAddDlgfm');
		var dialog = parent.sy.modalDialog({
			title : '企业信息',
			iconCls : 'ext-icon-monitor',
			width : 800,
			height : 600,
			url : basePath + 'pub/selectcomIndex',
			buttons : [ {
				text : '确定',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.getDataInfo(dialog, v_form, parent.$); 
				}
			},{
				text : '取消',
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
		
	}
	
	
	function refresh(){
		parent.window.refresh();	
	} 
	
//从单位信息表中读取
function myselectcom(){
    var url = basePath + 'pub/pub/selectcomIndex';
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

</script>
</head>
<body>
	<div class="easyui-layout" fit="true">      
	    <form id="myqueryfm" method="post" >
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>企业编号</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 200px"/>
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="myselectcom()">选择企业 </a>						
						</td>						
						<td style="text-align:right;"><nobr>企业名称</nobr></td>
						<td><input id="commc" name="commc" style="width: 200px" /></td>	
						<td colspan="2">
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
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addSysuser"
								iconCls="icon-add" plain="true" onclick="addAjdj()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateSysuser"
								iconCls="icon-edit" plain="true" onclick="updateAjdj()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delSysuser"
								iconCls="icon-remove" plain="true" onclick="delAjdj()">删除</a>
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
        </form>         
    </div>   
    
	<div id="ajdjAddDlg" class="easyui-dialog" style="width:800px;height:450px;padding:10px 10px;"
		closed="true" closeable="true" buttons="#dlg-buttons" modal="true">
		<form id="ajdjAddDlgfm" method="post">
		  <input id="ajdjid" name="ajdjid" type="hidden"/>
		  
        	<sicp3:groupbox title="案件登记新增信息">	
        		<table class="table" style="width: 99%;">
					<tr>
						<td style="text-align:right;"><nobr>案件登记编号:</nobr></td>
						<td><input id="ajdjbh" name="ajdjbh" style="width: 200px;" class="easyui-validatebox" 
						data-options="required:true,validType:'length[0,30]'"/></td>						
						<td style="text-align:right;"><nobr>企业代码:</nobr></td>
						<td><input id="comdm" name="comdm" style="width: 150px" class="easyui-validatebox" 
						data-options="required:true,validType:'length[0,50]'" />
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="querySelectcom2()">选择企业 </a>							
						</td>						
					</tr>
					<tr>
						<td style="text-align:right;" ><nobr>企业名称:</nobr></td>
						<td colspan="3"><input id="commc" name="commc" style="width: 580px" data-options="required:true,validType:'length[0,200]'"/></td>		
					</tr>					
					<tr>
						<td style="text-align:right;"><nobr>企业地址:</nobr></td>
						<td colspan="3"><input id="comdz" name="comdz" style="width: 580px" data-options="validType:'length[0,200]'"/></td>		
					</tr>
					<tr>		
						<td style="text-align:right;"><nobr>企业法人/业主:</nobr></td>
						<td><input id="comfrhyz" name="comfrhyz" style="width: 200px" class="easyui-validatebox" data-options="validType:'length[0,20]'" /></td>						
						<td style="text-align:right;"><nobr>企业法人/业主身份证号:</nobr></td>
						<td><input id="comfrsfzh" name="comfrsfzh" style="width: 200px" data-options="validType:'length[0,20]'"/></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>联系电话:</nobr></td>
						<td><input id="comyddh" name="comyddh" style="width: 200px" class="easyui-validatebox" data-options="required:true,validType:['length[0,20]','phoneAndMobile']" /></td>									
						<td style="text-align:right;"><nobr>企业邮政编码:</nobr></td>
						<td><input id="comyzbm" name="comyzbm" style="width: 200px" class="easyui-validatebox"  data-options="validType:['integer','zip','length[0,6]']" /></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr>案发时间:</nobr></td>
						<td><input id="ajdjafsj" name="ajdjafsj" style="width: 200px" class="easyui-datetimebox"  data-options="required:true"/></td>									
						<td style="text-align:right;"><nobr>案由:</nobr></td>
						<td><input id="ajdjay" name="ajdjay" style="width: 200px" class="easyui-validatebox"  data-options="required:true,validType:['length[0,100]']"/></td>			
					</tr>
					<tr>						
						<td style="text-align:right;"><nobr> 案件来源:</nobr></td>
						<td colspan="3"><input id="ajdjajly" name="ajdjajly" style="width: 200px" class="easyui-validatebox" data-options="validType:'comboboxNoEmpty'" /></td>									
					</tr>
					<tr>						
						<td style="text-align:right;">案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等):</td>
						<td colspan="3">
						
						<textarea class="easyui-validatebox" id="ajdjjbqk" name="ajdjjbqk" style="width: 580px;" 
						 rows="5" data-options="required:false,validType:'length[0,200]'"></textarea>
												
						</td>			
					</tr>					
				</table>
	        </sicp3:groupbox>
	   </form>
	   <div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveAjdj();">确定</a>
			<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#ajdjAddDlg').dialog('close')">取消</a>
		</div>
	</div>
	
	    

</body>
</html>