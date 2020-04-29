<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
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
<title>待办业务</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var sfqygzl = <%=SysmanageUtil.getAa10toJsonArray("SFQYGZL")%>;
	var cb_sfqygzl;
	var grid;
	
	$(function() {
		cb_sfqygzl = $('#sfqygzl').combobox({
	    	data : sfqygzl,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    	    
		grid = $('#grid').datagrid({
			//title: '待办业务',
			//iconCls: 'icon-tip',
		    height:420,
			toolbar: '#toolbar',
			url: basePath + '/workflow/queryWfywDaiban',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'ywbh', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ 
			{field:'opt',title:'操作',align:'center',width:260,
	              formatter:function(value,rec){   
	                  return '<span style="color:blue" mce_style="color:blue">&nbsp;<a href="javascript:wfywbl(\''+rec.ywlcid+'\',\''+rec.psbh+'\',\''+rec.nodeid+'\',\''+rec.nodename+'\',\''+rec.nodeurl+'\',\''+rec.ywbh+'\',\''+rec.nodename+'\',\''+rec.fjcsdmlb+'\',\''+rec.fjcsdlbh+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/user_edit.gif" align="absmiddle">'+rec.nodename+'</a>&nbsp;<a href="javascript:htdsyb(\''+rec.ywlcid+'\',\''+rec.psbh+'\',\''+rec.nodeid+'\',\''+rec.nodename+'\',\''+rec.ywbh+'\')" mce_href="#"><img src="<%=basePath%>/images/pub/user_edit.gif" align="absmiddle">回退到上一步</a></span>';  
	             }   
	        }, 	
		    {
				width : '100',
				title : '业务流程ID',
				field : 'ywlcid',
				hidden : true
			},{
				width : '150',
				title : '工作流编号',
				field : 'psbh',
				hidden : true
			},{
				width : '100',
				title : '工作流名称',
				field : 'psmc',
				hidden : false
			},{
				width : '180',
				title : '业务编号',
				field : 'ywbh',
				hidden : false
			}]],					
			columns : [[ 
            {
				width : '200',
				title : '企业名称',
				field : 'commc',
				hidden : false
			},
			{
				width : '100',
				title : '流程当前节点',
				field : 'ywlccurnode',
				hidden : true
			},{
				width : '100',
				title : '节点ID',
				field : 'nodeid',
				hidden : true
			},{
				width : '200',
				title : '节点名称',
				field : 'nodename',
				hidden : false
			},{
				width : '200',
				title : '节点名称拼音码',
				field : 'nodepym',
				hidden : true
			},{
				width : '100',
				title : '节点URL',
				field : 'nodeurl',
				hidden : true
			},{
				width : '100',
				title : '附件参数代码类别',
				field : 'fjcsdmlb',
				hidden : false
			},{
				width : '100',
				title : '附件参数大类编号',
				field : 'fjcsdlbh',
				hidden : false
			},{
				width : '100',
				title : '时限状态',
				field : 'sxzt',
				hidden : false,
				formatter : function(value, row) {
					if (row.sfqygzl == "0"){ //未启用
						return '<span style="color:red;">' + sy.formatGridCode(sfqygzl,value) + '</span>';
					}else{				
						return sy.formatGridCode(sfqygzl,value);
					}
				}
			} ]]
		});
	});

	// 查询
	function query() {
		var ywbh = $('#ywbh').val();		
		var param = {
			'ywbh': ywbh
		};
		grid.datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 
	
	function myrefreshdaiban(){
		$("#grid").datagrid("reload");
	}

	function showZfbalct(){
		var url = basePath + 'jsp/workflowyewu/wfyw_zfbalct.jsp';
		var dialog = parent.sy.modalDialog({
				title : '查看',
				width : 900,
				height : 600,
				url : url,
			    maximizable:true
		},function(dialogID) {
		    sy.removeWinRet(dialogID);//不可缺少
		});
	}
	
	function showYwbllog(){
		var row = grid.datagrid('getSelected');
		if (row) {
			var url = basePath + 'workflow/wfywlclogIndex';
			var dialog = parent.sy.modalDialog({
					title : '查看',
					param : {
						ywbh : row.ywbh,
						time : new Date().getMilliseconds()
					},
					width : 900,
					height : 600,
					url : url,
				    maximizable:true
			},function(dialogID) {
			    sy.removeWinRet(dialogID);//不可缺少
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		} 
		  
	}
	
	function wfywbl(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_nodeurl,v_ywbh,v_nodename,v_fjcsdmlb,v_fjcsdlbh){
		//var v_ywlcid = row.ywlcid;
		//var v_ywbh = row.ywbh;
		//var v_psbh = row.psbh;
		//var v_nodeid = row.nodeid;
		//var v_nodename = row.nodename;
		//var v_nodeurl = row.nodeurl;
		
		var cfmMsg= "确定要【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?"; 		  
		
		var row = grid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', cfmMsg, function(r) {
				if (r) {
					//if(retVal != null){
					//	if(retVal.type == 'ok'){
					//		grid.datagrid('load');
					//	}
					//}
					var url = contextPath + v_nodeurl;
					var dialog = parent.sy.modalDialog({
							title : '',
							param : {
								ywlcid : v_ywlcid,
								ywbh : v_ywbh, 
								psbh : v_psbh,
								nodeid : v_nodeid, 
								nodename : v_nodename,
								fjcsdmlb : v_fjcsdmlb,
								fjcsdlbh : v_fjcsdlbh
							},
							width : 1000,
							height : 600,
							url : url
					},function(dialogID) {
						var obj = sy.getWinRet(dialogID);
						if (obj != null && "ok"==obj){
							$("#grid").datagrid("reload"); 
						}
					    sy.removeWinRet(dialogID);//不可缺少
					});
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		} 
		}
	function htdsyb(v_ywlcid,v_psbh,v_nodeid,v_nodename,v_ywbh){
		
		var cfmMsg= "确定要回退【"+v_nodename+"】业务编号为【"+v_ywbh+"】的记录吗?";
		var v_url=encodeURI(encodeURI(basePath+"/workflow/huituiWfprocess?ywlcid="
			+v_ywlcid+"&ywbh="+v_ywbh+"&psbh="+v_psbh+"&nodeid="+v_nodeid));
		
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
						 		$("#grid").datagrid('reload');
						 		parent.$.messager.progress('close');
						 		parent.$.messager.alert('提示','回退成功！','info',function(){
				        		}); 	                        	                     
			              	} else {
			              		parent.$.messager.progress('close');
			              		parent.$.messager.alert('提示','回退失败：'+result.msg,'error');
			                }
				        }  
					});	
			    }
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
						<td style="text-align:right;"><nobr>业务编号</nobr></td>
						<td><input id="psbh" name="psbh" style="width: 200px"/></td>																
						<td>
							<a id="myquerybtn" name="myquerybtn" href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-search" onclick="query()"> 查 询 </a>
								&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0)" class="easyui-linkbutton"
								iconCls="icon-reload" onclick="refresh()"> 重 置 </a>
						</td>
					</tr>
				</table>
	        </sicp3:groupbox>
        	<sicp3:groupbox title="待办业务列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton"  data="btn_doWfprocess"
								iconCls="ext-icon-date_magnify" plain="true" onclick="showZfbalct()">查看执法办案流程图</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_doWfprocess"
								iconCls="ext-icon-report_edit" plain="true" onclick="showYwbllog()">查看办理日志</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  												
						</tr>
					</table>
				</div>
				<table id="grid"></table>
	        </sicp3:groupbox>
		</div>						         		
        </div>               
    </div>    
</body>
</html>