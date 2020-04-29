<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3"%>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<%@ page import="com.askj.zfba.service.AjdjService,com.zzhdsoft.siweb.entity.workflow.Wf_node" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" 
		 	+ request.getServerPort() + request.getContextPath() + "/";
	}
	
	AjdjService v_AjdjService = new AjdjService();
	Wf_node v_wf_node=v_AjdjService.getStartNodeFromYwpym("zfbalc");
	String v_psbh="";
	String v_nodeid="";
	String v_nodename="";
	if (v_wf_node!=null){
		v_psbh=v_wf_node.getPsbh();
		System.out.println(v_wf_node.getNodeid().toString());
		v_nodeid=v_wf_node.getNodeid().toString();
		v_nodename=v_wf_node.getNodename();
	}
%>
<!DOCTYPE html>
<html>
<head>

<title>案件登记</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>

<script type="text/javascript">
var mygrid;
var A_sfgx;
var A_ajzt;
var A_ajjsbz; // 案件结束标志
// 案件状态
var v_ajzt = <%=SysmanageUtil.getAa10toJsonArray("AJZT")%>;
// 案件登记案件来源
var v_AJDJAJLY = <%=SysmanageUtil.getAa10toJsonArray("AJDJAJLY")%>;
// 案件受理标志
var v_slbz = <%=SysmanageUtil.getAa10toJsonArray("SLBZ")%>;
// 案件结束标志
var V_AJJSBZ = <%=SysmanageUtil.getAa10toJsonArrayXz("AJJSBZ")%>;

$(function() {
		// 案件来源
	   $('#ajdjajly').combobox({
	    	data : v_AJDJAJLY,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    // 受理标志
		A_ajzt= $('#slbz').combobox({
	    	data :v_slbz,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });		
	    // 案件结束标志
	    A_ajjsbz = $('#ajjsbz').combobox({
	    	data :V_AJJSBZ,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto',
	        // 设置下拉框默认选中值
	        onLoadSuccess: function () { 
	            var data = $('#ajjsbz').combobox('getData');
                $('#ajjsbz').combobox('select', data[0].id);
            }
	    });
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
			fitColumns : false,// 列自适应宽度			btn_shoulihuitui
		    idField: 'ajdjid', //该列是一个唯一列
		    sortOrder: 'asc',	
		    onClickRow:function(rowIndex, rowData){
			  if (rowData.slbz==null || rowData.slbz==""|| rowData.slbz.length==0||rowData.slbz=="1"){
				  $("#btn_editAjdj").linkbutton('disable');
				  $("#btn_delAjdj").linkbutton('disable');
				  $("#btn_shouliAjdj").linkbutton('disable');
				  $("#btn_shoulihuitui").linkbutton('enable'); 
			  }else{
				 $("#btn_editAjdj").linkbutton('enable'); 
				 $("#btn_delAjdj").linkbutton('enable'); 
				 $("#btn_shouliAjdj").linkbutton('enable');
				 $("#btn_shoulihuitui").linkbutton('disable'); 
			  }
		    },
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
			},{
				width : '120',
				title : '案件受理人标志',
				field : 'ajslrbz',
				hidden : true
			}   
			] ]  
		});
});

// 窗口关闭回掉函数
function closeModalDialogCallback(dialogID){		
	var obj = sy.getWinRet(dialogID);
	if(obj=='ok'){
		mygrid.datagrid("reload"); 
	}
	sy.removeWinRet(dialogID);//不可缺少
}
// 新增
function addAjdj() {
	var dialog = parent.sy.modalDialog({
		title : '案件新增',
		width : 900,
		height : 600,
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
	},closeModalDialogCallback);
}

// 查看
function showAjdj() {
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var dialog = parent.sy.modalDialog({
			title : '查看案件登记',
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
// 编辑
function updateAjdj() {
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var dialog = parent.sy.modalDialog({
			title : '案件登记编辑',
			param : {
				ajdjid : row.ajdjid
			},
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
		},closeModalDialogCallback);
	}else{
		$.messager.alert('提示', '请先选择要修改的案件登记信息！', 'info');
	}
}

// 删除
function delAjdj() {
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		if (row.ajslrbz!=null && row.ajslrbz=='0'){
			alert("不是案件经办人，不能删除");
			return false;
		}
		
		var v_ajjsbz=row.ajjsbz;
		if (v_ajjsbz!=null && v_ajjsbz=='9'){
			alert("案件模板用，不允许删除");
			return false;
		}
		var v_ajdjid = row.ajdjid;

		$.messager.confirm('警告', '您确定要删除该记录吗?',function(r) {
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
//受理日志
function shoulirizhi(){ 
var row = $('#mygrid').datagrid('getSelected');
	if (row) {			
		var  v_ajdjid=row.ajdjid;
		var url = basePath+'workflow/wfywlclogIndex'; 
		var dialog = parent.sy.modalDialog({
			title : '附件管理',
			param : {
				ywbh : v_ajdjid 
			},
			width : 800,
			height :650,
			url : url,
			buttons : [ {
				text : '取消',
				handler : function() {						
				dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ] 
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
	}else{
		$.messager.alert('提示', '请先选择要受理的案件登记记录！', 'info');
	}	
 
}

//开始受理
function kaishishouli(){	 	
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var v_ajdjid=row.ajdjid;
		var v_comdm=row.comdm;
		var v_commc=row.commc;
		var ajdjslsj; // 案件登记受理时间
		var url = basePath + 'jsp/zfba/zfajslsj.jsp';
		var dialog = parent.sy.modalDialog({
				title : '开始受理',
				width : 450,
				height : 300,
				url : url
		},function(dialogID) {
			var obj = sy.getWinRet(dialogID);
			ajdjslsj = obj.value;
		    sy.removeWinRet(dialogID);//不可缺少
		    var cfmMsg= "确定要受理申请编号为【"+v_ajdjid+"】的记录吗?";
		  
			var v_yewumcpym="zfbalc";
			var v_transval="";
			var v_yewutablename="zfajdj";
			var v_yewucolname="ajdjid";
			var v_url=encodeURI(encodeURI("<%=basePath%>workflow/beginWfprocess?ywbh="
			  	+v_ajdjid+"&comdm="+v_comdm+"&commc="+v_commc+"&yewumcpym="
			  	+v_yewumcpym+"&transval="+v_transval+"&yewutablename="+v_yewutablename+"&yewucolname="
			  	+v_yewucolname+"&ajdjslsj="+ajdjslsj+"&time="+new Date().getMilliseconds()));
			
			 $.messager.confirm('确认', cfmMsg, function (r) {
			    if(r){
					parent.$.messager.progress({
						text : '开始受理....'
					});
					$.ajax({
						url:v_url,
						type:'post',
						async:true,
						cache:false,
						timeout: 100000,
						//data:formData,
						error:function(){
						    parent.$.messager.progress('close');
							alert("服务器繁忙，请稍后再试！");
						},
				        success: function(result){
				        	result = $.parseJSON(result);  
						 	if (result.code=='0'){
						 		$("#mygrid").datagrid('reload');
						 		parent.$.messager.progress('close');
						 		parent.$.messager.alert('提示','受理成功！','info',function(){
				        		}); 	                        	                     
			              	} else {
			              		parent.$.messager.progress('close');
			              		parent.$.messager.alert('提示','受理失败：'+result.msg,'error');
			                }
				        }  
					});	
			    }
			 });
		});
                
	}else{
		$.messager.alert('提示', '请先选择要受理的案件登记记录！', 'info');
	}
}

// 受理回退
function shoulihuitui(){	 	
	var row = $('#mygrid').datagrid('getSelected');
	
	if (row) {
		if (row.ajslrbz!=null && row.ajslrbz=='0'){
			alert("不是案件经办人，不能受理回退");
			return false;
		}
		
		var v_ajdjid = row.ajdjid;
		  var cfmMsg= "确定要回退受理编号为【"+v_ajdjid+"】的记录吗?";
		  
		  var v_yewumcpym="zfbalc";
		  var v_transval="";
		  var v_yewutablename="zfajdj";
		  var v_yewucolname="ajdjid";
		  
		  var v_url=encodeURI(encodeURI("<%=basePath%>workflow/rollbackWfprocess?ywbh="
		  	+v_ajdjid+"&yewumcpym="	+v_yewumcpym+"&yewutablename="+v_yewutablename+"&yewucolname="
		  	+v_yewucolname+"&time="+new Date().getMilliseconds()));
		
		 $.messager.confirm('确认', cfmMsg, function (r) {
		    if(r){
				parent.$.messager.progress({
					text : '处理中....'
				});
				$.ajax({
					url:v_url,
					type:'post',
					async:true,
					cache:false,
					timeout: 100000,
					error:function(){
					    parent.$.messager.progress('close');
						alert("服务器繁忙，请稍后再试！");
					},
			        success: function(result){
			        	result = $.parseJSON(result);  
					 	if (result.code=='0'){
					 		$("#mygrid").datagrid('reload');
					 		parent.$.messager.progress('close');
					 		parent.$.messager.alert('提示','处理成功！','info',function(){
			        		}); 	                        	                     
		              	} else {
		              		parent.$.messager.progress('close');
		              		parent.$.messager.alert('提示','处理失败：'+result.msg,'error');
		                }
			        }  
				});	
		    }
		 });
	}else{
		$.messager.alert('提示', '请先选择要回退的案件登记记录！', 'info');
	}
}
	
	// 查看显示案件承办人
	function showAjcbr() {
		var row = $('#mygrid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '案件承办人',
				width : 870,
				height : 500,
				url : basePath + '/zfba/ajdj/ajdjCbrFormIndex?ajdjid=' + row.ajdjid,
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
		}else{
			$.messager.alert('提示', '请先选择要操作的案件登记信息！', 'info');
		}
	}
	
	function query() {
		var param = {
			'comdm': $('#comdm').val(),
			'commc': $('#commc').val(),
			'slbz':$('#slbz').combobox('getValue'),
			'ajjsbz':$('#ajjsbz').combobox('getValue')
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
			height : 600,
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
//文书管理  统一修改
function wenshuguanli(){	
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var v_ajdjid=row.ajdjid;
		var v_ajslrbz=row.ajslrbz; 
		var url = basePath + "/pub/wsgldy/pubWsglIndex"; 
		var dialog = parent.sy.modalDialog({ 
			title : '文书管理',
			param : {
				ajdjid : v_ajdjid,
				ajslrbz : v_ajslrbz,
				psbh:'<%=v_psbh%>',
				nodeid :'<%=v_nodeid%>',
				nodename :encodeURI(encodeURI('<%=v_nodename%>'))
			},
			width : 900,
			height : 500,
			url : url 
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
    }else{
		$.messager.alert('提示', '请先选择要操作的案件登记记录！', 'info');
	}
}

function uploadFuJian(){	
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var v_ajdjid = row.ajdjid; 
	    var v_dmlb = "ZFAJDJFJ";//执法案件登记附件
	    var v_fjcsdlbh = "ZFBAFJ";//附件参数大类编号 执法办案附件
		var url = basePath + "/pub/pub/pubUploadFjListIndex";
		//创建模态窗口
		var dialog = parent.sy.modalDialog({
			title : '附件管理',
			param : {
				dmlb : v_dmlb,
				ajdjid : v_ajdjid,
				fjcsdlbh : v_fjcsdlbh
			},
			width : 900,
			height : 500,
			url : url, 
			buttons : [ {
				text : '取消',
				handler : function() {						
				dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
				}
			} ]
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		}); 
	}else{
		$.messager.alert('提示', '请先选择要操作的记录！', 'info');
	}	
} 

//从单位信息表中读取
function myAjdjSetRy(){
	var row = $('#mygrid').datagrid('getSelected');
	if (row) {
		var v_ajdjid = row.ajdjid;
		var url = basePath + "jsp/zfba/ajdjSetRy.jsp";
		var dialog = parent.sy.modalDialog({
			title : '经办人设置',
			param : { 
				ajdjid : v_ajdjid 
			},
			width : 650,
			height : 600,
			url : url 
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});   
    }else{
		$.messager.alert('提示', '请先选择要设置的案件登记记录！', 'info');
	}
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
						<td><input id="commc" name="commc" style="width:200px" /></td>	
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>受理标志</nobr></td>
						<td><input id="slbz" name="slbz" style="width: 200px" /></td>
						<td style="text-align:right;"><nobr>案件结束标志</nobr></td>
						<td><input id="ajjsbz" name="ajjsbz" style="width: 200px" /></td>
					</tr>
					<tr>
						<td style="text-align:center;" colspan="4">
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
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addAjdj"
								iconCls="icon-add" plain="true" onclick="addAjdj()">增加</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_showAjdj"
								iconCls="ext-icon-application_form_magnify" plain="true" onclick="showAjdj()">查看</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" id="btn_editAjdj" name="btn_editAjdj" 
								class="easyui-linkbutton" data="btn_updateAjdj"
								iconCls="icon-edit" plain="true" onclick="updateAjdj()">编辑</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)" class="easyui-linkbutton" 
								id="btn_delAjdj" name="btn_delAjdj" data="btn_delAjdj"
								iconCls="icon-remove" plain="true" onclick="delAjdj()">删除</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFuJian"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()">附件</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_wenshuguanliAjdj"
								iconCls="ext-icon-box" plain="true" onclick="wenshuguanli()">文书</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 	
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_shouliAjdj" 
								id="btn_shouliAjdj" name="btn_kaishishouli"
								iconCls="icon-ok" plain="true" onclick="kaishishouli()">受理</a> 
							</td>
							<td>  
							<div class="datagrid-btn-separator"></div>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" 
								data="btn_ajdjRollbackWfprocess" id="btn_shoulihuitui"
								iconCls="icon-ok" plain="true" onclick="shoulihuitui()">受理回退</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)"  class="easyui-linkbutton" data="btn_shoulirizhi"
								iconCls="ext-icon-overlays" plain="true" onclick="shoulirizhi()">受理日志</a> 
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td> 
							<td><a href="javascript:void(0)"  class="easyui-linkbutton" data="btn_myAjdjSetRy"
								iconCls="ext-icon-overlays" plain="true" onclick="myAjdjSetRy()">案件经办人设置</a> 
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