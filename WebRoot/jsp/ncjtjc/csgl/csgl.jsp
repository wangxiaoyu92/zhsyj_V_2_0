<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/sicp3.tld" prefix="sicp3" %>
<%@ page import="com.zzhdsoft.mvc.GlobalConfig,com.zzhdsoft.utils.SysmanageUtil" %>
<% 
	String contextPath = request.getContextPath();
	String basePath = GlobalConfig.getAppConfig("apppath");
	if (null==basePath || "".equals(basePath)){
		 basePath = request.getScheme() + "://"	+ request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>厨师管理</title>
<jsp:include page="${contextPath}/inc.jsp"></jsp:include>
<script type="text/javascript">
	//下拉框列表
	var cssfzjlx = <%=SysmanageUtil.getAa10toJsonArray("AAC058")%>;
	var csxb = <%=SysmanageUtil.getAa10toJsonArray("AAC004")%>;
	var cswhcd = <%=SysmanageUtil.getAa10toJsonArray("AAC011")%>;
	var cscynx = <%=SysmanageUtil.getAa10toJsonArray("CYNX")%>;
	var csjkzm = <%=SysmanageUtil.getAa10toJsonArray("JKZM")%>;
	var cspxqk = <%=SysmanageUtil.getAa10toJsonArray("PXQK")%>;
	var grid;
	
	$(function() {
		cb_cssfzjlx = $('#cssfzjlx').combobox({
	    	data : cssfzjlx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto'
	    });
		cb_csxb = $('#csxb').combobox({
	    	data : csxb,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cswhcd = $('#cswhcd').combobox({
	    	data : cswhcd,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : '200' 
	    });
		cb_cscynx = $('#cscynx').combobox({
	    	data : cscynx,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_csjkzm = $('#csjkzm').combobox({
	    	data : csjkzm,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
		cb_cspxqk = $('#cspxqk').combobox({
	    	data : cspxqk,      
	        valueField : 'id',   
	        textField : 'text',
	        required : false,
	        editable : false,
	        panelHeight : 'auto' 
	    });
	    
		grid = $('#grid').datagrid({
			//title : '厨师列表',
			//iconCcs : 'icon-tip',
			//collapsible : true,
			toolbar : '#toolbar',
			url : basePath + '/ncjtjc/csgl/queryCs',
			striped : true,// 奇偶行使用不同背景色
			singleSelect : true,// True只允许选中一行
			checkOnSelect : false,
			selectOnCheck : false,			
			pagination : true,// 底部显示分页栏
			pageSize : 10,
			pageList : [ 10, 20, 30 ],
			rownumbers : true,// 是否显示行号
			fitColumns : false,// 列自适应宽度			
		    idField: 'csid', //该列是一个唯一列
		    sortOrder: 'desc',
		    frozenColumns : [[ {
				width : '200',
				title : '厨师ID',
				field : 'csid',
				hidden : false
			},{
				width : '150',
				title : '厨师编号',
				field : 'csbh',
				hidden : false
			},{
				width : '100',
				title : '姓名',
				field : 'csxm',
				hidden : false
			}]],				
			columns : [ [ {
				width : '100',
				title : '姓名拼音码',
				field : 'cspym',
				hidden : true
			},{
				width : '100',
				title : '性别',
				field : 'csxb',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csxb,value);
				}
			},{
				width : '200',
				title : '家庭住址',
				field : 'csjtzz',
				hidden : false
			},{
				width : '150',
				title : '服务区域',
				field : 'csfwqy',
				hidden : false
			},{
				width : '150',
				title : '所属地区',
				field : 'aaa027name',
				hidden : false
			},{
				width : '100',
				title : '出生日期',
				field : 'cscsrq',
				hidden : false
			},{
				width : '200',
				title : '身份证件类型',
				field : 'cssfzjlx',
				hidden : true,
				formatter : function(value, row) {
					return sy.formatGridCode(cssfzjlx,value);
				}
			},{
				width : '150',
				title : '身份证号',
				field : 'cssfzjhm',
				hidden : false
			},{
				width : '100',
				title : '手机号',
				field : 'cssjh',
				hidden : false
			},{
				width : '100',
				title : '文化程度',
				field : 'cswhcd',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cswhcd,value);
				}
			},{
				width : '100',
				title : '从业年限',
				field : 'cscynx',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cscynx,value);
				}
			},{
				width : '100',
				title : '健康证明',
				field : 'csjkzm',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(csjkzm,value);
				}
			},{
				width : '150',
				title : '健康证有效期',
				field : 'csjkzyxq',
				hidden : false
			},{
				width : '100',
				title : '培训情况',
				field : 'cspxqk',
				hidden : false,
				formatter : function(value, row) {
					return sy.formatGridCode(cspxqk,value);
				}
			},{
				width : '150',
				title : '培训合格证有效期',
				field : 'cspxhgzyxq',
				hidden : false
			},{
				width : '150',
				title : '邮箱',
				field : 'csyx',
				hidden : false
			},{
				width : '150',
				title : 'QQ号',
				field : 'csqq',
				hidden : false
			},{
				width : '150',
				title : '微信号',
				field : 'cswx',
				hidden : false
			},{
				width : '200',
				title : '备注',
				field : 'aae013',
				hidden : false
			} ] ]
		});
	});

	// 查询
	function query() {
		var aaa027 = $('#aaa027').val();
		var csxm = $('#csxm').val();
		var cspym = $('#cspym').val();
		var cssfzjhm = $('#cssfzjhm').val();
		var param = {
			'aaa027': aaa027,
			'csxm': csxm,
			'cspym': cspym,
			'cssfzjhm': cssfzjhm
		};
		$('#grid').datagrid('reload', param);
		grid.datagrid('clearSelections');
	}

	// 重置
	function refresh(){
		parent.window.refresh();	
	} 

	// 新增
	var addCs = function() {
		var dialog = parent.sy.modalDialog({
			title : '新增厨师',
			width : 870,
			height : 570,
			url : basePath + '/ncjtjc/csgl/csglFormIndex',
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
	};

	// 编辑
	var updateCs = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '编辑厨师',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/csgl/csglFormIndex?csid=' + row.csid,
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
			$.messager.alert('提示', '请先选择要修改的记录！', 'info');
		}
	};

	// 查看
	var showCs = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '查看厨师',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/csgl/csglFormIndex?op=view&csid=' + row.csid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	};
	
	// 删除
	var delCs = function() {
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('警告', '您确定要删除这条记录吗，这将删除对应的厨师相关信息，且不可恢复！',function(r) {
				if (r) {
					$.post(basePath + '/ncjtjc/csgl/delCs', {
						csid: row.csid,csbh: row.csbh
					},
					function(result) {
						if (result.code == '0') {	
							$.messager.alert('提示','删除成功！','info',function(){
								$('#grid').datagrid('reload'); 
			        		}); 
						} else {
							$.messager.alert('提示', "删除失败：" + result.msg, 'error');
						}
					},
					'json');
				}
			});
		}else{
			$.messager.alert('提示', '请先选择要删除的记录！', 'info');
		}
	} 
	
	// 报表
	function printCsRecord(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + '/ncjtjc/csgl/printCsbadj'; 
			var dialog = parent.sy.modalDialog({
				title : '打印',
				param : {
					csid : row.csid 
				},
				width : 800,
				height : 600,
				url : url ,
				buttons : [ {
					text : '取消',
					handler : function() {						
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog);
					}
				} ]
			} ); 
			/* var obj = new Object();
		    var url = basePath + '/ncjtjc/csgl/printCsbadj?csid='+row.csid;
			var k = popwindow(url,obj,900,500);  */ 
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}
	
	
	
// 报表
	var printCsRecord1 = function() {
	var row = $('#grid').datagrid('getSelected');
		if (row) {
			var dialog = parent.sy.modalDialog({
				title : '打印《农村流动厨师备案登记表》',
				width : 870,
				height : 570,
				url : basePath + '/ncjtjc/csgl/printCsbadj?csid='+row.csid,
				buttons : [ {
					text : '取消',
					handler : function() {
						dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, parent.$);
					}
				} ]
			});
		}else{
			$.messager.alert('提示', '请先选择要查看的记录！', 'info');
		}
	};



	// 导入
	var csdrIndex = function(){		
		var dialog = parent.sy.modalDialog({
			title : '导入厨师',
			iconCcs : 'ext-icon-monitor',
			width : 870,
			height : 522,
			url : basePath + '/ncjtjc/csgl/csdrIndex',
			buttons : [ {
				text : '取消',
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.closeWindow(dialog, grid, parent.$);
				}
			} ]
		});
	} 
	
	// 上传附件
	function uploadFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/ncjtjc/csgl/uploadFjIndex";
			var dialog = parent.sy.modalDialog({
				title : "上传附件",
				width : 800,
				height : 600,
				param : {
					csid : row.csid
				}, 
				url : url
			});
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/csgl/uploadFjIndex?csid="+row.csid,obj,800,600);
			if(retVal != null){
				if(retVal.type == 'ok'){
					//grid.datagrid('load');
				}
			} --%>
		}else{
			$.messager.alert('提示', '请先选择要上传附件的记录！', 'info');
		}
	}
	// 删除附件
	function delFj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			var url = basePath + "/ncjtjc/csgl/uploadFjIndex";
			var dialog = parent.sy.modalDialog({ 
				width : 800,
				height : 600,
				param : {
					csid : row.csid
				}, 
				url : url
			});
			<%-- var obj = new Object(); 
			var retVal = popwindow("<%=contextPath %>/ncjtjc/csgl/delFjIndex?csid="+row.csid,obj,800,600);
			if(retVal != null){
				if(retVal.type == 'ok'){
					//grid.datagrid('load');
				}
			} --%>
		}else{
			$.messager.alert('提示', '请先选择要删除附件的记录！', 'info');
		}
	}


	//附件管理
	function uploadFuJian(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			/* var obj = new Object(); */
			var url = basePath + 'pub/pub/pubUploadFjListIndex';
			var v_ajdjid = row.csid;		    
		    var v_fjcsdlbh = "NCJTJCFJ";//附件参数大类编号：农村集体聚餐附件
		    var v_dmlb = "CSDJBAFJ";//附件参数小类编号：厨师登记备案附件
		    var dialog = parent.sy.modalDialog({
				width : 800,
				height : 600,
				param : {
					ajdjid : v_ajdjid,
					fjcsdlbh : v_fjcsdlbh,
					dmlb : v_dmlb
				}, 
				url : url
			});
		    /* var url = basePath + 'pub/pub/pubUploadFjListIndex?ajdjid='+v_ajdjid+'&dmlb='+v_dmlb+'&fjcsdlbh='+v_fjcsdlbh+'&time='+new Date().getMilliseconds(); 
			var k = popwindow(url,obj,900,500);   */
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}	 	
	}

	function printCsbadj(){
		var row = $('#grid').datagrid('getSelected');
		if (row) {
			getPersonPhoto(row.csid);//zjf
			var params = "csid=" + row.csid;
			sy.doPrint('ncjtjc/csbadj.cpt',params);
		}else{
			$.messager.alert('提示', '请先选择要操作的记录！', 'info');
		}
	}

	// 从数据库获取照片
	function getPersonPhoto(csid){		
		if (csid != null && csid != "") {
			$.post(basePath + '/ncjtjc/csgl/getCszp', {
				'csid':csid
			},
			function(result) {
				$('#cszp').attr('src',result.fileCtxPath + "?" + Math.random());
				if(result.code=='-1'){					
					$.messager.alert('提示', result.msg, 'error');	
				}				
			},
			'json');
		}	
	}
	
	function showMenu_aaa027() {
		var url = basePath + 'jsp/pub/pub/selectAaa027.jsp';
		var dialog = parent.sy.modalDialog({
			title : '监控',
			width : 300,
			height : 400,
			url : url
		},function (dialogID){
			var obj = sy.getWinRet(dialogID);//不可缺少
			if(typeof(obj.type)!="undefined" && obj.type!=null && obj.type=='ok'){
				$('#aaa027').val(obj.aaa027);
				$('#aaa027name').val(obj.aaa027name);
			}
			sy.removeWinRet(dialogID);//不可缺少
		})
	}
</script>
</head>
<body>
	<div class="easyui-layout" fit="true">                  
        <div region="center" style="overflow: true;" border="false">
        	<sicp3:groupbox title="查询条件">
        		<table class="table" style="width: 99%;">
					<tr>											
						<td style="text-align:right;"><nobr>所属统筹区:</nobr></td>
						<td>
							<input name="aaa027name" id="aaa027name"  style="width: 200px " onclick="showMenu_aaa027();" 
							   readonly="readonly" class="easyui-validatebox" data-options="required:false" />
							<input name="aaa027" id="aaa027"  type="hidden"/>
							<div id="menuContent_aaa027" class="menuContent" style="display:none; position: absolute;">
								<ul id="treeDemo_aaa027" class="ztree" style="margin-top:0px;width:150px;height:450px;"></ul>
							</div>							
						</td>
						<td style="text-align:right;"><nobr>厨师姓名:</nobr></td>
						<td><input id="csxm" name="csxm" style="width: 200px" /></td>			
						<td style="text-align:right;"><nobr>姓名拼音码:</nobr></td>
						<td><input id="cspym" name="cspym" style="width: 200px" /></td>									
					</tr>
					<tr>
						<td style="text-align:right;"><nobr>身份证号:</nobr></td>
						<td><input id="cssfzjhm" name="cssfzjhm" style="width: 200px" /></td>								
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
        	<sicp3:groupbox title="厨师列表">
	        	<div id="toolbar">
	        		<table>
						<tr>	        		
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_addCs"
								iconCls="icon-add" plain="true" onclick="addCs()">增加</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_updateCs"
								iconCls="icon-edit" plain="true" onclick="updateCs()">编辑</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_csglFormIndex"
								iconCls="ext-icon-report_magnify" plain="true" onclick="showCs()">查看</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>    
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_delCs"
								iconCls="icon-remove" plain="true" onclick="delCs()">删除</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>  
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_csdrIndex"
								iconCls="ext-icon-report_go" plain="true" onclick="csdrIndex()">导入厨师</a>
							</td>
							<td> 
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" data="btn_uploadFj"
								iconCls="icon-upload" plain="true" onclick="uploadFuJian()()">附件管理</a>
							</td>   
							<td>
								<div class="datagrid-btn-separator"></div>
							</td>
							<td><a href="javascript:void(0)" class="easyui-linkbutton" 
								iconCls="icon-print" plain="true" onclick="printCsRecord()">打印《农村流动厨师备案登记表》</a>
							</td>
							<td>  
								<div class="datagrid-btn-separator"></div>
							</td>   
						</tr>
					</table>
				</div>
				<div id="grid" style="height:350px;overflow:auto;"></div>
	        </sicp3:groupbox>
        </div>        
    </div>    
</body>
</html>